import 'package:flutter/material.dart';
import '../../models/property_search_response.dart';
import 'option_picker_sheet.dart';
import 'search_filters.dart';

/// Shared pickers used by both [SearchPanel] and the filters sheet. Each
/// returns true when [filters] was changed.
Future<bool> pickCategory(
  BuildContext context,
  SearchFilters filters,
  List<CategoryOption> categoryOptions,
) async {
  final current = filters.category;
  final result = await showOptionPicker<CategoryOption>(
    context: context,
    title: 'Property type',
    selected: current,
    options: [
      const PickerOption(null, 'Any type'),
      if (current != null && !categoryOptions.contains(current))
        PickerOption(current, current.title),
      ...categoryOptions.map((o) => PickerOption(o, o.title)),
    ],
  );
  if (result == null || result.value == current) return false;
  filters.category = result.value;
  // Amenity fields differ per category, so stale ones would filter wrongly.
  filters.amenities.clear();
  return true;
}

Future<bool> pickLocation(
  BuildContext context,
  SearchFilters filters,
  List<LocationOption> locationOptions,
) async {
  final current = filters.location;
  final result = await showOptionPicker<LocationOption>(
    context: context,
    title: 'Location',
    selected: current,
    searchable: true,
    searchHint: 'Search state, locality or area',
    options: [
      const PickerOption(null, 'Anywhere'),
      if (current != null && !locationOptions.contains(current))
        PickerOption(current, current.label),
      ...locationOptions.map((o) => PickerOption(o, o.label)),
    ],
  );
  if (result == null || result.value == current) return false;
  filters.location = result.value;
  return true;
}

Future<bool> pickPriceRange(BuildContext context, SearchFilters filters) async {
  final result = await showPriceRangeSheet(
    context: context,
    minPrice: filters.minPrice,
    maxPrice: filters.maxPrice,
  );
  if (result == null) return false;
  filters.minPrice = result.$1;
  filters.maxPrice = result.$2;
  return true;
}

Future<bool> pickAmenity(
  BuildContext context,
  SearchFilters filters, {
  required String name,
  required String title,
  required List<PickerOption<String>> options,
}) async {
  final current = filters.amenities[name];
  final result = await showOptionPicker<String>(
    context: context,
    title: title,
    selected: current,
    options: options,
  );
  if (result == null || result.value == current) return false;
  if (result.value == null) {
    filters.amenities.remove(name);
  } else {
    filters.amenities[name] = result.value!;
  }
  return true;
}

List<PickerOption<String>> bedroomPickerOptions() => [
  const PickerOption(null, 'Any beds'),
  ...countAmenityValues.map((v) => PickerOption(v, bedroomLabel(v)!)),
];

/// The Buy/Rent search card at the top of Explore.
class SearchPanel extends StatelessWidget {
  const SearchPanel({
    super.key,
    required this.filters,
    required this.categoryOptions,
    required this.locationOptions,
    required this.showBedrooms,
    required this.onChanged,
    required this.onSearch,
    required this.onMoreOptions,
  });

  final SearchFilters filters;
  final List<CategoryOption> categoryOptions;
  final List<LocationOption> locationOptions;
  final bool showBedrooms;
  final VoidCallback onChanged;
  final VoidCallback onSearch;
  final VoidCallback onMoreOptions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final extraCount = filters.extraFilterCount;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              _PurposeTab(
                icon: Icons.sell_outlined,
                label: 'Buy',
                selected: filters.purpose == 'sale',
                onTap: () => _setPurpose('sale'),
              ),
              const SizedBox(width: 8),
              _PurposeTab(
                icon: Icons.key_outlined,
                label: 'Rent',
                selected: filters.purpose == 'rent',
                onTap: () => _setPurpose('rent'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _FieldRow(
            label: 'LOCATION',
            value: filters.location?.label,
            placeholder: 'state, locality or area',
            showChevron: false,
            onTap: () async {
              if (await pickLocation(context, filters, locationOptions)) {
                onChanged();
              }
            },
          ),
          _FieldRow(
            label: 'PROPERTY TYPE',
            value: filters.category?.title ?? 'Any type',
            onTap: () async {
              if (await pickCategory(context, filters, categoryOptions)) {
                onChanged();
              }
            },
          ),
          _FieldRow(
            label: 'PRICE RANGE',
            value: filters.priceLabel,
            onTap: () async {
              if (await pickPriceRange(context, filters)) onChanged();
            },
          ),
          if (showBedrooms)
            _FieldRow(
              label: 'BEDROOMS',
              value: filters.bedroomsLabel,
              onTap: () async {
                final changed = await pickAmenity(
                  context,
                  filters,
                  name: 'bedrooms',
                  title: 'Bedrooms',
                  options: bedroomPickerOptions(),
                );
                if (changed) onChanged();
              },
            ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: onSearch,
            icon: const Icon(Icons.search, size: 20),
            label: const Text(
              'Search',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: onMoreOptions,
              icon: const Icon(Icons.filter_alt_outlined, size: 18),
              label: Text(
                extraCount > 0
                    ? 'More search options ($extraCount)'
                    : 'More search options',
              ),
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.onSurface,
                padding: const EdgeInsets.symmetric(horizontal: 4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _setPurpose(String purpose) {
    if (filters.purpose == purpose) return;
    filters.purpose = purpose;
    onChanged();
  }
}

class _PurposeTab extends StatelessWidget {
  const _PurposeTab({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = selected
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurfaceVariant;

    return Material(
      color: selected
          ? theme.colorScheme.primaryContainer.withValues(alpha: 0.6)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FieldRow extends StatelessWidget {
  const _FieldRow({
    required this.label,
    required this.value,
    required this.onTap,
    this.placeholder,
    this.showChevron = true,
  });

  final String label;
  final String? value;
  final String? placeholder;
  final bool showChevron;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: theme.colorScheme.outlineVariant),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 11,
                      letterSpacing: 0.6,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value ?? placeholder ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: value != null
                          ? FontWeight.w600
                          : FontWeight.normal,
                      color: value != null
                          ? theme.colorScheme.onSurface
                          : theme.colorScheme.onSurfaceVariant.withValues(
                              alpha: 0.7,
                            ),
                    ),
                  ),
                ],
              ),
            ),
            if (showChevron)
              const Icon(Icons.keyboard_arrow_down_rounded, size: 22),
          ],
        ),
      ),
    );
  }
}
