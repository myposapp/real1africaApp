import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/estate_provider.dart';
import '../providers/theme_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final estateProvider = context.watch<EstateProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final theme = Theme.of(context);
    final user = estateProvider.user;

    final savedCount = estateProvider.properties.where((p) => p.isFavorite).length;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              // User Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(user.avatar),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.fullName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text(user.email, style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant)),
                          Text(user.phone, style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Metrics Row
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard('Saved Homes', '$savedCount', theme),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildMetricCard('Viewings', '${estateProvider.viewings.length}', theme),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildMetricCard('Inquiries', '3', theme),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Scheduled Viewings
              if (estateProvider.viewings.isNotEmpty) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Scheduled Viewings (${estateProvider.viewings.length})',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 8),
                ...estateProvider.viewings.map((v) {
                  return Card(
                    child: ListTile(
                      title: Text(v.propertyTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      subtitle: Text('📅 ${v.date} at ${v.time}', style: const TextStyle(fontSize: 11)),
                      trailing: Chip(
                        label: Text(v.status, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  );
                }).toList(),
                const SizedBox(height: 20),
              ],

              // Settings Options
              Card(
                child: Column(
                  children: [
                    SwitchListTile(
                      title: const Text('Dark Mode Accessibility', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      subtitle: const Text('Material Design 3 dark theme', style: TextStyle(fontSize: 11)),
                      value: themeProvider.isDarkMode,
                      onChanged: (_) => themeProvider.toggleTheme(),
                      secondary: Icon(
                        themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: Icon(Icons.slideshow, color: theme.colorScheme.primary),
                      title: const Text('View Onboarding Slides', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      subtitle: const Text('Replay intro guide', style: TextStyle(fontSize: 11)),
                      trailing: const Icon(Icons.chevron_right, size: 18),
                      onTap: () => Navigator.pushNamed(context, '/intro'),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: Icon(Icons.restart_alt, color: theme.colorScheme.primary),
                      title: const Text('View Splash Screen', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      subtitle: const Text('Replay animated splash screen', style: TextStyle(fontSize: 11)),
                      trailing: const Icon(Icons.chevron_right, size: 18),
                      onTap: () => Navigator.pushNamed(context, '/splash'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard(String label, String value, ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: theme.colorScheme.primary)),
            const SizedBox(height: 2),
            Text(label, style: TextStyle(fontSize: 11, color: theme.colorScheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}
