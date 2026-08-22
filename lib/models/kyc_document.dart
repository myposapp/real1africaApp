import 'package:dart_mappable/dart_mappable.dart';

part 'kyc_document.mapper.dart';

@MappableClass()
class KycDocument with KycDocumentMappable {
  const KycDocument({
    required this.id,
    required this.type,
    this.content,
    this.file,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  @MappableField(key: "_id")
  final String id;
  final String type;
  final String? content;
  final String? file;
  final String? status;
  @MappableField(key: "createdAt")
  final String? createdAt;
  @MappableField(key: "updatedAt")
  final String? updatedAt;

  static final fromMap = KycDocumentMapper.fromMap;
  static final fromJson = KycDocumentMapper.fromJson;
}
