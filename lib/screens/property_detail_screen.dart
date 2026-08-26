import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/property.dart';
import '../network/provider/network_provider.dart';
import '../providers/estate_provider.dart';
import '../widgets/book_viewing_dialog.dart';
import '../widgets/full_map_dialog.dart';
import '../widgets/property_carousel_card.dart';
import '../widgets/save_property_button.dart';
import '../widgets/write_review_dialog.dart';

class PropertyDetailScreen extends StatefulWidget {
  final String propertyId;

  const PropertyDetailScreen({super.key, required this.propertyId});

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  int _activeImageIndex = 0;

  Property? _property;
  bool _isLoading = true;
  String? _error;
  List<Property> _related = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final networkRepo = context.read<NetworkProvider>().networkRepo;

    try {
      final response = await networkRepo.getPublicProperty(widget.propertyId);
      if (!mounted) return;

      if (response.success != true || response.data == null) {
        setState(() {
          _isLoading = false;
          _error = response.message ?? 'This property could not be found.';
        });
        return;
      }

      setState(() {
        _property = response.data;
        _isLoading = false;
      });

      try {
        final relatedResponse = await networkRepo.getRelatedProperties(
          widget.propertyId,
        );
        if (mounted && relatedResponse.success == true) {
          setState(() => _related = relatedResponse.data ?? []);
        }
      } catch (_) {
        // Non-critical section; ignore failures.
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _error = 'Could not load this property. Check your connection.';
      });
    }
  }

  String _priceLabel(Property property) {
    final price = property.salePrice ?? property.rentPrice;
    if (price == null) return 'Price on request';
    final currency = property.currency ?? '₦';
    final label = '$currency${price.toStringAsFixed(0)}';
    return property.salePrice == null && property.rentPrice != null
        ? '$label /period'
        : label;
  }

  String _addressLabel(Property property) {
    final address = property.address;
    if (address == null) return '';
    return [
      address.street,
      address.city,
      address.state,
      address.country,
    ].where((p) => p != null && p.isNotEmpty).join(', ');
  }

  String _formatAmenityKey(String key) {
    final spaced = key
        .replaceAllMapped(RegExp('([A-Z])'), (m) => ' ${m.group(0)}')
        .trim();
    if (spaced.isEmpty) return spaced;
    return spaced[0].toUpperCase() + spaced.substring(1);
  }

  String? _formatAmenityValue(dynamic value) {
    if (value == null) return null;
    if (value is String) return value.trim().isEmpty ? null : value;
    if (value is List) {
      final items = value
          .map((e) => e.toString())
          .where((s) => s.trim().isNotEmpty)
          .toList();
      return items.isEmpty ? null : items.join(', ');
    }
    if (value is num) return value == 0 ? null : '$value';
    if (value is bool) return value ? 'Yes' : null;
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null || _property == null) {
      final theme = Theme.of(context);
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.wifi_off_rounded,
                  size: 40,
                  color: theme.colorScheme.error,
                ),
                const SizedBox(height: 12),
                Text(
                  _error ?? 'This property could not be found.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: _load,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return _buildDetail(context, _property!);
  }

  Widget _buildDetail(BuildContext context, Property property) {
    final estateProvider = context.watch<EstateProvider>();
    final theme = Theme.of(context);

    final propertyReviews = estateProvider.reviews
        .where((r) => r.propertyId == property.id)
        .toList();
    final avgRating = propertyReviews.isEmpty
        ? 0.0
        : propertyReviews.map((r) => r.rating).reduce((a, b) => a + b) /
              propertyReviews.length;

    final amenityEntries = property.amenities.entries
        .map((e) => MapEntry(_formatAmenityKey(e.key), _formatAmenityValue(e.value)))
        .where((e) => e.value != null)
        .toList();

    final images = property.media;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Image Gallery
                Stack(
                  children: [
                    SizedBox(
                      height: 320,
                      width: double.infinity,
                      child: images.isEmpty
                          ? Container(
                              color: Colors.grey.shade300,
                              child: const Icon(Icons.home, size: 60),
                            )
                          : PageView.builder(
                              itemCount: images.length,
                              onPageChanged: (idx) =>
                                  setState(() => _activeImageIndex = idx),
                              itemBuilder: (context, idx) {
                                return Image.network(
                                  images[idx].fullUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, _, _) => Container(
                                    color: Colors.grey.shade300,
                                    child: const Icon(Icons.home, size: 60),
                                  ),
                                );
                              },
                            ),
                    ),
                    if (images.isNotEmpty)
                      Positioned(
                        bottom: 12,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            '${_activeImageIndex + 1}/${images.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      top: 40,
                      left: 16,
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withValues(alpha: 0.85),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      right: 16,
                      child: SavePropertyButton(
                        propertyId: property.id,
                        iconSize: 20,
                      ),
                    ),
                  ],
                ),

                // Property Info Card
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              property.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          Text(
                            _priceLabel(property),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              _addressLabel(property),
                              style: TextStyle(
                                fontSize: 12,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ],
                      ),

                      if (property.categories.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          children: property.categories
                              .map((c) => Chip(label: Text(c.title)))
                              .toList(),
                        ),
                      ],

                      const SizedBox(height: 24),

                      // About Section
                      const Text(
                        'About this Property',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        property.description,
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.5,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),

                      if (amenityEntries.isNotEmpty) ...[
                        const SizedBox(height: 24),
                        const Text(
                          'Property Details',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: amenityEntries.map((entry) {
                            return Chip(
                              avatar: Icon(
                                Icons.check_circle_outline,
                                size: 16,
                                color: theme.colorScheme.primary,
                              ),
                              label: Text('${entry.key}: ${entry.value}'),
                            );
                          }).toList(),
                        ),
                      ],

                      const SizedBox(height: 28),

                      // Location & Map Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Location & Map',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () => _openMap(context, property),
                            icon: const Icon(Icons.map_outlined, size: 18),
                            label: const Text(
                              'View on Map',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      GestureDetector(
                        onTap: () => _openMap(context, property),
                        child: Container(
                          height: 160,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: theme.colorScheme.outlineVariant
                                  .withValues(alpha: 0.4),
                            ),
                          ),
                          child: Stack(
                            children: [
                              CustomPaint(
                                size: const Size(double.infinity, 160),
                                painter: _MapPreviewGridPainter(
                                  color: theme.brightness == Brightness.dark
                                      ? Colors.white10
                                      : Colors.black.withValues(alpha: 0.05),
                                ),
                              ),
                              Center(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.2,
                                        ),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Flexible(
                                        child: Text(
                                          property.address?.city ??
                                              _addressLabel(property),
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 12,
                                right: 12,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.7),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    'Tap to open full map 🗺️',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      if (_related.isNotEmpty) ...[
                        const SizedBox(height: 28),
                        const Text(
                          'Related Properties',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 260,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _related.length,
                            itemBuilder: (context, index) {
                              final item = _related[index];
                              return PropertyCarouselCard(
                                property: item,
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => PropertyDetailScreen(
                                        propertyId: item.id,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],

                      const SizedBox(height: 28),

                      // Reviews & Ratings Section (client-side only; no reviews endpoint)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Ratings & Reviews',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => WriteReviewDialog(
                                  propertyId: property.id,
                                  propertyTitle: property.title,
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.rate_review_outlined,
                              size: 16,
                            ),
                            label: const Text(
                              'Write Review',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      if (propertyReviews.isEmpty)
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerLowest,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: theme.colorScheme.outline,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'No customer reviews yet. Be the first to leave a review!',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      else ...[
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerLow,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    avgRating.toStringAsFixed(1),
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w900,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                  Row(
                                    children: List.generate(
                                      5,
                                      (i) => Icon(
                                        i < avgRating.round()
                                            ? Icons.star
                                            : Icons.star_border,
                                        size: 14,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${propertyReviews.length} reviews',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 20),
                              const VerticalDivider(),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  children: List.generate(5, (i) {
                                    final star = 5 - i;
                                    final count = propertyReviews
                                        .where((r) => r.rating == star)
                                        .length;
                                    final ratio = propertyReviews.isEmpty
                                        ? 0.0
                                        : count / propertyReviews.length;
                                    return _buildRatingBar(
                                      '$star★',
                                      ratio,
                                      theme,
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...propertyReviews.map((review) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surfaceContainerLowest,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: theme.colorScheme.outlineVariant
                                    .withValues(alpha: 0.3),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 18,
                                      backgroundImage: NetworkImage(
                                        review.userAvatar,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            review.userName,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                          Text(
                                            review.date,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: theme
                                                  .colorScheme
                                                  .onSurfaceVariant,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: List.generate(
                                        review.rating,
                                        (_) => const Icon(
                                          Icons.star,
                                          size: 14,
                                          color: Colors.amber,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  review.comment,
                                  style: TextStyle(
                                    fontSize: 12,
                                    height: 1.4,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],

                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Fixed Action Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Messaging is coming soon.'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.chat_bubble_outline),
                      label: const Text('Contact Agent'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => BookViewingDialog(
                            propertyId: property.id,
                            propertyTitle: property.title,
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Book Viewing'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openMap(BuildContext context, Property property) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FullMapDialog(
          propertyTitle: property.title,
          priceLabel: _priceLabel(property),
          addressLabel: _addressLabel(property),
          cityLabel: property.address?.city ?? '',
        ),
      ),
    );
  }

  Widget _buildRatingBar(String label, double ratio, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Text(
              label,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: ratio,
                minHeight: 6,
                backgroundColor: theme.colorScheme.surfaceContainerHigh,
                valueColor: AlwaysStoppedAnimation<Color>(
                  theme.colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapPreviewGridPainter extends CustomPainter {
  final Color color;

  _MapPreviewGridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0;

    const step = 24.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
