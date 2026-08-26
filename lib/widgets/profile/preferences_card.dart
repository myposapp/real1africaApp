import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/static_configs.dart';
import '../../network/provider/network_provider.dart';
import '../../providers/estate_provider.dart';
import '../../providers/person_provider.dart';
import '../../providers/preferences_provider.dart';
import '../../providers/theme_provider.dart';
import '../confirmation_dialog.dart';

class PreferencesCard extends StatefulWidget {
  final Color primaryRed;

  const PreferencesCard({super.key, required this.primaryRed});

  @override
  State<PreferencesCard> createState() => _PreferencesCardState();
}

class _PreferencesCardState extends State<PreferencesCard> {
  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _clearSession() async {
    context.read<NetworkProvider>().clearCookies();
    context.read<ProfileProvider>().clearUserProfile();
    await context.read<PreferenceProvider>().remove(EstateConfigs.profileKey);
    if (mounted) {
      Provider.of<EstateProvider>(context, listen: false).logout();
    }
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (_) => ConfirmationDialog(
        title: 'Log Out of EstateEase?',
        message: 'You will need to sign in again to access your account.',
        confirmText: 'Log Out',
        onCancel: () => Navigator.pop(context),
        onConfirm: () async {
          Navigator.pop(context);
          await _clearSession();
          if (mounted) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/login',
              (route) => false,
            );
          }
        },
      ),
    );
  }

  void _deleteAccount() {
    showDialog(
      context: context,
      builder: (ctx) => ConfirmationDialog(
        title: 'Permanently Delete Account?',
        message:
            'This action is irreversible. All your profile data, properties, and KYC records will be deleted.',
        isDestructive: true,
        confirmText: 'Delete Account',
        onCancel: () => Navigator.pop(ctx),
        onConfirm: () async {
          Navigator.pop(ctx);
          final networkRepo = context.read<NetworkProvider>().networkRepo;
          try {
            final response = await networkRepo.deleteAccount();
            if (!mounted) return;
            if (response.success != true) {
              _showSnackBar(
                response.message ?? 'Could not delete your account.',
              );
              return;
            }
            await _clearSession();
            if (!mounted) return;
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/signup',
              (route) => false,
            );
          } catch (_) {
            if (!mounted) return;
            _showSnackBar('Could not delete your account. Check your connection.');
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Preferences & Security',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 12),

            const Text(
              'Theme Mode',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment(
                  value: ThemeMode.light,
                  label: Text('Light'),
                  icon: Icon(Icons.light_mode, size: 14),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  label: Text('Dark'),
                  icon: Icon(Icons.dark_mode, size: 14),
                ),
                ButtonSegment(
                  value: ThemeMode.system,
                  label: Text('System'),
                  icon: Icon(Icons.settings_brightness, size: 14),
                ),
              ],
              selected: {themeProvider.themeMode},
              onSelectionChanged: (set) =>
                  themeProvider.setThemeMode(set.first),
            ),

            const Divider(height: 24),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.logout, color: Colors.orange),
              title: const Text(
                'Log Out',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              subtitle: const Text(
                'Terminate your current session',
                style: TextStyle(fontSize: 11),
              ),
              trailing: OutlinedButton(
                onPressed: _logout,
                child: const Text('Log Out'),
              ),
            ),

            const Divider(height: 16),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.delete_forever, color: Colors.red),
              title: const Text(
                'Delete Account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.red,
                ),
              ),
              subtitle: const Text(
                'Permanently erase account data',
                style: TextStyle(fontSize: 11),
              ),
              trailing: ElevatedButton(
                onPressed: _deleteAccount,
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.primaryRed,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Delete'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
