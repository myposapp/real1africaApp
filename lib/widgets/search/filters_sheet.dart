import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/property_search_response.dart';
import '../../network/provider/network_provider.dart';
import 'option_picker_sheet.dart';
import 'search_filters.dart';
import 'search_panel.dart';

/// "More search options" sheet. Edits a copy of [filters] and returns it on
/// apply, or null when dismissed.
Future<SearchFilters?> showFiltersSheet({
  required BuildContext context,
  required SearchFilters filters,
  required List<CategoryOption> categoryOptions,
  required AmenityProfile? amenityProfile,
}) {
  return showModalBottomSheet<SearchFilters>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    useSafeArea: true,
    builder: (_) => _FiltersSheet(
      filters: filters.copy(),
      categoryOptions: categoryOptions,
      amenityProfile: amenityProfile,
    ),
  );
}

class _FiltersSheet extends StatefulWidget {
  const _FiltersSheet({
    required this.filters,
    required this.categoryOptions,
    required this.amenityProfile,
  });

  final SearchFilters filters;
  final List<CategoryOption> categoryOptions;
  final AmenityProfile? amenityProfile;

  @override
  State<_FiltersSheet> createState() => _FiltersSheetState();
}

class _FiltersSheetState extends State<_FiltersSheet> {
  late final SearchFilters _filters = widget.filters;
  late List<CategoryOption> _categoryOptions = widget.categoryOptions;
  late AmenityProfile? _profile = widget.amenityProfile;
  late final TextEditingController _keywordsController = TextEditingController(
    text: _filters.keywords ?? '',
  );
  bool _isLoadingProfile = false;

  @override
  void dispose() {
    _keywordsController.dispose();
    super.dispose();
  }

  /// The amenity fields depend on the category, so re-ask the search
  /// endpoint for the new category's profile.
  Future<void> _reloadProfile() async {
    setState(() => _isLoadingProfile = true);
    try {
      final response = await context
          .read<NetworkProvider>()
          .networkRepo
          .searchPublicProperties(
            purpose: _filters.purpose,
            categories: _filters.category?.slug,
            pageSize: 1,
          );
      if (!mounted) return;
      setState(() {
        _profile = response.amenityProfile;
        if (response.categoryOptions.isNotEmpty) {
          _categoryOptions = response.categoryOptions;
        }
      });
    } catch (_) {
      // Keep the previous profile; the main search still validates filters.
    } finally {
      if (mounted) setState(() => _isLoadingProfile = false);
    }
  }

  void _reset() {
    final hadCategory = _filters.category != null;
    setState(() {
      _filters
        ..category = null
        ..minPrice = null
        ..maxPrice = null
        ..keywords = null
        ..amenities.clear();
      _keywordsController.clear();
    });
    if (hadCategory) _reloadProfile();
  }

  void _apply() {
    _filters.keywords = _keywordsController.text.trim().isEmpty
        ? null
        : _keywordsController.text.trim();
    Navigator.pop(context, _filters);
  }

  List<AmenityField> get _extraFields {
    final fields = _profile?.fields ?? const <AmenityField>[];
    return fields.where((field) {
      if (field.name == 'bedrooms') return false;
      if (field.type == 'select') return field.options.isNotEmpty;
      if (field.type == 'boolean') return true;
      return field.type == 'number' && countAmenityFields.contains(field.name);
    }).toList();
  }

  bool get _hasBedrooms =>
      _profile == null || _profile!.fields.any((f) => f.name == 'bedrooms');

  List<PickerOption<String>> _optionsFor(AmenityField field) {
    switch (field.type) {
      case 'boolean':
        return const [
          PickerOption(null, 'Any'),
          PickerOption('true', 'Yes'),
          PickerOption('false', 'No'),
        ];
      case 'number':
        return [
          const PickerOption(null, 'Any'),
          ...countAmenityValues.map((v) => PickerOption(v, v)),
        ];
      default:
        return [
          const PickerOption(null, 'Any'),
          ...field.options.map((o) => PickerOption(o, o)),
        ];
    }
  }

  String _valueLabel(AmenityField field) {
    final value = _filters.amenities[field.name];
    if (value == null) return 'Any';
    if (field.type == 'boolean') return value == 'true' ? 'Yes' : 'No';
    return value;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 8, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Filters',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Refine your search',
                          style: TextStyle(
                            fontSize: 12,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _SheetRow(
                    label: 'Type',
                    value: _filters.category?.title ?? 'Any type',
                    isSet: _filters.category != null,
                    onTap: () async {
                      final changed = await pickCategory(
                        context,
                        _filters,
                        _categoryOptions,
                      );
                      if (changed) {
                        setState(() {});
                        _reloadProfile();
                      }
                    },
                  ),
                  _SheetRow(
                    label: 'Price range',
                    value: _filters.priceLabel,
                    isSet: _filters.priceQuery != null,
                    onTap: () async {
                      if (await pickPriceRange(context, _filters)) {
                        setState(() {});
                      }
                    },
                  ),
                  if (_isLoadingProfile)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    )
                  else ...[
                    if (_hasBedrooms)
                      _SheetRow(
                        label: 'Bedrooms',
                        value: _filters.bedroomsLabel,
                        isSet: _filters.bedrooms != null,
                        onTap: () async {
                          final changed = await pickAmenity(
                            context,
                            _filters,
                            name: 'bedrooms',
                            title: 'Bedrooms',
                            options: bedroomPickerOptions(),
                          );
                          if (changed) setState(() {});
                        },
                      ),
                    ..._extraFields.map(
                      (field) => _SheetRow(
                        label: field.label.trim(),
                        value: _valueLabel(field),
                        isSet: _filters.amenities.containsKey(field.name),
                        onTap: () async {
                          final changed = await pickAmenity(
                            context,
                            _filters,
                            name: field.name,
                            title: field.label.trim(),
                            options: _optionsFor(field),
                          );
                          if (changed) setState(() {});
                        },
                      ),
                    ),
                  ],
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: Text(
                            'Keywords',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: _keywordsController,
                            textAlign: TextAlign.end,
                            textInputAction: TextInputAction.search,
                            onSubmitted: (_) => _apply(),
                            decoration: InputDecoration(
                              hintText: 'e.g. pool, BQ, gym',
                              hintStyle: TextStyle(
                                color: theme.colorScheme.onSurfaceVariant
                                    .withValues(alpha: 0.6),
                              ),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                child: Row(
                  children: [
                    TextButton(onPressed: _reset, child: const Text('Reset')),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: _apply,
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Show results',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SheetRow extends StatelessWidget {
  const _SheetRow({
    required this.label,
    required this.value,
    required this.isSet,
    required this.onTap,
  });

  final String label;
  final String value;
  final bool isSet;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: theme.colorScheme.outlineVariant),
          ),
        ),
        child: Row(
          children: [
            Expanded(child: Text(label, style: const TextStyle(fontSize: 14))),
            Flexible(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSet ? FontWeight.w600 : FontWeight.normal,
                  color: isSet
                      ? theme.colorScheme.onSurface
                      : theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 20,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
