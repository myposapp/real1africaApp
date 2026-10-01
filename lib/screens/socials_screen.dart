import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/social_post.dart';
import '../models/user_profile.dart';
import '../network/provider/network_provider.dart';
import '../providers/person_provider.dart';
import '../widgets/social/social_common.dart';
import '../widgets/social/social_post_card.dart';
import '../widgets/social/social_post_composer.dart';
import 'social_post_screen.dart';

class SocialsScreen extends StatefulWidget {
  const SocialsScreen({super.key});

  @override
  State<SocialsScreen> createState() => _SocialsScreenState();
}

class _SocialsScreenState extends State<SocialsScreen> {
  static const _pageSize = 20;

  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  Timer? _searchDebounce;

  List<SocialPost> _posts = [];
  int _page = 0;
  int? _total;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  String? _error;

  String? _search;
  String? _tag;
  bool _onlyMine = false;

  /// Incremented on every fresh load so responses from superseded
  /// requests (e.g. an older search) are ignored.
  int _requestId = 0;

  /// The signed-in user the feed was last loaded for. The feed reloads when
  /// this changes, since liked state and visible posts depend on the user.
  String? _loadedForUserId;
  bool _hasLoaded = false;

  bool get _hasMore => _total == null || _posts.length < _total!;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.extentAfter < 600) _loadMore();
  }

  Future<void> _refresh() async {
    final requestId = ++_requestId;
    setState(() {
      _isLoading = true;
      _isLoadingMore = false;
      _error = null;
    });

    final posts = await _fetch(page: 1, requestId: requestId);
    if (!mounted || requestId != _requestId) return;
    setState(() {
      _isLoading = false;
      if (posts != null) {
        _posts = posts;
        _page = 1;
      }
    });
  }

  Future<void> _loadMore() async {
    if (_isLoading || _isLoadingMore || !_hasMore || _error != null) return;

    final requestId = _requestId;
    setState(() => _isLoadingMore = true);

    final posts = await _fetch(page: _page + 1, requestId: requestId);
    if (!mounted || requestId != _requestId) return;
    setState(() {
      _isLoadingMore = false;
      if (posts != null) {
        final known = {for (final p in _posts) p.id};
        _posts = [..._posts, ...posts.where((p) => !known.contains(p.id))];
        _page++;
        // Stop paging if the server returned less than a full page.
        if (posts.length < _pageSize) _total = _posts.length;
      }
    });
  }

  Future<List<SocialPost>?> _fetch({
    required int page,
    required int requestId,
  }) async {
    final networkRepo = context.read<NetworkProvider>().networkRepo;
    final profile = context.read<ProfileProvider>().profile;

    try {
      final response = await networkRepo.getSocialPosts(
        page: page,
        pageSize: _pageSize,
        search: _search,
        tag: _tag,
        authorId: _onlyMine ? profile?.id : null,
      );
      if (requestId != _requestId) return null;
      if (response.success != true) {
        _error = response.message ?? 'Could not load the community feed.';
        return null;
      }
      _total = response.metadata?.total;
      return response.data ?? [];
    } catch (_) {
      if (requestId == _requestId) {
        _error = 'Could not load the community feed. Check your connection.';
      }
      return null;
    }
  }

  void _onSearchChanged(String value) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 450), () {
      final search = value.trim().isEmpty ? null : value.trim();
      if (search == _search) return;
      _search = search;
      _refresh();
    });
    setState(() {});
  }

  void _setTag(String? tag) {
    if (tag == _tag) return;
    setState(() => _tag = tag);
    _refresh();
    if (_scrollController.hasClients) _scrollController.jumpTo(0);
  }

  void _setOnlyMine(bool value) {
    if (value && !requireSocialSignIn(context, action: 'see your posts')) {
      return;
    }
    if (value == _onlyMine) return;
    setState(() => _onlyMine = value);
    _refresh();
  }

  Future<void> _createPost() async {
    if (!requireSocialSignIn(context, action: 'post')) return;
    final created = await SocialPostComposer.show(context);
    if (created == null || !mounted) return;
    setState(() {
      _posts = [created, ..._posts];
      if (_total != null) _total = _total! + 1;
    });
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _replacePost(SocialPost post) {
    if (!mounted) return;
    setState(() {
      _posts = [for (final p in _posts) p.id == post.id ? post : p];
    });
  }

  void _removePost(String postId) {
    if (!mounted) return;
    setState(() {
      _posts = _posts.where((p) => p.id != postId).toList();
      if (_total != null && _total! > 0) _total = _total! - 1;
    });
  }

  void _openPost(SocialPost post, {bool focusComposer = false}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SocialPostScreen(
          post: post,
          focusComposer: focusComposer,
          onChanged: _replacePost,
          onDeleted: () => _removePost(post.id),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profile = context.watch<ProfileProvider>().profile;

    if (!_hasLoaded || profile?.id != _loadedForUserId) {
      _hasLoaded = true;
      _loadedForUserId = profile?.id;
      if (profile == null) _onlyMine = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _refresh();
      });
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      child: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            sliver: SliverList.list(
              children: [
                _buildHeader(theme),
                const SizedBox(height: 16),
                _buildSearchBar(theme),
                const SizedBox(height: 12),
                _buildFilters(theme, profile != null),
                const SizedBox(height: 14),
                _buildComposerPrompt(theme, profile),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Text(
                      _onlyMine ? 'Your posts' : 'Community feed',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (_total != null && !_isLoading)
                      Text(
                        '$_total post${_total == 1 ? '' : 's'}',
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          ..._buildFeed(theme),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'COMMUNITY',
          style: TextStyle(
            fontSize: 11,
            letterSpacing: 1.2,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'The property conversation lives here.',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Share what you know, ask what you don\'t, and make better property decisions together.',
          style: TextStyle(
            fontSize: 12.5,
            height: 1.4,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(ThemeData theme) {
    return TextField(
      controller: _searchController,
      onChanged: _onSearchChanged,
      textInputAction: TextInputAction.search,
      style: const TextStyle(fontSize: 13),
      decoration: InputDecoration(
        hintText: 'Search conversations…',
        hintStyle: TextStyle(fontSize: 13, color: theme.colorScheme.outline),
        prefixIcon: Icon(Icons.search, color: theme.colorScheme.outline),
        suffixIcon: _searchController.text.isEmpty
            ? null
            : IconButton(
                icon: const Icon(Icons.close, size: 18),
                onPressed: () {
                  _searchController.clear();
                  _onSearchChanged('');
                },
              ),
        filled: true,
        fillColor: theme.colorScheme.surfaceContainerLowest,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
          ),
        ),
      ),
    );
  }

  Widget _buildFilters(ThemeData theme, bool isSignedIn) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ChoiceChip(
            label: const Text('All posts'),
            selected: !_onlyMine,
            showCheckmark: false,
            onSelected: (_) => _setOnlyMine(false),
          ),
          const SizedBox(width: 8),
          ChoiceChip(
            label: const Text('My posts'),
            selected: _onlyMine,
            showCheckmark: false,
            onSelected: (_) => _setOnlyMine(true),
          ),
          if (_tag != null) ...[
            const SizedBox(width: 8),
            InputChip(
              label: Text('#$_tag'),
              selected: true,
              showCheckmark: false,
              onDeleted: () => _setTag(null),
              onPressed: () => _setTag(null),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildComposerPrompt(ThemeData theme, UserProfile? profile) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: _createPost,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              if (profile != null)
                SocialAvatar(
                  radius: 18,
                  author: SocialAuthor(
                    id: profile.id,
                    name: profile.name,
                    photo: profile.photo,
                  ),
                )
              else
                CircleAvatar(
                  radius: 18,
                  backgroundColor: theme.colorScheme.surfaceContainerLow,
                  child: Icon(
                    Icons.person,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  profile != null
                      ? 'Share something with the community…'
                      : 'Sign in to join the conversation',
                  style: TextStyle(
                    fontSize: 13,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              Icon(
                Icons.add_photo_alternate_outlined,
                color: theme.colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFeed(ThemeData theme) {
    if (_isLoading && _posts.isEmpty) {
      return const [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 60),
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
      ];
    }

    if (_error != null && _posts.isEmpty) {
      return [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Column(
              children: [
                Icon(Icons.cloud_off, size: 40, color: theme.colorScheme.error),
                const SizedBox(height: 10),
                Text(
                  _error!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: theme.colorScheme.error),
                ),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: _refresh,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ];
    }

    if (_posts.isEmpty) {
      final filtered = _search != null || _tag != null || _onlyMine;
      return [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: theme.colorScheme.primary.withValues(
                    alpha: 0.12,
                  ),
                  child: Icon(
                    Icons.forum_outlined,
                    size: 30,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  filtered ? 'No posts match your filters.' : 'No posts yet.',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  filtered
                      ? 'Try a different search or clear the filters.'
                      : 'Be the first to start a property conversation.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ];
    }

    return [
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverList.builder(
          itemCount: _posts.length,
          itemBuilder: (context, i) {
            final post = _posts[i];
            return SocialPostCard(
              key: ValueKey(post.id),
              post: post,
              onChanged: _replacePost,
              onDeleted: () => _removePost(post.id),
              onOpenComments: () => _openPost(post, focusComposer: true),
              onTagTap: _setTag,
            );
          },
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 28),
          child: Center(
            child: _isLoadingMore
                ? const CircularProgressIndicator()
                : _error != null
                ? TextButton.icon(
                    onPressed: () {
                      setState(() => _error = null);
                      _loadMore();
                    },
                    icon: const Icon(Icons.refresh, size: 18),
                    label: const Text('Load more'),
                  )
                : !_hasMore
                ? Text(
                    'You\'re all caught up',
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ),
    ];
  }
}
