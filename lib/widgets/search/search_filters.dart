import '../../models/property_search_response.dart';

/// The filter state behind the Explore search panel and the "More search
/// options" sheet. Mutable on purpose: the panel edits it in place and the
/// sheet works on a [copy] until the user applies it.
class SearchFilters {
  SearchFilters({
    this.purpose = 'sale',
    this.category,
    this.location,
    this.minPrice,
    this.maxPrice,
    this.keywords,
    Map<String, String>? amenities,
  }) : amenities = amenities ?? {};

  String purpose; // 'sale' | 'rent'
  CategoryOption? category;
  LocationOption? location;
  int? minPrice;
  int? maxPrice;
  String? keywords;

  /// Amenity-profile filters keyed by field name (e.g. bedrooms, furnishing).
  /// Sent to the search endpoint as top-level query params.
  final Map<String, String> amenities;

  SearchFilters copy() => SearchFilters(
    purpose: purpose,
    category: category,
    location: location,
    minPrice: minPrice,
    maxPrice: maxPrice,
    keywords: keywords,
    amenities: Map.of(amenities),
  );

  String? get bedrooms => amenities['bedrooms'];

  String? get priceQuery {
    if (minPrice == null && maxPrice == null) return null;
    return '${minPrice ?? ''}-${maxPrice ?? ''}';
  }

  String? get trimmedKeywords {
    final value = keywords?.trim();
    return value == null || value.isEmpty ? null : value;
  }

  /// Filters set only from the "More search options" sheet, for its badge.
  int get extraFilterCount =>
      amenities.keys.where((key) => key != 'bedrooms').length +
      (trimmedKeywords != null ? 1 : 0);

  String get priceLabel {
    if (minPrice == null && maxPrice == null) return 'Any price';
    if (minPrice == null) return 'Up to ${formatCompactNaira(maxPrice!)}';
    if (maxPrice == null) return 'From ${formatCompactNaira(minPrice!)}';
    return '${formatCompactNaira(minPrice!)} – ${formatCompactNaira(maxPrice!)}';
  }

  String get bedroomsLabel => bedroomLabel(bedrooms) ?? 'Any beds';
}

/// Amenity number fields that read naturally as a small count picker.
const countAmenityFields = {
  'bedrooms',
  'bathrooms',
  'toilets',
  'parkingSpaces',
};

const countAmenityValues = ['1', '2', '3', '4', '5', '6'];

String? bedroomLabel(String? value) {
  if (value == null) return null;
  return value == '1' ? '1 bed' : '$value beds';
}

String formatCompactNaira(int value) {
  String trim(double v) =>
      v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toStringAsFixed(1);
  if (value >= 1000000000) return '₦${trim(value / 1000000000)}B';
  if (value >= 1000000) return '₦${trim(value / 1000000)}M';
  if (value >= 1000) return '₦${trim(value / 1000)}K';
  return '₦$value';
}
