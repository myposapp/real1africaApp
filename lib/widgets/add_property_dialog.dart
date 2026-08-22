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
  String _location = '';
  double _price = 2500;
  int _beds = 3;
  int _baths = 2;
  int _sqft = 1400;
  String _description = '';

  @override
  Widget build(BuildContext context) {
    //final theme = Theme.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      title: Row(
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
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Property Title',
                  hintText: 'e.g. Modern Coastal Villa',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                onSaved: (v) => _title = v ?? '',
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: _type,
                      decoration: const InputDecoration(
                        labelText: 'Type',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                      ),
                      items: ['Rent', 'Sales', 'Lease']
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => _type = v!),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Price (\$)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      initialValue: '2500',
                      onSaved: (v) =>
                          _price = double.tryParse(v ?? '2500') ?? 2500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Location / Area',
                  hintText: 'e.g. Beverly Hills, CA',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                onSaved: (v) => _location = v ?? '',
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Beds',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      initialValue: '3',
                      onSaved: (v) => _beds = int.tryParse(v ?? '3') ?? 3,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Baths',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      initialValue: '2',
                      onSaved: (v) => _baths = int.tryParse(v ?? '2') ?? 2,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Sqft',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      initialValue: '1400',
                      onSaved: (v) => _sqft = int.tryParse(v ?? '1400') ?? 1400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                maxLines: 2,
                onSaved: (v) => _description = v ?? '',
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final newProperty = Property(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                title: _title,
                type: _type,
                location: _location,
                city: 'Los Angeles',
                price: _price,
                priceUnit: _type == 'Sales' ? 'total' : '/mo',
                beds: _beds,
                baths: _baths,
                sqft: _sqft,
                image:
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuAaUZNWGCBz8cJAAC9vAQ6QabqS7ZGRoS2dIL58D6VaKnatpzbWnD5Y90tkX_WVUHTbrINl242BuaywUiUdGL4ED3qLTF3XgAYmRtmQ-6jfTVfC8gULAo5hWT0OvMCEuQFRNYDPuEReQ9sKudUd5NVmN2Ef_PuvykK4P6kHtHRAGRnDP0uIneeA6paDAN78nF2w8gUu-FOFvC8AsB4O-vNuLJeFOOLzI0Orx55oHUf1R0fw4_j4TpnfBZVShnbrY4jtfBjDoV57i1X9',
                gallery: [
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuAaUZNWGCBz8cJAAC9vAQ6QabqS7ZGRoS2dIL58D6VaKnatpzbWnD5Y90tkX_WVUHTbrINl242BuaywUiUdGL4ED3qLTF3XgAYmRtmQ-6jfTVfC8gULAo5hWT0OvMCEuQFRNYDPuEReQ9sKudUd5NVmN2Ef_PuvykK4P6kHtHRAGRnDP0uIneeA6paDAN78nF2w8gUu-FOFvC8AsB4O-vNuLJeFOOLzI0Orx55oHUf1R0fw4_j4TpnfBZVShnbrY4jtfBjDoV57i1X9',
                ],
                isNew: true,
                description: _description.isNotEmpty
                    ? _description
                    : 'Newly listed estate property.',
                amenities: [
                  Amenity(icon: 'wifi', name: 'High Speed WiFi'),
                  Amenity(icon: 'local_parking', name: 'Parking'),
                ],
                managerId: 'm1',
                managerName: 'Sarah Johnson',
              );
              context.read<EstateProvider>().addProperty(newProperty);
              Navigator.pop(context);
            }
          },
          child: const Text('Post Listing'),
        ),
      ],
    );
  }
}
