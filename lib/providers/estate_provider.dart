import 'package:flutter/material.dart';
import '../models/models.dart';

class EstateProvider extends ChangeNotifier {
  int _currentNavIndex =
      0; // 0: Home, 1: Search, 2: Managers, 3: Messages, 4: Profile
  String _activeTab = 'Rent'; // 'Rent' | 'Sales' | 'Lease'
  String _searchQuery = '';
  String _selectedCity = 'All';

  Property? _selectedProperty;
  EstateManager? _selectedManager;

  final UserProfile _user = UserProfile(
    fullName: 'Sarah Jenkins',
    email: 'sarah.jenkins@example.com',
    phone: '+1 (555) 382-9102',
    avatar:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuB0OObhBbKoZPjK38iVFD4aokeMpumhaSjuhARJHmUME8kpJUYVc5W8lqXENUJFrErDHBjeRO7Uf8bUVA61nuPiailQ8gE07EJK9fRG8BhsYi5e0Dl6f6lzjYDDvabEkkNA96tjyfp0CGWwUtHsAgdVKm1vkZw9qMJ2Sop_I3iFJ_U9TgvHtsVAE2AZVsJnSIBNFlhdkE87zTMlt0yaJGD6yHMpNxPGcSE6TLl0yB-w1sMW-H4Ynx3GZLFubYuW6iJjL_WfpQG4KZZA',
  );

  final List<Property> _properties = [
    Property(
      id: 'p1',
      title: 'Grand Horizon Luxury Villa',
      type: 'Rent',
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
      image:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAaUZNWGCBz8cJAAC9vAQ6QabqS7ZGRoS2dIL58D6VaKnatpzbWnD5Y90tkX_WVUHTbrINl242BuaywUiUdGL4ED3qLTF3XgAYmRtmQ-6jfTVfC8gULAo5hWT0OvMCEuQFRNYDPuEReQ9sKudUd5NVmN2Ef_PuvykK4P6kHtHRAGRnDP0uIneeA6paDAN78nF2w8gUu-FOFvC8AsB4O-vNuLJeFOOLzI0Orx55oHUf1R0fw4_j4TpnfBZVShnbrY4jtfBjDoV57i1X9',
      gallery: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDzMc2jFGzz4TxkNtGRIxPsWmwQjjOlJ1k2JBRLIgEMi33JoP3B2FJG-RIPwnNBNkFKrMtIpJrewbMoxgHlbnGIhT4aAkVCeqwHlfI2HdMExScuTr-CSM6hMze0T0RsnAQULhdEcG8L3NmD1JG1vaRURZnLt14M14XwqxGIsKInpKa_AeypajiYxf2v8N10i3jSVleebof0kArQ0XrGthXomx8nFQcIb3oZmrc6055-hnKZX_arb5uUHDsFcI5bzhJ6z-i3r3zLv0fi',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDu5v4yGxybbZyPxF-UdIswxjG_Ls_MbBqtEIDAT9KrKnFdthpk8GVKG_m0tzVjlijsZmUDsdoMLl2Zvv7eZiTJqqa9GPZDrG7vJovI_DfTnZCnj5EeUoHHinLS3GrK8skFEDgnMQGvllf3AkJ2BAAZt6IDLR65MWt4icgcXQNC8J7IWrahMyARFHmuBxzFCHH2IhVyry6kyP7Mg-pVTS7eJkVAJrBBwlffVGNe5jnYEs1CyLaMWWaQVmWIjwgL6AAUvNfUI2l7mQOt',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAaUZNWGCBz8cJAAC9vAQ6QabqS7ZGRoS2dIL58D6VaKnatpzbWnD5Y90tkX_WVUHTbrINl242BuaywUiUdGL4ED3qLTF3XgAYmRtmQ-6jfTVfC8gULAo5hWT0OvMCEuQFRNYDPuEReQ9sKudUd5NVmN2Ef_PuvykK4P6kHtHRAGRnDP0uIneeA6paDAN78nF2w8gUu-FOFvC8AsB4O-vNuLJeFOOLzI0Orx55oHUf1R0fw4_j4TpnfBZVShnbrY4jtfBjDoV57i1X9',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuB7ZxMcdwNdYfAQmS3avxew2jxfqB8WAxhB2qq2pBS0GdFSp746o2ucrvRizujKFOdw0bsJFWP-q_OuPf88dH6bhs_wnxc_oGGfy1vlhUrjtOJaI2pQbKOXfJXA9AD4ZH7seqe66LTvzBMeOenMA0rGgj9GA1STU6HtwxiUNfCgBjAqPhHpFnUGRAR5NOvSLKZ1OMdz6e9AR-jl1_mPWHtjHZ8QT99rD8GWKudcQhaU3vHPpZefdi-LVUNMUvbLbKkKThJM0SSjqkfs',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCxRYGdqyNAZQ_S-pCESadwMNUr3R3wTJvSj-2N3p7amaowLZDFq5w7K3dSl0TAARUv-kLt-usKKzLjhWxd_VVMHLGod7L8oVBkfBgYeSQonEQWxX3sbGNZ_gnH6gtxwImaokjd6tnO8zB2YFDk3gTYqhh6qVjlfkRqS6sMLgC163VWzWK41HbqOMKnNfuSLgU8SL5Hxqq_69aEUenH6q8HIx4A9JkTOcD74ynW1TLYjM5aDiy2MzenL5BGEGzG8d9ble_yhpoKOc_R',
      ],
      description:
          'Experience absolute luxury in this Beverly Hills architectural masterpiece. Features floor-to-ceiling glass windows, custom marble infinity pool, intelligent climate controls, and private security access.',
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
      image:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCbo7uXfaAcm-J93hIXOiJodWVO5EUSAkoQX4DRdjyeb8bCR9Rm4CBdjV0Q0OjkNwaoP92nFn-7CqaZQzNv_LxXd80YuxD8fk3PXMamSVYXKUz9dRTmerB1UW0Pq5GYOiEiVoqeRja-cY8IQDioKtpCenhIN0rUs8K3WdG5ByLbN2rUJzVo7BsDUPI-B05LGO0waow-fv5d523TR1EGvTFiG9W8jgKSxy6pG_SH9ejgJrDcd2mJ0P4p_7YeGKSx06CvczhCw2ar_Nev',
      gallery: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCbo7uXfaAcm-J93hIXOiJodWVO5EUSAkoQX4DRdjyeb8bCR9Rm4CBdjV0Q0OjkNwaoP92nFn-7CqaZQzNv_LxXd80YuxD8fk3PXMamSVYXKUz9dRTmerB1UW0Pq5GYOiEiVoqeRja-cY8IQDioKtpCenhIN0rUs8K3WdG5ByLbN2rUJzVo7BsDUPI-B05LGO0waow-fv5d523TR1EGvTFiG9W8jgKSxy6pG_SH9ejgJrDcd2mJ0P4p_7YeGKSx06CvczhCw2ar_Nev',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuB7ZxMcdwNdYfAQmS3avxew2jxfqB8WAxhB2qq2pBS0GdFSp746o2ucrvRizujKFOdw0bsJFWP-q_OuPf88dH6bhs_wnxc_oGGfy1vlhUrjtOJaI2pQbKOXfJXA9AD4ZH7seqe66LTvzBMeOenMA0rGgj9GA1STU6HtwxiUNfCgBjAqPhHpFnUGRAR5NOvSLKZ1OMdz6e9AR-jl1_mPWHtjHZ8QT99rD8GWKudcQhaU3vHPpZefdi-LVUNMUvbLbKkKThJM0SSjqkfs',
      ],
      description:
          'Breathtaking 360-degree city views from the top floor. High-end modern furnishings, concierge service, and floor-to-ceiling skyline panorama.',
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
      image:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCxRYGdqyNAZQ_S-pCESadwMNUr3R3wTJvSj-2N3p7amaowLZDFq5w7K3dSl0TAARUv-kLt-usKKzLjhWxd_VVMHLGod7L8oVBkfBgYeSQonEQWxX3sbGNZ_gnH6gtxwImaokjd6tnO8zB2YFDk3gTYqhh6qVjlfkRqS6sMLgC163VWzWK41HbqOMKnNfuSLgU8SL5Hxqq_69aEUenH6q8HIx4A9JkTOcD74ynW1TLYjM5aDiy2MzenL5BGEGzG8d9ble_yhpoKOc_R',
      gallery: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCxRYGdqyNAZQ_S-pCESadwMNUr3R3wTJvSj-2N3p7amaowLZDFq5w7K3dSl0TAARUv-kLt-usKKzLjhWxd_VVMHLGod7L8oVBkfBgYeSQonEQWxX3sbGNZ_gnH6gtxwImaokjd6tnO8zB2YFDk3gTYqhh6qVjlfkRqS6sMLgC163VWzWK41HbqOMKnNfuSLgU8SL5Hxqq_69aEUenH6q8HIx4A9JkTOcD74ynW1TLYjM5aDiy2MzenL5BGEGzG8d9ble_yhpoKOc_R',
      ],
      description:
          'Direct beachfront private property in Malibu. Custom mahogany woodwork, sunset view terrace, and private path to the beach.',
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
      title: 'Serene Suburban Residence',
      type: 'Lease',
      location: 'Pasadena, CA',
      city: 'Pasadena',
      price: 2900,
      priceUnit: '/mo',
      beds: 3,
      baths: 2,
      sqft: 1680,
      isNew: true,
      isFavorite: false,
      rating: 4.7,
      reviewsCount: 15,
      image:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAaUZNWGCBz8cJAAC9vAQ6QabqS7ZGRoS2dIL58D6VaKnatpzbWnD5Y90tkX_WVUHTbrINl242BuaywUiUdGL4ED3qLTF3XgAYmRtmQ-6jfTVfC8gULAo5hWT0OvMCEuQFRNYDPuEReQ9sKudUd5NVmN2Ef_PuvykK4P6kHtHRAGRnDP0uIneeA6paDAN78nF2w8gUu-FOFvC8AsB4O-vNuLJeFOOLzI0Orx55oHUf1R0fw4_j4TpnfBZVShnbrY4jtfBjDoV57i1X9',
      gallery: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAaUZNWGCBz8cJAAC9vAQ6QabqS7ZGRoS2dIL58D6VaKnatpzbWnD5Y90tkX_WVUHTbrINl242BuaywUiUdGL4ED3qLTF3XgAYmRtmQ-6jfTVfC8gULAo5hWT0OvMCEuQFRNYDPuEReQ9sKudUd5NVmN2Ef_PuvykK4P6kHtHRAGRnDP0uIneeA6paDAN78nF2w8gUu-FOFvC8AsB4O-vNuLJeFOOLzI0Orx55oHUf1R0fw4_j4TpnfBZVShnbrY4jtfBjDoV57i1X9',
      ],
      description:
          'Family-friendly suburban sanctuary near top-rated schools. Spacious lush green yard and solar-powered utility support.',
      amenities: [
        Amenity(icon: 'park', name: 'Spacious Yard'),
        Amenity(icon: 'solar_power', name: 'Solar Panels'),
        Amenity(icon: 'pets', name: 'Pet Friendly'),
      ],
      managerId: 'm3',
      managerName: 'Prestige Management',
    ),
  ];

  final List<EstateManager> _managers = [
    EstateManager(
      id: 'm1',
      name: 'Sarah Johnson',
      companyName: 'Apex Estate Management',
      avatar:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDDl-qmpDjTs6-uxb12vqOMDkDyzZhAn-prd6epEIMVEG3wHDZgsHItVCjYiDXa5Yici1TkG2LBSjEnSu4qEvycX2Dj59NoiI_bPMl3_gNQR8FGVwnuRcNXKQn_spM4ZZpqF5wuMvBsB3zE4Xf3-tWWPcJg1dlpgNm362qrkDUpb-RFG2pte1RgAWhM5XeY8qRRgO9OhnDYhK2KuPm7ZwxU2WsPwZxRu6cRCYPNCqiCYJQw8oghFMeLjvq6350C7JSlnE9CU4vPuVNE',
      rating: 4.9,
      listingsCount: 24,
      description:
          'Specializing in luxury residential estates, high-yield rentals, and concierge property management across Beverly Hills & Malibu.',
      phone: '+1 (800) 555-KEY1',
      email: 'sarah@apexestate.com',
      specialties: ['Luxury Villas', 'Residential Rentals', 'Asset Mgmt'],
      iconType: 'key',
    ),
    EstateManager(
      id: 'm2',
      name: 'David Chen',
      companyName: 'Prime Property Group',
      avatar:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCFUFMiN54Qjm5ekO1siul-ThbYHWBcq1w22ReETlCfpM_a-Ikh6T-vJ356NzS_1NqHl4JK0s-SrGo0Kb1wJU1cxBXvytg7cANiAkJoiKRUJDVuI1oejJvXgFYLQx2G6bBXreY2Cq12ODk9DVv7_d4WPv-1ijC0DN82QZvHhKkwyRPB5RbE3g2kiVyZeDV6e4Efz5KeAioGk0ivc04yvnaeLD4aou-X0n6ecVkPtnpiT-zVtX_kZYL2o8U5kB9-PESsGe5p7ii0f8WP',
      rating: 4.8,
      listingsCount: 18,
      description:
          'Downtown LA high-rise penthouse and commercial space specialists providing end-to-end tenant leasing and facility maintenance.',
      phone: '+1 (800) 555-PRIME',
      email: 'dchen@primeproperty.com',
      specialties: ['Downtown Condos', 'Commercial', 'Leasing'],
      iconType: 'apartment',
    ),
    EstateManager(
      id: 'm3',
      name: 'Elena Rostova',
      companyName: 'Prestige Management',
      avatar:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBGQjqp_nohcfixK1q7gdoTCiD1QIKWkBtLB2Cwr3YNlPIQxfi5HdRgQteVgHeSskejwg05FlZRDQ1RfdSeK-hdAmTu7pC5z3NX8mdJk7UfIfo1URmB1kavHKSxcep01H3H2U47Qj0-86ggFzk1TrHbY12Lxe01cY6qSNjYfG5TJL5hGejTdJ13CBiRX2hceYToyW2J-l6NUOP4RZq0xr8YsYXiYymZSKNLV6hdDX-1v0IVUgDph09sLVjrYHMXLrXVxYkb_sAlXd35',
      rating: 4.95,
      listingsCount: 31,
      description:
          'Suburban estate advisory and long-term lease oversight in Pasadena and Glendale. Trusted by over 200 homeowners.',
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
      userAvatar:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCFUFMiN54Qjm5ekO1siul-ThbYHWBcq1w22ReETlCfpM_a-Ikh6T-vJ356NzS_1NqHl4JK0s-SrGo0Kb1wJU1cxBXvytg7cANiAkJoiKRUJDVuI1oejJvXgFYLQx2G6bBXreY2Cq12ODk9DVv7_d4WPv-1ijC0DN82QZvHhKkwyRPB5RbE3g2kiVyZeDV6e4Efz5KeAioGk0ivc04yvnaeLD4aou-X0n6ecVkPtnpiT-zVtX_kZYL2o8U5kB9-PESsGe5p7ii0f8WP',
      rating: 5,
      date: '2 days ago',
      comment:
          'Absolutely stunning property! The viewing process managed by Apex Estate was flawless.',
    ),
    Review(
      id: 'r2',
      propertyId: 'p1',
      userName: 'Claire Sterling',
      userAvatar:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuB0OObhBbKoZPjK38iVFD4aokeMpumhaSjuhARJHmUME8kpJUYVc5W8lqXENUJFrErDHBjeRO7Uf8bUVA61nuPiailQ8gE07EJK9fRG8BhsYi5e0Dl6f6lzjYDDvabEkkNA96tjyfp0CGWwUtHsAgdVKm1vkZw9qMJ2Sop_I3iFJ_U9TgvHtsVAE2AZVsJnSIBNFlhdkE87zTMlt0yaJGD6yHMpNxPGcSE6TLl0yB-w1sMW-H4Ynx3GZLFubYuW6iJjL_WfpQG4KZZA',
      rating: 5,
      date: '1 week ago',
      comment:
          'The infinity pool and hill views are breathtaking. Truly luxurious architecture.',
    ),
    Review(
      id: 'r3',
      propertyId: 'p2',
      userName: 'David Miller',
      userAvatar:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAWy37YIhIfPDxsoVvtDSX_Gfxf6UWbFsnUiOD_iPqkI0nVo8Fa4bquHu9JLHu1Z46aKSBt80nZGVJIxyzH2v7nMk0yr0XIxywL3ccLR2iHAHHulNU7vcs8Y5TZepk3Oi0OJa9n25qS9ZuGPjhL11FZaWg9tXdxk0cblEsxa4k0pVWW2nZFrKABP3TERQ9AmeDVvGIrXKbTT_nryt0b_maTtUZNFOeReNmsjgLyOkWN99vKSeq4XGE3ffkfK2Mq-kzhJeiYdBfPcPYI',
      rating: 4,
      date: '3 days ago',
      comment:
          'Incredible skyline view of downtown LA. Concierge service is very attentive.',
    ),
    Review(
      id: 'r4',
      propertyId: 'p3',
      userName: 'Jessica Thorne',
      userAvatar:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDUzuxurB3_OS3aeiX4BXh4iQAu2clRn4CULndcvluul20-OhGgQZMoEOfLsqUaEXtRofoXaMdA2zuzddz1Ofe3Yk0s-Y9pDuojwdYRNWzpy8rrmT-HzNvWB23eXRe_c5TNa0dkXkFJTBu-nrW03v4hiu96xOs1RaUskD2fnEOHTEScfSw-ddZeW46fTKviuLaOtiSLaH4FfkvM62tWksnAgFWv79qQ7LaBCbRAOymwLwwTe5VUSWMzGdaBfpuFvpCUFhnEGToQRZQg',
      rating: 5,
      date: '5 days ago',
      comment:
          'Best oceanfront view in Malibu. Private access to the beach is a huge plus.',
    ),
  ];

  final List<ChatMessage> _chatMessages = [
    ChatMessage(
      id: 'm1',
      sender: 'agent',
      text:
          'Hello Sarah! Thank you for inquiring about Grand Horizon Luxury Villa. How can I assist you with your search today?',
      timestamp: '10:14 AM',
    ),
    ChatMessage(
      id: 'm2',
      sender: 'user',
      text:
          'Hi Sarah! I would like to schedule a private viewing this Thursday afternoon.',
      timestamp: '10:16 AM',
    ),
    ChatMessage(
      id: 'm3',
      sender: 'agent',
      text:
          'Great choice! Thursday at 2:00 PM is available. I will send over the gate access confirmation details right away.',
      timestamp: '10:18 AM',
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
  List<EstateManager> get managers => _managers;
  List<Review> get reviews => _reviews;
  List<ChatMessage> get chatMessages => _chatMessages;
  List<ViewingBooking> get viewings => _viewings;

  List<Property> get filteredProperties {
    return _properties.filter((p) {
      final matchesTab = _activeTab == 'Rent'
          ? p.type == 'Rent'
          : _activeTab == 'Sales'
          ? p.type == 'Sales'
          : p.type == 'Lease';
      final matchesQuery =
          p.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.location.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCity =
          _selectedCity == 'All' ||
          p.city.toLowerCase() == _selectedCity.toLowerCase();
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
    notifyListeners();
  }

  void addReview(Review review) {
    _reviews.insert(0, review);
    notifyListeners();
  }

  void sendMessage(String text, String agentName) {
    _chatMessages.add(
      ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        sender: 'user',
        text: text,
        timestamp: 'Just now',
      ),
    );
    notifyListeners();

    // Auto-reply
    Future.delayed(const Duration(seconds: 1), () {
      _chatMessages.add(
        ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          sender: 'agent',
          text:
              'Thank you for your message regarding EstateEase listings! $agentName will respond shortly.',
          timestamp: 'Just now',
        ),
      );
      notifyListeners();
    });
  }

  void bookViewing(ViewingBooking booking) {
    _viewings.insert(0, booking);
    notifyListeners();
  }
}

extension PropertyFilterList on List<Property> {
  List<Property> filter(bool Function(Property) test) {
    return where(test).toList();
  }
}
