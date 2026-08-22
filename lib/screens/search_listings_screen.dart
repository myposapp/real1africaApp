import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/estate_provider.dart';
import 'property_detail_screen.dart';

class SearchListingsScreen extends StatelessWidget {
  const SearchListingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final estateProvider = context.watch<EstateProvider>();
    final properties = estateProvider.filteredProperties;
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Input Box
              TextField(
                onChanged: (q) => estateProvider.setSearchQuery(q),
                decoration: InputDecoration(
                  hintText: 'Search properties or locations...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: estateProvider.searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => estateProvider.setSearchQuery(''),
                        )
                      : null,
                  filled: true,
                  fillColor: theme.colorScheme.surfaceContainerLowest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Filter Chips Row (Type & City)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...['Rent', 'Sales', 'Lease'].map((type) {
                      final isSelected = estateProvider.activeTab == type;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FilterChip(
                          label: Text(type),
                          selected: isSelected,
                          onSelected: (_) => estateProvider.setActiveTab(type),
                        ),
                      );
                    }),
                    const VerticalDivider(),
                    ...['All', 'Los Angeles', 'Malibu', 'Pasadena'].map((city) {
                      final isSelected = estateProvider.selectedCity == city;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FilterChip(
                          label: Text(city),
                          selected: isSelected,
                          onSelected: (_) =>
                              estateProvider.setSelectedCity(city),
                        ),
                      );
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Result Count
              Text(
                'Showing ${properties.length} Estates',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 12),

              // Properties List View
              Expanded(
                child: properties.isEmpty
                    ? Center(
                        child: Text(
                          'No properties match your filter.',
                          style: TextStyle(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: properties.length,
                        itemBuilder: (context, index) {
                          final prop = properties[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: InkWell(
                              onTap: () {
                                estateProvider.setSelectedProperty(prop);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        PropertyDetailScreen(property: prop),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        prop.image,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            prop.title,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            prop.location,
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: theme
                                                  .colorScheme
                                                  .onSurfaceVariant,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            '\$${prop.price.toInt()}${prop.priceUnit}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w900,
                                              color: theme.colorScheme.primary,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '${prop.beds} Bed • ${prop.baths} Bath • ${prop.sqft} sqft',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: theme
                                                  .colorScheme
                                                  .onSurfaceVariant,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        prop.isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Colors.red,
                                      ),
                                      onPressed: () => estateProvider
                                          .toggleFavorite(prop.id),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
