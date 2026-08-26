import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/analytics.dart';
import '../../network/provider/network_provider.dart';
import '../../providers/estate_provider.dart';
import '../add_property_dialog.dart';

class DashboardTab extends StatefulWidget {
  final Color primaryRed;
  final VoidCallback onViewProperties;
  final VoidCallback onViewSaved;
  final VoidCallback onPropertiesChanged;

  const DashboardTab({
    super.key,
    required this.primaryRed,
    required this.onViewProperties,
    required this.onViewSaved,
    required this.onPropertiesChanged,
  });

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
  Analytics? _analytics;
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
      final response = await networkRepo.getAnalytics();
      if (!mounted) return;
      setState(() {
        _analytics = response.data;
        _isLoading = false;
        if (response.success != true) {
          _error = response.message ?? 'Could not load dashboard metrics.';
        }
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _error = 'Could not load dashboard metrics.';
      });
    }
  }

  Future<void> _openAddPropertyDialog() async {
    final created = await showDialog<bool>(
      context: context,
      builder: (_) => const AddPropertyDialog(),
    );
    if (created == true) {
      widget.onPropertiesChanged();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<EstateProvider>();

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: _load,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_error != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  _error!,
                  style: TextStyle(
                    color: theme.colorScheme.onErrorContainer,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Metrics Grid
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.45,
              children: [
                _MetricTile(
                  title: 'My properties',
                  subtitle: 'Properties you added',
                  count: '${_analytics?.totalProperties ?? 0}',
                  icon: Icons.home,
                  iconColor: widget.primaryRed,
                  onTap: widget.onViewProperties,
                ),
                _MetricTile(
                  title: 'Saved properties',
                  subtitle: 'Listings saved for later',
                  count: '${_analytics?.savedProperties ?? 0}',
                  icon: Icons.bookmark,
                  iconColor: Colors.amber.shade700,
                  onTap: widget.onViewSaved,
                ),
                _MetricTile(
                  title: 'Scheduled Viewings',
                  subtitle: 'Upcoming tours',
                  count: '${provider.viewings.length}',
                  icon: Icons.calendar_month,
                  iconColor: Colors.blue.shade700,
                ),
                _MetricTile(
                  title: 'Inquiries',
                  subtitle: 'Direct messages',
                  count: '3',
                  icon: Icons.chat_bubble_outline,
                  iconColor: Colors.teal.shade700,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Scheduled Viewings Card (mock; no viewings endpoint yet)
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
                                        color:
                                            theme.colorScheme.onSurfaceVariant,
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
                    onPressed: _openAddPropertyDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: widget.primaryRed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      '+ Post Listing',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
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

class _MetricTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String count;
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onTap;

  const _MetricTile({
    required this.title,
    required this.subtitle,
    required this.count,
    required this.icon,
    required this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
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
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
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
}
