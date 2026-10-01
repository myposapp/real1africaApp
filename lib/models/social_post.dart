import 'package:dart_mappable/dart_mappable.dart';
import '../data/static_configs.dart';
import 'property.dart';

part 'social_post.mapper.dart';

@MappableClass()
class SocialAuthor with SocialAuthorMappable {
  const SocialAuthor({
    required this.id,
    this.name,
    this.photo,
    this.verifiedAgent,
    this.verifiedSurveyor,
  });

  @MappableField(key: "_id")
  final String id;
  final String? name;
  final String? photo;
  final bool? verifiedAgent;
  final bool? verifiedSurveyor;

  String? get photoUrl =>
      photo == null ? null : "${EstateConfigs.contentBaseUrl}$photo";

  String get initials {
    final parts = (name ?? '')
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  static final fromMap = SocialAuthorMapper.fromMap;
  static final fromJson = SocialAuthorMapper.fromJson;
}

@MappableClass()
class SocialMedia with SocialMediaMappable {
  const SocialMedia({
    required this.type,
    required this.url,
    this.mime,
    this.name,
    this.size,
  });

  /// "image" | "video"
  final String type;
  final String url;
  final String? mime;
  final String? name;
  final int? size;

  bool get isVideo => type == "video";

  String get fullUrl => "${EstateConfigs.contentBaseUrl}$url";

  static final fromMap = SocialMediaMapper.fromMap;
  static final fromJson = SocialMediaMapper.fromJson;
}

@MappableClass()
class SocialLinkedProperty with SocialLinkedPropertyMappable {
  const SocialLinkedProperty({
    required this.id,
    required this.title,
    this.media = const [],
  });

  @MappableField(key: "_id")
  final String id;
  final String title;
  final List<PropertyMedia> media;

  String? get coverUrl => media.isEmpty ? null : media.first.fullUrl;

  static final fromMap = SocialLinkedPropertyMapper.fromMap;
  static final fromJson = SocialLinkedPropertyMapper.fromJson;
}

@MappableClass()
class SocialPost with SocialPostMappable {
  const SocialPost({
    required this.id,
    required this.author,
    this.content = '',
    this.media = const [],
    this.linkedProperty,
    this.tags = const [],
    this.visibility = 'public',
    this.status,
    this.likeCount = 0,
    this.commentCount = 0,
    this.liked = false,
    this.editedAt,
    required this.createdAt,
    this.updatedAt,
  });

  @MappableField(key: "_id")
  final String id;
  final SocialAuthor author;
  final String content;
  final List<SocialMedia> media;
  final SocialLinkedProperty? linkedProperty;
  final List<String> tags;

  /// "public" | "followers" | "private"
  final String visibility;
  final String? status;
  final int likeCount;
  final int commentCount;
  final bool liked;
  final String? editedAt;
  @MappableField(key: "createdAt")
  final String createdAt;
  @MappableField(key: "updatedAt")
  final String? updatedAt;

  static final fromMap = SocialPostMapper.fromMap;
  static final fromJson = SocialPostMapper.fromJson;
}

@MappableClass()
class SocialComment with SocialCommentMappable {
  const SocialComment({
    required this.id,
    required this.post,
    required this.author,
    this.parentComment,
    required this.content,
    this.status,
    this.likeCount = 0,
    this.replyCount = 0,
    this.liked = false,
    this.editedAt,
    required this.createdAt,
    this.updatedAt,
  });

  @MappableField(key: "_id")
  final String id;
  final String post;
  final SocialAuthor author;

  /// Id of the top-level comment this is a reply to. Replies to replies are
  /// re-attached to the original top-level comment by the API.
  final String? parentComment;
  final String content;
  final String? status;
  final int likeCount;
  final int replyCount;
  final bool liked;
  final String? editedAt;
  @MappableField(key: "createdAt")
  final String createdAt;
  @MappableField(key: "updatedAt")
  final String? updatedAt;

  bool get isReply => parentComment != null;

  static final fromMap = SocialCommentMapper.fromMap;
  static final fromJson = SocialCommentMapper.fromJson;
}

/// Result of toggling a like on a post or comment.
@MappableClass()
class SocialReaction with SocialReactionMappable {
  const SocialReaction({required this.liked, required this.likeCount});

  final bool liked;
  final int likeCount;

  static final fromMap = SocialReactionMapper.fromMap;
  static final fromJson = SocialReactionMapper.fromJson;
}
