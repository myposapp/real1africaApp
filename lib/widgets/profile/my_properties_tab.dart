import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/property.dart';
import '../../network/provider/network_provider.dart';
import '../add_property_dialog.dart';
import '../confirmation_dialog.dart';

class MyPropertiesTab extends StatefulWidget {
  final Color primaryRed;
  final VoidCallback onChanged;

  const MyPropertiesTab({
    super.key,
    required this.primaryRed,
    required this.onChanged,
  });

  @override
  State<MyPropertiesTab> createState() => _MyPropertiesTabState();
}

class _MyPropertiesTabState extends State<MyPropertiesTab> {
  List<Property> _properties = [];
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
      final response = await networkRepo.getManagedProperties(pageSize: 100);
      if (!mounted) return;
      setState(() {
        _properties = response.data ?? [];
        _isLoading = false;
        if (response.success != true) {
          _error = response.message ?? 'Could not load your properties.';
        }
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _error = 'Could not load your properties.';
      });
    }
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _openAddPropertyDialog() async {
    final created = await showDialog<bool>(
      context: context,
      builder: (_) => const AddPropertyDialog(),
    );
    if (created == true) {
      widget.onChanged();
    }
  }

  Future<void> _deleteProperty(Property property) async {
    final networkRepo = context.read<NetworkProvider>().networkRepo;
    try {
      final response = await networkRepo.deleteProperty(property.id);
      if (!mounted) return;
      if (response.success != true) {
        _showSnackBar(response.message ?? 'Could not delete property.');
        return;
      }
      _showSnackBar('Property deleted.');
      widget.onChanged();
    } catch (_) {
      if (!mounted) return;
      _showSnackBar('Could not delete property. Check your connection.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: _load,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Properties (${_properties.length})',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _openAddPropertyDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text(
                    'Add Property',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            if (_isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (_error != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  _error!,
                  style: TextStyle(color: theme.colorScheme.error, fontSize: 12),
                ),
              )
            else if (_properties.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _properties.length,
                itemBuilder: (context, idx) {
                  final prop = _properties[idx];
                  final imageUrl = prop.media.isNotEmpty
                      ? prop.media.first.fullUrl
                      : null;
                  final categoryLabel = prop.categories.isNotEmpty
                      ? prop.categories.map((c) => c.title).join(', ')
                      : 'Uncategorized';

                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: imageUrl != null
                                ? Image.network(
                                    imageUrl,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, _, _) => Container(
                                      width: 60,
                                      height: 60,
                                      color: Colors.grey.shade300,
                                      child: const Icon(Icons.home),
                                    ),
                                  )
                                : Container(
                                    width: 60,
                                    height: 60,
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
                                  categoryLabel,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  prop.title,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                  maxLines: 1,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    _Badge(text: prop.status, color: Colors.green),
                                    const SizedBox(width: 4),
                                    _Badge(text: prop.visibility, color: Colors.blue),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                              size: 20,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => ConfirmationDialog(
                                  title: 'Delete Property?',
                                  message:
                                      'Are you sure you want to permanently remove this property listing?',
                                  isDestructive: true,
                                  confirmText: 'Delete',
                                  onCancel: () => Navigator.pop(context),
                                  onConfirm: () {
                                    Navigator.pop(context);
                                    _deleteProperty(prop);
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            else
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text('No properties listed yet.'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  final Color color;

  const _Badge({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    final label = text.isNotEmpty
        ? '${text[0].toUpperCase()}${text.substring(1)}'
        : text;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.bold),
      ),
    );
  }
}
