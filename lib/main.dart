@MappableLib(generateInitializerForScope: InitializerScope.package)
library;

import 'package:estate_ease/network/provider/network_provider.dart';
import 'package:estate_ease/providers/person_provider.dart';
import 'package:estate_ease/providers/preferences_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:provider/provider.dart';
import 'providers/estate_provider.dart';
import 'providers/theme_provider.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/intro_slides_screen.dart';
import 'screens/main_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';

import 'main.init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initializeMappers();

  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  final prefProvider = await PreferenceProvider.create();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => EstateProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider(), lazy: false),
        Provider(create: (_) => NetworkProvider(), lazy: false),
        Provider.value(value: prefProvider),
      ],
      child: const EstateEaseApp(),
    ),
  );
}

class EstateEaseApp extends StatelessWidget {
  const EstateEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      title: 'Real1 Africa',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/intro': (context) => const IntroSlidesScreen(),
        '/main': (context) => const MainScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
      },
    );
  }
}
