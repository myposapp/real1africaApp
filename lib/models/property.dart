import 'package:dart_mappable/dart_mappable.dart';
import 'static_configs.dart';

part 'property.mapper.dart';

@MappableClass()
class PropertyOwner with PropertyOwnerMappable {
  const PropertyOwner({
    required this.id,
    required this.name,
    this.phone,
    this.email,
    this.photo,
    this.verifiedAgent,
  });

  @MappableField(key: "_id")
  final String id;
  final String name;
  final String? phone;
  final String? email;
  final String? photo;
  final bool? verifiedAgent;

  String? get photoUrl =>
      photo == null ? null : "${EstateConfigs.contentBaseUrl}$photo";

  static final fromMap = PropertyOwnerMapper.fromMap;
  static final fromJson = PropertyOwnerMapper.fromJson;
}

@MappableClass()
class PropertyCategoryRef with PropertyCategoryRefMappable {
  const PropertyCategoryRef({
    required this.id,
    required this.title,
    this.pageTitle,
    this.image,
  });

  @MappableField(key: "_id")
  final String id;
  final String title;
  final String? pageTitle;
  final String? image;

  String? get imageUrl =>
      image == null ? null : "${EstateConfigs.contentBaseUrl}$image";

  static final fromMap = PropertyCategoryRefMapper.fromMap;
  static final fromJson = PropertyCategoryRefMapper.fromJson;
}

@MappableClass()
class PropertyMedia with PropertyMediaMappable {
  const PropertyMedia({
    required this.id,
    required this.url,
    required this.mime,
    required this.name,
    required this.size,
  });

  @MappableField(key: "_id")
  final String id;
  final String url;
  final String mime;
  final String name;
  final int size;

  String get fullUrl => "${EstateConfigs.contentBaseUrl}$url";

  static final fromMap = PropertyMediaMapper.fromMap;
  static final fromJson = PropertyMediaMapper.fromJson;
}

@MappableClass()
class PropertyAddress with PropertyAddressMappable {
  const PropertyAddress({
    this.addressLine1,
    this.street,
    this.city,
    this.state,
    this.country,
    this.postcode,
  });

  final String? addressLine1;
  final String? street;
  final String? city;
  final String? state;
  final String? country;
  final String? postcode;

  static final fromMap = PropertyAddressMapper.fromMap;
  static final fromJson = PropertyAddressMapper.fromJson;

  Map<String, dynamic> toRequestMap() => {
    if (addressLine1 != null) "addressLine1": addressLine1,
    if (street != null) "street": street,
    if (city != null) "city": city,
    if (state != null) "state": state,
    if (country != null) "country": country,
    if (postcode != null) "postcode": postcode,
  };
}

@MappableClass()
class PropertyLocation with PropertyLocationMappable {
  const PropertyLocation({this.coordinates = const []});

  final List<double> coordinates;

  static final fromMap = PropertyLocationMapper.fromMap;
  static final fromJson = PropertyLocationMapper.fromJson;
}

@MappableClass()
class Property with PropertyMappable {
  const Property({
    required this.id,
    required this.owner,
    required this.categories,
    required this.title,
    required this.description,
    this.salePrice,
    this.rentPrice,
    this.currency,
    this.media = const [],
    this.tags = const [],
    this.address,
    this.location,
    required this.forSale,
    required this.forRent,
    required this.visibility,
    this.amenities = const {},
    required this.status,
    this.faqs = const [],
    this.documents = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  @MappableField(key: "_id")
  final String id;
  @MappableField(key: "user")
  final PropertyOwner owner;
  final List<PropertyCategoryRef> categories;
  final String title;
  final String description;
  final num? salePrice;
  final num? rentPrice;
  final String? currency;
  final List<PropertyMedia> media;
  final List<String> tags;
  final PropertyAddress? address;
  final PropertyLocation? location;
  final bool forSale;
  final bool forRent;
  final String visibility;
  final Map<String, dynamic> amenities;
  final String status;
  final List<dynamic> faqs;
  final List<dynamic> documents;
  @MappableField(key: "createdAt")
  final String createdAt;
  @MappableField(key: "updatedAt")
  final String updatedAt;

  static final fromMap = PropertyMapper.fromMap;
  static final fromJson = PropertyMapper.fromJson;
}
