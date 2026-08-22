// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'user_profile.dart';

class UserProfileMapper extends ClassMapperBase<UserProfile> {
  UserProfileMapper._();

  static UserProfileMapper? _instance;
  static UserProfileMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserProfileMapper._());
      KycDocumentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'UserProfile';

  static String _$id(UserProfile v) => v.id;
  static const Field<UserProfile, String> _f$id = Field(
    'id',
    _$id,
    key: r'_id',
  );
  static String _$name(UserProfile v) => v.name;
  static const Field<UserProfile, String> _f$name = Field('name', _$name);
  static String _$email(UserProfile v) => v.email;
  static const Field<UserProfile, String> _f$email = Field('email', _$email);
  static String _$phone(UserProfile v) => v.phone;
  static const Field<UserProfile, String> _f$phone = Field('phone', _$phone);
  static String? _$photo(UserProfile v) => v.photo;
  static const Field<UserProfile, String> _f$photo = Field(
    'photo',
    _$photo,
    opt: true,
  );
  static String? _$status(UserProfile v) => v.status;
  static const Field<UserProfile, String> _f$status = Field(
    'status',
    _$status,
    opt: true,
  );
  static String? _$dob(UserProfile v) => v.dob;
  static const Field<UserProfile, String> _f$dob = Field(
    'dob',
    _$dob,
    opt: true,
  );
  static bool? _$verifiedAgent(UserProfile v) => v.verifiedAgent;
  static const Field<UserProfile, bool> _f$verifiedAgent = Field(
    'verifiedAgent',
    _$verifiedAgent,
    opt: true,
  );
  static bool? _$verifiedSurveyor(UserProfile v) => v.verifiedSurveyor;
  static const Field<UserProfile, bool> _f$verifiedSurveyor = Field(
    'verifiedSurveyor',
    _$verifiedSurveyor,
    opt: true,
  );
  static List<KycDocument> _$kyc(UserProfile v) => v.kyc;
  static const Field<UserProfile, List<KycDocument>> _f$kyc = Field(
    'kyc',
    _$kyc,
    opt: true,
    def: const [],
  );
  static String? _$userType(UserProfile v) => v.userType;
  static const Field<UserProfile, String> _f$userType = Field(
    'userType',
    _$userType,
    opt: true,
  );
  static String _$createdAt(UserProfile v) => v.createdAt;
  static const Field<UserProfile, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );
  static String? _$updatedAt(UserProfile v) => v.updatedAt;
  static const Field<UserProfile, String> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    opt: true,
  );

  @override
  final MappableFields<UserProfile> fields = const {
    #id: _f$id,
    #name: _f$name,
    #email: _f$email,
    #phone: _f$phone,
    #photo: _f$photo,
    #status: _f$status,
    #dob: _f$dob,
    #verifiedAgent: _f$verifiedAgent,
    #verifiedSurveyor: _f$verifiedSurveyor,
    #kyc: _f$kyc,
    #userType: _f$userType,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
  };

  static UserProfile _instantiate(DecodingData data) {
    return UserProfile(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      email: data.dec(_f$email),
      phone: data.dec(_f$phone),
      photo: data.dec(_f$photo),
      status: data.dec(_f$status),
      dob: data.dec(_f$dob),
      verifiedAgent: data.dec(_f$verifiedAgent),
      verifiedSurveyor: data.dec(_f$verifiedSurveyor),
      kyc: data.dec(_f$kyc),
      userType: data.dec(_f$userType),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static UserProfile fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserProfile>(map);
  }

  static UserProfile fromJson(String json) {
    return ensureInitialized().decodeJson<UserProfile>(json);
  }
}

mixin UserProfileMappable {
  String toJson() {
    return UserProfileMapper.ensureInitialized().encodeJson<UserProfile>(
      this as UserProfile,
    );
  }

  Map<String, dynamic> toMap() {
    return UserProfileMapper.ensureInitialized().encodeMap<UserProfile>(
      this as UserProfile,
    );
  }

  UserProfileCopyWith<UserProfile, UserProfile, UserProfile> get copyWith =>
      _UserProfileCopyWithImpl<UserProfile, UserProfile>(
        this as UserProfile,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return UserProfileMapper.ensureInitialized().stringifyValue(
      this as UserProfile,
    );
  }

  @override
  bool operator ==(Object other) {
    return UserProfileMapper.ensureInitialized().equalsValue(
      this as UserProfile,
      other,
    );
  }

  @override
  int get hashCode {
    return UserProfileMapper.ensureInitialized().hashValue(this as UserProfile);
  }
}

extension UserProfileValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserProfile, $Out> {
  UserProfileCopyWith<$R, UserProfile, $Out> get $asUserProfile =>
      $base.as((v, t, t2) => _UserProfileCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserProfileCopyWith<$R, $In extends UserProfile, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    KycDocument,
    KycDocumentCopyWith<$R, KycDocument, KycDocument>
  >
  get kyc;
  $R call({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? photo,
    String? status,
    String? dob,
    bool? verifiedAgent,
    bool? verifiedSurveyor,
    List<KycDocument>? kyc,
    String? userType,
    String? createdAt,
    String? updatedAt,
  });
  UserProfileCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserProfileCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserProfile, $Out>
    implements UserProfileCopyWith<$R, UserProfile, $Out> {
  _UserProfileCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserProfile> $mapper =
      UserProfileMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    KycDocument,
    KycDocumentCopyWith<$R, KycDocument, KycDocument>
  >
  get kyc => ListCopyWith(
    $value.kyc,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(kyc: v),
  );
  @override
  $R call({
    String? id,
    String? name,
    String? email,
    String? phone,
    Object? photo = $none,
    Object? status = $none,
    Object? dob = $none,
    Object? verifiedAgent = $none,
    Object? verifiedSurveyor = $none,
    List<KycDocument>? kyc,
    Object? userType = $none,
    String? createdAt,
    Object? updatedAt = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (email != null) #email: email,
      if (phone != null) #phone: phone,
      if (photo != $none) #photo: photo,
      if (status != $none) #status: status,
      if (dob != $none) #dob: dob,
      if (verifiedAgent != $none) #verifiedAgent: verifiedAgent,
      if (verifiedSurveyor != $none) #verifiedSurveyor: verifiedSurveyor,
      if (kyc != null) #kyc: kyc,
      if (userType != $none) #userType: userType,
      if (createdAt != null) #createdAt: createdAt,
      if (updatedAt != $none) #updatedAt: updatedAt,
    }),
  );
  @override
  UserProfile $make(CopyWithData data) => UserProfile(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    email: data.get(#email, or: $value.email),
    phone: data.get(#phone, or: $value.phone),
    photo: data.get(#photo, or: $value.photo),
    status: data.get(#status, or: $value.status),
    dob: data.get(#dob, or: $value.dob),
    verifiedAgent: data.get(#verifiedAgent, or: $value.verifiedAgent),
    verifiedSurveyor: data.get(#verifiedSurveyor, or: $value.verifiedSurveyor),
    kyc: data.get(#kyc, or: $value.kyc),
    userType: data.get(#userType, or: $value.userType),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
  );

  @override
  UserProfileCopyWith<$R2, UserProfile, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _UserProfileCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

