import 'package:dart_mappable/dart_mappable.dart';
import 'property.dart';

part 'saved_property.mapper.dart';

@MappableClass()
class SavedProperty with SavedPropertyMappable {
  const SavedProperty({
    required this.id,
    required this.user,
    required this.property,
    required this.createdAt,
    required this.updatedAt,
  });

  @MappableField(key: "_id")
  final String id;
  final String user;
  final Property property;
  @MappableField(key: "createdAt")
  final String createdAt;
  @MappableField(key: "updatedAt")
  final String updatedAt;

  static final fromMap = SavedPropertyMapper.fromMap;
  static final fromJson = SavedPropertyMapper.fromJson;
}
