// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'saved_property.dart';

class SavedPropertyMapper extends ClassMapperBase<SavedProperty> {
  SavedPropertyMapper._();

  static SavedPropertyMapper? _instance;
  static SavedPropertyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SavedPropertyMapper._());
      PropertyMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SavedProperty';

  static String _$id(SavedProperty v) => v.id;
  static const Field<SavedProperty, String> _f$id = Field(
    'id',
    _$id,
    key: r'_id',
  );
  static String _$user(SavedProperty v) => v.user;
  static const Field<SavedProperty, String> _f$user = Field('user', _$user);
  static Property _$property(SavedProperty v) => v.property;
  static const Field<SavedProperty, Property> _f$property = Field(
    'property',
    _$property,
  );
  static String _$createdAt(SavedProperty v) => v.createdAt;
  static const Field<SavedProperty, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );
  static String _$updatedAt(SavedProperty v) => v.updatedAt;
  static const Field<SavedProperty, String> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
  );

  @override
  final MappableFields<SavedProperty> fields = const {
    #id: _f$id,
    #user: _f$user,
    #property: _f$property,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
  };

  static SavedProperty _instantiate(DecodingData data) {
    return SavedProperty(
      id: data.dec(_f$id),
      user: data.dec(_f$user),
      property: data.dec(_f$property),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SavedProperty fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SavedProperty>(map);
  }

  static SavedProperty fromJson(String json) {
    return ensureInitialized().decodeJson<SavedProperty>(json);
  }
}

mixin SavedPropertyMappable {
  String toJson() {
    return SavedPropertyMapper.ensureInitialized().encodeJson<SavedProperty>(
      this as SavedProperty,
    );
  }

  Map<String, dynamic> toMap() {
    return SavedPropertyMapper.ensureInitialized().encodeMap<SavedProperty>(
      this as SavedProperty,
    );
  }

  SavedPropertyCopyWith<SavedProperty, SavedProperty, SavedProperty>
  get copyWith => _SavedPropertyCopyWithImpl<SavedProperty, SavedProperty>(
    this as SavedProperty,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return SavedPropertyMapper.ensureInitialized().stringifyValue(
      this as SavedProperty,
    );
  }

  @override
  bool operator ==(Object other) {
    return SavedPropertyMapper.ensureInitialized().equalsValue(
      this as SavedProperty,
      other,
    );
  }

  @override
  int get hashCode {
    return SavedPropertyMapper.ensureInitialized().hashValue(
      this as SavedProperty,
    );
  }
}

extension SavedPropertyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SavedProperty, $Out> {
  SavedPropertyCopyWith<$R, SavedProperty, $Out> get $asSavedProperty =>
      $base.as((v, t, t2) => _SavedPropertyCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SavedPropertyCopyWith<$R, $In extends SavedProperty, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  PropertyCopyWith<$R, Property, Property> get property;
  $R call({
    String? id,
    String? user,
    Property? property,
    String? createdAt,
    String? updatedAt,
  });
  SavedPropertyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SavedPropertyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SavedProperty, $Out>
    implements SavedPropertyCopyWith<$R, SavedProperty, $Out> {
  _SavedPropertyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SavedProperty> $mapper =
      SavedPropertyMapper.ensureInitialized();
  @override
  PropertyCopyWith<$R, Property, Property> get property =>
      $value.property.copyWith.$chain((v) => call(property: v));
  @override
  $R call({
    String? id,
    String? user,
    Property? property,
    String? createdAt,
    String? updatedAt,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (user != null) #user: user,
      if (property != null) #property: property,
      if (createdAt != null) #createdAt: createdAt,
      if (updatedAt != null) #updatedAt: updatedAt,
    }),
  );
  @override
  SavedProperty $make(CopyWithData data) => SavedProperty(
    id: data.get(#id, or: $value.id),
    user: data.get(#user, or: $value.user),
    property: data.get(#property, or: $value.property),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
  );

  @override
  SavedPropertyCopyWith<$R2, SavedProperty, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SavedPropertyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

