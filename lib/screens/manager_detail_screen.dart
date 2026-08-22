import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../providers/estate_provider.dart';
import 'property_detail_screen.dart';

class ManagerDetailScreen extends StatelessWidget {
  final EstateManager manager;

  const ManagerDetailScreen({super.key, required this.manager});

  @override
  Widget build(BuildContext context) {
    final estateProvider = context.watch<EstateProvider>();
    final theme = Theme.of(context);

    final managerProperties = estateProvider.properties
        .where((p) => p.managerId == manager.id || p.managerName == manager.companyName)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(manager.companyName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Manager Profile Card
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 44,
                    backgroundImage: NetworkImage(manager.avatar),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    manager.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    manager.companyName,
                    style: TextStyle(fontSize: 13, color: theme.colorScheme.primary, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text('${manager.rating} • ${manager.listingsCount} Listings',
                          style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Text(
              manager.description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: theme.colorScheme.onSurfaceVariant, height: 1.4),
            ),

            const SizedBox(height: 20),

            // Specialties
            const Text('Specialties', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: manager.specialties
                  .map((s) => Chip(
                        label: Text(s, style: const TextStyle(fontSize: 11)),
                      ))
                  .toList(),
            ),

            const SizedBox(height: 24),

            // Listings by Manager
            Text(
              'Listings by ${manager.companyName}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),

            ...managerProperties.map((prop) {
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(prop.image, width: 60, height: 60, fit: BoxFit.cover),
                  ),
                  title: Text(prop.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  subtitle: Text('\$${prop.price.toInt()}${prop.priceUnit} • ${prop.location}', style: const TextStyle(fontSize: 11)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    estateProvider.setSelectedProperty(prop);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => PropertyDetailScreen(property: prop)),
                    );
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
