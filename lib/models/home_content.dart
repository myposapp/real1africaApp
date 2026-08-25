import 'package:dart_mappable/dart_mappable.dart';
import '../data/static_configs.dart';
import 'property.dart';

part 'home_content.mapper.dart';

@MappableClass()
class HomeCategorySummary with HomeCategorySummaryMappable {
  const HomeCategorySummary({
    required this.id,
    this.parentCategory,
    required this.title,
    this.pageTitle,
    this.description,
    this.article,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    this.count = 0,
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
  final int count;

  String get imageUrl => "${EstateConfigs.contentBaseUrl}$image";

  static final fromMap = HomeCategorySummaryMapper.fromMap;
  static final fromJson = HomeCategorySummaryMapper.fromJson;
}

@MappableClass()
class HomeStateSummary with HomeStateSummaryMappable {
  const HomeStateSummary({required this.state, required this.count});

  @MappableField(key: "_id")
  final String state;
  final int count;

  static final fromMap = HomeStateSummaryMapper.fromMap;
  static final fromJson = HomeStateSummaryMapper.fromJson;
}

@MappableClass()
class HomeShelfSort with HomeShelfSortMappable {
  const HomeShelfSort({required this.key, required this.value});

  final String key;
  final int value;

  static final fromMap = HomeShelfSortMapper.fromMap;
  static final fromJson = HomeShelfSortMapper.fromJson;
}

@MappableClass()
class HomeShelf with HomeShelfMappable {
  const HomeShelf({
    this.eyebrow,
    required this.title,
    this.description,
    this.filterMode,
    this.filters = const [],
    this.sort,
    this.limit,
    required this.id,
    required this.type,
    this.items = const [],
  });

  final String? eyebrow;
  final String title;
  final String? description;
  final String? filterMode;
  final List<dynamic> filters;
  final HomeShelfSort? sort;
  final int? limit;
  @MappableField(key: "_id")
  final String id;
  final String type;
  final List<Property> items;

  static final fromMap = HomeShelfMapper.fromMap;
  static final fromJson = HomeShelfMapper.fromJson;
}

@MappableClass()
class HomeContent with HomeContentMappable {
  const HomeContent({
    this.categories = const [],
    required this.propertyCount,
    required this.agentCount,
    this.states = const [],
    this.shelves = const [],
  });

  final List<HomeCategorySummary> categories;
  final int propertyCount;
  final int agentCount;
  final List<HomeStateSummary> states;
  final List<HomeShelf> shelves;

  static final fromMap = HomeContentMapper.fromMap;
  static final fromJson = HomeContentMapper.fromJson;
}
