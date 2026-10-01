import 'package:flutter/material.dart';
import '../../models/social_post.dart';
import '../../utils/social_format.dart';
import 'social_common.dart';

class SocialCommentTile extends StatelessWidget {
  final SocialComment comment;
  final bool isOwner;
  final VoidCallback onLike;
  final VoidCallback onReply;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const SocialCommentTile({
    super.key,
    required this.comment,
    required this.isOwner,
    required this.onLike,
    required this.onReply,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.colorScheme.onSurfaceVariant;
    final actionStyle = TextStyle(
      fontSize: 11.5,
      fontWeight: FontWeight.bold,
      color: muted,
    );

    return Padding(
      padding: EdgeInsets.only(
        left: comment.isReply ? 44 : 0,
        top: 6,
        bottom: 6,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SocialAvatar(author: comment.author, radius: comment.isReply ? 14 : 17),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onLongPress: isOwner ? () => _showOwnerActions(context) : null,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SocialAuthorName(author: comment.author, fontSize: 12),
                        const SizedBox(height: 3),
                        Text(
                          comment.content,
                          style: const TextStyle(fontSize: 13, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 4),
                  child: Row(
                    children: [
                      Text(
                        socialTimeAgo(comment.createdAt) +
                            (comment.editedAt != null ? ' · edited' : ''),
                        style: TextStyle(fontSize: 11, color: muted),
                      ),
                      const SizedBox(width: 14),
                      GestureDetector(
                        onTap: onLike,
                        child: Text(
                          comment.liked ? 'Liked' : 'Like',
                          style: actionStyle.copyWith(
                            color: comment.liked ? Colors.red : muted,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      GestureDetector(
                        onTap: onReply,
                        child: Text('Reply', style: actionStyle),
                      ),
                      if (isOwner) ...[
                        const SizedBox(width: 14),
                        GestureDetector(
                          onTap: () => _showOwnerActions(context),
                          child: Icon(Icons.more_horiz, size: 16, color: muted),
                        ),
                      ],
                      const Spacer(),
                      if (comment.likeCount > 0) ...[
                        const Icon(Icons.favorite, size: 12, color: Colors.red),
                        const SizedBox(width: 3),
                        Text(
                          socialCount(comment.likeCount),
                          style: TextStyle(fontSize: 11, color: muted),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showOwnerActions(BuildContext context) {
    final theme = Theme.of(context);

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: const Text('Edit comment'),
              onTap: () {
                Navigator.pop(sheetContext);
                onEdit();
              },
            ),
            ListTile(
              leading: Icon(Icons.delete_outline, color: theme.colorScheme.error),
              title: Text(
                'Delete comment',
                style: TextStyle(color: theme.colorScheme.error),
              ),
              onTap: () {
                Navigator.pop(sheetContext);
                onDelete();
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
