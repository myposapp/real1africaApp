import 'package:flutter/material.dart';
import '../models/models.dart';

class EstateProvider extends ChangeNotifier {
  int _currentNavIndex = 0; // 0: Home, 1: Search, 2: Managers, 3: Messages, 4: Profile
  String _activeTab = 'Rent'; // 'Rent' | 'Sales' | 'Lease'
  String _searchQuery = '';
  String _selectedCity = 'All';

  Property? _selectedProperty;
  EstateManager? _selectedManager;

  UserProfile _user = UserProfile(
    fullName: 'Estate manager 1',
    email: 'test1@app3star.com',
    phone: '+234 7054512124',
    avatar: 'https://lh3.googleusercontent.com/aida-public/AB6AXuB0OObhBbKoZPjK38iVFD4aokeMpumhaSjuhARJHmUME8kpJUYVc5W8lqXENUJFrErDHBjeRO7Uf8bUVA61nuPiailQ8gE07EJK9fRG8BhsYi5e0Dl6f6lzjYDDvabEkkNA96tjyfp0CGWwUtHsAgdVKm1vkZw9qMJ2Sop_I3iFJ_U9TgvHtsVAE2AZVsJnSIBNFlhdkE87zTMlt0yaJGD6yHMpNxPGcSE6TLl0yB-w1sMW-H4Ynx3GZLFubYuW6iJjL_WfpQG4KZZA',
  );

  final List<Property> _properties = [
    Property(
      id: 'p1',
      title: 'Grand Horizon Luxury Villa',
      type: 'Rent',
      category: 'Duplex & Mansions',
      location: 'Beverly Hills, CA',
      city: 'Los Angeles',
      price: 4500,
      priceUnit: '/mo',
      beds: 4,
      baths: 3,
      sqft: 2850,
      isNew: true,
      isFavorite: true,
      rating: 4.9,
      reviewsCount: 28,
      status: 'Active',
      visibility: 'Public',
      addedAt: 'Aug 10, 26 07:16am',
      image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAaUZNWGCBz8cJAAC9vAQ6QabqS7ZGRoS2dIL58D6VaKnatpzbWnD5Y90tkX_WVUHTbrINl242BuaywUiUdGL4ED3qLTF3XgAYmRtmQ-6jfTVfC8gULAo5hWT0OvMCEuQFRNYDPuEReQ9sKudUd5NVmN2Ef_PuvykK4P6kHtHRAGRnDP0uIneeA6paDAN78nF2w8gUu-FOFvC8AsB4O-vNuLJeFOOLzI0Orx55oHUf1R0fw4_j4TpnfBZVShnbrY4jtfBjDoV57i1X9',
      gallery: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAaUZNWGCBz8cJAAC9vAQ6QabqS7ZGRoS2dIL58D6VaKnatpzbWnD5Y90tkX_WVUHTbrINl242BuaywUiUdGL4ED3qLTF3XgAYmRtmQ-6jfTVfC8gULAo5hWT0OvMCEuQFRNYDPuEReQ9sKudUd5NVmN2Ef_PuvykK4P6kHtHRAGRnDP0uIneeA6paDAN78nF2w8gUu-FOFvC8AsB4O-vNuLJeFOOLzI0Orx55oHUf1R0fw4_j4TpnfBZVShnbrY4jtfBjDoV57i1X9',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAMsZ5s6A6R4fLIL6j36xUqInN0QG8Yn4xJ8sE3I8a-y4O0n9gH6c5m0kF3h_2qP_8v0iI8pY9zA4O_L6zB4yF_u3L5kC_2I5y7X_6M6I5G_3kL_7n_2s3G',
      ],
      description: 'Experience absolute luxury in this Beverly Hills architectural masterpiece. Features floor-to-ceiling glass windows, custom marble infinity pool, intelligent climate controls, and private security access.',
      amenities: [
        Amenity(icon: 'pool', name: 'Infinity Pool'),
        Amenity(icon: 'wifi', name: 'High-speed Fiber'),
        Amenity(icon: 'local_parking', name: '3-Car Garage'),
        Amenity(icon: 'fitness_center', name: 'Private Gym'),
        Amenity(icon: 'security', name: '24/7 Security'),
      ],
      managerId: 'm1',
      managerName: 'Apex Estate Management',
    ),
    Property(
      id: 'p2',
      title: 'Skyline Modern Penthouse',
      type: 'Rent',
      category: 'Apartments & Flats',
      location: 'Downtown, Los Angeles',
      city: 'Los Angeles',
      price: 3800,
      priceUnit: '/mo',
      beds: 3,
      baths: 2,
      sqft: 1950,
      isNew: true,
      isFavorite: false,
      rating: 4.8,
      reviewsCount: 19,
      status: 'Active',
      visibility: 'Public',
      addedAt: 'Aug 08, 26 09:30am',
      image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDF0W782m0m0p13v-yP1qO3p-M6x63xK2vB6gN1Y4xH9s_J3R5k4f8x1L8n9Y_8I3w4v1k3h8b_8R5v9L6_I5m7b8K3J1u8i0O2_m4n5k6',
      gallery: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDF0W782m0m0p13v-yP1qO3p-M6x63xK2vB6gN1Y4xH9s_J3R5k4f8x1L8n9Y_8I3w4v1k3h8b_8R5v9L6_I5m7b8K3J1u8i0O2_m4n5k6',
      ],
      description: 'Breathtaking 360-degree city views from the top floor. High-end modern furnishings, concierge service, and floor-to-ceiling skyline panorama.',
      amenities: [
        Amenity(icon: 'balcony', name: 'Sky Balcony'),
        Amenity(icon: 'elevator', name: 'Private Elevator'),
        Amenity(icon: 'ac_unit', name: 'Central AC'),
      ],
      managerId: 'm2',
      managerName: 'Prime Property Group',
    ),
    Property(
      id: 'p3',
      title: 'Ocean Breeze Coastal Villa',
      type: 'Sales',
      category: 'Beachfront Homes',
      location: 'Malibu Coast, CA',
      city: 'Malibu',
      price: 1250000,
      priceUnit: 'total',
      beds: 5,
      baths: 4,
      sqft: 4200,
      isNew: false,
      isFavorite: true,
      rating: 5.0,
      reviewsCount: 34,
      status: 'Active',
      visibility: 'Public',
      addedAt: 'Aug 05, 26 02:45pm',
      image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBFJv51KzN5v8f-1oB2J3K4L5M6N7O8P9Q0R1S2T3U4V5W6X7Y8Z9A0B1C2D3E4F5G6H7I8J9K0L1M2N3O4P5Q6R7S8T9U0',
      gallery: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuBFJv51KzN5v8f-1oB2J3K4L5M6N7O8P9Q0R1S2T3U4V5W6X7Y8Z9A0B1C2D3E4F5G6H7I8J9K0L1M2N3O4P5Q6R7S8T9U0',
      ],
      description: 'Direct beachfront private property in Malibu. Custom mahogany woodwork, sunset view terrace, and private path to the beach.',
      amenities: [
        Amenity(icon: 'surfing', name: 'Beach Access'),
        Amenity(icon: 'hot_tub', name: 'Jacuzzi'),
        Amenity(icon: 'outdoor_grill', name: 'BBQ Area'),
      ],
      managerId: 'm1',
      managerName: 'Apex Estate Management',
    ),
    Property(
      id: 'p4',
      title: 'Commercial Plaza Store',
      type: 'Lease',
      category: 'Stores for rent',
      location: 'Victoria Island, Lagos',
      city: 'Lagos',
      price: 2500000,
      priceUnit: '/yr',
      beds: 1,
      baths: 1,
      sqft: 1200,
      isNew: true,
      isFavorite: false,
      rating: 4.7,
      reviewsCount: 15,
      status: 'Active',
      visibility: 'Public',
      addedAt: 'Aug 01, 26 10:15am',
      image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBGK2w5J0k0N1v7f8I9s0m1O2P3Q4R5S6T7U8V9W0X1Y2Z3A4B5C6D7E8F9G0H1I2J3K4L5M6N7O8P9Q0R1S2T3U4V5',
      gallery: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuBGK2w5J0k0N1v7f8I9s0m1O2P3Q4R5S6T7U8V9W0X1Y2Z3A4B5C6D7E8F9G0H1I2J3K4L5M6N7O8P9Q0R1S2T3U4V5',
      ],
      description: 'Strategic commercial retail store along bustling high-street corridor.',
      amenities: [
        Amenity(icon: 'store', name: 'Showroom Glass'),
        Amenity(icon: 'security', name: 'Security Post'),
      ],
      managerId: 'm3',
      managerName: 'Prestige Management',
    ),
  ];

  late List<Property> _myProperties = [
    _properties[0],
    _properties[3],
  ];

  final List<KYCDocument> _kycDocs = [
    KYCDocument(
      id: 'kyc1',
      name: 'National ID Card (NIN Slip)',
      type: 'Government ID',
      status: 'Verified',
      uploadedAt: 'Jul 15, 2026',
    ),
    KYCDocument(
      id: 'kyc2',
      name: 'Corporate Affairs Commission (CAC Certificate)',
      type: 'Business License',
      status: 'Pending',
      uploadedAt: 'Aug 02, 2026',
    ),
  ];

  SubscriptionPlan? _activePlan;
  String _subscriptionPeriod = 'Monthly';

  bool _isRefreshingProfile = false;
  bool _isDeletingAccount = false;

  final List<EstateManager> _managers = [
    EstateManager(
      id: 'm1',
      name: 'Sarah Johnson',
      companyName: 'Apex Estate Management',
      avatar: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCFUFMiN54Qjm5ekO1siul-ThbYHWBcq1w22ReETlCfpM_a-Ikh6T-vJ356NzS_1NqHl4JK0s-SrGo0Kb1wJU1cxBXvytg7cANiAkJoiKRUJDVuI1oejJvXgFYLQx2G6bBXreY2Cq12ODk9DVv7_d4WPv-1ijC0DN82QZvHhKkwyRPB5RbE3g2kiVyZeDV6e4Efz5KeAioGk0ivc04yvnaeLD4aou-X0n6ecVkPtnpiT-zVtX_kZYL2o8U5kB9-PESsGe5p7ii0f8WP',
      rating: 4.9,
      listingsCount: 24,
      description: 'Specializing in luxury residential estates, high-yield rentals, and concierge property management across Beverly Hills & Malibu.',
      phone: '+1 (800) 555-KEY1',
      email: 'sarah@apexestate.com',
      specialties: ['Luxury Villas', 'Residential Rentals', 'Asset Mgmt'],
      iconType: 'key',
    ),
    EstateManager(
      id: 'm2',
      name: 'David Chen',
      companyName: 'Prime Property Group',
      avatar: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDE_m1k3G5R7K9s2N8v1O0P3Q4R5S6T7U8V9W0X1Y2Z3A4B5C6D7E8F9G0H1I2J3K4L5M6N7O8P9Q0R1S2T3U4V5W6',
      rating: 4.8,
      listingsCount: 18,
      description: 'Downtown LA high-rise penthouse and commercial space specialists providing end-to-end tenant leasing and facility maintenance.',
      phone: '+1 (800) 555-PRIME',
      email: 'dchen@primeproperty.com',
      specialties: ['Downtown Condos', 'Commercial', 'Leasing'],
      iconType: 'apartment',
    ),
    EstateManager(
      id: 'm3',
      name: 'Elena Rostova',
      companyName: 'Prestige Management',
      avatar: 'https://lh3.googleusercontent.com/aida-public/AB6AXuE0_x1k2G3R4K5s6N7v8O9P0Q1R2S3T4U5V6W7X8Y9Z0A1B2C3D4E5F6G7H8I9J0K1L2M3N4O5P6Q7R8S9T0U1V2W3',
      rating: 4.95,
      listingsCount: 31,
      description: 'Suburban estate advisory and long-term lease oversight in Pasadena and Glendale. Trusted by over 200 homeowners.',
      phone: '+1 (800) 555-PRESTIGE',
      email: 'elena@prestigemgmt.com',
      specialties: ['Suburban Homes', 'Long-term Leases', 'Valuations'],
      iconType: 'verified',
    ),
  ];

  final List<Review> _reviews = [
    Review(
      id: 'r1',
      propertyId: 'p1',
      userName: 'Marcus Vance',
      userAvatar: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCFUFMiN54Qjm5ekO1siul-ThbYHWBcq1w22ReETlCfpM_a-Ikh6T-vJ356NzS_1NqHl4JK0s-SrGo0Kb1wJU1cxBXvytg7cANiAkJoiKRUJDVuI1oejJvXgFYLQx2G6bBXreY2Cq12ODk9DVv7_d4WPv-1ijC0DN82QZvHhKkwyRPB5RbE3g2kiVyZeDV6e4Efz5KeAioGk0ivc04yvnaeLD4aou-X0n6ecVkPtnpiT-zVtX_kZYL2o8U5kB9-PESsGe5p7ii0f8WP',
      rating: 5,
      date: '2 days ago',
      comment: 'Absolutely stunning property! The viewing process managed by Apex Estate was flawless.',
    ),
    Review(
      id: 'r2',
      propertyId: 'p1',
      userName: 'Claire Sterling',
      userAvatar: 'https://lh3.googleusercontent.com/aida-public/AB6AXuB0OObhBbKoZPjK38iVFD4aokeMpumhaSjuhARJHmUME8kpJUYVc5W8lqXENUJFrErDHBjeRO7Uf8bUVA61nuPiailQ8gE07EJK9fRG8BhsYi5e0Dl6f6lzjYDDvabEkkNA96tjyfp0CGWwUtHsAgdVKm1vkZw9qMJ2Sop_I3iFJ_U9TgvHtsVAE2AZVsJnSIBNFlhdkE87zTMlt0yaJGD6yHMpNxPGcSE6TLl0yB-w1sMW-H4Ynx3GZLFubYuW6iJjL_WfpQG4KZZA',
      rating: 5,
      date: '1 week ago',
      comment: 'The infinity pool and hill views are breathtaking. Truly luxurious architecture.',
    ),
  ];

  final List<ChatMessage> _chatMessages = [
    ChatMessage(
      id: 'm1',
      sender: 'agent',
      text: 'Hello Sarah! Thank you for inquiring about Grand Horizon Luxury Villa. How can I assist you with your search today?',
      timestamp: '10:14 AM',
    ),
  ];

  final List<ViewingBooking> _viewings = [
    ViewingBooking(
      id: 'v1',
      propertyId: 'p1',
      propertyTitle: 'Grand Horizon Luxury Villa',
      date: '2026-07-30',
      time: '14:00',
    ),
  ];

  // Getters
  int get currentNavIndex => _currentNavIndex;
  String get activeTab => _activeTab;
  String get searchQuery => _searchQuery;
  String get selectedCity => _selectedCity;
  Property? get selectedProperty => _selectedProperty;
  EstateManager? get selectedManager => _selectedManager;
  UserProfile get user => _user;
  List<Property> get properties => _properties;
  List<Property> get myProperties => _myProperties;
  List<KYCDocument> get kycDocs => _kycDocs;
  SubscriptionPlan? get activePlan => _activePlan;
  String get subscriptionPeriod => _subscriptionPeriod;
  bool get isRefreshingProfile => _isRefreshingProfile;
  bool get isDeletingAccount => _isDeletingAccount;
  List<EstateManager> get managers => _managers;
  List<Review> get reviews => _reviews;
  List<ChatMessage> get chatMessages => _chatMessages;
  List<ViewingBooking> get viewings => _viewings;

  List<Property> get filteredProperties {
    return _properties.where((p) {
      final matchesTab = _activeTab == 'Rent'
          ? p.type == 'Rent'
          : _activeTab == 'Sales'
              ? p.type == 'Sales'
              : p.type == 'Lease';
      final matchesQuery = p.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.location.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCity = _selectedCity == 'All' || p.city.toLowerCase() == _selectedCity.toLowerCase();
      return matchesTab && matchesQuery && matchesCity;
    }).toList();
  }

  // Setters & Actions
  void setNavIndex(int index) {
    _currentNavIndex = index;
    notifyListeners();
  }

  void setActiveTab(String tab) {
    _activeTab = tab;
    notifyListeners();
  }

  void setSearchQuery(String q) {
    _searchQuery = q;
    notifyListeners();
  }

  void setSelectedCity(String city) {
    _selectedCity = city;
    notifyListeners();
  }

  void setSelectedProperty(Property property) {
    _selectedProperty = property;
    notifyListeners();
  }

  void setSelectedManager(EstateManager manager) {
    _selectedManager = manager;
    notifyListeners();
  }

  void toggleFavorite(String propertyId) {
    final idx = _properties.indexWhere((p) => p.id == propertyId);
    if (idx != -1) {
      _properties[idx].isFavorite = !_properties[idx].isFavorite;
      notifyListeners();
    }
  }

  void addProperty(Property newProp) {
    _properties.insert(0, newProp);
    _myProperties.insert(0, newProp);
    notifyListeners();
  }

  void deleteProperty(String propertyId) {
    _properties.removeWhere((p) => p.id == propertyId);
    _myProperties.removeWhere((p) => p.id == propertyId);
    notifyListeners();
  }

  void addKycDoc(KYCDocument doc) {
    _kycDocs.insert(0, doc);
    notifyListeners();
  }

  void deleteKycDoc(String docId) {
    _kycDocs.removeWhere((d) => d.id == docId);
    notifyListeners();
  }

  void changePlan(SubscriptionPlan plan) {
    _activePlan = plan;
    notifyListeners();
  }

  void setSubscriptionPeriod(String period) {
    _subscriptionPeriod = period;
    notifyListeners();
  }

  Future<void> refreshProfile() async {
    _isRefreshingProfile = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 900));
    _isRefreshingProfile = false;
    notifyListeners();
  }

  Future<void> deleteAccount() async {
    _isDeletingAccount = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 1200));
    _myProperties.clear();
    _kycDocs.clear();
    _isLoggedIn = false;
    _isDeletingAccount = false;
    notifyListeners();
  }

  void addReview(Review review) {
    _reviews.insert(0, review);
    notifyListeners();
  }

  void sendMessage(String text, String agentName) {
    _chatMessages.add(ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sender: 'user',
      text: text,
      timestamp: 'Just now',
    ));
    notifyListeners();

    // Auto-reply
    Future.delayed(const Duration(seconds: 1), () {
      _chatMessages.add(ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        sender: 'agent',
        text: 'Thank you for your message regarding EstateEase listings! $agentName will respond shortly.',
        timestamp: 'Just now',
      ));
      notifyListeners();
    });
  }

  void bookViewing(ViewingBooking booking) {
    _viewings.insert(0, booking);
    notifyListeners();
  }

  bool _isLoggedIn = true;
  bool get isLoggedIn => _isLoggedIn;

  void login(String identifier, {String? name}) {
    _isLoggedIn = true;
    _user = UserProfile(
      fullName: name ?? (identifier.contains('@') ? identifier.split('@')[0] : 'Estate User'),
      email: identifier.contains('@') ? identifier : 'test1@app3star.com',
      phone: !identifier.contains('@') ? identifier : '+234 7054512124',
      avatar: _user.avatar,
    );
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }

  void updateProfile({String? fullName, String? email, String? phone, String? avatar}) {
    _user = UserProfile(
      fullName: fullName ?? _user.fullName,
      email: email ?? _user.email,
      phone: phone ?? _user.phone,
      avatar: avatar ?? _user.avatar,
    );
    notifyListeners();
  }
}
