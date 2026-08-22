import 'package:dart_mappable/dart_mappable.dart';
import 'static_configs.dart';

part 'property_category.mapper.dart';

@MappableClass()
class PropertyCategory with PropertyCategoryMappable {
  const PropertyCategory({
    required this.id,
    this.parentCategory,
    required this.title,
    this.pageTitle,
    this.description,
    this.article,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  @MappableField(key: "_id")
  final String id;
  @MappableField(key: "category")
  final String? parentCategory;
  final String title;
  final String? pageTitle;
  final String? description;
  final String? article;
  final String image;
  @MappableField(key: "createdAt")
  final String createdAt;
  @MappableField(key: "updatedAt")
  final String updatedAt;

  String get imageUrl => "${EstateConfigs.contentBaseUrl}$image";

  static final fromMap = PropertyCategoryMapper.fromMap;
  static final fromJson = PropertyCategoryMapper.fromJson;
}
