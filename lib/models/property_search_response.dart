import 'package:dart_mappable/dart_mappable.dart';
import 'property.dart';
import '../network/model/base_api_response.dart';

part 'property_search_response.mapper.dart';

@MappableClass()
class CategoryOption with CategoryOptionMappable {
  const CategoryOption({required this.id, required this.title, required this.slug});

  @MappableField(key: "_id")
  final String id;
  final String title;
  final String slug;

  static final fromMap = CategoryOptionMapper.fromMap;
  static final fromJson = CategoryOptionMapper.fromJson;
}

@MappableClass()
class LocationOption with LocationOptionMappable {
  const LocationOption({
    required this.name,
    required this.label,
    required this.slug,
    required this.type,
  });

  final String name;
  final String label;
  final String slug;
  final String type;

  static final fromMap = LocationOptionMapper.fromMap;
  static final fromJson = LocationOptionMapper.fromJson;
}

@MappableClass()
class AmenityField with AmenityFieldMappable {
  const AmenityField({
    required this.name,
    required this.label,
    required this.type,
    this.options = const [],
  });

  final String name;
  final String label;
  final String type;
  final List<String> options;

  static final fromMap = AmenityFieldMapper.fromMap;
  static final fromJson = AmenityFieldMapper.fromJson;
}

@MappableClass()
class AmenityProfile with AmenityProfileMappable {
  const AmenityProfile({
    required this.title,
    this.keywords = const [],
    this.fields = const [],
  });

  final String title;
  final List<String> keywords;
  final List<AmenityField> fields;

  static final fromMap = AmenityProfileMapper.fromMap;
  static final fromJson = AmenityProfileMapper.fromJson;
}

@MappableClass()
class PropertySearchResponse with PropertySearchResponseMappable {
  const PropertySearchResponse({
    this.success,
    this.message,
    this.data = const [],
    this.metadata,
    this.categoryPath = const [],
    this.categoryOptions = const [],
    this.categoryIsLeaf,
    this.location,
    this.locationOptions = const [],
    this.amenityProfile,
    this.purpose,
  });

  final bool? success;
  final String? message;
  final List<Property> data;
  final ResponseMetadata? metadata;
  final List<dynamic> categoryPath;
  final List<CategoryOption> categoryOptions;
  final bool? categoryIsLeaf;
  final String? location;
  final List<LocationOption> locationOptions;
  final AmenityProfile? amenityProfile;
  final String? purpose;

  static final fromMap = PropertySearchResponseMapper.fromMap;
  static final fromJson = PropertySearchResponseMapper.fromJson;
}
