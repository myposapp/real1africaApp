import 'package:estate_ease/data/static_configs.dart';
import 'package:estate_ease/models/user_profile.dart';
import 'package:estate_ease/providers/person_provider.dart';
import 'package:estate_ease/providers/preferences_provider.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  var showIntro = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _scaleAnimation = Tween<double>(
      begin: 0.85,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();

    Timer(const Duration(seconds: 3), _routeFromSplash);
  }

  Future<void> _routeFromSplash() async {
    if (!mounted) return;
    final prefs = context.read<PreferenceProvider>();

    var isLoggedIn = false;
    final cachedProfileJson = prefs.getString(EstateConfigs.profileKey);
    if (cachedProfileJson != null) {
      try {
        final cachedProfile = UserProfile.fromJson(cachedProfileJson);
        context.read<ProfileProvider>().setUserProfile(
          cachedProfile,
          source: UserSource.cache,
        );
        isLoggedIn = true;
      } catch (error) {
        debugPrint('Cached profile malformed/stale: $error');
      }
    }

    final isOnboarded = prefs.getBool(EstateConfigs.onboardedKey) == true;

    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, isOnboarded ? '/main' : '/intro');
      return;
    }

    final choice = await showModalBottomSheet<_EntryChoice>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      builder: (_) => const _EntryChoiceSheet(),
    );
    if (!mounted || choice == null) return;

    if (choice == _EntryChoice.signIn) {
      // Main sits underneath so backing out of sign-in lands the user in the
      // app as a guest instead of closing it.
      await prefs.setBool(EstateConfigs.onboardedKey, true);
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/main');
      Navigator.pushNamed(context, '/login');
    } else {
      Navigator.pushReplacementNamed(context, isOnboarded ? '/main' : '/intro');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF003838), Color(0xFF006767), Color(0xFF008282)],
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.real_estate_agent,
                      size: 48,
                      color: Color(0xFF006767),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Real1 Africa',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Modern Property Management Simplified',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 48),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFABD32)),
                  strokeWidth: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum _EntryChoice { guest, signIn }

class _EntryChoiceSheet extends StatelessWidget {
  const _EntryChoiceSheet();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Welcome to Real1 Africa',
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Sign in to save properties, book viewings and manage your '
                'listings, or browse freely as a guest.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => Navigator.pop(context, _EntryChoice.signIn),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Sign In',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => Navigator.pop(context, _EntryChoice.guest),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text('Continue as Guest'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
