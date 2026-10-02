import 'package:estate_ease/models/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../network/provider/network_provider.dart';
import '../providers/person_provider.dart';
// import '../widgets/add_property_dialog.dart';
import '../widgets/profile/dashboard_tab.dart';
import '../widgets/profile/my_properties_tab.dart';
import '../widgets/profile/profile_info_tab.dart';
import '../widgets/profile/saved_properties_tab.dart';
import '../widgets/profile/subscription_tab.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const _primaryRed = Color(0xFFC00016);

  int _propertiesTick = 0;
  int _savedTick = 0;
  int _profileTick = 0;
  bool _isRefreshingProfile = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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

  Future<void> _refreshProfile() async {
    setState(() => _isRefreshingProfile = true);

    final networkRepo = context.read<NetworkProvider>().networkRepo;
    try {
      final response = await networkRepo.getUserProfile();
      if (!mounted) return;

      if (response.success == true && response.data != null) {
        context.read<ProfileProvider>().setUserProfile(
          response.data!,
          source: UserSource.network,
        );
      }

      setState(() {
        _isRefreshingProfile = false;
        _profileTick++;
      });
      _showSnackBar('Profile content refreshed!');
    } catch (_) {
      if (!mounted) return;
      setState(() => _isRefreshingProfile = false);
      _showSnackBar('Could not refresh profile. Check your connection.');
    }
  }

  /*Future<void> _openAddPropertyDialog() async {
    final created = await showDialog<bool>(
      context: context,
      builder: (_) => const AddPropertyDialog(),
    );
    if (created == true) {
      setState(() => _propertiesTick++);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profile = context.watch<ProfileProvider>().profile;

    return Scaffold(
      body: SafeArea(
        child: (profile != null)
            ? _buildContent(theme, profile)
            : _buildNotLoggedInUI(),
      ),
    );
  }

  Widget _buildNotLoggedInUI() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('You are not logged in', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/login");
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(ThemeData theme, UserProfile profile) {
    return Column(
      children: [
        if (_isRefreshingProfile)
          LinearProgressIndicator(color: _primaryRed, minHeight: 3),

        // Top Header & Refresh / Action Bar
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                  Text(
                    "${profile.id} (${profile.userType ?? "User"})",
                    style: TextStyle(
                      fontSize: 11,
                      color: theme.colorScheme.onSurfaceVariant,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    'Manage dashboard, listings, and security',
                    style: TextStyle(
                      fontSize: 11,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    tooltip: 'Refresh Profile',
                    onPressed: _isRefreshingProfile ? null : _refreshProfile,
                    icon: _isRefreshingProfile
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.refresh),
                  ),
                  /*IconButton(
                        tooltip: 'Add Property',
                        style: IconButton.styleFrom(
                          backgroundColor: const Color(0xFF2E7D32),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: _openAddPropertyDialog,
                        icon: const Icon(Icons.add, size: 20),
                      ),*/
                ],
              ),
            ],
          ),
        ),

        // Responsive Tab Bar
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withValues(
              alpha: 0.4,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: _primaryRed,
            ),
            dividerColor: Colors.transparent,
            labelColor: Colors.white,
            unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            tabs: const [
              Tab(text: 'Dashboard'),
              Tab(text: 'My Properties'),
              Tab(text: 'Saved'),
              Tab(text: 'Subscription'),
              Tab(text: 'Profile Info'),
            ],
          ),
        ),

        // Tab View Body
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              DashboardTab(
                key: ValueKey('dashboard-$_propertiesTick-$_savedTick'),
                primaryRed: _primaryRed,
                onViewProperties: () => _tabController.animateTo(1),
                onViewSaved: () => _tabController.animateTo(2),
                onPropertiesChanged: () => setState(() => _propertiesTick++),
              ),
              MyPropertiesTab(
                key: ValueKey('myprops-$_propertiesTick'),
                primaryRed: _primaryRed,
                onChanged: () => setState(() => _propertiesTick++),
              ),
              SavedPropertiesTab(
                key: ValueKey('saved-$_savedTick'),
                primaryRed: _primaryRed,
                onChanged: () => setState(() => _savedTick++),
              ),
              const SubscriptionTab(primaryRed: _primaryRed),
              ProfileInfoTab(
                key: ValueKey('profile-$_profileTick'),
                primaryRed: _primaryRed,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
