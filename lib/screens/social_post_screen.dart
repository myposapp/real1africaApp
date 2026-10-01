import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/social_post.dart';
import '../network/provider/network_provider.dart';
import '../providers/person_provider.dart';
import '../widgets/confirmation_dialog.dart';
import '../widgets/social/social_comment_tile.dart';
import '../widgets/social/social_common.dart';
import '../widgets/social/social_post_card.dart';

/// A single post with its full comment thread.
class SocialPostScreen extends StatefulWidget {
  final SocialPost post;
  final ValueChanged<SocialPost> onChanged;
  final VoidCallback onDeleted;
  final bool focusComposer;

  const SocialPostScreen({
    super.key,
    required this.post,
    required this.onChanged,
    required this.onDeleted,
    this.focusComposer = false,
  });

  @override
  State<SocialPostScreen> createState() => _SocialPostScreenState();
}

class _SocialPostScreenState extends State<SocialPostScreen> {
  static const _maxCommentLength = 2000;
  static const _pageSize = 100;

  late SocialPost _post;
  List<SocialComment> _comments = [];
  bool _isLoading = true;
  String? _error;

  final _inputController = TextEditingController();
  final _inputFocus = FocusNode();
  SocialComment? _replyTo;
  SocialComment? _editing;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _post = widget.post;
    _loadComments();
    if (widget.focusComposer) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && context.read<ProfileProvider>().profile != null) {
          _inputFocus.requestFocus();
        }
      });
    }
  }

  @override
  void dispose() {
    _inputController.dispose();
    _inputFocus.dispose();
    super.dispose();
  }

  void _updatePost(SocialPost post) {
    setState(() => _post = post);
    widget.onChanged(post);
  }

  /// Loads every page so replies can always be grouped under their parent.
  Future<void> _loadComments() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final networkRepo = context.read<NetworkProvider>().networkRepo;
    try {
      final all = <SocialComment>[];
      var page = 1;
      while (true) {
        final response = await networkRepo.getSocialPostComments(
          _post.id,
          page: page,
          pageSize: _pageSize,
        );
        if (response.success != true) {
          throw response.message ?? 'Could not load comments.';
        }
        final data = response.data ?? [];
        all.addAll(data);
        final total = response.metadata?.total ?? all.length;
        if (data.length < _pageSize || all.length >= total) break;
        page++;
      }
      if (!mounted) return;
      setState(() {
        _comments = all;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _error = e is String ? e : 'Could not load comments.';
      });
    }
  }

  void _startReply(SocialComment comment) {
    if (!requireSocialSignIn(context, action: 'reply')) return;
    setState(() {
      _editing = null;
      _replyTo = comment;
    });
    _inputFocus.requestFocus();
  }

  void _startEdit(SocialComment comment) {
    setState(() {
      _replyTo = null;
      _editing = comment;
      _inputController.text = comment.content;
    });
    _inputFocus.requestFocus();
  }

  void _cancelContext() {
    setState(() {
      if (_editing != null) _inputController.clear();
      _replyTo = null;
      _editing = null;
    });
  }

  Future<void> _send() async {
    final content = _inputController.text.trim();
    if (content.isEmpty || _isSending) return;
    if (!requireSocialSignIn(context, action: 'comment')) return;

    setState(() => _isSending = true);
    final networkRepo = context.read<NetworkProvider>().networkRepo;
    final editing = _editing;
    final replyTo = _replyTo;

    try {
      final response = editing != null
          ? await networkRepo.updateSocialComment(
              _post.id,
              editing.id,
              content: content,
            )
          : replyTo != null
          ? await networkRepo.replyToSocialComment(
              _post.id,
              replyTo.id,
              content: content,
            )
          : await networkRepo.createSocialComment(_post.id, content: content);

      if (!mounted) return;
      final saved = response.data;
      if (response.success != true || saved == null) {
        setState(() => _isSending = false);
        showSocialSnackBar(context, response.message ?? 'Could not send comment.');
        return;
      }

      setState(() {
        if (editing != null) {
          _comments = [
            for (final c in _comments)
              c.id == saved.id
                  ? saved.copyWith(liked: c.liked, likeCount: c.likeCount)
                  : c,
          ];
        } else {
          _comments = [..._comments, saved];
        }
        _inputController.clear();
        _replyTo = null;
        _editing = null;
        _isSending = false;
      });
      if (editing == null) {
        _updatePost(_post.copyWith(commentCount: _post.commentCount + 1));
      }
      _inputFocus.unfocus();
    } catch (_) {
      if (!mounted) return;
      setState(() => _isSending = false);
      showSocialSnackBar(context, 'Could not send comment. Check your connection.');
    }
  }

  Future<void> _toggleCommentLike(SocialComment comment) async {
    if (!requireSocialSignIn(context, action: 'like comments')) return;

    void replace(SocialComment updated) => setState(() {
      _comments = [
        for (final c in _comments) c.id == updated.id ? updated : c,
      ];
    });

    final liked = !comment.liked;
    replace(
      comment.copyWith(
        liked: liked,
        likeCount: liked
            ? comment.likeCount + 1
            : (comment.likeCount - 1).clamp(0, comment.likeCount),
      ),
    );

    final networkRepo = context.read<NetworkProvider>().networkRepo;
    try {
      final response = await networkRepo.toggleSocialCommentLike(
        _post.id,
        comment.id,
      );
      if (!mounted) return;
      final reaction = response.data;
      if (response.success == true && reaction != null) {
        replace(
          comment.copyWith(
            liked: reaction.liked,
            likeCount: reaction.likeCount,
          ),
        );
      } else {
        replace(comment);
        showSocialSnackBar(context, response.message ?? 'Could not like comment.');
      }
    } catch (_) {
      if (!mounted) return;
      replace(comment);
      showSocialSnackBar(context, 'Could not like comment. Check your connection.');
    }
  }

  Future<void> _deleteComment(SocialComment comment) async {
    final replyCount = comment.isReply
        ? 0
        : _comments.where((c) => c.parentComment == comment.id).length;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => ConfirmationDialog(
        title: 'Delete comment?',
        message: replyCount > 0
            ? 'This also deletes its $replyCount repl${replyCount == 1 ? 'y' : 'ies'}.'
            : 'This cannot be undone.',
        confirmText: 'Delete',
        isDestructive: true,
        icon: Icons.delete_outline,
        onConfirm: () => Navigator.pop(dialogContext, true),
        onCancel: () => Navigator.pop(dialogContext, false),
      ),
    );
    if (confirmed != true || !mounted) return;

    final networkRepo = context.read<NetworkProvider>().networkRepo;
    try {
      final response = await networkRepo.deleteSocialComment(
        _post.id,
        comment.id,
      );
      if (!mounted) return;
      if (response.success != true) {
        showSocialSnackBar(context, response.message ?? 'Could not delete comment.');
        return;
      }

      setState(() {
        _comments = _comments
            .where((c) => c.id != comment.id && c.parentComment != comment.id)
            .toList();
        if (_editing?.id == comment.id || _replyTo?.id == comment.id) {
          _cancelContext();
        }
      });
      final removed = 1 + replyCount;
      _updatePost(
        _post.copyWith(
          commentCount: (_post.commentCount - removed).clamp(
            0,
            _post.commentCount,
          ),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      showSocialSnackBar(context, 'Could not delete comment. Check your connection.');
    }
  }

  /// Top-level comments in order, each followed by its replies.
  List<SocialComment> get _threaded {
    final ids = {for (final c in _comments) c.id};
    final repliesByParent = <String, List<SocialComment>>{};
    final topLevel = <SocialComment>[];

    for (final c in _comments) {
      final parent = c.parentComment;
      if (parent != null && ids.contains(parent)) {
        repliesByParent.putIfAbsent(parent, () => []).add(c);
      } else {
        topLevel.add(c);
      }
    }

    return [
      for (final c in topLevel) ...[c, ...?repliesByParent[c.id]],
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profile = context.watch<ProfileProvider>().profile;
    final threaded = _threaded;

    return Scaffold(
      appBar: AppBar(title: const Text('Post')),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: _loadComments,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                children: [
                  SocialPostCard(
                    post: _post,
                    onChanged: _updatePost,
                    onDeleted: () {
                      widget.onDeleted();
                      Navigator.pop(context);
                    },
                    onOpenComments: () {
                      if (requireSocialSignIn(context, action: 'comment')) {
                        _inputFocus.requestFocus();
                      }
                    },
                  ),
                  Text(
                    'Comments',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 6),
                  if (_isLoading)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (_error != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Column(
                        children: [
                          Text(
                            _error!,
                            style: TextStyle(
                              color: theme.colorScheme.error,
                              fontSize: 12,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: _loadComments,
                            icon: const Icon(Icons.refresh, size: 18),
                            label: const Text('Retry'),
                          ),
                        ],
                      ),
                    )
                  else if (threaded.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Column(
                        children: [
                          Icon(
                            Icons.forum_outlined,
                            size: 36,
                            color: theme.colorScheme.outline,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'No comments yet. Start the conversation.',
                            style: TextStyle(
                              fontSize: 12.5,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    for (final comment in threaded)
                      SocialCommentTile(
                        key: ValueKey(comment.id),
                        comment: comment,
                        isOwner: profile?.id == comment.author.id,
                        onLike: () => _toggleCommentLike(comment),
                        onReply: () => _startReply(comment),
                        onEdit: () => _startEdit(comment),
                        onDelete: () => _deleteComment(comment),
                      ),
                ],
              ),
            ),
          ),
          _buildInputBar(theme, profile != null),
        ],
      ),
    );
  }

  Widget _buildInputBar(ThemeData theme, bool isSignedIn) {
    final contextLabel = _editing != null
        ? 'Editing your comment'
        : _replyTo != null
        ? 'Replying to ${_replyTo!.author.name ?? 'comment'}'
        : null;

    return Material(
      color: theme.colorScheme.surfaceContainerLowest,
      elevation: 8,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
          child: !isSignedIn
              ? SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () => Navigator.pushNamed(context, '/login'),
                    icon: const Icon(Icons.login, size: 18),
                    label: const Text('Sign in to join the conversation'),
                  ),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (contextLabel != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 4, bottom: 4),
                        child: Row(
                          children: [
                            Icon(
                              _editing != null
                                  ? Icons.edit_outlined
                                  : Icons.reply,
                              size: 14,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                contextLabel,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: _cancelContext,
                              child: Icon(
                                Icons.close,
                                size: 16,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _inputController,
                            focusNode: _inputFocus,
                            minLines: 1,
                            maxLines: 5,
                            maxLength: _maxCommentLength,
                            textCapitalization: TextCapitalization.sentences,
                            onChanged: (_) => setState(() {}),
                            decoration: InputDecoration(
                              hintText: _replyTo != null
                                  ? 'Write a reply…'
                                  : 'Write a comment…',
                              hintStyle: TextStyle(
                                fontSize: 13,
                                color: theme.colorScheme.outline,
                              ),
                              counterText: '',
                              isDense: true,
                              filled: true,
                              fillColor: theme.colorScheme.surfaceContainerLow,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        _isSending
                            ? const Padding(
                                padding: EdgeInsets.all(12),
                                child: SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              )
                            : IconButton(
                                onPressed:
                                    _inputController.text.trim().isEmpty
                                    ? null
                                    : _send,
                                color: theme.colorScheme.primary,
                                icon: Icon(
                                  _editing != null
                                      ? Icons.check_circle
                                      : Icons.send_rounded,
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
