import 'package:estate_ease/screens/socials_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/estate_provider.dart';
// import '../widgets/add_property_dialog.dart';
import 'home_screen.dart';
import 'search_listings_screen.dart';
import 'estate_managers_screen.dart';
// import 'messages_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  final List<Widget> _screens = const [
    HomeScreen(),
    SearchListingsScreen(),
    EstateManagersScreen(),
    SocialsScreen(),
    // MessagesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final estateProvider = context.watch<EstateProvider>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
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
            const Text(
              'Real1 Africa',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
            ),
          ],
        ),
        actions: [
          /*IconButton(
            icon: const Icon(Icons.add_circle_outline_rounded),
            tooltip: 'Add Property',
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => const AddPropertyDialog(),
              );
            },
          ),*/
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No new notifications.')),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _screens[estateProvider.currentNavIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: estateProvider.currentNavIndex,
        onDestinationSelected: (index) => estateProvider.setNavIndex(index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.business_outlined),
            selectedIcon: Icon(Icons.business),
            label: 'Managers',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble),
            label: 'Socials',
          ),
          /*NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble),
            label: 'Messages',
          ),*/
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
