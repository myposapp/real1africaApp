// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'property_search_response.dart';

class CategoryOptionMapper extends ClassMapperBase<CategoryOption> {
  CategoryOptionMapper._();

  static CategoryOptionMapper? _instance;
  static CategoryOptionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CategoryOptionMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CategoryOption';

  static String _$id(CategoryOption v) => v.id;
  static const Field<CategoryOption, String> _f$id = Field(
    'id',
    _$id,
    key: r'_id',
  );
  static String _$title(CategoryOption v) => v.title;
  static const Field<CategoryOption, String> _f$title = Field('title', _$title);
  static String _$slug(CategoryOption v) => v.slug;
  static const Field<CategoryOption, String> _f$slug = Field('slug', _$slug);

  @override
  final MappableFields<CategoryOption> fields = const {
    #id: _f$id,
    #title: _f$title,
    #slug: _f$slug,
  };

  static CategoryOption _instantiate(DecodingData data) {
    return CategoryOption(
      id: data.dec(_f$id),
      title: data.dec(_f$title),
      slug: data.dec(_f$slug),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CategoryOption fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CategoryOption>(map);
  }

  static CategoryOption fromJson(String json) {
    return ensureInitialized().decodeJson<CategoryOption>(json);
  }
}

mixin CategoryOptionMappable {
  String toJson() {
    return CategoryOptionMapper.ensureInitialized().encodeJson<CategoryOption>(
      this as CategoryOption,
    );
  }

  Map<String, dynamic> toMap() {
    return CategoryOptionMapper.ensureInitialized().encodeMap<CategoryOption>(
      this as CategoryOption,
    );
  }

  CategoryOptionCopyWith<CategoryOption, CategoryOption, CategoryOption>
  get copyWith => _CategoryOptionCopyWithImpl<CategoryOption, CategoryOption>(
    this as CategoryOption,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return CategoryOptionMapper.ensureInitialized().stringifyValue(
      this as CategoryOption,
    );
  }

  @override
  bool operator ==(Object other) {
    return CategoryOptionMapper.ensureInitialized().equalsValue(
      this as CategoryOption,
      other,
    );
  }

  @override
  int get hashCode {
    return CategoryOptionMapper.ensureInitialized().hashValue(
      this as CategoryOption,
    );
  }
}

extension CategoryOptionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CategoryOption, $Out> {
  CategoryOptionCopyWith<$R, CategoryOption, $Out> get $asCategoryOption =>
      $base.as((v, t, t2) => _CategoryOptionCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CategoryOptionCopyWith<$R, $In extends CategoryOption, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? title, String? slug});
  CategoryOptionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CategoryOptionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CategoryOption, $Out>
    implements CategoryOptionCopyWith<$R, CategoryOption, $Out> {
  _CategoryOptionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CategoryOption> $mapper =
      CategoryOptionMapper.ensureInitialized();
  @override
  $R call({String? id, String? title, String? slug}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (title != null) #title: title,
      if (slug != null) #slug: slug,
    }),
  );
  @override
  CategoryOption $make(CopyWithData data) => CategoryOption(
    id: data.get(#id, or: $value.id),
    title: data.get(#title, or: $value.title),
    slug: data.get(#slug, or: $value.slug),
  );

  @override
  CategoryOptionCopyWith<$R2, CategoryOption, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CategoryOptionCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class LocationOptionMapper extends ClassMapperBase<LocationOption> {
  LocationOptionMapper._();

  static LocationOptionMapper? _instance;
  static LocationOptionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocationOptionMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LocationOption';

  static String _$name(LocationOption v) => v.name;
  static const Field<LocationOption, String> _f$name = Field('name', _$name);
  static String _$label(LocationOption v) => v.label;
  static const Field<LocationOption, String> _f$label = Field('label', _$label);
  static String _$slug(LocationOption v) => v.slug;
  static const Field<LocationOption, String> _f$slug = Field('slug', _$slug);
  static String _$type(LocationOption v) => v.type;
  static const Field<LocationOption, String> _f$type = Field('type', _$type);

  @override
  final MappableFields<LocationOption> fields = const {
    #name: _f$name,
    #label: _f$label,
    #slug: _f$slug,
    #type: _f$type,
  };

  static LocationOption _instantiate(DecodingData data) {
    return LocationOption(
      name: data.dec(_f$name),
      label: data.dec(_f$label),
      slug: data.dec(_f$slug),
      type: data.dec(_f$type),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LocationOption fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocationOption>(map);
  }

  static LocationOption fromJson(String json) {
    return ensureInitialized().decodeJson<LocationOption>(json);
  }
}

mixin LocationOptionMappable {
  String toJson() {
    return LocationOptionMapper.ensureInitialized().encodeJson<LocationOption>(
      this as LocationOption,
    );
  }

  Map<String, dynamic> toMap() {
    return LocationOptionMapper.ensureInitialized().encodeMap<LocationOption>(
      this as LocationOption,
    );
  }

  LocationOptionCopyWith<LocationOption, LocationOption, LocationOption>
  get copyWith => _LocationOptionCopyWithImpl<LocationOption, LocationOption>(
    this as LocationOption,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return LocationOptionMapper.ensureInitialized().stringifyValue(
      this as LocationOption,
    );
  }

  @override
  bool operator ==(Object other) {
    return LocationOptionMapper.ensureInitialized().equalsValue(
      this as LocationOption,
      other,
    );
  }

  @override
  int get hashCode {
    return LocationOptionMapper.ensureInitialized().hashValue(
      this as LocationOption,
    );
  }
}

extension LocationOptionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocationOption, $Out> {
  LocationOptionCopyWith<$R, LocationOption, $Out> get $asLocationOption =>
      $base.as((v, t, t2) => _LocationOptionCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class LocationOptionCopyWith<$R, $In extends LocationOption, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, String? label, String? slug, String? type});
  LocationOptionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LocationOptionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocationOption, $Out>
    implements LocationOptionCopyWith<$R, LocationOption, $Out> {
  _LocationOptionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocationOption> $mapper =
      LocationOptionMapper.ensureInitialized();
  @override
  $R call({String? name, String? label, String? slug, String? type}) => $apply(
    FieldCopyWithData({
      if (name != null) #name: name,
      if (label != null) #label: label,
      if (slug != null) #slug: slug,
      if (type != null) #type: type,
    }),
  );
  @override
  LocationOption $make(CopyWithData data) => LocationOption(
    name: data.get(#name, or: $value.name),
    label: data.get(#label, or: $value.label),
    slug: data.get(#slug, or: $value.slug),
    type: data.get(#type, or: $value.type),
  );

  @override
  LocationOptionCopyWith<$R2, LocationOption, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LocationOptionCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AmenityFieldMapper extends ClassMapperBase<AmenityField> {
  AmenityFieldMapper._();

  static AmenityFieldMapper? _instance;
  static AmenityFieldMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AmenityFieldMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AmenityField';

  static String _$name(AmenityField v) => v.name;
  static const Field<AmenityField, String> _f$name = Field('name', _$name);
  static String _$label(AmenityField v) => v.label;
  static const Field<AmenityField, String> _f$label = Field('label', _$label);
  static String _$type(AmenityField v) => v.type;
  static const Field<AmenityField, String> _f$type = Field('type', _$type);
  static List<String> _$options(AmenityField v) => v.options;
  static const Field<AmenityField, List<String>> _f$options = Field(
    'options',
    _$options,
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<AmenityField> fields = const {
    #name: _f$name,
    #label: _f$label,
    #type: _f$type,
    #options: _f$options,
  };

  static AmenityField _instantiate(DecodingData data) {
    return AmenityField(
      name: data.dec(_f$name),
      label: data.dec(_f$label),
      type: data.dec(_f$type),
      options: data.dec(_f$options),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AmenityField fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AmenityField>(map);
  }

  static AmenityField fromJson(String json) {
    return ensureInitialized().decodeJson<AmenityField>(json);
  }
}

mixin AmenityFieldMappable {
  String toJson() {
    return AmenityFieldMapper.ensureInitialized().encodeJson<AmenityField>(
      this as AmenityField,
    );
  }

  Map<String, dynamic> toMap() {
    return AmenityFieldMapper.ensureInitialized().encodeMap<AmenityField>(
      this as AmenityField,
    );
  }

  AmenityFieldCopyWith<AmenityField, AmenityField, AmenityField> get copyWith =>
      _AmenityFieldCopyWithImpl<AmenityField, AmenityField>(
        this as AmenityField,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AmenityFieldMapper.ensureInitialized().stringifyValue(
      this as AmenityField,
    );
  }

  @override
  bool operator ==(Object other) {
    return AmenityFieldMapper.ensureInitialized().equalsValue(
      this as AmenityField,
      other,
    );
  }

  @override
  int get hashCode {
    return AmenityFieldMapper.ensureInitialized().hashValue(
      this as AmenityField,
    );
  }
}

extension AmenityFieldValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AmenityField, $Out> {
  AmenityFieldCopyWith<$R, AmenityField, $Out> get $asAmenityField =>
      $base.as((v, t, t2) => _AmenityFieldCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AmenityFieldCopyWith<$R, $In extends AmenityField, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get options;
  $R call({String? name, String? label, String? type, List<String>? options});
  AmenityFieldCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AmenityFieldCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AmenityField, $Out>
    implements AmenityFieldCopyWith<$R, AmenityField, $Out> {
  _AmenityFieldCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AmenityField> $mapper =
      AmenityFieldMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get options =>
      ListCopyWith(
        $value.options,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(options: v),
      );
  @override
  $R call({String? name, String? label, String? type, List<String>? options}) =>
      $apply(
        FieldCopyWithData({
          if (name != null) #name: name,
          if (label != null) #label: label,
          if (type != null) #type: type,
          if (options != null) #options: options,
        }),
      );
  @override
  AmenityField $make(CopyWithData data) => AmenityField(
    name: data.get(#name, or: $value.name),
    label: data.get(#label, or: $value.label),
    type: data.get(#type, or: $value.type),
    options: data.get(#options, or: $value.options),
  );

  @override
  AmenityFieldCopyWith<$R2, AmenityField, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AmenityFieldCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AmenityProfileMapper extends ClassMapperBase<AmenityProfile> {
  AmenityProfileMapper._();

  static AmenityProfileMapper? _instance;
  static AmenityProfileMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AmenityProfileMapper._());
      AmenityFieldMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AmenityProfile';

  static String _$title(AmenityProfile v) => v.title;
  static const Field<AmenityProfile, String> _f$title = Field('title', _$title);
  static List<String> _$keywords(AmenityProfile v) => v.keywords;
  static const Field<AmenityProfile, List<String>> _f$keywords = Field(
    'keywords',
    _$keywords,
    opt: true,
    def: const [],
  );
  static List<AmenityField> _$fields(AmenityProfile v) => v.fields;
  static const Field<AmenityProfile, List<AmenityField>> _f$fields = Field(
    'fields',
    _$fields,
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<AmenityProfile> fields = const {
    #title: _f$title,
    #keywords: _f$keywords,
    #fields: _f$fields,
  };

  static AmenityProfile _instantiate(DecodingData data) {
    return AmenityProfile(
      title: data.dec(_f$title),
      keywords: data.dec(_f$keywords),
      fields: data.dec(_f$fields),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AmenityProfile fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AmenityProfile>(map);
  }

  static AmenityProfile fromJson(String json) {
    return ensureInitialized().decodeJson<AmenityProfile>(json);
  }
}

mixin AmenityProfileMappable {
  String toJson() {
    return AmenityProfileMapper.ensureInitialized().encodeJson<AmenityProfile>(
      this as AmenityProfile,
    );
  }

  Map<String, dynamic> toMap() {
    return AmenityProfileMapper.ensureInitialized().encodeMap<AmenityProfile>(
      this as AmenityProfile,
    );
  }

  AmenityProfileCopyWith<AmenityProfile, AmenityProfile, AmenityProfile>
  get copyWith => _AmenityProfileCopyWithImpl<AmenityProfile, AmenityProfile>(
    this as AmenityProfile,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return AmenityProfileMapper.ensureInitialized().stringifyValue(
      this as AmenityProfile,
    );
  }

  @override
  bool operator ==(Object other) {
    return AmenityProfileMapper.ensureInitialized().equalsValue(
      this as AmenityProfile,
      other,
    );
  }

  @override
  int get hashCode {
    return AmenityProfileMapper.ensureInitialized().hashValue(
      this as AmenityProfile,
    );
  }
}

extension AmenityProfileValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AmenityProfile, $Out> {
  AmenityProfileCopyWith<$R, AmenityProfile, $Out> get $asAmenityProfile =>
      $base.as((v, t, t2) => _AmenityProfileCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AmenityProfileCopyWith<$R, $In extends AmenityProfile, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get keywords;
  ListCopyWith<
    $R,
    AmenityField,
    AmenityFieldCopyWith<$R, AmenityField, AmenityField>
  >
  get fields;
  $R call({String? title, List<String>? keywords, List<AmenityField>? fields});
  AmenityProfileCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AmenityProfileCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AmenityProfile, $Out>
    implements AmenityProfileCopyWith<$R, AmenityProfile, $Out> {
  _AmenityProfileCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AmenityProfile> $mapper =
      AmenityProfileMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get keywords =>
      ListCopyWith(
        $value.keywords,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(keywords: v),
      );
  @override
  ListCopyWith<
    $R,
    AmenityField,
    AmenityFieldCopyWith<$R, AmenityField, AmenityField>
  >
  get fields => ListCopyWith(
    $value.fields,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(fields: v),
  );
  @override
  $R call({
    String? title,
    List<String>? keywords,
    List<AmenityField>? fields,
  }) => $apply(
    FieldCopyWithData({
      if (title != null) #title: title,
      if (keywords != null) #keywords: keywords,
      if (fields != null) #fields: fields,
    }),
  );
  @override
  AmenityProfile $make(CopyWithData data) => AmenityProfile(
    title: data.get(#title, or: $value.title),
    keywords: data.get(#keywords, or: $value.keywords),
    fields: data.get(#fields, or: $value.fields),
  );

  @override
  AmenityProfileCopyWith<$R2, AmenityProfile, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AmenityProfileCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PropertySearchResponseMapper
    extends ClassMapperBase<PropertySearchResponse> {
  PropertySearchResponseMapper._();

  static PropertySearchResponseMapper? _instance;
  static PropertySearchResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PropertySearchResponseMapper._());
      PropertyMapper.ensureInitialized();
      ResponseMetadataMapper.ensureInitialized();
      CategoryOptionMapper.ensureInitialized();
      LocationOptionMapper.ensureInitialized();
      AmenityProfileMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PropertySearchResponse';

  static bool? _$success(PropertySearchResponse v) => v.success;
  static const Field<PropertySearchResponse, bool> _f$success = Field(
    'success',
    _$success,
    opt: true,
  );
  static String? _$message(PropertySearchResponse v) => v.message;
  static const Field<PropertySearchResponse, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static List<Property> _$data(PropertySearchResponse v) => v.data;
  static const Field<PropertySearchResponse, List<Property>> _f$data = Field(
    'data',
    _$data,
    opt: true,
    def: const [],
  );
  static ResponseMetadata? _$metadata(PropertySearchResponse v) => v.metadata;
  static const Field<PropertySearchResponse, ResponseMetadata> _f$metadata =
      Field('metadata', _$metadata, opt: true);
  static List<dynamic> _$categoryPath(PropertySearchResponse v) =>
      v.categoryPath;
  static const Field<PropertySearchResponse, List<dynamic>> _f$categoryPath =
      Field('categoryPath', _$categoryPath, opt: true, def: const []);
  static List<CategoryOption> _$categoryOptions(PropertySearchResponse v) =>
      v.categoryOptions;
  static const Field<PropertySearchResponse, List<CategoryOption>>
  _f$categoryOptions = Field(
    'categoryOptions',
    _$categoryOptions,
    opt: true,
    def: const [],
  );
  static bool? _$categoryIsLeaf(PropertySearchResponse v) => v.categoryIsLeaf;
  static const Field<PropertySearchResponse, bool> _f$categoryIsLeaf = Field(
    'categoryIsLeaf',
    _$categoryIsLeaf,
    opt: true,
  );
  static String? _$location(PropertySearchResponse v) => v.location;
  static const Field<PropertySearchResponse, String> _f$location = Field(
    'location',
    _$location,
    opt: true,
  );
  static List<LocationOption> _$locationOptions(PropertySearchResponse v) =>
      v.locationOptions;
  static const Field<PropertySearchResponse, List<LocationOption>>
  _f$locationOptions = Field(
    'locationOptions',
    _$locationOptions,
    opt: true,
    def: const [],
  );
  static AmenityProfile? _$amenityProfile(PropertySearchResponse v) =>
      v.amenityProfile;
  static const Field<PropertySearchResponse, AmenityProfile> _f$amenityProfile =
      Field('amenityProfile', _$amenityProfile, opt: true);
  static String? _$purpose(PropertySearchResponse v) => v.purpose;
  static const Field<PropertySearchResponse, String> _f$purpose = Field(
    'purpose',
    _$purpose,
    opt: true,
  );

  @override
  final MappableFields<PropertySearchResponse> fields = const {
    #success: _f$success,
    #message: _f$message,
    #data: _f$data,
    #metadata: _f$metadata,
    #categoryPath: _f$categoryPath,
    #categoryOptions: _f$categoryOptions,
    #categoryIsLeaf: _f$categoryIsLeaf,
    #location: _f$location,
    #locationOptions: _f$locationOptions,
    #amenityProfile: _f$amenityProfile,
    #purpose: _f$purpose,
  };

  static PropertySearchResponse _instantiate(DecodingData data) {
    return PropertySearchResponse(
      success: data.dec(_f$success),
      message: data.dec(_f$message),
      data: data.dec(_f$data),
      metadata: data.dec(_f$metadata),
      categoryPath: data.dec(_f$categoryPath),
      categoryOptions: data.dec(_f$categoryOptions),
      categoryIsLeaf: data.dec(_f$categoryIsLeaf),
      location: data.dec(_f$location),
      locationOptions: data.dec(_f$locationOptions),
      amenityProfile: data.dec(_f$amenityProfile),
      purpose: data.dec(_f$purpose),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PropertySearchResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PropertySearchResponse>(map);
  }

  static PropertySearchResponse fromJson(String json) {
    return ensureInitialized().decodeJson<PropertySearchResponse>(json);
  }
}

mixin PropertySearchResponseMappable {
  String toJson() {
    return PropertySearchResponseMapper.ensureInitialized()
        .encodeJson<PropertySearchResponse>(this as PropertySearchResponse);
  }

  Map<String, dynamic> toMap() {
    return PropertySearchResponseMapper.ensureInitialized()
        .encodeMap<PropertySearchResponse>(this as PropertySearchResponse);
  }

  PropertySearchResponseCopyWith<
    PropertySearchResponse,
    PropertySearchResponse,
    PropertySearchResponse
  >
  get copyWith =>
      _PropertySearchResponseCopyWithImpl<
        PropertySearchResponse,
        PropertySearchResponse
      >(this as PropertySearchResponse, $identity, $identity);
  @override
  String toString() {
    return PropertySearchResponseMapper.ensureInitialized().stringifyValue(
      this as PropertySearchResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return PropertySearchResponseMapper.ensureInitialized().equalsValue(
      this as PropertySearchResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return PropertySearchResponseMapper.ensureInitialized().hashValue(
      this as PropertySearchResponse,
    );
  }
}

extension PropertySearchResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PropertySearchResponse, $Out> {
  PropertySearchResponseCopyWith<$R, PropertySearchResponse, $Out>
  get $asPropertySearchResponse => $base.as(
    (v, t, t2) => _PropertySearchResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class PropertySearchResponseCopyWith<
  $R,
  $In extends PropertySearchResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Property, PropertyCopyWith<$R, Property, Property>> get data;
  ResponseMetadataCopyWith<$R, ResponseMetadata, ResponseMetadata>?
  get metadata;
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>
  get categoryPath;
  ListCopyWith<
    $R,
    CategoryOption,
    CategoryOptionCopyWith<$R, CategoryOption, CategoryOption>
  >
  get categoryOptions;
  ListCopyWith<
    $R,
    LocationOption,
    LocationOptionCopyWith<$R, LocationOption, LocationOption>
  >
  get locationOptions;
  AmenityProfileCopyWith<$R, AmenityProfile, AmenityProfile>?
  get amenityProfile;
  $R call({
    bool? success,
    String? message,
    List<Property>? data,
    ResponseMetadata? metadata,
    List<dynamic>? categoryPath,
    List<CategoryOption>? categoryOptions,
    bool? categoryIsLeaf,
    String? location,
    List<LocationOption>? locationOptions,
    AmenityProfile? amenityProfile,
    String? purpose,
  });
  PropertySearchResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PropertySearchResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PropertySearchResponse, $Out>
    implements
        PropertySearchResponseCopyWith<$R, PropertySearchResponse, $Out> {
  _PropertySearchResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PropertySearchResponse> $mapper =
      PropertySearchResponseMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Property, PropertyCopyWith<$R, Property, Property>>
  get data => ListCopyWith(
    $value.data,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(data: v),
  );
  @override
  ResponseMetadataCopyWith<$R, ResponseMetadata, ResponseMetadata>?
  get metadata => $value.metadata?.copyWith.$chain((v) => call(metadata: v));
  @override
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>
  get categoryPath => ListCopyWith(
    $value.categoryPath,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(categoryPath: v),
  );
  @override
  ListCopyWith<
    $R,
    CategoryOption,
    CategoryOptionCopyWith<$R, CategoryOption, CategoryOption>
  >
  get categoryOptions => ListCopyWith(
    $value.categoryOptions,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(categoryOptions: v),
  );
  @override
  ListCopyWith<
    $R,
    LocationOption,
    LocationOptionCopyWith<$R, LocationOption, LocationOption>
  >
  get locationOptions => ListCopyWith(
    $value.locationOptions,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(locationOptions: v),
  );
  @override
  AmenityProfileCopyWith<$R, AmenityProfile, AmenityProfile>?
  get amenityProfile =>
      $value.amenityProfile?.copyWith.$chain((v) => call(amenityProfile: v));
  @override
  $R call({
    Object? success = $none,
    Object? message = $none,
    List<Property>? data,
    Object? metadata = $none,
    List<dynamic>? categoryPath,
    List<CategoryOption>? categoryOptions,
    Object? categoryIsLeaf = $none,
    Object? location = $none,
    List<LocationOption>? locationOptions,
    Object? amenityProfile = $none,
    Object? purpose = $none,
  }) => $apply(
    FieldCopyWithData({
      if (success != $none) #success: success,
      if (message != $none) #message: message,
      if (data != null) #data: data,
      if (metadata != $none) #metadata: metadata,
      if (categoryPath != null) #categoryPath: categoryPath,
      if (categoryOptions != null) #categoryOptions: categoryOptions,
      if (categoryIsLeaf != $none) #categoryIsLeaf: categoryIsLeaf,
      if (location != $none) #location: location,
      if (locationOptions != null) #locationOptions: locationOptions,
      if (amenityProfile != $none) #amenityProfile: amenityProfile,
      if (purpose != $none) #purpose: purpose,
    }),
  );
  @override
  PropertySearchResponse $make(CopyWithData data) => PropertySearchResponse(
    success: data.get(#success, or: $value.success),
    message: data.get(#message, or: $value.message),
    data: data.get(#data, or: $value.data),
    metadata: data.get(#metadata, or: $value.metadata),
    categoryPath: data.get(#categoryPath, or: $value.categoryPath),
    categoryOptions: data.get(#categoryOptions, or: $value.categoryOptions),
    categoryIsLeaf: data.get(#categoryIsLeaf, or: $value.categoryIsLeaf),
    location: data.get(#location, or: $value.location),
    locationOptions: data.get(#locationOptions, or: $value.locationOptions),
    amenityProfile: data.get(#amenityProfile, or: $value.amenityProfile),
    purpose: data.get(#purpose, or: $value.purpose),
  );

  @override
  PropertySearchResponseCopyWith<$R2, PropertySearchResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PropertySearchResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

