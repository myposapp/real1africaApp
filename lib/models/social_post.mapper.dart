// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'social_post.dart';

class SocialAuthorMapper extends ClassMapperBase<SocialAuthor> {
  SocialAuthorMapper._();

  static SocialAuthorMapper? _instance;
  static SocialAuthorMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SocialAuthorMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SocialAuthor';

  static String _$id(SocialAuthor v) => v.id;
  static const Field<SocialAuthor, String> _f$id = Field(
    'id',
    _$id,
    key: r'_id',
  );
  static String? _$name(SocialAuthor v) => v.name;
  static const Field<SocialAuthor, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static String? _$photo(SocialAuthor v) => v.photo;
  static const Field<SocialAuthor, String> _f$photo = Field(
    'photo',
    _$photo,
    opt: true,
  );
  static bool? _$verifiedAgent(SocialAuthor v) => v.verifiedAgent;
  static const Field<SocialAuthor, bool> _f$verifiedAgent = Field(
    'verifiedAgent',
    _$verifiedAgent,
    opt: true,
  );
  static bool? _$verifiedSurveyor(SocialAuthor v) => v.verifiedSurveyor;
  static const Field<SocialAuthor, bool> _f$verifiedSurveyor = Field(
    'verifiedSurveyor',
    _$verifiedSurveyor,
    opt: true,
  );

  @override
  final MappableFields<SocialAuthor> fields = const {
    #id: _f$id,
    #name: _f$name,
    #photo: _f$photo,
    #verifiedAgent: _f$verifiedAgent,
    #verifiedSurveyor: _f$verifiedSurveyor,
  };

  static SocialAuthor _instantiate(DecodingData data) {
    return SocialAuthor(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      photo: data.dec(_f$photo),
      verifiedAgent: data.dec(_f$verifiedAgent),
      verifiedSurveyor: data.dec(_f$verifiedSurveyor),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SocialAuthor fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SocialAuthor>(map);
  }

  static SocialAuthor fromJson(String json) {
    return ensureInitialized().decodeJson<SocialAuthor>(json);
  }
}

mixin SocialAuthorMappable {
  String toJson() {
    return SocialAuthorMapper.ensureInitialized().encodeJson<SocialAuthor>(
      this as SocialAuthor,
    );
  }

  Map<String, dynamic> toMap() {
    return SocialAuthorMapper.ensureInitialized().encodeMap<SocialAuthor>(
      this as SocialAuthor,
    );
  }

  SocialAuthorCopyWith<SocialAuthor, SocialAuthor, SocialAuthor> get copyWith =>
      _SocialAuthorCopyWithImpl<SocialAuthor, SocialAuthor>(
        this as SocialAuthor,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return SocialAuthorMapper.ensureInitialized().stringifyValue(
      this as SocialAuthor,
    );
  }

  @override
  bool operator ==(Object other) {
    return SocialAuthorMapper.ensureInitialized().equalsValue(
      this as SocialAuthor,
      other,
    );
  }

  @override
  int get hashCode {
    return SocialAuthorMapper.ensureInitialized().hashValue(
      this as SocialAuthor,
    );
  }
}

extension SocialAuthorValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SocialAuthor, $Out> {
  SocialAuthorCopyWith<$R, SocialAuthor, $Out> get $asSocialAuthor =>
      $base.as((v, t, t2) => _SocialAuthorCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SocialAuthorCopyWith<$R, $In extends SocialAuthor, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? name,
    String? photo,
    bool? verifiedAgent,
    bool? verifiedSurveyor,
  });
  SocialAuthorCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SocialAuthorCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SocialAuthor, $Out>
    implements SocialAuthorCopyWith<$R, SocialAuthor, $Out> {
  _SocialAuthorCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SocialAuthor> $mapper =
      SocialAuthorMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    Object? name = $none,
    Object? photo = $none,
    Object? verifiedAgent = $none,
    Object? verifiedSurveyor = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != $none) #name: name,
      if (photo != $none) #photo: photo,
      if (verifiedAgent != $none) #verifiedAgent: verifiedAgent,
      if (verifiedSurveyor != $none) #verifiedSurveyor: verifiedSurveyor,
    }),
  );
  @override
  SocialAuthor $make(CopyWithData data) => SocialAuthor(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    photo: data.get(#photo, or: $value.photo),
    verifiedAgent: data.get(#verifiedAgent, or: $value.verifiedAgent),
    verifiedSurveyor: data.get(#verifiedSurveyor, or: $value.verifiedSurveyor),
  );

  @override
  SocialAuthorCopyWith<$R2, SocialAuthor, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SocialAuthorCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class SocialMediaMapper extends ClassMapperBase<SocialMedia> {
  SocialMediaMapper._();

  static SocialMediaMapper? _instance;
  static SocialMediaMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SocialMediaMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SocialMedia';

  static String _$type(SocialMedia v) => v.type;
  static const Field<SocialMedia, String> _f$type = Field('type', _$type);
  static String _$url(SocialMedia v) => v.url;
  static const Field<SocialMedia, String> _f$url = Field('url', _$url);
  static String? _$mime(SocialMedia v) => v.mime;
  static const Field<SocialMedia, String> _f$mime = Field(
    'mime',
    _$mime,
    opt: true,
  );
  static String? _$name(SocialMedia v) => v.name;
  static const Field<SocialMedia, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static int? _$size(SocialMedia v) => v.size;
  static const Field<SocialMedia, int> _f$size = Field(
    'size',
    _$size,
    opt: true,
  );

  @override
  final MappableFields<SocialMedia> fields = const {
    #type: _f$type,
    #url: _f$url,
    #mime: _f$mime,
    #name: _f$name,
    #size: _f$size,
  };

  static SocialMedia _instantiate(DecodingData data) {
    return SocialMedia(
      type: data.dec(_f$type),
      url: data.dec(_f$url),
      mime: data.dec(_f$mime),
      name: data.dec(_f$name),
      size: data.dec(_f$size),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SocialMedia fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SocialMedia>(map);
  }

  static SocialMedia fromJson(String json) {
    return ensureInitialized().decodeJson<SocialMedia>(json);
  }
}

mixin SocialMediaMappable {
  String toJson() {
    return SocialMediaMapper.ensureInitialized().encodeJson<SocialMedia>(
      this as SocialMedia,
    );
  }

  Map<String, dynamic> toMap() {
    return SocialMediaMapper.ensureInitialized().encodeMap<SocialMedia>(
      this as SocialMedia,
    );
  }

  SocialMediaCopyWith<SocialMedia, SocialMedia, SocialMedia> get copyWith =>
      _SocialMediaCopyWithImpl<SocialMedia, SocialMedia>(
        this as SocialMedia,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return SocialMediaMapper.ensureInitialized().stringifyValue(
      this as SocialMedia,
    );
  }

  @override
  bool operator ==(Object other) {
    return SocialMediaMapper.ensureInitialized().equalsValue(
      this as SocialMedia,
      other,
    );
  }

  @override
  int get hashCode {
    return SocialMediaMapper.ensureInitialized().hashValue(this as SocialMedia);
  }
}

extension SocialMediaValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SocialMedia, $Out> {
  SocialMediaCopyWith<$R, SocialMedia, $Out> get $asSocialMedia =>
      $base.as((v, t, t2) => _SocialMediaCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SocialMediaCopyWith<$R, $In extends SocialMedia, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? type, String? url, String? mime, String? name, int? size});
  SocialMediaCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SocialMediaCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SocialMedia, $Out>
    implements SocialMediaCopyWith<$R, SocialMedia, $Out> {
  _SocialMediaCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SocialMedia> $mapper =
      SocialMediaMapper.ensureInitialized();
  @override
  $R call({
    String? type,
    String? url,
    Object? mime = $none,
    Object? name = $none,
    Object? size = $none,
  }) => $apply(
    FieldCopyWithData({
      if (type != null) #type: type,
      if (url != null) #url: url,
      if (mime != $none) #mime: mime,
      if (name != $none) #name: name,
      if (size != $none) #size: size,
    }),
  );
  @override
  SocialMedia $make(CopyWithData data) => SocialMedia(
    type: data.get(#type, or: $value.type),
    url: data.get(#url, or: $value.url),
    mime: data.get(#mime, or: $value.mime),
    name: data.get(#name, or: $value.name),
    size: data.get(#size, or: $value.size),
  );

  @override
  SocialMediaCopyWith<$R2, SocialMedia, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SocialMediaCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class SocialLinkedPropertyMapper extends ClassMapperBase<SocialLinkedProperty> {
  SocialLinkedPropertyMapper._();

  static SocialLinkedPropertyMapper? _instance;
  static SocialLinkedPropertyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SocialLinkedPropertyMapper._());
      PropertyMediaMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SocialLinkedProperty';

  static String _$id(SocialLinkedProperty v) => v.id;
  static const Field<SocialLinkedProperty, String> _f$id = Field(
    'id',
    _$id,
    key: r'_id',
  );
  static String _$title(SocialLinkedProperty v) => v.title;
  static const Field<SocialLinkedProperty, String> _f$title = Field(
    'title',
    _$title,
  );
  static List<PropertyMedia> _$media(SocialLinkedProperty v) => v.media;
  static const Field<SocialLinkedProperty, List<PropertyMedia>> _f$media =
      Field('media', _$media, opt: true, def: const []);

  @override
  final MappableFields<SocialLinkedProperty> fields = const {
    #id: _f$id,
    #title: _f$title,
    #media: _f$media,
  };

  static SocialLinkedProperty _instantiate(DecodingData data) {
    return SocialLinkedProperty(
      id: data.dec(_f$id),
      title: data.dec(_f$title),
      media: data.dec(_f$media),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SocialLinkedProperty fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SocialLinkedProperty>(map);
  }

  static SocialLinkedProperty fromJson(String json) {
    return ensureInitialized().decodeJson<SocialLinkedProperty>(json);
  }
}

mixin SocialLinkedPropertyMappable {
  String toJson() {
    return SocialLinkedPropertyMapper.ensureInitialized()
        .encodeJson<SocialLinkedProperty>(this as SocialLinkedProperty);
  }

  Map<String, dynamic> toMap() {
    return SocialLinkedPropertyMapper.ensureInitialized()
        .encodeMap<SocialLinkedProperty>(this as SocialLinkedProperty);
  }

  SocialLinkedPropertyCopyWith<
    SocialLinkedProperty,
    SocialLinkedProperty,
    SocialLinkedProperty
  >
  get copyWith =>
      _SocialLinkedPropertyCopyWithImpl<
        SocialLinkedProperty,
        SocialLinkedProperty
      >(this as SocialLinkedProperty, $identity, $identity);
  @override
  String toString() {
    return SocialLinkedPropertyMapper.ensureInitialized().stringifyValue(
      this as SocialLinkedProperty,
    );
  }

  @override
  bool operator ==(Object other) {
    return SocialLinkedPropertyMapper.ensureInitialized().equalsValue(
      this as SocialLinkedProperty,
      other,
    );
  }

  @override
  int get hashCode {
    return SocialLinkedPropertyMapper.ensureInitialized().hashValue(
      this as SocialLinkedProperty,
    );
  }
}

extension SocialLinkedPropertyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SocialLinkedProperty, $Out> {
  SocialLinkedPropertyCopyWith<$R, SocialLinkedProperty, $Out>
  get $asSocialLinkedProperty => $base.as(
    (v, t, t2) => _SocialLinkedPropertyCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class SocialLinkedPropertyCopyWith<
  $R,
  $In extends SocialLinkedProperty,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    PropertyMedia,
    PropertyMediaCopyWith<$R, PropertyMedia, PropertyMedia>
  >
  get media;
  $R call({String? id, String? title, List<PropertyMedia>? media});
  SocialLinkedPropertyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _SocialLinkedPropertyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SocialLinkedProperty, $Out>
    implements SocialLinkedPropertyCopyWith<$R, SocialLinkedProperty, $Out> {
  _SocialLinkedPropertyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SocialLinkedProperty> $mapper =
      SocialLinkedPropertyMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    PropertyMedia,
    PropertyMediaCopyWith<$R, PropertyMedia, PropertyMedia>
  >
  get media => ListCopyWith(
    $value.media,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(media: v),
  );
  @override
  $R call({String? id, String? title, List<PropertyMedia>? media}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (title != null) #title: title,
      if (media != null) #media: media,
    }),
  );
  @override
  SocialLinkedProperty $make(CopyWithData data) => SocialLinkedProperty(
    id: data.get(#id, or: $value.id),
    title: data.get(#title, or: $value.title),
    media: data.get(#media, or: $value.media),
  );

  @override
  SocialLinkedPropertyCopyWith<$R2, SocialLinkedProperty, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _SocialLinkedPropertyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class SocialPostMapper extends ClassMapperBase<SocialPost> {
  SocialPostMapper._();

  static SocialPostMapper? _instance;
  static SocialPostMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SocialPostMapper._());
      SocialAuthorMapper.ensureInitialized();
      SocialMediaMapper.ensureInitialized();
      SocialLinkedPropertyMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SocialPost';

  static String _$id(SocialPost v) => v.id;
  static const Field<SocialPost, String> _f$id = Field('id', _$id, key: r'_id');
  static SocialAuthor _$author(SocialPost v) => v.author;
  static const Field<SocialPost, SocialAuthor> _f$author = Field(
    'author',
    _$author,
  );
  static String _$content(SocialPost v) => v.content;
  static const Field<SocialPost, String> _f$content = Field(
    'content',
    _$content,
    opt: true,
    def: '',
  );
  static List<SocialMedia> _$media(SocialPost v) => v.media;
  static const Field<SocialPost, List<SocialMedia>> _f$media = Field(
    'media',
    _$media,
    opt: true,
    def: const [],
  );
  static SocialLinkedProperty? _$linkedProperty(SocialPost v) =>
      v.linkedProperty;
  static const Field<SocialPost, SocialLinkedProperty> _f$linkedProperty =
      Field('linkedProperty', _$linkedProperty, opt: true);
  static List<String> _$tags(SocialPost v) => v.tags;
  static const Field<SocialPost, List<String>> _f$tags = Field(
    'tags',
    _$tags,
    opt: true,
    def: const [],
  );
  static String _$visibility(SocialPost v) => v.visibility;
  static const Field<SocialPost, String> _f$visibility = Field(
    'visibility',
    _$visibility,
    opt: true,
    def: 'public',
  );
  static String? _$status(SocialPost v) => v.status;
  static const Field<SocialPost, String> _f$status = Field(
    'status',
    _$status,
    opt: true,
  );
  static int _$likeCount(SocialPost v) => v.likeCount;
  static const Field<SocialPost, int> _f$likeCount = Field(
    'likeCount',
    _$likeCount,
    opt: true,
    def: 0,
  );
  static int _$commentCount(SocialPost v) => v.commentCount;
  static const Field<SocialPost, int> _f$commentCount = Field(
    'commentCount',
    _$commentCount,
    opt: true,
    def: 0,
  );
  static bool _$liked(SocialPost v) => v.liked;
  static const Field<SocialPost, bool> _f$liked = Field(
    'liked',
    _$liked,
    opt: true,
    def: false,
  );
  static String? _$editedAt(SocialPost v) => v.editedAt;
  static const Field<SocialPost, String> _f$editedAt = Field(
    'editedAt',
    _$editedAt,
    opt: true,
  );
  static String _$createdAt(SocialPost v) => v.createdAt;
  static const Field<SocialPost, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );
  static String? _$updatedAt(SocialPost v) => v.updatedAt;
  static const Field<SocialPost, String> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    opt: true,
  );

  @override
  final MappableFields<SocialPost> fields = const {
    #id: _f$id,
    #author: _f$author,
    #content: _f$content,
    #media: _f$media,
    #linkedProperty: _f$linkedProperty,
    #tags: _f$tags,
    #visibility: _f$visibility,
    #status: _f$status,
    #likeCount: _f$likeCount,
    #commentCount: _f$commentCount,
    #liked: _f$liked,
    #editedAt: _f$editedAt,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
  };

  static SocialPost _instantiate(DecodingData data) {
    return SocialPost(
      id: data.dec(_f$id),
      author: data.dec(_f$author),
      content: data.dec(_f$content),
      media: data.dec(_f$media),
      linkedProperty: data.dec(_f$linkedProperty),
      tags: data.dec(_f$tags),
      visibility: data.dec(_f$visibility),
      status: data.dec(_f$status),
      likeCount: data.dec(_f$likeCount),
      commentCount: data.dec(_f$commentCount),
      liked: data.dec(_f$liked),
      editedAt: data.dec(_f$editedAt),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SocialPost fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SocialPost>(map);
  }

  static SocialPost fromJson(String json) {
    return ensureInitialized().decodeJson<SocialPost>(json);
  }
}

mixin SocialPostMappable {
  String toJson() {
    return SocialPostMapper.ensureInitialized().encodeJson<SocialPost>(
      this as SocialPost,
    );
  }

  Map<String, dynamic> toMap() {
    return SocialPostMapper.ensureInitialized().encodeMap<SocialPost>(
      this as SocialPost,
    );
  }

  SocialPostCopyWith<SocialPost, SocialPost, SocialPost> get copyWith =>
      _SocialPostCopyWithImpl<SocialPost, SocialPost>(
        this as SocialPost,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return SocialPostMapper.ensureInitialized().stringifyValue(
      this as SocialPost,
    );
  }

  @override
  bool operator ==(Object other) {
    return SocialPostMapper.ensureInitialized().equalsValue(
      this as SocialPost,
      other,
    );
  }

  @override
  int get hashCode {
    return SocialPostMapper.ensureInitialized().hashValue(this as SocialPost);
  }
}

extension SocialPostValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SocialPost, $Out> {
  SocialPostCopyWith<$R, SocialPost, $Out> get $asSocialPost =>
      $base.as((v, t, t2) => _SocialPostCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SocialPostCopyWith<$R, $In extends SocialPost, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  SocialAuthorCopyWith<$R, SocialAuthor, SocialAuthor> get author;
  ListCopyWith<
    $R,
    SocialMedia,
    SocialMediaCopyWith<$R, SocialMedia, SocialMedia>
  >
  get media;
  SocialLinkedPropertyCopyWith<$R, SocialLinkedProperty, SocialLinkedProperty>?
  get linkedProperty;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get tags;
  $R call({
    String? id,
    SocialAuthor? author,
    String? content,
    List<SocialMedia>? media,
    SocialLinkedProperty? linkedProperty,
    List<String>? tags,
    String? visibility,
    String? status,
    int? likeCount,
    int? commentCount,
    bool? liked,
    String? editedAt,
    String? createdAt,
    String? updatedAt,
  });
  SocialPostCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SocialPostCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SocialPost, $Out>
    implements SocialPostCopyWith<$R, SocialPost, $Out> {
  _SocialPostCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SocialPost> $mapper =
      SocialPostMapper.ensureInitialized();
  @override
  SocialAuthorCopyWith<$R, SocialAuthor, SocialAuthor> get author =>
      $value.author.copyWith.$chain((v) => call(author: v));
  @override
  ListCopyWith<
    $R,
    SocialMedia,
    SocialMediaCopyWith<$R, SocialMedia, SocialMedia>
  >
  get media => ListCopyWith(
    $value.media,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(media: v),
  );
  @override
  SocialLinkedPropertyCopyWith<$R, SocialLinkedProperty, SocialLinkedProperty>?
  get linkedProperty =>
      $value.linkedProperty?.copyWith.$chain((v) => call(linkedProperty: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get tags =>
      ListCopyWith(
        $value.tags,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(tags: v),
      );
  @override
  $R call({
    String? id,
    SocialAuthor? author,
    String? content,
    List<SocialMedia>? media,
    Object? linkedProperty = $none,
    List<String>? tags,
    String? visibility,
    Object? status = $none,
    int? likeCount,
    int? commentCount,
    bool? liked,
    Object? editedAt = $none,
    String? createdAt,
    Object? updatedAt = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (author != null) #author: author,
      if (content != null) #content: content,
      if (media != null) #media: media,
      if (linkedProperty != $none) #linkedProperty: linkedProperty,
      if (tags != null) #tags: tags,
      if (visibility != null) #visibility: visibility,
      if (status != $none) #status: status,
      if (likeCount != null) #likeCount: likeCount,
      if (commentCount != null) #commentCount: commentCount,
      if (liked != null) #liked: liked,
      if (editedAt != $none) #editedAt: editedAt,
      if (createdAt != null) #createdAt: createdAt,
      if (updatedAt != $none) #updatedAt: updatedAt,
    }),
  );
  @override
  SocialPost $make(CopyWithData data) => SocialPost(
    id: data.get(#id, or: $value.id),
    author: data.get(#author, or: $value.author),
    content: data.get(#content, or: $value.content),
    media: data.get(#media, or: $value.media),
    linkedProperty: data.get(#linkedProperty, or: $value.linkedProperty),
    tags: data.get(#tags, or: $value.tags),
    visibility: data.get(#visibility, or: $value.visibility),
    status: data.get(#status, or: $value.status),
    likeCount: data.get(#likeCount, or: $value.likeCount),
    commentCount: data.get(#commentCount, or: $value.commentCount),
    liked: data.get(#liked, or: $value.liked),
    editedAt: data.get(#editedAt, or: $value.editedAt),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
  );

  @override
  SocialPostCopyWith<$R2, SocialPost, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SocialPostCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class SocialCommentMapper extends ClassMapperBase<SocialComment> {
  SocialCommentMapper._();

  static SocialCommentMapper? _instance;
  static SocialCommentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SocialCommentMapper._());
      SocialAuthorMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SocialComment';

  static String _$id(SocialComment v) => v.id;
  static const Field<SocialComment, String> _f$id = Field(
    'id',
    _$id,
    key: r'_id',
  );
  static String _$post(SocialComment v) => v.post;
  static const Field<SocialComment, String> _f$post = Field('post', _$post);
  static SocialAuthor _$author(SocialComment v) => v.author;
  static const Field<SocialComment, SocialAuthor> _f$author = Field(
    'author',
    _$author,
  );
  static String? _$parentComment(SocialComment v) => v.parentComment;
  static const Field<SocialComment, String> _f$parentComment = Field(
    'parentComment',
    _$parentComment,
    opt: true,
  );
  static String _$content(SocialComment v) => v.content;
  static const Field<SocialComment, String> _f$content = Field(
    'content',
    _$content,
  );
  static String? _$status(SocialComment v) => v.status;
  static const Field<SocialComment, String> _f$status = Field(
    'status',
    _$status,
    opt: true,
  );
  static int _$likeCount(SocialComment v) => v.likeCount;
  static const Field<SocialComment, int> _f$likeCount = Field(
    'likeCount',
    _$likeCount,
    opt: true,
    def: 0,
  );
  static int _$replyCount(SocialComment v) => v.replyCount;
  static const Field<SocialComment, int> _f$replyCount = Field(
    'replyCount',
    _$replyCount,
    opt: true,
    def: 0,
  );
  static bool _$liked(SocialComment v) => v.liked;
  static const Field<SocialComment, bool> _f$liked = Field(
    'liked',
    _$liked,
    opt: true,
    def: false,
  );
  static String? _$editedAt(SocialComment v) => v.editedAt;
  static const Field<SocialComment, String> _f$editedAt = Field(
    'editedAt',
    _$editedAt,
    opt: true,
  );
  static String _$createdAt(SocialComment v) => v.createdAt;
  static const Field<SocialComment, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );
  static String? _$updatedAt(SocialComment v) => v.updatedAt;
  static const Field<SocialComment, String> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    opt: true,
  );

  @override
  final MappableFields<SocialComment> fields = const {
    #id: _f$id,
    #post: _f$post,
    #author: _f$author,
    #parentComment: _f$parentComment,
    #content: _f$content,
    #status: _f$status,
    #likeCount: _f$likeCount,
    #replyCount: _f$replyCount,
    #liked: _f$liked,
    #editedAt: _f$editedAt,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
  };

  static SocialComment _instantiate(DecodingData data) {
    return SocialComment(
      id: data.dec(_f$id),
      post: data.dec(_f$post),
      author: data.dec(_f$author),
      parentComment: data.dec(_f$parentComment),
      content: data.dec(_f$content),
      status: data.dec(_f$status),
      likeCount: data.dec(_f$likeCount),
      replyCount: data.dec(_f$replyCount),
      liked: data.dec(_f$liked),
      editedAt: data.dec(_f$editedAt),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SocialComment fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SocialComment>(map);
  }

  static SocialComment fromJson(String json) {
    return ensureInitialized().decodeJson<SocialComment>(json);
  }
}

mixin SocialCommentMappable {
  String toJson() {
    return SocialCommentMapper.ensureInitialized().encodeJson<SocialComment>(
      this as SocialComment,
    );
  }

  Map<String, dynamic> toMap() {
    return SocialCommentMapper.ensureInitialized().encodeMap<SocialComment>(
      this as SocialComment,
    );
  }

  SocialCommentCopyWith<SocialComment, SocialComment, SocialComment>
  get copyWith => _SocialCommentCopyWithImpl<SocialComment, SocialComment>(
    this as SocialComment,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return SocialCommentMapper.ensureInitialized().stringifyValue(
      this as SocialComment,
    );
  }

  @override
  bool operator ==(Object other) {
    return SocialCommentMapper.ensureInitialized().equalsValue(
      this as SocialComment,
      other,
    );
  }

  @override
  int get hashCode {
    return SocialCommentMapper.ensureInitialized().hashValue(
      this as SocialComment,
    );
  }
}

extension SocialCommentValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SocialComment, $Out> {
  SocialCommentCopyWith<$R, SocialComment, $Out> get $asSocialComment =>
      $base.as((v, t, t2) => _SocialCommentCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SocialCommentCopyWith<$R, $In extends SocialComment, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  SocialAuthorCopyWith<$R, SocialAuthor, SocialAuthor> get author;
  $R call({
    String? id,
    String? post,
    SocialAuthor? author,
    String? parentComment,
    String? content,
    String? status,
    int? likeCount,
    int? replyCount,
    bool? liked,
    String? editedAt,
    String? createdAt,
    String? updatedAt,
  });
  SocialCommentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SocialCommentCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SocialComment, $Out>
    implements SocialCommentCopyWith<$R, SocialComment, $Out> {
  _SocialCommentCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SocialComment> $mapper =
      SocialCommentMapper.ensureInitialized();
  @override
  SocialAuthorCopyWith<$R, SocialAuthor, SocialAuthor> get author =>
      $value.author.copyWith.$chain((v) => call(author: v));
  @override
  $R call({
    String? id,
    String? post,
    SocialAuthor? author,
    Object? parentComment = $none,
    String? content,
    Object? status = $none,
    int? likeCount,
    int? replyCount,
    bool? liked,
    Object? editedAt = $none,
    String? createdAt,
    Object? updatedAt = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (post != null) #post: post,
      if (author != null) #author: author,
      if (parentComment != $none) #parentComment: parentComment,
      if (content != null) #content: content,
      if (status != $none) #status: status,
      if (likeCount != null) #likeCount: likeCount,
      if (replyCount != null) #replyCount: replyCount,
      if (liked != null) #liked: liked,
      if (editedAt != $none) #editedAt: editedAt,
      if (createdAt != null) #createdAt: createdAt,
      if (updatedAt != $none) #updatedAt: updatedAt,
    }),
  );
  @override
  SocialComment $make(CopyWithData data) => SocialComment(
    id: data.get(#id, or: $value.id),
    post: data.get(#post, or: $value.post),
    author: data.get(#author, or: $value.author),
    parentComment: data.get(#parentComment, or: $value.parentComment),
    content: data.get(#content, or: $value.content),
    status: data.get(#status, or: $value.status),
    likeCount: data.get(#likeCount, or: $value.likeCount),
    replyCount: data.get(#replyCount, or: $value.replyCount),
    liked: data.get(#liked, or: $value.liked),
    editedAt: data.get(#editedAt, or: $value.editedAt),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
  );

  @override
  SocialCommentCopyWith<$R2, SocialComment, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SocialCommentCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class SocialReactionMapper extends ClassMapperBase<SocialReaction> {
  SocialReactionMapper._();

  static SocialReactionMapper? _instance;
  static SocialReactionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SocialReactionMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SocialReaction';

  static bool _$liked(SocialReaction v) => v.liked;
  static const Field<SocialReaction, bool> _f$liked = Field('liked', _$liked);
  static int _$likeCount(SocialReaction v) => v.likeCount;
  static const Field<SocialReaction, int> _f$likeCount = Field(
    'likeCount',
    _$likeCount,
  );

  @override
  final MappableFields<SocialReaction> fields = const {
    #liked: _f$liked,
    #likeCount: _f$likeCount,
  };

  static SocialReaction _instantiate(DecodingData data) {
    return SocialReaction(
      liked: data.dec(_f$liked),
      likeCount: data.dec(_f$likeCount),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SocialReaction fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SocialReaction>(map);
  }

  static SocialReaction fromJson(String json) {
    return ensureInitialized().decodeJson<SocialReaction>(json);
  }
}

mixin SocialReactionMappable {
  String toJson() {
    return SocialReactionMapper.ensureInitialized().encodeJson<SocialReaction>(
      this as SocialReaction,
    );
  }

  Map<String, dynamic> toMap() {
    return SocialReactionMapper.ensureInitialized().encodeMap<SocialReaction>(
      this as SocialReaction,
    );
  }

  SocialReactionCopyWith<SocialReaction, SocialReaction, SocialReaction>
  get copyWith => _SocialReactionCopyWithImpl<SocialReaction, SocialReaction>(
    this as SocialReaction,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return SocialReactionMapper.ensureInitialized().stringifyValue(
      this as SocialReaction,
    );
  }

  @override
  bool operator ==(Object other) {
    return SocialReactionMapper.ensureInitialized().equalsValue(
      this as SocialReaction,
      other,
    );
  }

  @override
  int get hashCode {
    return SocialReactionMapper.ensureInitialized().hashValue(
      this as SocialReaction,
    );
  }
}

extension SocialReactionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SocialReaction, $Out> {
  SocialReactionCopyWith<$R, SocialReaction, $Out> get $asSocialReaction =>
      $base.as((v, t, t2) => _SocialReactionCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SocialReactionCopyWith<$R, $In extends SocialReaction, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({bool? liked, int? likeCount});
  SocialReactionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _SocialReactionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SocialReaction, $Out>
    implements SocialReactionCopyWith<$R, SocialReaction, $Out> {
  _SocialReactionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SocialReaction> $mapper =
      SocialReactionMapper.ensureInitialized();
  @override
  $R call({bool? liked, int? likeCount}) => $apply(
    FieldCopyWithData({
      if (liked != null) #liked: liked,
      if (likeCount != null) #likeCount: likeCount,
    }),
  );
  @override
  SocialReaction $make(CopyWithData data) => SocialReaction(
    liked: data.get(#liked, or: $value.liked),
    likeCount: data.get(#likeCount, or: $value.likeCount),
  );

  @override
  SocialReactionCopyWith<$R2, SocialReaction, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SocialReactionCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

