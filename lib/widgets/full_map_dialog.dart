import 'package:flutter/material.dart';

class FullMapDialog extends StatelessWidget {
  final String propertyTitle;
  final String priceLabel;
  final String addressLabel;
  final String cityLabel;

  const FullMapDialog({
    super.key,
    required this.propertyTitle,
    required this.priceLabel,
    required this.addressLabel,
    required this.cityLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('$propertyTitle - Map View'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Location link copied to clipboard.')),
              );
            },
          )
        ],
      ),
      body: Stack(
        children: [
          // Map Background Simulation
          Container(
            color: theme.brightness == Brightness.dark
                ? const Color(0xFF1E293B)
                : const Color(0xFFE2E8F0),
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                // Grid lines / Map pattern graphics
                CustomPaint(
                  size: Size.infinite,
                  painter: _MapGridPainter(
                    gridColor: theme.brightness == Brightness.dark
                        ? Colors.white10
                        : Colors.black.withValues(alpha: 0.06),
                  ),
                ),

                // Center Pin Marker
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.25),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.home_filled, color: Colors.white, size: 16),
                            const SizedBox(width: 6),
                            Text(
                              priceLabel,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xFF006767),
                        size: 28,
                      ),
                    ],
                  ),
                ),

                // Map controls overlay (Zoom + Layers)
                Positioned(
                  top: 20,
                  right: 20,
                  child: Column(
                    children: [
                      _buildMapButton(Icons.add, () {}, theme),
                      const SizedBox(height: 8),
                      _buildMapButton(Icons.remove, () {}, theme),
                      const SizedBox(height: 12),
                      _buildMapButton(Icons.layers_outlined, () {}, theme),
                      const SizedBox(height: 8),
                      _buildMapButton(Icons.my_location, () {}, theme),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Location Card Sheet
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on, color: theme.colorScheme.primary, size: 22),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          addressLabel,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      if (cityLabel.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            cityLabel,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSecondaryContainer,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Opening turn-by-turn directions to $addressLabel...')),
                        );
                      },
                      icon: const Icon(Icons.turn_right_rounded),
                      label: const Text('Get Directions'),
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

  Widget _buildMapButton(IconData icon, VoidCallback onPressed, ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 8,
          )
        ],
      ),
      child: IconButton(
        icon: Icon(icon, size: 20),
        onPressed: onPressed,
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  final Color gridColor;

  _MapGridPainter({required this.gridColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.0;

    const step = 40.0;
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
