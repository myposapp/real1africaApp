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

    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        var prefs = context.read<PreferenceProvider>();

        final cachedProfileJson = prefs.getString(EstateConfigs.profileKey);
        if (cachedProfileJson != null) {
          try {
            final cachedProfile = UserProfile.fromJson(cachedProfileJson);
            context.read<ProfileProvider>().setUserProfile(
              cachedProfile,
              source: UserSource.cache,
            );
          } catch (error) {
            debugPrint('Cached profile malformed/stale: $error');
          }
        }

        if (prefs.getBool(EstateConfigs.onboardedKey) == true) {
          Navigator.pushReplacementNamed(context, '/main');
        } else {
          Navigator.pushReplacementNamed(context, '/intro');
        }
      }
    });
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
