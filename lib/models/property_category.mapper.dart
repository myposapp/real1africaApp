// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'property_category.dart';

class PropertyCategoryMapper extends ClassMapperBase<PropertyCategory> {
  PropertyCategoryMapper._();

  static PropertyCategoryMapper? _instance;
  static PropertyCategoryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PropertyCategoryMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PropertyCategory';

  static String _$id(PropertyCategory v) => v.id;
  static const Field<PropertyCategory, String> _f$id = Field(
    'id',
    _$id,
    key: r'_id',
  );
  static String? _$parentCategory(PropertyCategory v) => v.parentCategory;
  static const Field<PropertyCategory, String> _f$parentCategory = Field(
    'parentCategory',
    _$parentCategory,
    key: r'category',
    opt: true,
  );
  static String _$title(PropertyCategory v) => v.title;
  static const Field<PropertyCategory, String> _f$title = Field(
    'title',
    _$title,
  );
  static String? _$pageTitle(PropertyCategory v) => v.pageTitle;
  static const Field<PropertyCategory, String> _f$pageTitle = Field(
    'pageTitle',
    _$pageTitle,
    opt: true,
  );
  static String? _$description(PropertyCategory v) => v.description;
  static const Field<PropertyCategory, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
  );
  static String? _$article(PropertyCategory v) => v.article;
  static const Field<PropertyCategory, String> _f$article = Field(
    'article',
    _$article,
    opt: true,
  );
  static String _$image(PropertyCategory v) => v.image;
  static const Field<PropertyCategory, String> _f$image = Field(
    'image',
    _$image,
  );
  static String _$createdAt(PropertyCategory v) => v.createdAt;
  static const Field<PropertyCategory, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );
  static String _$updatedAt(PropertyCategory v) => v.updatedAt;
  static const Field<PropertyCategory, String> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
  );

  @override
  final MappableFields<PropertyCategory> fields = const {
    #id: _f$id,
    #parentCategory: _f$parentCategory,
    #title: _f$title,
    #pageTitle: _f$pageTitle,
    #description: _f$description,
    #article: _f$article,
    #image: _f$image,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
  };

  static PropertyCategory _instantiate(DecodingData data) {
    return PropertyCategory(
      id: data.dec(_f$id),
      parentCategory: data.dec(_f$parentCategory),
      title: data.dec(_f$title),
      pageTitle: data.dec(_f$pageTitle),
      description: data.dec(_f$description),
      article: data.dec(_f$article),
      image: data.dec(_f$image),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PropertyCategory fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PropertyCategory>(map);
  }

  static PropertyCategory fromJson(String json) {
    return ensureInitialized().decodeJson<PropertyCategory>(json);
  }
}

mixin PropertyCategoryMappable {
  String toJson() {
    return PropertyCategoryMapper.ensureInitialized()
        .encodeJson<PropertyCategory>(this as PropertyCategory);
  }

  Map<String, dynamic> toMap() {
    return PropertyCategoryMapper.ensureInitialized()
        .encodeMap<PropertyCategory>(this as PropertyCategory);
  }

  PropertyCategoryCopyWith<PropertyCategory, PropertyCategory, PropertyCategory>
  get copyWith =>
      _PropertyCategoryCopyWithImpl<PropertyCategory, PropertyCategory>(
        this as PropertyCategory,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PropertyCategoryMapper.ensureInitialized().stringifyValue(
      this as PropertyCategory,
    );
  }

  @override
  bool operator ==(Object other) {
    return PropertyCategoryMapper.ensureInitialized().equalsValue(
      this as PropertyCategory,
      other,
    );
  }

  @override
  int get hashCode {
    return PropertyCategoryMapper.ensureInitialized().hashValue(
      this as PropertyCategory,
    );
  }
}

extension PropertyCategoryValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PropertyCategory, $Out> {
  PropertyCategoryCopyWith<$R, PropertyCategory, $Out>
  get $asPropertyCategory =>
      $base.as((v, t, t2) => _PropertyCategoryCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PropertyCategoryCopyWith<$R, $In extends PropertyCategory, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? parentCategory,
    String? title,
    String? pageTitle,
    String? description,
    String? article,
    String? image,
    String? createdAt,
    String? updatedAt,
  });
  PropertyCategoryCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PropertyCategoryCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PropertyCategory, $Out>
    implements PropertyCategoryCopyWith<$R, PropertyCategory, $Out> {
  _PropertyCategoryCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PropertyCategory> $mapper =
      PropertyCategoryMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    Object? parentCategory = $none,
    String? title,
    Object? pageTitle = $none,
    Object? description = $none,
    Object? article = $none,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (parentCategory != $none) #parentCategory: parentCategory,
      if (title != null) #title: title,
      if (pageTitle != $none) #pageTitle: pageTitle,
      if (description != $none) #description: description,
      if (article != $none) #article: article,
      if (image != null) #image: image,
      if (createdAt != null) #createdAt: createdAt,
      if (updatedAt != null) #updatedAt: updatedAt,
    }),
  );
  @override
  PropertyCategory $make(CopyWithData data) => PropertyCategory(
    id: data.get(#id, or: $value.id),
    parentCategory: data.get(#parentCategory, or: $value.parentCategory),
    title: data.get(#title, or: $value.title),
    pageTitle: data.get(#pageTitle, or: $value.pageTitle),
    description: data.get(#description, or: $value.description),
    article: data.get(#article, or: $value.article),
    image: data.get(#image, or: $value.image),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
  );

  @override
  PropertyCategoryCopyWith<$R2, PropertyCategory, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PropertyCategoryCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

