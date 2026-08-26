import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../data/countries_data.dart';
import '../../data/static_configs.dart';
import '../../models/country.dart';
import '../../network/provider/network_provider.dart';
import '../../providers/person_provider.dart';
import '../../providers/preferences_provider.dart';
import '../phone_input_field.dart';

class BasicInfoCard extends StatefulWidget {
  final Color primaryRed;

  const BasicInfoCard({super.key, required this.primaryRed});

  @override
  State<BasicInfoCard> createState() => _BasicInfoCardState();
}

class _BasicInfoCardState extends State<BasicInfoCard> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  Country _selectedCountry = kCountries.firstWhere(
    (c) => c.code == 'NG',
    orElse: () => kCountries.first,
  );
  String? _phoneError;
  File? _pickedPhoto;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final profile = context.read<ProfileProvider>().profile;

    _nameController = TextEditingController(text: profile?.name ?? '');
    _emailController = TextEditingController(text: profile?.email ?? '');

    String phoneDigits = profile?.phone ?? '';
    for (final country in kCountries) {
      if (phoneDigits.startsWith(country.dialCode)) {
        _selectedCountry = country;
        phoneDigits = phoneDigits.substring(country.dialCode.length).trim();
        break;
      }
    }
    phoneDigits = phoneDigits.replaceAll(RegExp(r'\D'), '');
    if (phoneDigits.length > 10) {
      phoneDigits = phoneDigits.substring(phoneDigits.length - 10);
    }
    _phoneController = TextEditingController(text: phoneDigits);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
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

  Future<void> _pickPhoto() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (picked != null) {
      setState(() => _pickedPhoto = File(picked.path));
    }
  }

  Future<void> _save() async {
    final rawDigits = _phoneController.text.trim();
    if (rawDigits.isEmpty) {
      setState(() => _phoneError = 'Phone number is required');
      return;
    } else if (rawDigits.length < 10) {
      setState(() => _phoneError = 'Phone number must be 10 digits');
      return;
    } else {
      setState(() => _phoneError = null);
    }

    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    final networkRepo = context.read<NetworkProvider>().networkRepo;
    final fullPhone = '${_selectedCountry.dialCode}$rawDigits';

    try {
      final response = await networkRepo.updateProfile(
        photo: _pickedPhoto,
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: fullPhone,
      );

      if (!mounted) return;

      final profile = response.data;
      if (response.success != true || profile == null) {
        setState(() => _isSaving = false);
        _showSnackBar(response.message ?? 'Could not save your changes.');
        return;
      }

      context.read<ProfileProvider>().setUserProfile(
        profile,
        source: UserSource.network,
      );
      await context.read<PreferenceProvider>().setString(
        EstateConfigs.profileKey,
        profile.toJson(),
      );

      if (!mounted) return;
      setState(() {
        _isSaving = false;
        _pickedPhoto = null;
      });
      _showSnackBar('Profile saved successfully!');
    } catch (_) {
      if (!mounted) return;
      setState(() => _isSaving = false);
      _showSnackBar('Could not save your changes. Check your connection.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final photoUrl = context.watch<ProfileProvider>().profile?.photoUrl;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Basic Info',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 12),

              Text(
                'Profile Photo',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: _pickPhoto,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: _pickedPhoto != null
                          ? FileImage(_pickedPhoto!) as ImageProvider
                          : (photoUrl != null ? NetworkImage(photoUrl) : null),
                      child: (_pickedPhoto == null && photoUrl == null)
                          ? Icon(Icons.person, color: Colors.grey.shade500, size: 28)
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest
                              .withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: theme.colorScheme.outlineVariant,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.upload_outlined,
                              size: 18,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _pickedPhoto != null
                                  ? 'New photo selected'
                                  : 'Add Profile Photo',
                              style: TextStyle(
                                fontSize: 12,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              PhoneInputField(
                controller: _phoneController,
                selectedCountry: _selectedCountry,
                onCountryChanged: (c) => setState(() => _selectedCountry = c),
                errorText: _phoneError,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _isSaving ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.primaryRed,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isSaving
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Save Changes',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
