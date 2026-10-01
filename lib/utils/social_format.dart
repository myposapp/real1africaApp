import 'package:flutter/material.dart';

const _months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

/// Short relative timestamp for feed items: "now", "5m", "3h", "2d",
/// then "12 Sep" (or "12 Sep 2025" for previous years).
String socialTimeAgo(String isoDate) {
  final date = DateTime.tryParse(isoDate)?.toLocal();
  if (date == null) return '';

  final now = DateTime.now();
  final diff = now.difference(date);

  if (diff.inMinutes < 1) return 'now';
  if (diff.inHours < 1) return '${diff.inMinutes}m';
  if (diff.inDays < 1) return '${diff.inHours}h';
  if (diff.inDays < 7) return '${diff.inDays}d';

  final label = '${date.day} ${_months[date.month - 1]}';
  return date.year == now.year ? label : '$label ${date.year}';
}

/// Compact counter: 999, 1.2k, 3.4M.
String socialCount(int count) {
  if (count < 1000) return '$count';
  if (count < 1000000) {
    return '${(count / 1000).toStringAsFixed(count < 10000 ? 1 : 0)}k';
  }
  return '${(count / 1000000).toStringAsFixed(1)}M';
}

const socialVisibilityOptions = ['public', 'followers', 'private'];

String socialVisibilityLabel(String visibility) => switch (visibility) {
  'followers' => 'Followers',
  'private' => 'Only me',
  _ => 'Public',
};

IconData socialVisibilityIcon(String visibility) => switch (visibility) {
  'followers' => Icons.group_outlined,
  'private' => Icons.lock_outline,
  _ => Icons.public,
};

/// Normalizes free-form tag input ("#Lagos, lekki  duplex") into the
/// lowercase, de-duplicated list the API expects (max 30 tags).
List<String> parseSocialTags(String input) {
  final tags = <String>{};
  for (final raw in input.split(RegExp(r'[,\s]+'))) {
    final tag = raw.replaceAll('#', '').trim().toLowerCase();
    if (tag.isNotEmpty) tags.add(tag);
    if (tags.length == 30) break;
  }
  return tags.toList();
}
