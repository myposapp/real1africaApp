import 'package:flutter/material.dart';
import '../models/property.dart';
import '../utils/property_format.dart';
import 'save_property_button.dart';

class PropertyCarouselCard extends StatelessWidget {
  final Property property;
  final VoidCallback onTap;
  final double width;

  const PropertyCarouselCard({
    super.key,
    required this.property,
    required this.onTap,
    this.width = 220,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imageUrl = property.media.isNotEmpty
        ? property.media.first.fullUrl
        : null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                imageUrl != null
                    ? Image.network(
                        imageUrl,
                        height: 140,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Container(
                          height: 140,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.home),
                        ),
                      )
                    : Container(
                        height: 140,
                        width: double.infinity,
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.home),
                      ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: SavePropertyButton(propertyId: property.id),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    propertyCityStateLabel(property),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    propertyPriceLabel(property),
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: theme.colorScheme.primary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
