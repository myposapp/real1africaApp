import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../models/property.dart';
import '../../models/social_post.dart';
import '../../network/provider/network_provider.dart';
import '../../providers/person_provider.dart';
import '../../utils/social_format.dart';
import 'social_common.dart';

/// Bottom sheet for creating a post, or editing [post] when given.
/// Pops with the created/updated [SocialPost], or null if dismissed.
class SocialPostComposer extends StatefulWidget {
  final SocialPost? post;

  const SocialPostComposer({super.key, this.post});

  static Future<SocialPost?> show(BuildContext context, {SocialPost? post}) {
    return showModalBottomSheet<SocialPost>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => SocialPostComposer(post: post),
    );
  }

  @override
  State<SocialPostComposer> createState() => _SocialPostComposerState();
}

class _SocialPostComposerState extends State<SocialPostComposer> {
  static const _maxContentLength = 5000;
  static const _maxMedia = 10;
  static const _videoExtensions = {
    'mp4',
    'mov',
    'm4v',
    'webm',
    '3gp',
    'mkv',
    'avi',
  };

  late final TextEditingController _contentController;
  late final TextEditingController _tagsController;
  final List<File> _media = [];
  late String _visibility;
  Property? _linkedProperty;
  bool _isSubmitting = false;
  String? _errorMessage;

  bool get _isEditing => widget.post != null;

  @override
  void initState() {
    super.initState();
    final post = widget.post;
    _contentController = TextEditingController(text: post?.content ?? '');
    _tagsController = TextEditingController(text: post?.tags.join(', ') ?? '');
    _visibility = post?.visibility ?? 'public';
  }

  @override
  void dispose() {
    _contentController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  bool _isVideo(File file) =>
      _videoExtensions.contains(file.path.split('.').last.toLowerCase());

  Future<void> _pickMedia() async {
    final remaining = _maxMedia - _media.length;
    if (remaining <= 0) {
      showSocialSnackBar(context, 'You can attach up to $_maxMedia files.');
      return;
    }

    final picked = await ImagePicker().pickMultipleMedia(imageQuality: 85);
    if (picked.isEmpty || !mounted) return;

    if (picked.length > remaining) {
      showSocialSnackBar(
        context,
        'Only the first $remaining file(s) were added (max $_maxMedia).',
      );
    }
    setState(() {
      _media.addAll(picked.take(remaining).map((x) => File(x.path)));
    });
  }

  Future<void> _pickLinkedProperty() async {
    final selected = await showModalBottomSheet<Property>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const _LinkPropertySheet(),
    );
    if (selected != null) setState(() => _linkedProperty = selected);
  }

  Future<void> _submit() async {
    final content = _contentController.text.trim();
    final tags = parseSocialTags(_tagsController.text);

    if (!_isEditing && content.isEmpty && _media.isEmpty) {
      setState(() => _errorMessage = 'Write something or add a photo/video.');
      return;
    }
    if (_isEditing && content.isEmpty && widget.post!.media.isEmpty &&
        _media.isEmpty) {
      setState(() => _errorMessage = 'A post needs text or media.');
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    final networkRepo = context.read<NetworkProvider>().networkRepo;
    try {
      final response = _isEditing
          ? await networkRepo.updateSocialPost(
              widget.post!.id,
              content: content,
              tags: tags,
              visibility: _visibility,
              media: _media.isEmpty ? null : _media,
            )
          : await networkRepo.createSocialPost(
              content: content.isEmpty ? null : content,
              media: _media,
              tags: tags.isEmpty ? null : tags,
              linkedPropertyId: _linkedProperty?.id,
              visibility: _visibility,
            );

      if (!mounted) return;
      if (response.success == true && response.data != null) {
        showSocialSnackBar(
          context,
          _isEditing ? 'Post updated' : 'Post shared with the community',
        );
        Navigator.pop(context, response.data);
        return;
      }
      setState(() {
        _isSubmitting = false;
        _errorMessage = response.message ?? 'Could not save your post.';
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
        _errorMessage = 'Could not save your post. Check your connection.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profile = context.watch<ProfileProvider>().profile;
    final tags = parseSocialTags(_tagsController.text);
    final existingMediaCount = widget.post?.media.length ?? 0;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                if (profile != null)
                  SocialAvatar(
                    radius: 18,
                    author: SocialAuthor(
                      id: profile.id,
                      name: profile.name,
                      photo: profile.photo,
                    ),
                  ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _isEditing ? 'Edit post' : 'Create post',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _contentController,
              autofocus: !_isEditing,
              minLines: 4,
              maxLines: 10,
              maxLength: _maxContentLength,
              textCapitalization: TextCapitalization.sentences,
              decoration: _inputDecoration(
                theme,
                hint: 'Share what you know, or ask what you don\'t…',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _tagsController,
              onChanged: (_) => setState(() {}),
              decoration: _inputDecoration(
                theme,
                hint: 'Tags, e.g. lagos, lekki, duplex',
                prefixIcon: Icons.tag,
              ),
            ),
            if (tags.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final tag in tags)
                    Chip(
                      label: Text('#$tag'),
                      visualDensity: VisualDensity.compact,
                    ),
                ],
              ),
            ],
            const SizedBox(height: 16),
            _sectionLabel(theme, 'Who can see this?'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                for (final option in socialVisibilityOptions)
                  ChoiceChip(
                    avatar: Icon(socialVisibilityIcon(option), size: 16),
                    label: Text(socialVisibilityLabel(option)),
                    selected: _visibility == option,
                    showCheckmark: false,
                    onSelected: (_) => setState(() => _visibility = option),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            _sectionLabel(theme, 'Photos & videos'),
            if (_isEditing && existingMediaCount > 0) ...[
              const SizedBox(height: 4),
              Text(
                _media.isEmpty
                    ? 'This post has $existingMediaCount file(s). Adding new media will replace them.'
                    : 'The $existingMediaCount existing file(s) will be replaced.',
                style: TextStyle(
                  fontSize: 11.5,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            const SizedBox(height: 8),
            _buildMediaPicker(theme),
            if (!_isEditing) ...[
              const SizedBox(height: 16),
              _sectionLabel(theme, 'Linked property (optional)'),
              const SizedBox(height: 8),
              _buildLinkedProperty(theme),
            ],
            if (_errorMessage != null) ...[
              const SizedBox(height: 14),
              Text(
                _errorMessage!,
                style: TextStyle(color: theme.colorScheme.error, fontSize: 12),
              ),
            ],
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(_isEditing ? 'Save changes' : 'Post'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(ThemeData theme, String text) => Text(
    text,
    style: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: theme.colorScheme.onSurfaceVariant,
    ),
  );

  InputDecoration _inputDecoration(
    ThemeData theme, {
    required String hint,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(fontSize: 13, color: theme.colorScheme.outline),
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 18) : null,
      filled: true,
      fillColor: theme.colorScheme.surfaceContainerLow,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    );
  }

  Widget _buildMediaPicker(ThemeData theme) {
    return SizedBox(
      height: 76,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          InkWell(
            onTap: _isSubmitting ? null : _pickMedia,
            borderRadius: BorderRadius.circular(14),
            child: Container(
              width: 76,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: theme.colorScheme.primary.withValues(alpha: 0.5),
                ),
                color: theme.colorScheme.primary.withValues(alpha: 0.06),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${_media.length}/$_maxMedia',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          for (var i = 0; i < _media.length; i++)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: _isVideo(_media[i])
                        ? Container(
                            width: 76,
                            height: 76,
                            color: const Color(0xFF0F172A),
                            child: const Icon(
                              Icons.videocam_outlined,
                              color: Colors.white,
                            ),
                          )
                        : Image.file(
                            _media[i],
                            width: 76,
                            height: 76,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () => setState(() => _media.removeAt(i)),
                      child: const CircleAvatar(
                        radius: 11,
                        backgroundColor: Colors.black54,
                        child: Icon(Icons.close, size: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLinkedProperty(ThemeData theme) {
    final property = _linkedProperty;
    if (property == null) {
      return OutlinedButton.icon(
        onPressed: _isSubmitting ? null : _pickLinkedProperty,
        icon: const Icon(Icons.home_work_outlined, size: 18),
        label: const Text('Link one of your listings'),
      );
    }

    final coverUrl = property.media.isNotEmpty
        ? property.media.first.fullUrl
        : null;

    return Container(
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
                ? Image.network(coverUrl, width: 44, height: 44, fit: BoxFit.cover)
                : Container(
                    width: 44,
                    height: 44,
                    color: theme.colorScheme.primaryContainer,
                    child: Icon(
                      Icons.home_work_outlined,
                      color: theme.colorScheme.primary,
                    ),
                  ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              property.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 18),
            onPressed: () => setState(() => _linkedProperty = null),
          ),
        ],
      ),
    );
  }
}

/// Lists the signed-in user's active public listings, which are the only
/// properties the API accepts as a post's linked property.
class _LinkPropertySheet extends StatefulWidget {
  const _LinkPropertySheet();

  @override
  State<_LinkPropertySheet> createState() => _LinkPropertySheetState();
}

class _LinkPropertySheetState extends State<_LinkPropertySheet> {
  List<Property> _properties = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final profile = context.read<ProfileProvider>().profile;
    final networkRepo = context.read<NetworkProvider>().networkRepo;

    try {
      final response = await networkRepo.getManagedProperties(
        pageSize: 100,
        user: profile?.id,
        status: 'active',
      );
      if (!mounted) return;
      setState(() {
        _properties = (response.data ?? [])
            .where((p) => p.status == 'active' && p.visibility == 'public')
            .toList();
        _isLoading = false;
        if (response.success != true) {
          _error = response.message ?? 'Could not load your listings.';
        }
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _error = 'Could not load your listings.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 4),
            child: Text(
              'Link a property',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Text(
              'Only your active, public listings can be linked.',
              style: TextStyle(
                fontSize: 12,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Flexible(
            child: _isLoading
                ? const Padding(
                    padding: EdgeInsets.all(40),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : _error != null || _properties.isEmpty
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                    child: Text(
                      _error ?? 'You have no active public listings yet.',
                      style: TextStyle(
                        fontSize: 13,
                        color: _error != null
                            ? theme.colorScheme.error
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
                    itemCount: _properties.length,
                    itemBuilder: (context, i) {
                      final property = _properties[i];
                      final coverUrl = property.media.isNotEmpty
                          ? property.media.first.fullUrl
                          : null;
                      return ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: coverUrl != null
                              ? Image.network(
                                  coverUrl,
                                  width: 48,
                                  height: 48,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  width: 48,
                                  height: 48,
                                  color: theme.colorScheme.primaryContainer,
                                  child: const Icon(Icons.home_work_outlined),
                                ),
                        ),
                        title: Text(
                          property.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        onTap: () => Navigator.pop(context, property),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
