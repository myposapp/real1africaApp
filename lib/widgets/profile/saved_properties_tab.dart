import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/saved_property.dart';
import '../../network/provider/network_provider.dart';

class SavedPropertiesTab extends StatefulWidget {
  final Color primaryRed;
  final VoidCallback onChanged;

  const SavedPropertiesTab({
    super.key,
    required this.primaryRed,
    required this.onChanged,
  });

  @override
  State<SavedPropertiesTab> createState() => _SavedPropertiesTabState();
}

class _SavedPropertiesTabState extends State<SavedPropertiesTab> {
  List<SavedProperty> _saved = [];
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
      final response = await networkRepo.getSavedProperties(pageSize: 100);
      if (!mounted) return;
      setState(() {
        _saved = response.data ?? [];
        _isLoading = false;
        if (response.success != true) {
          _error = response.message ?? 'Could not load saved properties.';
        }
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _error = 'Could not load saved properties.';
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

  Future<void> _unsave(SavedProperty saved) async {
    final networkRepo = context.read<NetworkProvider>().networkRepo;
    try {
      final response = await networkRepo.unsaveProperty(saved.id);
      if (!mounted) return;
      if (response.success != true) {
        _showSnackBar(response.message ?? 'Could not remove property.');
        return;
      }
      _showSnackBar('Removed from saved properties');
      widget.onChanged();
    } catch (_) {
      if (!mounted) return;
      _showSnackBar('Could not remove property. Check your connection.');
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
        child: _isLoading
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: Center(child: CircularProgressIndicator()),
              )
            : _error != null
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  _error!,
                  style: TextStyle(color: theme.colorScheme.error, fontSize: 12),
                ),
              )
            : _saved.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Saved Properties (${_saved.length})',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _saved.length,
                    itemBuilder: (context, idx) {
                      final saved = _saved[idx];
                      final property = saved.property;
                      final imageUrl = property.media.isNotEmpty
                          ? property.media.first.fullUrl
                          : null;
                      final price = property.salePrice ?? property.rentPrice;
                      final priceLabel = price != null
                          ? '${property.currency ?? '₦'}${price.toStringAsFixed(0)}${property.rentPrice != null ? ' /period' : ''}'
                          : 'Price on request';

                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: imageUrl != null
                                ? Image.network(
                                    imageUrl,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: 50,
                                    height: 50,
                                    color: Colors.grey.shade300,
                                    child: const Icon(Icons.home),
                                  ),
                          ),
                          title: Text(
                            property.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          subtitle: Text(
                            priceLabel,
                            style: TextStyle(
                              color: widget.primaryRed,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.bookmark_remove,
                              color: Colors.grey,
                              size: 20,
                            ),
                            onPressed: () => _unsave(saved),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.amber.withValues(alpha: 0.15),
                        child: const Icon(
                          Icons.bookmark_border,
                          size: 32,
                          color: Colors.amber,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'You have not saved any properties yet.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Browse listings and tap bookmark to save properties here.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
