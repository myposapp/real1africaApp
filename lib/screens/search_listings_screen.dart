import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/property.dart';
import '../models/property_search_response.dart';
import '../network/provider/network_provider.dart';
import '../providers/estate_provider.dart';
import '../utils/property_format.dart';
import '../widgets/save_property_button.dart';
import 'property_detail_screen.dart';

class SearchListingsScreen extends StatefulWidget {
  const SearchListingsScreen({super.key});

  @override
  State<SearchListingsScreen> createState() => _SearchListingsScreenState();
}

class _SearchListingsScreenState extends State<SearchListingsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();
  Timer? _debounce;

  String? _purpose; // null (All) | 'sale' | 'rent'
  String? _categorySlug;
  String? _categoryLabel;
  String? _pendingCategoryTitle;
  String? _locationSlug;
  String? _sort; // null | 'price-low' | 'price-high'

  List<Property> _results = [];
  List<CategoryOption> _categoryOptions = [];
  List<LocationOption> _locationOptions = [];
  int _page = 1;
  int? _pageCount;
  int _total = 0;
  bool _isLoading = true;
  bool _isLoadingMore = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final estateProvider = context.read<EstateProvider>();
    if (estateProvider.activeTab == 'sale' || estateProvider.activeTab == 'rent') {
      _purpose = estateProvider.activeTab;
    }
    _pendingCategoryTitle = estateProvider.selectedCategoryTitle;
    _search();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 450), () => _search());
  }

  Future<void> _search({int page = 1}) async {
    final networkRepo = context.read<NetworkProvider>().networkRepo;

    setState(() {
      if (page == 1) {
        _isLoading = true;
        _error = null;
      } else {
        _isLoadingMore = true;
      }
    });

    String? priceQuery;
    final min = _minPriceController.text.trim();
    final max = _maxPriceController.text.trim();
    if (min.isNotEmpty || max.isNotEmpty) {
      priceQuery = '$min-$max';
    }

    try {
      final response = await networkRepo.searchPublicProperties(
        purpose: _purpose,
        categories: _categorySlug,
        title: _searchController.text.trim().isEmpty
            ? null
            : _searchController.text.trim(),
        location: _locationSlug,
        price: priceQuery,
        sort: _sort,
        page: page,
        pageSize: 20,
      );

      if (!mounted) return;

      // Resolve a category passed in from Home (known only by title) into
      // the slug the search endpoint actually filters on.
      if (_pendingCategoryTitle != null && _categorySlug == null) {
        final pendingTitle = _pendingCategoryTitle!;
        _pendingCategoryTitle = null;
        CategoryOption? match;
        for (final option in response.categoryOptions) {
          if (option.title.toLowerCase() == pendingTitle.toLowerCase()) {
            match = option;
            break;
          }
        }
        if (match != null) {
          _categorySlug = match.slug;
          _categoryLabel = match.title;
          await _search(page: 1);
          return;
        }
      }

      setState(() {
        _results = page == 1 ? response.data : [..._results, ...response.data];
        _categoryOptions = response.categoryOptions;
        _locationOptions = response.locationOptions;
        _page = page;
        _pageCount = response.metadata?.pageCount;
        _total = response.metadata?.total ?? response.data.length;
        _isLoading = false;
        _isLoadingMore = false;
        if (response.success != true) {
          _error = response.message ?? 'Could not load properties.';
        }
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _isLoadingMore = false;
        if (page == 1) {
          _error = 'Could not load properties. Check your connection.';
        }
      });
    }
  }

  bool get _hasMore => _pageCount == null || _page < _pageCount!;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _searchController,
                onChanged: _onSearchTextChanged,
                decoration: InputDecoration(
                  hintText: 'Search properties or locations...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            _search();
                          },
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

              const SizedBox(height: 12),

              // Purpose filter
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...[
                      (null, 'All'),
                      ('sale', 'For Sale'),
                      ('rent', 'For Rent'),
                    ].map((entry) {
                      final isSelected = _purpose == entry.$1;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FilterChip(
                          label: Text(entry.$2),
                          selected: isSelected,
                          onSelected: (_) {
                            setState(() => _purpose = entry.$1);
                            _search();
                          },
                        ),
                      );
                    }),
                    if (_categoryOptions.isNotEmpty) ...[
                      const VerticalDivider(),
                      FilterChip(
                        label: const Text('All Categories'),
                        selected: _categorySlug == null,
                        onSelected: (_) {
                          setState(() {
                            _categorySlug = null;
                            _categoryLabel = null;
                          });
                          _search();
                        },
                      ),
                      const SizedBox(width: 8),
                      ..._categoryOptions.map((option) {
                        final isSelected = _categorySlug == option.slug;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: FilterChip(
                            label: Text(option.title),
                            selected: isSelected,
                            onSelected: (_) {
                              setState(() {
                                _categorySlug = isSelected ? null : option.slug;
                                _categoryLabel = isSelected ? null : option.title;
                              });
                              _search();
                            },
                          ),
                        );
                      }),
                    ] else if (_categoryLabel != null) ...[
                      const VerticalDivider(),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FilterChip(
                          label: Text(_categoryLabel!),
                          selected: true,
                          onSelected: (_) {
                            setState(() {
                              _categorySlug = null;
                              _categoryLabel = null;
                            });
                            _search();
                          },
                        ),
                      ),
                    ],
                    if (_locationOptions.isNotEmpty) ...[
                      const VerticalDivider(),
                      ..._locationOptions.take(8).map((option) {
                        final isSelected = _locationSlug == option.slug;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: FilterChip(
                            label: Text(option.label),
                            selected: isSelected,
                            onSelected: (_) {
                              setState(() {
                                _locationSlug = isSelected ? null : option.slug;
                              });
                              _search();
                            },
                          ),
                        );
                      }),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Price range + sort
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _minPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Min price',
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _maxPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Max price',
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filledTonal(
                    tooltip: 'Apply price filter',
                    onPressed: () => _search(),
                    icon: const Icon(Icons.check, size: 18),
                  ),
                  const SizedBox(width: 4),
                  PopupMenuButton<String?>(
                    tooltip: 'Sort',
                    icon: const Icon(Icons.sort),
                    onSelected: (value) {
                      setState(() => _sort = value);
                      _search();
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(value: null, child: Text('Default')),
                      PopupMenuItem(
                        value: 'price-low',
                        child: Text('Price: Low to High'),
                      ),
                      PopupMenuItem(
                        value: 'price-high',
                        child: Text('Price: High to Low'),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 12),

              if (!_isLoading && _error == null)
                Text(
                  'Showing $_total Estates',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),

              const SizedBox(height: 12),

              Expanded(child: _buildResults(theme)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResults(ThemeData theme) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
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
                onPressed: () => _search(),
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_results.isEmpty) {
      return Center(
        child: Text(
          'No properties match your filter.',
          style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => _search(),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: _results.length + 1,
        itemBuilder: (context, index) {
          if (index == _results.length) {
            if (!_hasMore) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: _isLoadingMore
                    ? const CircularProgressIndicator()
                    : OutlinedButton(
                        onPressed: () => _search(page: _page + 1),
                        child: const Text('Load More'),
                      ),
              ),
            );
          }

          final prop = _results[index];
          final imageUrl = prop.media.isNotEmpty ? prop.media.first.fullUrl : null;
          final categoryLabel = prop.categories.isNotEmpty
              ? prop.categories.map((c) => c.title).join(', ')
              : 'Uncategorized';

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PropertyDetailScreen(propertyId: prop.id),
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
                      child: imageUrl != null
                          ? Image.network(
                              imageUrl,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) => Container(
                                width: 100,
                                height: 100,
                                color: Colors.grey.shade300,
                                child: const Icon(Icons.home),
                              ),
                            )
                          : Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey.shade300,
                              child: const Icon(Icons.home),
                            ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            categoryLabel,
                            style: TextStyle(
                              fontSize: 11,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            propertyCityStateLabel(prop),
                            style: TextStyle(
                              fontSize: 11,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            propertyPriceLabel(prop),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SavePropertyButton(
                      propertyId: prop.id,
                      backgroundColor: Colors.transparent,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
