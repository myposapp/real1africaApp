import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/home_content.dart';
import '../network/provider/network_provider.dart';
import '../providers/estate_provider.dart';
import '../providers/person_provider.dart';
import '../widgets/property_carousel_card.dart';
import 'property_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeContent? _homeContent;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final networkRepo = context.read<NetworkProvider>().networkRepo;

    try {
      final response = await networkRepo.getHomeContent();
      if (!mounted) return;
      setState(() {
        _homeContent = response.data;
        _isLoading = false;
        if (response.success != true) {
          _error = response.message ?? 'Could not load home content.';
        }
      });

      // Best-effort hydration so heart icons reflect saved state right away.
      try {
        final savedResponse = await networkRepo.getSavedProperties(
          pageSize: 100,
        );
        if (mounted && savedResponse.success == true) {
          context.read<EstateProvider>().setSavedPropertyIds(
            (savedResponse.data ?? []).map((s) => s.property.id),
          );
        }
      } catch (_) {
        // Non-critical; heart icons simply stay unhydrated.
      }
    } catch (error) {
      debugPrint(error.toString());

      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _error = 'Could not load home content. Check your connection.';
      });
    }
  }

  void _goToSearch({
    String? purpose,
    String? categoryId,
    String? categoryTitle,
  }) {
    final estateProvider = context.read<EstateProvider>();
    if (purpose != null) estateProvider.setActiveTab(purpose);
    if (categoryId != null) {
      estateProvider.setSelectedCategory(categoryId, categoryTitle);
    }
    estateProvider.setNavIndex(1);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      final theme = Theme.of(context);
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.wifi_off_rounded,
                size: 40,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: 12),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _load,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(onRefresh: _load, child: _buildContent(context));
  }

  Widget _buildContent(BuildContext context) {
    final estateProvider = context.watch<EstateProvider>();
    final profile = context.watch<ProfileProvider>().profile;
    final theme = Theme.of(context);
    final homeContent = _homeContent;

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting & Search Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back, 👋',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    profile?.name ?? 'Find Your Ideal Home',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                backgroundImage: profile?.photoUrl != null
                    ? NetworkImage(profile!.photoUrl!)
                    : null,
                child: profile?.photoUrl == null
                    ? Icon(
                        Icons.person,
                        color: theme.colorScheme.onSurfaceVariant,
                      )
                    : null,
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Search Bar
          InkWell(
            onTap: () => estateProvider.setNavIndex(1),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: theme.colorScheme.outlineVariant.withValues(
                    alpha: 0.3,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: theme.colorScheme.outline),
                  const SizedBox(width: 10),
                  Text(
                    'Search location, property, villa...',
                    style: TextStyle(
                      fontSize: 13,
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Purpose shortcuts
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _goToSearch(purpose: 'sale'),
                  icon: const Icon(Icons.sell_outlined, size: 16),
                  label: const Text('For Sale'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _goToSearch(purpose: 'rent'),
                  icon: const Icon(Icons.key_outlined, size: 16),
                  label: const Text('For Rent'),
                ),
              ),
            ],
          ),

          if (homeContent != null &&
              (homeContent.propertyCount > 0 ||
                  homeContent.agentCount > 0)) ...[
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _StatTile(
                    label: 'Properties',
                    value: '${homeContent.propertyCount}',
                    icon: Icons.home_work_outlined,
                    theme: theme,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatTile(
                    label: 'Verified Agents',
                    value: '${homeContent.agentCount}',
                    icon: Icons.verified_outlined,
                    theme: theme,
                  ),
                ),
              ],
            ),
          ],

          if (homeContent != null && homeContent.categories.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text(
              'Browse by Category',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 96,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: homeContent.categories.length,
                itemBuilder: (context, index) {
                  final category = homeContent.categories[index];
                  return GestureDetector(
                    onTap: () => _goToSearch(
                      categoryId: category.id,
                      categoryTitle: category.title,
                    ),
                    child: Container(
                      width: 92,
                      margin: const EdgeInsets.only(right: 12),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor:
                                theme.colorScheme.surfaceContainerHighest,
                            backgroundImage: NetworkImage(category.imageUrl),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${category.title} (${category.count})',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],

          if (homeContent != null)
            ...homeContent.shelves
                .where((s) => s.items.isNotEmpty)
                .map((shelf) => _ShelfSection(shelf: shelf)),

          const SizedBox(height: 24),

          // Top Managers Snippet Header (dummy — no manager API endpoint yet)
          Text(
            'Verified Managers',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),

          ...estateProvider.managers.take(2).map((manager) {
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(manager.avatar),
                  radius: 24,
                ),
                title: Text(
                  manager.companyName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                subtitle: Text(
                  '${manager.listingsCount} listings • Rating ${manager.rating}',
                  style: TextStyle(
                    fontSize: 11,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  estateProvider.setSelectedManager(manager);
                  estateProvider.setNavIndex(2);
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final ThemeData theme;

  const _StatTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ShelfSection extends StatelessWidget {
  final HomeShelf shelf;

  const _ShelfSection({required this.shelf});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (shelf.eyebrow != null && shelf.eyebrow!.isNotEmpty)
            Text(
              shelf.eyebrow!.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
                color: theme.colorScheme.primary,
              ),
            ),
          Text(
            shelf.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 260,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: shelf.items.length,
              itemBuilder: (context, index) {
                final property = shelf.items[index];
                return PropertyCarouselCard(
                  property: property,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            PropertyDetailScreen(propertyId: property.id),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
