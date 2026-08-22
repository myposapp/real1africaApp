class Amenity {
  final String icon;
  final String name;

  Amenity({required this.icon, required this.name});
}

class Property {
  final String id;
  final String title;
  final String type; // 'Rent' | 'Sales' | 'Lease'
  final String location;
  final String city;
  final double price;
  final String priceUnit; // '/mo' | 'total'
  final int beds;
  final int baths;
  final int sqft;
  final String image;
  final List<String> gallery;
  final bool isNew;
  bool isFavorite;
  final double rating;
  final int reviewsCount;
  final String description;
  final List<Amenity> amenities;
  final String managerId;
  final String managerName;

  Property({
    required this.id,
    required this.title,
    required this.type,
    required this.location,
    required this.city,
    required this.price,
    required this.priceUnit,
    required this.beds,
    required this.baths,
    required this.sqft,
    required this.image,
    required this.gallery,
    this.isNew = false,
    this.isFavorite = false,
    this.rating = 4.8,
    this.reviewsCount = 12,
    required this.description,
    required this.amenities,
    required this.managerId,
    required this.managerName,
  });
}

class EstateManager {
  final String id;
  final String name;
  final String companyName;
  final String avatar;
  final double rating;
  final int listingsCount;
  final String description;
  final String phone;
  final String email;
  final List<String> specialties;
  final String iconType;

  EstateManager({
    required this.id,
    required this.name,
    required this.companyName,
    required this.avatar,
    required this.rating,
    required this.listingsCount,
    required this.description,
    required this.phone,
    required this.email,
    required this.specialties,
    required this.iconType,
  });
}

class Review {
  final String id;
  final String propertyId;
  final String userName;
  final String userAvatar;
  final int rating;
  final String date;
  final String comment;

  Review({
    required this.id,
    required this.propertyId,
    required this.userName,
    required this.userAvatar,
    required this.rating,
    required this.date,
    required this.comment,
  });
}

class ChatMessage {
  final String id;
  final String sender; // 'user' | 'agent'
  final String text;
  final String timestamp;

  ChatMessage({
    required this.id,
    required this.sender,
    required this.text,
    required this.timestamp,
  });
}

class ViewingBooking {
  final String id;
  final String propertyId;
  final String propertyTitle;
  final String date;
  final String time;
  final String status;

  ViewingBooking({
    required this.id,
    required this.propertyId,
    required this.propertyTitle,
    required this.date,
    required this.time,
    this.status = 'Confirmed',
  });
}

class UserProfile {
  final String fullName;
  final String email;
  final String phone;
  final String avatar;

  UserProfile({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.avatar,
  });
}
