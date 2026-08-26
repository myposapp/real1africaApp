import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/property.dart';
import '../models/property_category.dart';
import '../network/provider/network_provider.dart';

class AddPropertyDialog extends StatefulWidget {
  const AddPropertyDialog({super.key});

  @override
  State<AddPropertyDialog> createState() => _AddPropertyDialogState();
}

class _AddPropertyDialogState extends State<AddPropertyDialog> {
  final _formKey = GlobalKey<FormState>();

  List<PropertyCategory> _categories = [];
  bool _isLoadingCategories = true;
  String? _selectedCategoryId;

  String _title = '';
  String _description = '';
  String _street = '';
  String _city = '';
  String _state = '';
  String _country = 'Nigeria';
  double _price = 5000000;

  bool _forSale = true;
  String _visibility = 'public';

  final List<File> _media = [];
  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final networkRepo = context.read<NetworkProvider>().networkRepo;
    try {
      final response = await networkRepo.getPropertyCategories(pageSize: 100);
      if (!mounted) return;
      setState(() {
        _categories = response.data ?? [];
        _isLoadingCategories = false;
        if (_categories.isNotEmpty) {
          _selectedCategoryId = _categories.first.id;
        } else {
          _errorMessage = 'No property categories are available yet.';
        }
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoadingCategories = false;
        _errorMessage = 'Could not load property categories.';
      });
    }
  }

  Future<void> _pickMedia() async {
    final picked = await ImagePicker().pickMultiImage(imageQuality: 85);
    if (picked.isNotEmpty) {
      setState(() => _media.addAll(picked.map((x) => File(x.path))));
    }
  }

  Future<void> _submit() async {
    setState(() => _errorMessage = null);

    if (_selectedCategoryId == null) {
      setState(() => _errorMessage = 'Please select a category.');
      return;
    }
    if (_media.isEmpty) {
      setState(() => _errorMessage = 'Please add at least one photo.');
      return;
    }
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() => _isSubmitting = true);

    final networkRepo = context.read<NetworkProvider>().networkRepo;

    try {
      final response = await networkRepo.createProperty(
        title: _title,
        description: _description,
        categoryIds: [_selectedCategoryId!],
        address: PropertyAddress(
          street: _street,
          city: _city,
          state: _state,
          country: _country,
        ),
        status: 'active',
        forSale: _forSale,
        forRent: !_forSale,
        visibility: _visibility,
        media: _media,
        salePrice: _forSale ? _price : null,
        rentPrice: !_forSale ? _price : null,
      );

      if (!mounted) return;

      if (response.success != true) {
        setState(() {
          _isSubmitting = false;
          _errorMessage = response.message ?? 'Could not create property.';
        });
        return;
      }

      Navigator.pop(context, true);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
        _errorMessage = 'Something went wrong. Please check your connection.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        width: 500,
        constraints: const BoxConstraints(maxHeight: 650),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add New Property',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(
                      color: theme.colorScheme.onErrorContainer,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            Expanded(
              child: _isLoadingCategories
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            // Category
                            DropdownButtonFormField<String>(
                              initialValue: _selectedCategoryId,
                              decoration: const InputDecoration(
                                labelText: 'Category *',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                              items: _categories
                                  .map(
                                    (c) => DropdownMenuItem(
                                      value: c.id,
                                      child: Text(
                                        c.parentCategory != null
                                            ? '— ${c.title}'
                                            : c.title,
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (v) =>
                                  setState(() => _selectedCategoryId = v),
                            ),
                            const SizedBox(height: 12),

                            // Title
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Property Title *',
                                hintText: 'e.g. 20 x 100 Prime Dry Land',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                              validator: (v) =>
                                  v == null || v.isEmpty ? 'Required' : null,
                              onSaved: (v) => _title = v ?? '',
                            ),
                            const SizedBox(height: 12),

                            // Type & Price
                            Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField<bool>(
                                    initialValue: _forSale,
                                    decoration: const InputDecoration(
                                      labelText: 'Listing Type',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                    ),
                                    items: const [
                                      DropdownMenuItem(
                                        value: true,
                                        child: Text(
                                          'For Sale',
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: false,
                                        child: Text(
                                          'For Rent',
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ),
                                    ],
                                    onChanged: (v) =>
                                        setState(() => _forSale = v!),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: _forSale
                                          ? 'Sale Price (₦) *'
                                          : 'Rent Price (₦) *',
                                      prefixText: '₦ ',
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    initialValue: '5000000',
                                    validator: (v) => v == null || v.isEmpty
                                        ? 'Required'
                                        : null,
                                    onSaved: (v) => _price =
                                        double.tryParse(v ?? '5000000') ??
                                        5000000,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Street
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Street Address *',
                                hintText: 'e.g. 12 Admiralty Way',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                              validator: (v) =>
                                  v == null || v.isEmpty ? 'Required' : null,
                              onSaved: (v) => _street = v ?? '',
                            ),
                            const SizedBox(height: 12),

                            // City & State
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'City *',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                    ),
                                    validator: (v) => v == null || v.isEmpty
                                        ? 'Required'
                                        : null,
                                    onSaved: (v) => _city = v ?? '',
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'State *',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                    ),
                                    validator: (v) => v == null || v.isEmpty
                                        ? 'Required'
                                        : null,
                                    onSaved: (v) => _state = v ?? '',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            TextFormField(
                              initialValue: _country,
                              decoration: const InputDecoration(
                                labelText: 'Country *',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                              validator: (v) =>
                                  v == null || v.isEmpty ? 'Required' : null,
                              onSaved: (v) => _country = v ?? 'Nigeria',
                            ),
                            const SizedBox(height: 12),

                            // Visibility
                            DropdownButtonFormField<String>(
                              initialValue: _visibility,
                              decoration: const InputDecoration(
                                labelText: 'Visibility',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: 'public',
                                  child: Text(
                                    'Public',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'private',
                                  child: Text(
                                    'Private',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ],
                              onChanged: (v) =>
                                  setState(() => _visibility = v!),
                            ),
                            const SizedBox(height: 12),

                            // Description
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Description',
                                hintText:
                                    'Enter comprehensive property information, amenities, and title docs...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                              maxLines: 3,
                              onSaved: (v) => _description = v ?? '',
                            ),
                            const SizedBox(height: 12),

                            Text(
                              'Photos *',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                ..._media.asMap().entries.map(
                                  (entry) => Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          entry.value,
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: -6,
                                        right: -6,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.cancel,
                                            size: 18,
                                            color: Colors.red,
                                          ),
                                          onPressed: () => setState(
                                            () => _media.removeAt(entry.key),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _pickMedia,
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: theme
                                          .colorScheme
                                          .surfaceContainerHighest
                                          .withValues(alpha: 0.4),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: theme.colorScheme.outlineVariant,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.add_a_photo_outlined,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: (_isSubmitting || _isLoadingCategories)
                        ? null
                        : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC00016),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isSubmitting
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Add Property',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
