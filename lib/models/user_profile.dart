import 'package:dart_mappable/dart_mappable.dart';
import 'kyc_document.dart';
import 'static_configs.dart';

part 'user_profile.mapper.dart';

@MappableClass()
class UserProfile with UserProfileMappable {
  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.photo,
    this.status,
    this.dob,
    this.verifiedAgent,
    this.verifiedSurveyor,
    this.kyc = const [],
    this.userType,
    required this.createdAt,
    this.updatedAt,
  });

  @MappableField(key: "_id")
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? photo;
  final String? status;
  final String? dob;
  final bool? verifiedAgent;
  final bool? verifiedSurveyor;
  final List<KycDocument> kyc;
  final String? userType;
  @MappableField(key: "createdAt")
  final String createdAt;
  @MappableField(key: "updatedAt")
  final String? updatedAt;

  String? get photoUrl =>
      photo == null ? null : "${EstateConfigs.contentBaseUrl}$photo";

  static final fromMap = UserProfileMapper.fromMap;
  static final fromJson = UserProfileMapper.fromJson;
}
