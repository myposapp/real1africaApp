import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/models.dart';
import '../../providers/estate_provider.dart';

class SubscriptionTab extends StatelessWidget {
  final Color primaryRed;

  const SubscriptionTab({super.key, required this.primaryRed});

  void _showSnackBar(BuildContext context, String msg) {
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
    final theme = Theme.of(context);
    final provider = context.watch<EstateProvider>();

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

          _PlanCard(
            title: 'Starter Plan',
            price: '₦0',
            period: '/mo',
            features: const [
              'Up to 3 listings',
              'Standard search listing',
              'Basic inquiries inbox',
            ],
            isCurrent: provider.activePlan == null,
            primaryRed: primaryRed,
            onSelect: () => _showSnackBar(context, 'Selected Starter Plan'),
          ),
          const SizedBox(height: 12),

          _PlanCard(
            title: 'Pro Manager',
            price: '₦15,000',
            period: '/mo',
            badge: 'Popular',
            features: const [
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
                  features: const ['Up to 15 listings'],
                ),
              );
              _showSnackBar(context, 'Subscribed to Pro Manager!');
            },
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final String title;
  final String price;
  final String period;
  final String? badge;
  final List<String> features;
  final bool isCurrent;
  final Color primaryRed;
  final VoidCallback onSelect;

  const _PlanCard({
    required this.title,
    required this.price,
    required this.period,
    this.badge,
    required this.features,
    required this.isCurrent,
    required this.primaryRed,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
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
                      badge!,
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
}
