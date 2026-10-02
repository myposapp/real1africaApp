import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/property.dart';
import '../models/property_search_response.dart';
import '../network/provider/network_provider.dart';
import '../providers/estate_provider.dart';
import '../utils/property_format.dart';
import '../widgets/save_property_button.dart';
import '../widgets/search/filters_sheet.dart';
import '../widgets/search/search_filters.dart';
import '../widgets/search/search_panel.dart';
import 'property_detail_screen.dart';

class SearchListingsScreen extends StatefulWidget {
  const SearchListingsScreen({super.key});

  @override
  State<SearchListingsScreen> createState() => _SearchListingsScreenState();
}

class _SearchListingsScreenState extends State<SearchListingsScreen> {
  final SearchFilters _filters = SearchFilters();
  String? _pendingCategoryTitle;
  String? _sort; // null | 'price-low' | 'price-high'

  List<Property> _results = [];
  List<CategoryOption> _categoryOptions = [];
  List<LocationOption> _locationOptions = [];
  AmenityProfile? _amenityProfile;
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
    if (estateProvider.activeTab == 'sale' ||
        estateProvider.activeTab == 'rent') {
      _filters.purpose = estateProvider.activeTab;
    }
    _pendingCategoryTitle = estateProvider.selectedCategoryTitle;
    _search();
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

    try {
      final response = await networkRepo.searchPublicProperties(
        purpose: _filters.purpose,
        categories: _filters.category?.slug,
        title: _filters.trimmedKeywords,
        location: _filters.location?.slug,
        price: _filters.priceQuery,
        sort: _sort,
        page: page,
        pageSize: 20,
        amenityFilters: _filters.amenities.isEmpty
            ? null
            : Map<String, dynamic>.of(_filters.amenities),
      );

      if (!mounted) return;

      // Resolve a category passed in from Home (known only by title) into
      // the slug the search endpoint actually filters on.
      if (_pendingCategoryTitle != null && _filters.category == null) {
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
          _filters.category = match;
          await _search(page: 1);
          return;
        }
      }

      setState(() {
        _results = page == 1 ? response.data : [..._results, ...response.data];
        // A leaf category returns no children; keep the last useful list.
        if (response.categoryOptions.isNotEmpty || _filters.category == null) {
          _categoryOptions = response.categoryOptions;
        }
        if (response.locationOptions.isNotEmpty) {
          _locationOptions = response.locationOptions;
        }
        _amenityProfile = response.amenityProfile;
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

  Future<void> _openMoreOptions() async {
    final updated = await showFiltersSheet(
      context: context,
      filters: _filters,
      categoryOptions: _categoryOptions,
      amenityProfile: _amenityProfile,
    );
    if (updated == null || !mounted) return;

    setState(() {
      _filters
        ..category = updated.category
        ..minPrice = updated.minPrice
        ..maxPrice = updated.maxPrice
        ..keywords = updated.keywords
        ..amenities.clear()
        ..amenities.addAll(updated.amenities);
    });
    _search();
  }

  bool get _hasMore => _pageCount == null || _page < _pageCount!;

  bool get _showBedrooms =>
      _amenityProfile == null ||
      _amenityProfile!.fields.any((field) => field.name == 'bedrooms');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => _search(),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                sliver: SliverToBoxAdapter(
                  child: SearchPanel(
                    filters: _filters,
                    categoryOptions: _categoryOptions,
                    locationOptions: _locationOptions,
                    showBedrooms: _showBedrooms,
                    onChanged: () => setState(() {}),
                    onSearch: () => _search(),
                    onMoreOptions: _openMoreOptions,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 12, 8, 4),
                sliver: SliverToBoxAdapter(child: _buildResultsHeader(theme)),
              ),
              ..._buildResults(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultsHeader(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: Text(
            _isLoading || _error != null ? '' : 'Showing $_total Estates',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
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
    );
  }

  List<Widget> _buildResults(ThemeData theme) {
    if (_isLoading) {
      return const [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 48),
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
      ];
    }

    if (_error != null) {
      return [
        SliverToBoxAdapter(
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
        ),
      ];
    }

    if (_results.isEmpty) {
      return [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: Center(
              child: Text(
                'No properties match your filter.',
                style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
              ),
            ),
          ),
        ),
      ];
    }

    return [
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
        sliver: SliverList.builder(
          itemCount: _results.length,
          itemBuilder: (context, index) => _buildResultCard(theme, index),
        ),
      ),
      if (_hasMore)
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: _isLoadingMore
                  ? const CircularProgressIndicator()
                  : OutlinedButton(
                      onPressed: () => _search(page: _page + 1),
                      child: const Text('Load More'),
                    ),
            ),
          ),
        ),
    ];
  }

  Widget _buildResultCard(ThemeData theme, int index) {
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
  }
}
