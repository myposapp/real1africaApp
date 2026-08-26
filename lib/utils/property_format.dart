import '../models/property.dart';

String propertyPriceLabel(Property property) {
  final price = property.salePrice ?? property.rentPrice;
  if (price == null) return 'Price on request';
  final currency = property.currency ?? '₦';
  final label = '$currency${price.toStringAsFixed(0)}';
  return property.salePrice == null && property.rentPrice != null
      ? '$label /period'
      : label;
}

String propertyAddressLabel(Property property) {
  final address = property.address;
  if (address == null) return '';
  return [
    address.street,
    address.city,
    address.state,
    address.country,
  ].where((p) => p != null && p.isNotEmpty).join(', ');
}

String propertyCityStateLabel(Property property) {
  final address = property.address;
  if (address == null) return '';
  return [
    address.city,
    address.state,
  ].where((p) => p != null && p.isNotEmpty).join(', ');
}
