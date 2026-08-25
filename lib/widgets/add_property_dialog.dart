import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/estate_provider.dart';
import '../models/models.dart';

class AddPropertyDialog extends StatefulWidget {
  const AddPropertyDialog({super.key});

  @override
  State<AddPropertyDialog> createState() => _AddPropertyDialogState();
}

class _AddPropertyDialogState extends State<AddPropertyDialog> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _type = 'Rent';
  String _category = 'Land for sale';
  String _subcategory = 'Residential Land';
  String _location = '';
  double _price = 5000000;
  String _priceUnit = 'total';
  int _beds = 3;
  int _baths = 2;
  int _sqft = 1500;
  String _description = '';
  String _status = 'Active';
  String _visibility = 'Public';
  bool _isSubmitting = false;

  final Map<String, List<String>> _categories = {
    'Land for sale': [
      'Residential Land',
      'Commercial Plot',
      'Farmland / Agricultural',
      'Industrial Land',
    ],
    'Stores for rent': [
      'Retail Storefront',
      'Shopping Complex Unit',
      'Warehouse Storage',
      'Office Suite',
    ],
    'Duplex & Mansions': [
      'Detached Duplex',
      'Semi-Detached Duplex',
      'Terrace Duplex',
      'Penthouse Mansion',
    ],
    'Apartments & Flats': [
      '1 Bedroom Mini Flat',
      '2 Bedroom Flat',
      '3 Bedroom Luxury Apartment',
      'Studio Flat',
    ],
    'Shortlets & Holiday Homes': [
      'Serviced Studio',
      'Waterfront Shortlet',
      'Luxury Penthouse Suite',
    ],
  };

  @override
  Widget build(BuildContext context) {
    //final theme = Theme.of(context);
    final subcategories = _categories[_category] ?? ['General'];

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
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      // Category
                      DropdownButtonFormField<String>(
                        initialValue: _category,
                        decoration: const InputDecoration(
                          labelText: 'Category *',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        items: _categories.keys
                            .map(
                              (c) => DropdownMenuItem(
                                value: c,
                                child: Text(
                                  c,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (v) {
                          setState(() {
                            _category = v!;
                            _subcategory = _categories[_category]!.first;
                          });
                        },
                      ),
                      const SizedBox(height: 12),

                      // Subcategory
                      DropdownButtonFormField<String>(
                        initialValue: _subcategory,
                        decoration: const InputDecoration(
                          labelText: 'Sub Category *',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        items: subcategories
                            .map(
                              (s) => DropdownMenuItem(
                                value: s,
                                child: Text(
                                  s,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (v) => setState(() => _subcategory = v!),
                      ),
                      const SizedBox(height: 12),

                      // Title
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Property Title *',
                          hintText: 'e.g. 20 x 100 Prime Dry Land',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
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
                            child: DropdownButtonFormField<String>(
                              initialValue: _type,
                              decoration: const InputDecoration(
                                labelText: 'Listing Type',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                              items: ['Rent', 'Sales', 'Lease']
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(
                                        e,
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (v) {
                                setState(() {
                                  _type = v!;
                                  _priceUnit = _type == 'Sales'
                                      ? 'total'
                                      : '/yr';
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Price (₦) *',
                                prefixText: '₦ ',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              initialValue: '5000000',
                              validator: (v) =>
                                  v == null || v.isEmpty ? 'Required' : null,
                              onSaved: (v) => _price =
                                  double.tryParse(v ?? '5000000') ?? 5000000,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Location
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Location / Address *',
                          hintText: 'e.g. Lekki Phase 1, Lagos',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Required' : null,
                        onSaved: (v) => _location = v ?? '',
                      ),
                      const SizedBox(height: 12),

                      // Beds & Baths & Sqft
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Beds',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              initialValue: '3',
                              onSaved: (v) =>
                                  _beds = int.tryParse(v ?? '3') ?? 3,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Baths',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              initialValue: '2',
                              onSaved: (v) =>
                                  _baths = int.tryParse(v ?? '2') ?? 2,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Sqft',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              initialValue: '1500',
                              onSaved: (v) =>
                                  _sqft = int.tryParse(v ?? '1500') ?? 1500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Status & Visibility
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: _status,
                              decoration: const InputDecoration(
                                labelText: 'Status',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                              items: ['Active', 'Draft', 'Under Offer']
                                  .map(
                                    (s) => DropdownMenuItem(
                                      value: s,
                                      child: Text(
                                        s,
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (v) => setState(() => _status = v!),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: _visibility,
                              decoration: const InputDecoration(
                                labelText: 'Visibility',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                              items: ['Public', 'Private']
                                  .map(
                                    (vis) => DropdownMenuItem(
                                      value: vis,
                                      child: Text(
                                        vis,
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (v) =>
                                  setState(() => _visibility = v!),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Description
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          hintText:
                              'Enter comprehensive property information, amenities, and title docs...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        maxLines: 3,
                        onSaved: (v) => _description = v ?? '',
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
                    onPressed: _isSubmitting
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              setState(() => _isSubmitting = true);
                              Future.delayed(const Duration(milliseconds: 600), () {
                                final newProperty = Property(
                                  id: 'p_${DateTime.now().millisecondsSinceEpoch}',
                                  title: _title,
                                  type: _type,
                                  category: _category,
                                  subcategory: _subcategory,
                                  location: _location,
                                  city: 'Lagos',
                                  price: _price,
                                  priceUnit: _priceUnit,
                                  beds: _beds,
                                  baths: _baths,
                                  sqft: _sqft,
                                  status: _status,
                                  visibility: _visibility,
                                  addedAt: 'Just now',
                                  image:
                                      'https://lh3.googleusercontent.com/aida-public/AB6AXuAaUZNWGCBz8cJAAC9vAQ6QabqS7ZGRoS2dIL58D6VaKnatpzbWnD5Y90tkX_WVUHTbrINl242BuaywUiUdGL4ED3qLTF3XgAYmRtmQ-6jfTVfC8gULAo5hWT0OvMCEuQFRNYDPuEReQ9sKudUd5NVmN2Ef_PuvykK4P6kHtHRAGRnDP0uIneeA6paDAN78nF2w8gUu-FOFvC8AsB4O-vNuLJeFOOLzI0Orx55oHUf1R0fw4_j4TpnfBZVShnbrY4jtfBjDoV57i1X9',
                                  gallery: [
                                    'https://lh3.googleusercontent.com/aida-public/AB6AXuAaUZNWGCBz8cJAAC9vAQ6QabqS7ZGRoS2dIL58D6VaKnatpzbWnD5Y90tkX_WVUHTbrINl242BuaywUiUdGL4ED3qLTF3XgAYmRtmQ-6jfTVfC8gULAo5hWT0OvMCEuQFRNYDPuEReQ9sKudUd5NVmN2Ef_PuvykK4P6kHtHRAGRnDP0uIneeA6paDAN78nF2w8gUu-FOFvC8AsB4O-vNuLJeFOOLzI0Orx55oHUf1R0fw4_j4TpnfBZVShnbrY4jtfBjDoV57i1X9',
                                    'https://lh3.googleusercontent.com/aida-public/AB6AXuAMsZ5s6A6R4fLIL6j36xUqInN0QG8Yn4xJ8sE3I8a-y4O0n9gH6c5m0kF3h_2qP_8v0iI8pY9zA4O_L6zB4yF_u3L5kC_2I5y7X_6M6I5G_3kL_7n_2s3G',
                                  ],
                                  isNew: true,
                                  description: _description.isNotEmpty
                                      ? _description
                                      : 'Newly listed estate property.',
                                  amenities: [
                                    Amenity(
                                      icon: 'verified',
                                      name: 'Document Verified',
                                    ),
                                    Amenity(
                                      icon: 'local_parking',
                                      name: 'Access Road',
                                    ),
                                  ],
                                  managerId: 'm1',
                                  managerName: 'Estate manager 1',
                                );
                                if (context.mounted) {
                                  context.read<EstateProvider>().addProperty(
                                    newProperty,
                                  );
                                  Navigator.pop(context);
                                }
                              });
                            }
                          },
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
