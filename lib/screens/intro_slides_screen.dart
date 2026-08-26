import 'package:estate_ease/data/static_configs.dart';
import 'package:estate_ease/providers/preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _IntroSlide {
  final String title;
  final String description;
  final IconData icon;
  final String badgeText;

  _IntroSlide({
    required this.title,
    required this.description,
    required this.icon,
    required this.badgeText,
  });
}

class IntroSlidesScreen extends StatefulWidget {
  const IntroSlidesScreen({super.key});

  @override
  State<IntroSlidesScreen> createState() => _IntroSlidesScreenState();
}

class _IntroSlidesScreenState extends State<IntroSlidesScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<_IntroSlide> _slides = [
    _IntroSlide(
      title: 'Discover Luxury & Comfort',
      description:
          'Explore verified premium properties, villas, and apartments tailored to your exact taste with real-time tour scheduling.',
      icon: Icons.home_work_rounded,
      badgeText: 'Property Search',
    ),
    _IntroSlide(
      title: 'Seamless Estate Management',
      description:
          'Connect directly with certified property managers, view detailed performance metrics, and submit inquiries instantly.',
      icon: Icons.business_center_rounded,
      badgeText: 'Verified Managers',
    ),
    _IntroSlide(
      title: 'Effortless In-App Booking',
      description:
          'Book home viewings in two clicks and communicate directly with property agents through integrated real-time chat.',
      icon: Icons.calendar_month_rounded,
      badgeText: 'Instant Schedule',
    ),
  ];

  void _nextPage() {
    if (_currentIndex < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<PreferenceProvider>().setBool(
      EstateConfigs.onboardedKey,
      true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.real_estate_agent,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Real1 Africa',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/main'),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.outline,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Page View
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemCount: _slides.length,
                itemBuilder: (context, index) {
                  final slide = _slides[index];
                  return Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon Circle Frame
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            slide.icon,
                            size: 68,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            slide.badgeText,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSecondaryContainer,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          slide.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          slide.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.5,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Bottom Indicators & Action Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Dot Indicators
                  Row(
                    children: List.generate(
                      _slides.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.only(right: 6),
                        width: _currentIndex == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentIndex == index
                              ? theme.colorScheme.primary
                              : theme.colorScheme.outlineVariant,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),

                  // Next / Get Started Button
                  ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _currentIndex == _slides.length - 1
                              ? 'Get Started'
                              : 'Next',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.arrow_forward_rounded, size: 18),
                      ],
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
