import 'package:dart_mappable/dart_mappable.dart';

part 'analytics.mapper.dart';

@MappableClass()
class Analytics with AnalyticsMappable {
  const Analytics({required this.totalProperties, required this.savedProperties});

  final int totalProperties;
  final int savedProperties;

  static final fromMap = AnalyticsMapper.fromMap;
  static final fromJson = AnalyticsMapper.fromJson;
}
