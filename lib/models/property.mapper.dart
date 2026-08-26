// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'property.dart';

class PropertyOwnerMapper extends ClassMapperBase<PropertyOwner> {
  PropertyOwnerMapper._();

  static PropertyOwnerMapper? _instance;
  static PropertyOwnerMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PropertyOwnerMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PropertyOwner';

  static String _$id(PropertyOwner v) => v.id;
  static const Field<PropertyOwner, String> _f$id = Field(
    'id',
    _$id,
    key: r'_id',
  );
  static String? _$name(PropertyOwner v) => v.name;
  static const Field<PropertyOwner, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static String? _$phone(PropertyOwner v) => v.phone;
  static const Field<PropertyOwner, String> _f$phone = Field(
    'phone',
    _$phone,
    opt: true,
  );
  static String? _$email(PropertyOwner v) => v.email;
  static const Field<PropertyOwner, String> _f$email = Field(
    'email',
    _$email,
    opt: true,
  );
  static String? _$photo(PropertyOwner v) => v.photo;
  static const Field<PropertyOwner, String> _f$photo = Field(
    'photo',
    _$photo,
    opt: true,
  );
  static bool? _$verifiedAgent(PropertyOwner v) => v.verifiedAgent;
  static const Field<PropertyOwner, bool> _f$verifiedAgent = Field(
    'verifiedAgent',
    _$verifiedAgent,
    opt: true,
  );

  @override
  final MappableFields<PropertyOwner> fields = const {
    #id: _f$id,
    #name: _f$name,
    #phone: _f$phone,
    #email: _f$email,
    #photo: _f$photo,
    #verifiedAgent: _f$verifiedAgent,
  };

  static PropertyOwner _instantiate(DecodingData data) {
    return PropertyOwner(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      phone: data.dec(_f$phone),
      email: data.dec(_f$email),
      photo: data.dec(_f$photo),
      verifiedAgent: data.dec(_f$verifiedAgent),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PropertyOwner fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PropertyOwner>(map);
  }

  static PropertyOwner fromJson(String json) {
    return ensureInitialized().decodeJson<PropertyOwner>(json);
  }
}

mixin PropertyOwnerMappable {
  String toJson() {
    return PropertyOwnerMapper.ensureInitialized().encodeJson<PropertyOwner>(
      this as PropertyOwner,
    );
  }

  Map<String, dynamic> toMap() {
    return PropertyOwnerMapper.ensureInitialized().encodeMap<PropertyOwner>(
      this as PropertyOwner,
    );
  }

  PropertyOwnerCopyWith<PropertyOwner, PropertyOwner, PropertyOwner>
  get copyWith => _PropertyOwnerCopyWithImpl<PropertyOwner, PropertyOwner>(
    this as PropertyOwner,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return PropertyOwnerMapper.ensureInitialized().stringifyValue(
      this as PropertyOwner,
    );
  }

  @override
  bool operator ==(Object other) {
    return PropertyOwnerMapper.ensureInitialized().equalsValue(
      this as PropertyOwner,
      other,
    );
  }

  @override
  int get hashCode {
    return PropertyOwnerMapper.ensureInitialized().hashValue(
      this as PropertyOwner,
    );
  }
}

extension PropertyOwnerValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PropertyOwner, $Out> {
  PropertyOwnerCopyWith<$R, PropertyOwner, $Out> get $asPropertyOwner =>
      $base.as((v, t, t2) => _PropertyOwnerCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PropertyOwnerCopyWith<$R, $In extends PropertyOwner, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? photo,
    bool? verifiedAgent,
  });
  PropertyOwnerCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PropertyOwnerCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PropertyOwner, $Out>
    implements PropertyOwnerCopyWith<$R, PropertyOwner, $Out> {
  _PropertyOwnerCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PropertyOwner> $mapper =
      PropertyOwnerMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    Object? name = $none,
    Object? phone = $none,
    Object? email = $none,
    Object? photo = $none,
    Object? verifiedAgent = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != $none) #name: name,
      if (phone != $none) #phone: phone,
      if (email != $none) #email: email,
      if (photo != $none) #photo: photo,
      if (verifiedAgent != $none) #verifiedAgent: verifiedAgent,
    }),
  );
  @override
  PropertyOwner $make(CopyWithData data) => PropertyOwner(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    phone: data.get(#phone, or: $value.phone),
    email: data.get(#email, or: $value.email),
    photo: data.get(#photo, or: $value.photo),
    verifiedAgent: data.get(#verifiedAgent, or: $value.verifiedAgent),
  );

  @override
  PropertyOwnerCopyWith<$R2, PropertyOwner, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PropertyOwnerCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PropertyCategoryRefMapper extends ClassMapperBase<PropertyCategoryRef> {
  PropertyCategoryRefMapper._();

  static PropertyCategoryRefMapper? _instance;
  static PropertyCategoryRefMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PropertyCategoryRefMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PropertyCategoryRef';

  static String _$id(PropertyCategoryRef v) => v.id;
  static const Field<PropertyCategoryRef, String> _f$id = Field(
    'id',
    _$id,
    key: r'_id',
  );
  static String _$title(PropertyCategoryRef v) => v.title;
  static const Field<PropertyCategoryRef, String> _f$title = Field(
    'title',
    _$title,
  );
  static String? _$pageTitle(PropertyCategoryRef v) => v.pageTitle;
  static const Field<PropertyCategoryRef, String> _f$pageTitle = Field(
    'pageTitle',
    _$pageTitle,
    opt: true,
  );
  static String? _$image(PropertyCategoryRef v) => v.image;
  static const Field<PropertyCategoryRef, String> _f$image = Field(
    'image',
    _$image,
    opt: true,
  );

  @override
  final MappableFields<PropertyCategoryRef> fields = const {
    #id: _f$id,
    #title: _f$title,
    #pageTitle: _f$pageTitle,
    #image: _f$image,
  };

  static PropertyCategoryRef _instantiate(DecodingData data) {
    return PropertyCategoryRef(
      id: data.dec(_f$id),
      title: data.dec(_f$title),
      pageTitle: data.dec(_f$pageTitle),
      image: data.dec(_f$image),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PropertyCategoryRef fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PropertyCategoryRef>(map);
  }

  static PropertyCategoryRef fromJson(String json) {
    return ensureInitialized().decodeJson<PropertyCategoryRef>(json);
  }
}

mixin PropertyCategoryRefMappable {
  String toJson() {
    return PropertyCategoryRefMapper.ensureInitialized()
        .encodeJson<PropertyCategoryRef>(this as PropertyCategoryRef);
  }

  Map<String, dynamic> toMap() {
    return PropertyCategoryRefMapper.ensureInitialized()
        .encodeMap<PropertyCategoryRef>(this as PropertyCategoryRef);
  }

  PropertyCategoryRefCopyWith<
    PropertyCategoryRef,
    PropertyCategoryRef,
    PropertyCategoryRef
  >
  get copyWith =>
      _PropertyCategoryRefCopyWithImpl<
        PropertyCategoryRef,
        PropertyCategoryRef
      >(this as PropertyCategoryRef, $identity, $identity);
  @override
  String toString() {
    return PropertyCategoryRefMapper.ensureInitialized().stringifyValue(
      this as PropertyCategoryRef,
    );
  }

  @override
  bool operator ==(Object other) {
    return PropertyCategoryRefMapper.ensureInitialized().equalsValue(
      this as PropertyCategoryRef,
      other,
    );
  }

  @override
  int get hashCode {
    return PropertyCategoryRefMapper.ensureInitialized().hashValue(
      this as PropertyCategoryRef,
    );
  }
}

extension PropertyCategoryRefValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PropertyCategoryRef, $Out> {
  PropertyCategoryRefCopyWith<$R, PropertyCategoryRef, $Out>
  get $asPropertyCategoryRef => $base.as(
    (v, t, t2) => _PropertyCategoryRefCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class PropertyCategoryRefCopyWith<
  $R,
  $In extends PropertyCategoryRef,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? title, String? pageTitle, String? image});
  PropertyCategoryRefCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PropertyCategoryRefCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PropertyCategoryRef, $Out>
    implements PropertyCategoryRefCopyWith<$R, PropertyCategoryRef, $Out> {
  _PropertyCategoryRefCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PropertyCategoryRef> $mapper =
      PropertyCategoryRefMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? title,
    Object? pageTitle = $none,
    Object? image = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (title != null) #title: title,
      if (pageTitle != $none) #pageTitle: pageTitle,
      if (image != $none) #image: image,
    }),
  );
  @override
  PropertyCategoryRef $make(CopyWithData data) => PropertyCategoryRef(
    id: data.get(#id, or: $value.id),
    title: data.get(#title, or: $value.title),
    pageTitle: data.get(#pageTitle, or: $value.pageTitle),
    image: data.get(#image, or: $value.image),
  );

  @override
  PropertyCategoryRefCopyWith<$R2, PropertyCategoryRef, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PropertyCategoryRefCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PropertyMediaMapper extends ClassMapperBase<PropertyMedia> {
  PropertyMediaMapper._();

  static PropertyMediaMapper? _instance;
  static PropertyMediaMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PropertyMediaMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PropertyMedia';

  static String _$id(PropertyMedia v) => v.id;
  static const Field<PropertyMedia, String> _f$id = Field(
    'id',
    _$id,
    key: r'_id',
  );
  static String _$url(PropertyMedia v) => v.url;
  static const Field<PropertyMedia, String> _f$url = Field('url', _$url);
  static String _$mime(PropertyMedia v) => v.mime;
  static const Field<PropertyMedia, String> _f$mime = Field('mime', _$mime);
  static String _$name(PropertyMedia v) => v.name;
  static const Field<PropertyMedia, String> _f$name = Field('name', _$name);
  static int _$size(PropertyMedia v) => v.size;
  static const Field<PropertyMedia, int> _f$size = Field('size', _$size);

  @override
  final MappableFields<PropertyMedia> fields = const {
    #id: _f$id,
    #url: _f$url,
    #mime: _f$mime,
    #name: _f$name,
    #size: _f$size,
  };

  static PropertyMedia _instantiate(DecodingData data) {
    return PropertyMedia(
      id: data.dec(_f$id),
      url: data.dec(_f$url),
      mime: data.dec(_f$mime),
      name: data.dec(_f$name),
      size: data.dec(_f$size),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PropertyMedia fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PropertyMedia>(map);
  }

  static PropertyMedia fromJson(String json) {
    return ensureInitialized().decodeJson<PropertyMedia>(json);
  }
}

mixin PropertyMediaMappable {
  String toJson() {
    return PropertyMediaMapper.ensureInitialized().encodeJson<PropertyMedia>(
      this as PropertyMedia,
    );
  }

  Map<String, dynamic> toMap() {
    return PropertyMediaMapper.ensureInitialized().encodeMap<PropertyMedia>(
      this as PropertyMedia,
    );
  }

  PropertyMediaCopyWith<PropertyMedia, PropertyMedia, PropertyMedia>
  get copyWith => _PropertyMediaCopyWithImpl<PropertyMedia, PropertyMedia>(
    this as PropertyMedia,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return PropertyMediaMapper.ensureInitialized().stringifyValue(
      this as PropertyMedia,
    );
  }

  @override
  bool operator ==(Object other) {
    return PropertyMediaMapper.ensureInitialized().equalsValue(
      this as PropertyMedia,
      other,
    );
  }

  @override
  int get hashCode {
    return PropertyMediaMapper.ensureInitialized().hashValue(
      this as PropertyMedia,
    );
  }
}

extension PropertyMediaValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PropertyMedia, $Out> {
  PropertyMediaCopyWith<$R, PropertyMedia, $Out> get $asPropertyMedia =>
      $base.as((v, t, t2) => _PropertyMediaCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PropertyMediaCopyWith<$R, $In extends PropertyMedia, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? url, String? mime, String? name, int? size});
  PropertyMediaCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PropertyMediaCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PropertyMedia, $Out>
    implements PropertyMediaCopyWith<$R, PropertyMedia, $Out> {
  _PropertyMediaCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PropertyMedia> $mapper =
      PropertyMediaMapper.ensureInitialized();
  @override
  $R call({String? id, String? url, String? mime, String? name, int? size}) =>
      $apply(
        FieldCopyWithData({
          if (id != null) #id: id,
          if (url != null) #url: url,
          if (mime != null) #mime: mime,
          if (name != null) #name: name,
          if (size != null) #size: size,
        }),
      );
  @override
  PropertyMedia $make(CopyWithData data) => PropertyMedia(
    id: data.get(#id, or: $value.id),
    url: data.get(#url, or: $value.url),
    mime: data.get(#mime, or: $value.mime),
    name: data.get(#name, or: $value.name),
    size: data.get(#size, or: $value.size),
  );

  @override
  PropertyMediaCopyWith<$R2, PropertyMedia, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PropertyMediaCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PropertyAddressMapper extends ClassMapperBase<PropertyAddress> {
  PropertyAddressMapper._();

  static PropertyAddressMapper? _instance;
  static PropertyAddressMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PropertyAddressMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PropertyAddress';

  static String? _$addressLine1(PropertyAddress v) => v.addressLine1;
  static const Field<PropertyAddress, String> _f$addressLine1 = Field(
    'addressLine1',
    _$addressLine1,
    opt: true,
  );
  static String? _$street(PropertyAddress v) => v.street;
  static const Field<PropertyAddress, String> _f$street = Field(
    'street',
    _$street,
    opt: true,
  );
  static String? _$city(PropertyAddress v) => v.city;
  static const Field<PropertyAddress, String> _f$city = Field(
    'city',
    _$city,
    opt: true,
  );
  static String? _$state(PropertyAddress v) => v.state;
  static const Field<PropertyAddress, String> _f$state = Field(
    'state',
    _$state,
    opt: true,
  );
  static String? _$country(PropertyAddress v) => v.country;
  static const Field<PropertyAddress, String> _f$country = Field(
    'country',
    _$country,
    opt: true,
  );
  static String? _$postcode(PropertyAddress v) => v.postcode;
  static const Field<PropertyAddress, String> _f$postcode = Field(
    'postcode',
    _$postcode,
    opt: true,
  );

  @override
  final MappableFields<PropertyAddress> fields = const {
    #addressLine1: _f$addressLine1,
    #street: _f$street,
    #city: _f$city,
    #state: _f$state,
    #country: _f$country,
    #postcode: _f$postcode,
  };

  static PropertyAddress _instantiate(DecodingData data) {
    return PropertyAddress(
      addressLine1: data.dec(_f$addressLine1),
      street: data.dec(_f$street),
      city: data.dec(_f$city),
      state: data.dec(_f$state),
      country: data.dec(_f$country),
      postcode: data.dec(_f$postcode),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PropertyAddress fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PropertyAddress>(map);
  }

  static PropertyAddress fromJson(String json) {
    return ensureInitialized().decodeJson<PropertyAddress>(json);
  }
}

mixin PropertyAddressMappable {
  String toJson() {
    return PropertyAddressMapper.ensureInitialized()
        .encodeJson<PropertyAddress>(this as PropertyAddress);
  }

  Map<String, dynamic> toMap() {
    return PropertyAddressMapper.ensureInitialized().encodeMap<PropertyAddress>(
      this as PropertyAddress,
    );
  }

  PropertyAddressCopyWith<PropertyAddress, PropertyAddress, PropertyAddress>
  get copyWith =>
      _PropertyAddressCopyWithImpl<PropertyAddress, PropertyAddress>(
        this as PropertyAddress,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PropertyAddressMapper.ensureInitialized().stringifyValue(
      this as PropertyAddress,
    );
  }

  @override
  bool operator ==(Object other) {
    return PropertyAddressMapper.ensureInitialized().equalsValue(
      this as PropertyAddress,
      other,
    );
  }

  @override
  int get hashCode {
    return PropertyAddressMapper.ensureInitialized().hashValue(
      this as PropertyAddress,
    );
  }
}

extension PropertyAddressValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PropertyAddress, $Out> {
  PropertyAddressCopyWith<$R, PropertyAddress, $Out> get $asPropertyAddress =>
      $base.as((v, t, t2) => _PropertyAddressCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PropertyAddressCopyWith<$R, $In extends PropertyAddress, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? addressLine1,
    String? street,
    String? city,
    String? state,
    String? country,
    String? postcode,
  });
  PropertyAddressCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PropertyAddressCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PropertyAddress, $Out>
    implements PropertyAddressCopyWith<$R, PropertyAddress, $Out> {
  _PropertyAddressCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PropertyAddress> $mapper =
      PropertyAddressMapper.ensureInitialized();
  @override
  $R call({
    Object? addressLine1 = $none,
    Object? street = $none,
    Object? city = $none,
    Object? state = $none,
    Object? country = $none,
    Object? postcode = $none,
  }) => $apply(
    FieldCopyWithData({
      if (addressLine1 != $none) #addressLine1: addressLine1,
      if (street != $none) #street: street,
      if (city != $none) #city: city,
      if (state != $none) #state: state,
      if (country != $none) #country: country,
      if (postcode != $none) #postcode: postcode,
    }),
  );
  @override
  PropertyAddress $make(CopyWithData data) => PropertyAddress(
    addressLine1: data.get(#addressLine1, or: $value.addressLine1),
    street: data.get(#street, or: $value.street),
    city: data.get(#city, or: $value.city),
    state: data.get(#state, or: $value.state),
    country: data.get(#country, or: $value.country),
    postcode: data.get(#postcode, or: $value.postcode),
  );

  @override
  PropertyAddressCopyWith<$R2, PropertyAddress, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PropertyAddressCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PropertyLocationMapper extends ClassMapperBase<PropertyLocation> {
  PropertyLocationMapper._();

  static PropertyLocationMapper? _instance;
  static PropertyLocationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PropertyLocationMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PropertyLocation';

  static List<double> _$coordinates(PropertyLocation v) => v.coordinates;
  static const Field<PropertyLocation, List<double>> _f$coordinates = Field(
    'coordinates',
    _$coordinates,
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<PropertyLocation> fields = const {
    #coordinates: _f$coordinates,
  };

  static PropertyLocation _instantiate(DecodingData data) {
    return PropertyLocation(coordinates: data.dec(_f$coordinates));
  }

  @override
  final Function instantiate = _instantiate;

  static PropertyLocation fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PropertyLocation>(map);
  }

  static PropertyLocation fromJson(String json) {
    return ensureInitialized().decodeJson<PropertyLocation>(json);
  }
}

mixin PropertyLocationMappable {
  String toJson() {
    return PropertyLocationMapper.ensureInitialized()
        .encodeJson<PropertyLocation>(this as PropertyLocation);
  }

  Map<String, dynamic> toMap() {
    return PropertyLocationMapper.ensureInitialized()
        .encodeMap<PropertyLocation>(this as PropertyLocation);
  }

  PropertyLocationCopyWith<PropertyLocation, PropertyLocation, PropertyLocation>
  get copyWith =>
      _PropertyLocationCopyWithImpl<PropertyLocation, PropertyLocation>(
        this as PropertyLocation,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PropertyLocationMapper.ensureInitialized().stringifyValue(
      this as PropertyLocation,
    );
  }

  @override
  bool operator ==(Object other) {
    return PropertyLocationMapper.ensureInitialized().equalsValue(
      this as PropertyLocation,
      other,
    );
  }

  @override
  int get hashCode {
    return PropertyLocationMapper.ensureInitialized().hashValue(
      this as PropertyLocation,
    );
  }
}

extension PropertyLocationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PropertyLocation, $Out> {
  PropertyLocationCopyWith<$R, PropertyLocation, $Out>
  get $asPropertyLocation =>
      $base.as((v, t, t2) => _PropertyLocationCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PropertyLocationCopyWith<$R, $In extends PropertyLocation, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, double, ObjectCopyWith<$R, double, double>> get coordinates;
  $R call({List<double>? coordinates});
  PropertyLocationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PropertyLocationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PropertyLocation, $Out>
    implements PropertyLocationCopyWith<$R, PropertyLocation, $Out> {
  _PropertyLocationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PropertyLocation> $mapper =
      PropertyLocationMapper.ensureInitialized();
  @override
  ListCopyWith<$R, double, ObjectCopyWith<$R, double, double>>
  get coordinates => ListCopyWith(
    $value.coordinates,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(coordinates: v),
  );
  @override
  $R call({List<double>? coordinates}) => $apply(
    FieldCopyWithData({if (coordinates != null) #coordinates: coordinates}),
  );
  @override
  PropertyLocation $make(CopyWithData data) => PropertyLocation(
    coordinates: data.get(#coordinates, or: $value.coordinates),
  );

  @override
  PropertyLocationCopyWith<$R2, PropertyLocation, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PropertyLocationCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PropertyMapper extends ClassMapperBase<Property> {
  PropertyMapper._();

  static PropertyMapper? _instance;
  static PropertyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PropertyMapper._());
      PropertyOwnerMapper.ensureInitialized();
      PropertyCategoryRefMapper.ensureInitialized();
      PropertyMediaMapper.ensureInitialized();
      PropertyAddressMapper.ensureInitialized();
      PropertyLocationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Property';

  static String _$id(Property v) => v.id;
  static const Field<Property, String> _f$id = Field('id', _$id, key: r'_id');
  static PropertyOwner _$owner(Property v) => v.owner;
  static const Field<Property, PropertyOwner> _f$owner = Field(
    'owner',
    _$owner,
    key: r'user',
    hook: _PropertyOwnerHook(),
  );
  static List<PropertyCategoryRef> _$categories(Property v) => v.categories;
  static const Field<Property, List<PropertyCategoryRef>> _f$categories = Field(
    'categories',
    _$categories,
  );
  static String _$title(Property v) => v.title;
  static const Field<Property, String> _f$title = Field('title', _$title);
  static String _$description(Property v) => v.description;
  static const Field<Property, String> _f$description = Field(
    'description',
    _$description,
  );
  static num? _$salePrice(Property v) => v.salePrice;
  static const Field<Property, num> _f$salePrice = Field(
    'salePrice',
    _$salePrice,
    opt: true,
  );
  static num? _$rentPrice(Property v) => v.rentPrice;
  static const Field<Property, num> _f$rentPrice = Field(
    'rentPrice',
    _$rentPrice,
    opt: true,
  );
  static String? _$currency(Property v) => v.currency;
  static const Field<Property, String> _f$currency = Field(
    'currency',
    _$currency,
    opt: true,
  );
  static List<PropertyMedia> _$media(Property v) => v.media;
  static const Field<Property, List<PropertyMedia>> _f$media = Field(
    'media',
    _$media,
    opt: true,
    def: const [],
  );
  static List<String> _$tags(Property v) => v.tags;
  static const Field<Property, List<String>> _f$tags = Field(
    'tags',
    _$tags,
    opt: true,
    def: const [],
  );
  static PropertyAddress? _$address(Property v) => v.address;
  static const Field<Property, PropertyAddress> _f$address = Field(
    'address',
    _$address,
    opt: true,
  );
  static PropertyLocation? _$location(Property v) => v.location;
  static const Field<Property, PropertyLocation> _f$location = Field(
    'location',
    _$location,
    opt: true,
  );
  static bool _$forSale(Property v) => v.forSale;
  static const Field<Property, bool> _f$forSale = Field('forSale', _$forSale);
  static bool _$forRent(Property v) => v.forRent;
  static const Field<Property, bool> _f$forRent = Field('forRent', _$forRent);
  static String _$visibility(Property v) => v.visibility;
  static const Field<Property, String> _f$visibility = Field(
    'visibility',
    _$visibility,
  );
  static Map<String, dynamic> _$amenities(Property v) => v.amenities;
  static const Field<Property, Map<String, dynamic>> _f$amenities = Field(
    'amenities',
    _$amenities,
    opt: true,
    def: const {},
  );
  static String _$status(Property v) => v.status;
  static const Field<Property, String> _f$status = Field('status', _$status);
  static List<dynamic> _$faqs(Property v) => v.faqs;
  static const Field<Property, List<dynamic>> _f$faqs = Field(
    'faqs',
    _$faqs,
    opt: true,
    def: const [],
  );
  static List<dynamic> _$documents(Property v) => v.documents;
  static const Field<Property, List<dynamic>> _f$documents = Field(
    'documents',
    _$documents,
    opt: true,
    def: const [],
  );
  static String _$createdAt(Property v) => v.createdAt;
  static const Field<Property, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );
  static String _$updatedAt(Property v) => v.updatedAt;
  static const Field<Property, String> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
  );

  @override
  final MappableFields<Property> fields = const {
    #id: _f$id,
    #owner: _f$owner,
    #categories: _f$categories,
    #title: _f$title,
    #description: _f$description,
    #salePrice: _f$salePrice,
    #rentPrice: _f$rentPrice,
    #currency: _f$currency,
    #media: _f$media,
    #tags: _f$tags,
    #address: _f$address,
    #location: _f$location,
    #forSale: _f$forSale,
    #forRent: _f$forRent,
    #visibility: _f$visibility,
    #amenities: _f$amenities,
    #status: _f$status,
    #faqs: _f$faqs,
    #documents: _f$documents,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
  };

  static Property _instantiate(DecodingData data) {
    return Property(
      id: data.dec(_f$id),
      owner: data.dec(_f$owner),
      categories: data.dec(_f$categories),
      title: data.dec(_f$title),
      description: data.dec(_f$description),
      salePrice: data.dec(_f$salePrice),
      rentPrice: data.dec(_f$rentPrice),
      currency: data.dec(_f$currency),
      media: data.dec(_f$media),
      tags: data.dec(_f$tags),
      address: data.dec(_f$address),
      location: data.dec(_f$location),
      forSale: data.dec(_f$forSale),
      forRent: data.dec(_f$forRent),
      visibility: data.dec(_f$visibility),
      amenities: data.dec(_f$amenities),
      status: data.dec(_f$status),
      faqs: data.dec(_f$faqs),
      documents: data.dec(_f$documents),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Property fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Property>(map);
  }

  static Property fromJson(String json) {
    return ensureInitialized().decodeJson<Property>(json);
  }
}

mixin PropertyMappable {
  String toJson() {
    return PropertyMapper.ensureInitialized().encodeJson<Property>(
      this as Property,
    );
  }

  Map<String, dynamic> toMap() {
    return PropertyMapper.ensureInitialized().encodeMap<Property>(
      this as Property,
    );
  }

  PropertyCopyWith<Property, Property, Property> get copyWith =>
      _PropertyCopyWithImpl<Property, Property>(
        this as Property,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PropertyMapper.ensureInitialized().stringifyValue(this as Property);
  }

  @override
  bool operator ==(Object other) {
    return PropertyMapper.ensureInitialized().equalsValue(
      this as Property,
      other,
    );
  }

  @override
  int get hashCode {
    return PropertyMapper.ensureInitialized().hashValue(this as Property);
  }
}

extension PropertyValueCopy<$R, $Out> on ObjectCopyWith<$R, Property, $Out> {
  PropertyCopyWith<$R, Property, $Out> get $asProperty =>
      $base.as((v, t, t2) => _PropertyCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PropertyCopyWith<$R, $In extends Property, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  PropertyOwnerCopyWith<$R, PropertyOwner, PropertyOwner> get owner;
  ListCopyWith<
    $R,
    PropertyCategoryRef,
    PropertyCategoryRefCopyWith<$R, PropertyCategoryRef, PropertyCategoryRef>
  >
  get categories;
  ListCopyWith<
    $R,
    PropertyMedia,
    PropertyMediaCopyWith<$R, PropertyMedia, PropertyMedia>
  >
  get media;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get tags;
  PropertyAddressCopyWith<$R, PropertyAddress, PropertyAddress>? get address;
  PropertyLocationCopyWith<$R, PropertyLocation, PropertyLocation>?
  get location;
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>
  get amenities;
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?> get faqs;
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>
  get documents;
  $R call({
    String? id,
    PropertyOwner? owner,
    List<PropertyCategoryRef>? categories,
    String? title,
    String? description,
    num? salePrice,
    num? rentPrice,
    String? currency,
    List<PropertyMedia>? media,
    List<String>? tags,
    PropertyAddress? address,
    PropertyLocation? location,
    bool? forSale,
    bool? forRent,
    String? visibility,
    Map<String, dynamic>? amenities,
    String? status,
    List<dynamic>? faqs,
    List<dynamic>? documents,
    String? createdAt,
    String? updatedAt,
  });
  PropertyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PropertyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Property, $Out>
    implements PropertyCopyWith<$R, Property, $Out> {
  _PropertyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Property> $mapper =
      PropertyMapper.ensureInitialized();
  @override
  PropertyOwnerCopyWith<$R, PropertyOwner, PropertyOwner> get owner =>
      $value.owner.copyWith.$chain((v) => call(owner: v));
  @override
  ListCopyWith<
    $R,
    PropertyCategoryRef,
    PropertyCategoryRefCopyWith<$R, PropertyCategoryRef, PropertyCategoryRef>
  >
  get categories => ListCopyWith(
    $value.categories,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(categories: v),
  );
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
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get tags =>
      ListCopyWith(
        $value.tags,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(tags: v),
      );
  @override
  PropertyAddressCopyWith<$R, PropertyAddress, PropertyAddress>? get address =>
      $value.address?.copyWith.$chain((v) => call(address: v));
  @override
  PropertyLocationCopyWith<$R, PropertyLocation, PropertyLocation>?
  get location => $value.location?.copyWith.$chain((v) => call(location: v));
  @override
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>
  get amenities => MapCopyWith(
    $value.amenities,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(amenities: v),
  );
  @override
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?> get faqs =>
      ListCopyWith(
        $value.faqs,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(faqs: v),
      );
  @override
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>
  get documents => ListCopyWith(
    $value.documents,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(documents: v),
  );
  @override
  $R call({
    String? id,
    PropertyOwner? owner,
    List<PropertyCategoryRef>? categories,
    String? title,
    String? description,
    Object? salePrice = $none,
    Object? rentPrice = $none,
    Object? currency = $none,
    List<PropertyMedia>? media,
    List<String>? tags,
    Object? address = $none,
    Object? location = $none,
    bool? forSale,
    bool? forRent,
    String? visibility,
    Map<String, dynamic>? amenities,
    String? status,
    List<dynamic>? faqs,
    List<dynamic>? documents,
    String? createdAt,
    String? updatedAt,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (owner != null) #owner: owner,
      if (categories != null) #categories: categories,
      if (title != null) #title: title,
      if (description != null) #description: description,
      if (salePrice != $none) #salePrice: salePrice,
      if (rentPrice != $none) #rentPrice: rentPrice,
      if (currency != $none) #currency: currency,
      if (media != null) #media: media,
      if (tags != null) #tags: tags,
      if (address != $none) #address: address,
      if (location != $none) #location: location,
      if (forSale != null) #forSale: forSale,
      if (forRent != null) #forRent: forRent,
      if (visibility != null) #visibility: visibility,
      if (amenities != null) #amenities: amenities,
      if (status != null) #status: status,
      if (faqs != null) #faqs: faqs,
      if (documents != null) #documents: documents,
      if (createdAt != null) #createdAt: createdAt,
      if (updatedAt != null) #updatedAt: updatedAt,
    }),
  );
  @override
  Property $make(CopyWithData data) => Property(
    id: data.get(#id, or: $value.id),
    owner: data.get(#owner, or: $value.owner),
    categories: data.get(#categories, or: $value.categories),
    title: data.get(#title, or: $value.title),
    description: data.get(#description, or: $value.description),
    salePrice: data.get(#salePrice, or: $value.salePrice),
    rentPrice: data.get(#rentPrice, or: $value.rentPrice),
    currency: data.get(#currency, or: $value.currency),
    media: data.get(#media, or: $value.media),
    tags: data.get(#tags, or: $value.tags),
    address: data.get(#address, or: $value.address),
    location: data.get(#location, or: $value.location),
    forSale: data.get(#forSale, or: $value.forSale),
    forRent: data.get(#forRent, or: $value.forRent),
    visibility: data.get(#visibility, or: $value.visibility),
    amenities: data.get(#amenities, or: $value.amenities),
    status: data.get(#status, or: $value.status),
    faqs: data.get(#faqs, or: $value.faqs),
    documents: data.get(#documents, or: $value.documents),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
  );

  @override
  PropertyCopyWith<$R2, Property, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PropertyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

