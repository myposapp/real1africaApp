import 'package:flutter/material.dart';

class PickerOption<T> {
  const PickerOption(this.value, this.label);

  /// null represents the "Any ..." choice.
  final T? value;
  final String label;
}

/// Wraps the picked value so "picked Any (null)" differs from "dismissed".
class PickResult<T> {
  const PickResult(this.value);

  final T? value;
}

Future<PickResult<T>?> showOptionPicker<T>({
  required BuildContext context,
  required String title,
  required List<PickerOption<T>> options,
  T? selected,
  bool searchable = false,
  String searchHint = 'Search',
}) {
  return showModalBottomSheet<PickResult<T>>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    useSafeArea: true,
    builder: (_) => _OptionPickerSheet<T>(
      title: title,
      options: options,
      selected: selected,
      searchable: searchable,
      searchHint: searchHint,
    ),
  );
}

class _OptionPickerSheet<T> extends StatefulWidget {
  const _OptionPickerSheet({
    super.key,
    required this.title,
    required this.options,
    required this.selected,
    required this.searchable,
    required this.searchHint,
  });

  final String title;
  final List<PickerOption<T>> options;
  final T? selected;
  final bool searchable;
  final String searchHint;

  @override
  State<_OptionPickerSheet<T>> createState() => _OptionPickerSheetState<T>();
}

class _OptionPickerSheetState<T> extends State<_OptionPickerSheet<T>> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final query = _query.trim().toLowerCase();
    final visible = query.isEmpty
        ? widget.options
        : widget.options
              .where((o) => o.label.toLowerCase().contains(query))
              .toList();

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75,
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
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (widget.searchable)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
                child: TextField(
                  autofocus: false,
                  onChanged: (value) => setState(() => _query = value),
                  decoration: InputDecoration(
                    hintText: widget.searchHint,
                    prefixIcon: const Icon(Icons.search),
                    isDense: true,
                    filled: true,
                    fillColor: theme.colorScheme.surfaceContainerHighest
                        .withValues(alpha: 0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            Flexible(
              child: visible.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        'No matches.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(bottom: 16),
                      itemCount: visible.length,
                      itemBuilder: (context, index) {
                        final option = visible[index];
                        final isSelected = option.value == widget.selected;
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          title: Text(
                            option.label,
                            style: TextStyle(
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isSelected
                                  ? theme.colorScheme.primary
                                  : null,
                            ),
                          ),
                          trailing: isSelected
                              ? Icon(
                                  Icons.check_rounded,
                                  color: theme.colorScheme.primary,
                                )
                              : null,
                          onTap: () => Navigator.pop(
                            context,
                            PickResult<T>(option.value),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Lets the user type a min/max price. Returns null when dismissed, and
/// `(null, null)` for "Any price".
Future<(int?, int?)?> showPriceRangeSheet({
  required BuildContext context,
  int? minPrice,
  int? maxPrice,
}) {
  return showModalBottomSheet<(int?, int?)>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    useSafeArea: true,
    builder: (_) => _PriceRangeSheet(minPrice: minPrice, maxPrice: maxPrice),
  );
}

class _PriceRangeSheet extends StatefulWidget {
  const _PriceRangeSheet({this.minPrice, this.maxPrice});

  final int? minPrice;
  final int? maxPrice;

  @override
  State<_PriceRangeSheet> createState() => _PriceRangeSheetState();
}

class _PriceRangeSheetState extends State<_PriceRangeSheet> {
  late final TextEditingController _minController = TextEditingController(
    text: widget.minPrice?.toString() ?? '',
  );
  late final TextEditingController _maxController = TextEditingController(
    text: widget.maxPrice?.toString() ?? '',
  );
  String? _error;

  @override
  void dispose() {
    _minController.dispose();
    _maxController.dispose();
    super.dispose();
  }

  void _apply() {
    final min = int.tryParse(_minController.text.trim());
    final max = int.tryParse(_maxController.text.trim());
    if (min != null && max != null && min > max) {
      setState(() => _error = 'Minimum price cannot exceed maximum price.');
      return;
    }
    Navigator.pop(context, (min, max));
  }

  InputDecoration _decoration(String label) => InputDecoration(
    labelText: label,
    prefixText: '₦ ',
    isDense: true,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        0,
        20,
        20 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Price range',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _minController,
                  keyboardType: TextInputType.number,
                  decoration: _decoration('Min price'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _maxController,
                  keyboardType: TextInputType.number,
                  decoration: _decoration('Max price'),
                ),
              ),
            ],
          ),
          if (_error != null) ...[
            const SizedBox(height: 8),
            Text(
              _error!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 12,
              ),
            ),
          ],
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context, (null, null)),
                  child: const Text('Any price'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: _apply,
                  child: const Text('Apply'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
