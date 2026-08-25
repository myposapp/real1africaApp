import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/estate_provider.dart';
import '../providers/theme_provider.dart';
import '../models/models.dart';
import '../models/country.dart';
import '../data/countries_data.dart';
import '../widgets/confirmation_dialog.dart';
import '../widgets/add_property_dialog.dart';
import '../widgets/add_kyc_document_dialog.dart';
import '../widgets/phone_input_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _basicInfoFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  Country _selectedCountry = kCountries.firstWhere(
    (c) => c.code == 'NG',
    orElse: () => kCountries[3],
  );
  String? _phoneError;

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _showOldPass = false;
  bool _showNewPass = false;
  bool _showConfirmPass = false;

  bool _isSavingBasic = false;
  bool _isUpdatingPass = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    final user = context.read<EstateProvider>().user;
    _nameController = TextEditingController(text: user.fullName);
    _emailController = TextEditingController(text: user.email);

    // Parse user's phone to detect matching country dial code & 10-digit number
    String phoneDigits = user.phone;
    for (final country in kCountries) {
      if (phoneDigits.startsWith(country.dialCode)) {
        _selectedCountry = country;
        phoneDigits = phoneDigits.substring(country.dialCode.length).trim();
        break;
      }
    }
    phoneDigits = phoneDigits.replaceAll(RegExp(r'\D'), '');
    if (phoneDigits.length > 10) {
      phoneDigits = phoneDigits.substring(phoneDigits.length - 10);
    }
    _phoneController = TextEditingController(text: phoneDigits);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
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

  @override
  Widget build(BuildContext context) {
    final estateProvider = context.watch<EstateProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final theme = Theme.of(context);
    //final isDark = themeProvider.isDarkMode;

    final primaryRed = const Color(0xFFC00016);
    final savedCount = estateProvider.properties
        .where((p) => p.isFavorite)
        .length;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Network Content Loading Indicator
            if (estateProvider.isRefreshingProfile ||
                estateProvider.isDeletingAccount)
              LinearProgressIndicator(color: primaryRed, minHeight: 3),

            // Top Header & Refresh / Action Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'User Area',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
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
                        onPressed: estateProvider.isRefreshingProfile
                            ? null
                            : () async {
                                await estateProvider.refreshProfile();
                                _showSnackBar('Profile content refreshed!');
                              },
                        icon: estateProvider.isRefreshingProfile
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.refresh),
                      ),
                      IconButton(
                        tooltip: 'Add Property',
                        style: IconButton.styleFrom(
                          backgroundColor: const Color(0xFF2E7D32),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => const AddPropertyDialog(),
                          );
                        },
                        icon: const Icon(Icons.add, size: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Responsive Tab Bar matching screenshots
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.4,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: primaryRed,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                tabs: [
                  const Tab(text: 'Dashboard'),
                  Tab(
                    text:
                        'My Properties (${estateProvider.myProperties.length})',
                  ),
                  Tab(text: 'Saved ($savedCount)'),
                  const Tab(text: 'Subscription'),
                  const Tab(text: 'Profile Info'),
                ],
              ),
            ),

            // Tab View Body
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildDashboardTab(
                    estateProvider,
                    theme,
                    primaryRed,
                    savedCount,
                  ),
                  _buildMyPropertiesTab(estateProvider, theme, primaryRed),
                  _buildSavedPropertiesTab(estateProvider, theme, primaryRed),
                  _buildSubscriptionTab(estateProvider, theme, primaryRed),
                  _buildProfileInfoTab(
                    estateProvider,
                    themeProvider,
                    theme,
                    primaryRed,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TAB 1: DASHBOARD
  Widget _buildDashboardTab(
    EstateProvider provider,
    ThemeData theme,
    Color primaryRed,
    int savedCount,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Metrics Grid (Screenshot 1)
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.45,
            children: [
              _buildMetricTile(
                title: 'My properties',
                subtitle: 'Properties you added',
                count: '${provider.myProperties.length}',
                icon: Icons.home,
                iconColor: primaryRed,
                onTap: () => _tabController.animateTo(1),
              ),
              _buildMetricTile(
                title: 'Saved properties',
                subtitle: 'Listings saved for later',
                count: '$savedCount',
                icon: Icons.bookmark,
                iconColor: Colors.amber.shade700,
                onTap: () => _tabController.animateTo(2),
              ),
              _buildMetricTile(
                title: 'Scheduled Viewings',
                subtitle: 'Upcoming tours',
                count: '${provider.viewings.length}',
                icon: Icons.calendar_month,
                iconColor: Colors.blue.shade700,
              ),
              _buildMetricTile(
                title: 'Inquiries',
                subtitle: 'Direct messages',
                count: '3',
                icon: Icons.chat_bubble_outline,
                iconColor: Colors.teal.shade700,
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Scheduled Viewings Card (Preserved from original requirements)
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Scheduled Viewings',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Chip(
                        label: Text(
                          '${provider.viewings.length} Active',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (provider.viewings.isNotEmpty)
                    ...provider.viewings.map(
                      (v) => Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest
                              .withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    v.propertyTitle,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '📅 ${v.date} at ${v.time}',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                v.status,
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'No scheduled viewings at the moment.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Quick Post Banner
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFC00016), Color(0xFFE53935)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Have a property to list?',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Post land, apartments, houses, or stores.',
                        style: TextStyle(color: Colors.white70, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => const AddPropertyDialog(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: primaryRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    '+ Post Listing',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricTile({
    required String title,
    required String subtitle,
    required String count,
    required IconData icon,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    count,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: iconColor.withValues(alpha: 0.12),
                    child: Icon(icon, color: iconColor, size: 18),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                    maxLines: 1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // TAB 2: MY PROPERTIES (Screenshot 2)
  Widget _buildMyPropertiesTab(
    EstateProvider provider,
    ThemeData theme,
    Color primaryRed,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Properties (${provider.myProperties.length})',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => const AddPropertyDialog(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                icon: const Icon(Icons.add, size: 16),
                label: const Text(
                  'Add Property',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          if (provider.myProperties.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: provider.myProperties.length,
              itemBuilder: (context, idx) {
                final prop = provider.myProperties[idx];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            prop.image,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => Container(
                              width: 60,
                              height: 60,
                              color: Colors.grey.shade300,
                              child: const Icon(Icons.home),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                prop.category ?? prop.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                prop.title,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                                maxLines: 1,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withValues(
                                        alpha: 0.15,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      prop.status ?? 'Active',
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withValues(
                                        alpha: 0.15,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      prop.visibility ?? 'Public',
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                            size: 20,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => ConfirmationDialog(
                                title: 'Delete Property?',
                                message:
                                    'Are you sure you want to permanently remove this property listing?',
                                isDestructive: true,
                                confirmText: 'Delete',
                                onCancel: () => Navigator.pop(context),
                                onConfirm: () {
                                  provider.deleteProperty(prop.id);
                                  Navigator.pop(context);
                                  _showSnackBar('Property deleted.');
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          else
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Text('No properties listed yet.'),
              ),
            ),
        ],
      ),
    );
  }

  // TAB 3: SAVED PROPERTIES (Screenshot 3)
  Widget _buildSavedPropertiesTab(
    EstateProvider provider,
    ThemeData theme,
    Color primaryRed,
  ) {
    final favorites = provider.properties.where((p) => p.isFavorite).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: favorites.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Saved Properties (${favorites.length})',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: favorites.length,
                  itemBuilder: (context, idx) {
                    final prop = favorites[idx];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            prop.image,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          prop.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        subtitle: Text(
                          '₦${prop.price.toStringAsFixed(0)} ${prop.priceUnit}',
                          style: TextStyle(
                            color: primaryRed,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.bookmark_remove,
                            color: Colors.grey,
                            size: 20,
                          ),
                          onPressed: () {
                            provider.toggleFavorite(prop.id);
                            _showSnackBar('Removed from saved properties');
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.amber.withValues(alpha: 0.15),
                      child: const Icon(
                        Icons.bookmark_border,
                        size: 32,
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'You have not saved any properties yet.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Browse listings and tap bookmark to save properties here.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  // TAB 4: SUBSCRIPTION (Screenshot 4)
  Widget _buildSubscriptionTab(
    EstateProvider provider,
    ThemeData theme,
    Color primaryRed,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current Subscription
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'CURRENT SUBSCRIPTION',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    provider.activePlan?.name ?? 'No active plan',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    provider.activePlan != null
                        ? 'Active on ${provider.subscriptionPeriod} billing.'
                        : 'Choose a plan below to unlock subscription benefits and listing capacity.',
                    style: TextStyle(
                      fontSize: 11,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          const Text(
            'Choose your plan',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 12),

          _buildPlanCard(
            title: 'Starter Plan',
            price: '₦0',
            period: '/mo',
            features: [
              'Up to 3 listings',
              'Standard search listing',
              'Basic inquiries inbox',
            ],
            isCurrent: provider.activePlan == null,
            primaryRed: primaryRed,
            onSelect: () => _showSnackBar('Selected Starter Plan'),
          ),
          const SizedBox(height: 12),

          _buildPlanCard(
            title: 'Pro Manager',
            price: '₦15,000',
            period: '/mo',
            badge: 'Popular',
            features: [
              'Up to 15 listings',
              'Verified Agent blue badge',
              'Direct WhatsApp & call',
              'Top search priority',
            ],
            isCurrent: provider.activePlan?.name == 'Pro Manager',
            primaryRed: primaryRed,
            onSelect: () {
              provider.changePlan(
                SubscriptionPlan(
                  id: 'plan_pro',
                  name: 'Pro Manager',
                  monthlyPrice: 15000,
                  quarterlyPrice: 40500,
                  yearlyPrice: 144000,
                  maxListings: 15,
                  features: ['Up to 15 listings'],
                ),
              );
              _showSnackBar('Subscribed to Pro Manager!');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String price,
    required String period,
    String? badge,
    required List<String> features,
    required bool isCurrent,
    required Color primaryRed,
    required VoidCallback onSelect,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: isCurrent
            ? BorderSide(color: primaryRed, width: 1.5)
            : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                if (badge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade700,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      badge,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              '$price $period',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
            const Divider(height: 20),
            ...features.map(
              (f) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      size: 14,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 6),
                    Text(f, style: const TextStyle(fontSize: 11)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isCurrent ? null : onSelect,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isCurrent
                      ? Colors.grey.shade300
                      : primaryRed,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  isCurrent ? 'Current Plan' : 'Select Plan',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TAB 5: PROFILE INFORMATION (Screenshots 5, 6, 7 & User requests)
  Widget _buildProfileInfoTab(
    EstateProvider provider,
    ThemeProvider themeProvider,
    ThemeData theme,
    Color primaryRed,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. KYC Documents Card (Screenshot 5)
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'KYC Documents',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Submit identity documents',
                            style: TextStyle(
                              fontSize: 11,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => AddKYCDocumentDialog(
                              onAdd: (doc) {
                                provider.addKycDoc(doc);
                                _showSnackBar('KYC Document submitted!');
                              },
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryRed,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                        ),
                        icon: const Icon(Icons.add, size: 14),
                        label: const Text(
                          '+ Add',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (provider.kycDocs.isNotEmpty)
                    ...provider.kycDocs.map(
                      (doc) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          doc.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        subtitle: Text(
                          '${doc.type} • ${doc.uploadedAt}',
                          style: const TextStyle(fontSize: 10),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Chip(
                              label: Text(
                                doc.status,
                                style: const TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              padding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                size: 18,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => ConfirmationDialog(
                                    title: 'Delete KYC Document?',
                                    message:
                                        'Are you sure you want to remove this verification document?',
                                    isDestructive: true,
                                    confirmText: 'Delete',
                                    onCancel: () => Navigator.pop(context),
                                    onConfirm: () {
                                      provider.deleteKycDoc(doc.id);
                                      Navigator.pop(context);
                                      _showSnackBar('KYC document removed.');
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    const Text(
                      'No KYC documents submitted yet.',
                      style: TextStyle(fontSize: 11),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 2. Basic Info Card (Screenshot 6)
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _basicInfoFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Basic Info',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name *',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 12),
                    PhoneInputField(
                      controller: _phoneController,
                      selectedCountry: _selectedCountry,
                      onCountryChanged: (c) =>
                          setState(() => _selectedCountry = c),
                      errorText: _phoneError,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email Address *',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _isSavingBasic
                          ? null
                          : () {
                              final rawDigits = _phoneController.text.trim();
                              if (rawDigits.isEmpty) {
                                setState(
                                  () =>
                                      _phoneError = 'Phone number is required',
                                );
                                return;
                              } else if (rawDigits.length < 10) {
                                setState(
                                  () => _phoneError =
                                      'Phone number must be 10 digits',
                                );
                                return;
                              } else {
                                setState(() => _phoneError = null);
                              }

                              if (_basicInfoFormKey.currentState!.validate()) {
                                setState(() => _isSavingBasic = true);
                                final fullPhone =
                                    '${_selectedCountry.dialCode} $rawDigits';
                                Future.delayed(
                                  const Duration(milliseconds: 500),
                                  () {
                                    provider.updateProfile(
                                      fullName: _nameController.text,
                                      email: _emailController.text,
                                      phone: fullPhone,
                                    );
                                    setState(() => _isSavingBasic = false);
                                    _showSnackBar(
                                      'Profile saved successfully!',
                                    );
                                  },
                                );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryRed,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isSavingBasic
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Save Changes',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 3. Update Password Card (Screenshot 7)
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _passwordFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Update Password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _oldPasswordController,
                      obscureText: !_showOldPass,
                      decoration: InputDecoration(
                        labelText: 'Old Password *',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _showOldPass
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 18,
                          ),
                          onPressed: () =>
                              setState(() => _showOldPass = !_showOldPass),
                        ),
                      ),
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _newPasswordController,
                      obscureText: !_showNewPass,
                      decoration: InputDecoration(
                        labelText: 'New Password *',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _showNewPass
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 18,
                          ),
                          onPressed: () =>
                              setState(() => _showNewPass = !_showNewPass),
                        ),
                      ),
                      validator: (v) =>
                          v != null && v.length < 6 ? 'Min 6 chars' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: !_showConfirmPass,
                      decoration: InputDecoration(
                        labelText: 'Confirm New Password *',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _showConfirmPass
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 18,
                          ),
                          onPressed: () => setState(
                            () => _showConfirmPass = !_showConfirmPass,
                          ),
                        ),
                      ),
                      validator: (v) => v != _newPasswordController.text
                          ? 'Passwords do not match'
                          : null,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _isUpdatingPass
                          ? null
                          : () {
                              if (_passwordFormKey.currentState!.validate()) {
                                setState(() => _isUpdatingPass = true);
                                Future.delayed(
                                  const Duration(milliseconds: 600),
                                  () {
                                    setState(() => _isUpdatingPass = false);
                                    _oldPasswordController.clear();
                                    _newPasswordController.clear();
                                    _confirmPasswordController.clear();
                                    _showSnackBar(
                                      'Password updated successfully!',
                                    );
                                  },
                                );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryRed,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isUpdatingPass
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Update Password',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 4. Preferences & Account Actions (Dark mode with system match, Logout, Delete Account)
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
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

                  // Theme Mode (Light | Dark | System)
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

                  // Log Out Button
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.logout, color: Colors.orange),
                    title: const Text(
                      'Log Out',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    subtitle: const Text(
                      'Terminate your current session',
                      style: TextStyle(fontSize: 11),
                    ),
                    trailing: OutlinedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => ConfirmationDialog(
                            title: 'Log Out of EstateEase?',
                            message:
                                'You will need to sign in again to access your account.',
                            confirmText: 'Log Out',
                            onCancel: () => Navigator.pop(context),
                            onConfirm: () {
                              provider.logout();
                              Navigator.pop(context);
                              Navigator.pushNamed(context, '/login');
                            },
                          ),
                        );
                      },
                      child: const Text('Log Out'),
                    ),
                  ),

                  const Divider(height: 16),

                  // Delete Account Option
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ),
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
                      onPressed: () {
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
                              await provider.deleteAccount();
                              if (ctx.mounted) {
                                Navigator.pushNamed(ctx, '/signup');
                              }
                            },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryRed,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Delete'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
