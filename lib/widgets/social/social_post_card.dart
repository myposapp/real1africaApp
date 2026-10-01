import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/social_post.dart';
import '../../network/provider/network_provider.dart';
import '../../providers/person_provider.dart';
import '../../screens/property_detail_screen.dart';
import '../../utils/social_format.dart';
import '../confirmation_dialog.dart';
import 'social_common.dart';
import 'social_media_viewer.dart';
import 'social_post_composer.dart';

class SocialPostCard extends StatefulWidget {
  final SocialPost post;
  final ValueChanged<SocialPost> onChanged;
  final VoidCallback onDeleted;

  /// Opens the post's comment thread. Null when the card is already shown on
  /// the post detail screen.
  final VoidCallback? onOpenComments;
  final ValueChanged<String>? onTagTap;

  const SocialPostCard({
    super.key,
    required this.post,
    required this.onChanged,
    required this.onDeleted,
    this.onOpenComments,
    this.onTagTap,
  });

  @override
  State<SocialPostCard> createState() => _SocialPostCardState();
}

class _SocialPostCardState extends State<SocialPostCard> {
  static const _collapsedLength = 280;

  bool _isLiking = false;
  bool _isExpanded = false;

  SocialPost get _post => widget.post;

  Future<void> _toggleLike() async {
    if (_isLiking || !requireSocialSignIn(context, action: 'like posts')) {
      return;
    }

    // Optimistic update, reconciled with the server's count below.
    final original = _post;
    final liked = !original.liked;
    widget.onChanged(
      original.copyWith(
        liked: liked,
        likeCount: liked
            ? original.likeCount + 1
            : (original.likeCount - 1).clamp(0, original.likeCount),
      ),
    );
    setState(() => _isLiking = true);

    final networkRepo = context.read<NetworkProvider>().networkRepo;
    try {
      final response = await networkRepo.toggleSocialPostLike(original.id);
      if (!mounted) return;
      final reaction = response.data;
      if (response.success == true && reaction != null) {
        widget.onChanged(
          original.copyWith(
            liked: reaction.liked,
            likeCount: reaction.likeCount,
          ),
        );
      } else {
        widget.onChanged(original);
        showSocialSnackBar(context, response.message ?? 'Could not like post.');
      }
    } catch (_) {
      if (!mounted) return;
      widget.onChanged(original);
      showSocialSnackBar(context, 'Could not like post. Check your connection.');
    }

    if (mounted) setState(() => _isLiking = false);
  }

  Future<void> _edit() async {
    final updated = await SocialPostComposer.show(context, post: _post);
    if (updated != null) widget.onChanged(updated);
  }

  Future<void> _delete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => ConfirmationDialog(
        title: 'Delete post?',
        message:
            'This also deletes its comments, likes and uploaded media. This cannot be undone.',
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
      final response = await networkRepo.deleteSocialPost(_post.id);
      if (!mounted) return;
      if (response.success == true) {
        showSocialSnackBar(context, 'Post deleted');
        widget.onDeleted();
      } else {
        showSocialSnackBar(context, response.message ?? 'Could not delete post.');
      }
    } catch (_) {
      if (!mounted) return;
      showSocialSnackBar(context, 'Could not delete post. Check your connection.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profile = context.watch<ProfileProvider>().profile;
    final isOwner = profile != null && profile.id == _post.author.id;

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(theme, isOwner),
          if (_post.content.isNotEmpty) _buildContent(theme),
          if (_post.tags.isNotEmpty) _buildTags(theme),
          if (_post.media.isNotEmpty) ...[
            const SizedBox(height: 10),
            _SocialMediaGrid(media: _post.media),
          ],
          if (_post.linkedProperty != null)
            _LinkedPropertyTile(property: _post.linkedProperty!),
          _buildActions(theme),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, bool isOwner) {
    final metaStyle = TextStyle(
      fontSize: 11,
      color: theme.colorScheme.onSurfaceVariant,
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 4, 0),
      child: Row(
        children: [
          SocialAvatar(author: _post.author),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SocialAuthorName(author: _post.author),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(socialTimeAgo(_post.createdAt), style: metaStyle),
                    if (_post.editedAt != null)
                      Text(' · edited', style: metaStyle),
                    Text(' · ', style: metaStyle),
                    Icon(
                      socialVisibilityIcon(_post.visibility),
                      size: 12,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isOwner)
            PopupMenuButton<String>(
              icon: Icon(
                Icons.more_horiz,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              onSelected: (value) => value == 'edit' ? _edit() : _delete(),
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.edit_outlined, size: 20),
                    title: Text('Edit post'),
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.delete_outline,
                      size: 20,
                      color: theme.colorScheme.error,
                    ),
                    title: Text(
                      'Delete post',
                      style: TextStyle(color: theme.colorScheme.error),
                    ),
                  ),
                ),
              ],
            )
          else
            const SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget _buildContent(ThemeData theme) {
    final content = _post.content;
    final isLong = content.length > _collapsedLength;
    final shown = isLong && !_isExpanded
        ? '${content.substring(0, _collapsedLength).trimRight()}…'
        : content;

    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(shown, style: const TextStyle(fontSize: 13.5, height: 1.45)),
          if (isLong)
            GestureDetector(
              onTap: () => setState(() => _isExpanded = !_isExpanded),
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  _isExpanded ? 'See less' : 'See more',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTags(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 0),
      child: Wrap(
        spacing: 6,
        runSpacing: 4,
        children: [
          for (final tag in _post.tags)
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: widget.onTagTap == null
                  ? null
                  : () => widget.onTagTap!(tag),
              child: Text(
                '#$tag',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActions(ThemeData theme) {
    final muted = theme.colorScheme.onSurfaceVariant;

    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
      child: Row(
        children: [
          TextButton.icon(
            onPressed: _toggleLike,
            style: TextButton.styleFrom(foregroundColor: muted),
            icon: Icon(
              _post.liked ? Icons.favorite : Icons.favorite_border,
              size: 20,
              color: _post.liked ? Colors.red : muted,
            ),
            label: Text(
              _post.likeCount > 0 ? socialCount(_post.likeCount) : 'Like',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
          TextButton.icon(
            onPressed: widget.onOpenComments,
            style: TextButton.styleFrom(
              foregroundColor: muted,
              disabledForegroundColor: muted,
            ),
            icon: const Icon(Icons.mode_comment_outlined, size: 19),
            label: Text(
              _post.commentCount > 0
                  ? socialCount(_post.commentCount)
                  : 'Comment',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialMediaGrid extends StatelessWidget {
  final List<SocialMedia> media;

  const _SocialMediaGrid({required this.media});

  @override
  Widget build(BuildContext context) {
    void open(int index) =>
        SocialMediaViewer.open(context, media, initialIndex: index);

    if (media.length == 1) {
      return AspectRatio(
        aspectRatio: 4 / 3,
        child: _MediaTile(item: media.first, onTap: () => open(0)),
      );
    }

    final shown = media.length > 4 ? 4 : media.length;
    final extra = media.length - shown;

    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: shown,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: shown == 2 ? 0.8 : 1,
      ),
      itemBuilder: (context, i) => _MediaTile(
        item: media[i],
        overlayCount: i == shown - 1 ? extra : 0,
        onTap: () => open(i),
      ),
    );
  }
}

class _MediaTile extends StatelessWidget {
  final SocialMedia item;
  final int overlayCount;
  final VoidCallback onTap;

  const _MediaTile({
    required this.item,
    required this.onTap,
    this.overlayCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (item.isVideo)
            Container(
              color: const Color(0xFF0F172A),
              child: const Center(
                child: CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.play_arrow, color: Colors.white, size: 34),
                ),
              ),
            )
          else
            Image.network(
              item.fullUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) => progress == null
                  ? child
                  : Container(color: theme.colorScheme.surfaceContainerLow),
              errorBuilder: (_, _, _) => Container(
                color: theme.colorScheme.surfaceContainerLow,
                child: Icon(
                  Icons.broken_image_outlined,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          if (overlayCount > 0)
            Container(
              color: Colors.black54,
              alignment: Alignment.center,
              child: Text(
                '+$overlayCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _LinkedPropertyTile extends StatelessWidget {
  final SocialLinkedProperty property;

  const _LinkedPropertyTile({required this.property});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final coverUrl = property.coverUrl;

    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PropertyDetailScreen(propertyId: property.id),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: coverUrl != null
                    ? Image.network(
                        coverUrl,
                        width: 52,
                        height: 52,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 52,
                        height: 52,
                        color: theme.colorScheme.primaryContainer,
                        child: Icon(
                          Icons.home_work_outlined,
                          color: theme.colorScheme.primary,
                        ),
                      ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LINKED PROPERTY',
                      style: TextStyle(
                        fontSize: 9.5,
                        letterSpacing: 0.8,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      property.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
