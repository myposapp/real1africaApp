import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../network/provider/network_provider.dart';

class AddKYCDocumentDialog extends StatefulWidget {
  const AddKYCDocumentDialog({super.key});

  @override
  State<AddKYCDocumentDialog> createState() => _AddKYCDocumentDialogState();
}

class _AddKYCDocumentDialogState extends State<AddKYCDocumentDialog> {
  final _formKey = GlobalKey<FormState>();

  static const _textTypes = {
    'nin': 'NIN',
    'bvn': 'BVN',
    'surcon-id': 'SURCON ID',
  };
  static const _fileTypes = {
    'driving-license': 'Driving License',
    'utility-bill': 'Utility Bill',
    'passport': 'International Passport',
  };

  String _docType = 'nin';
  final TextEditingController _contentController = TextEditingController();
  File? _selectedFile;
  bool _isSubmitting = false;
  String? _errorMessage;

  bool get _isTextType => _textTypes.containsKey(_docType);

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (picked != null) {
      setState(() => _selectedFile = File(picked.path));
    }
  }

  Future<void> _submit() async {
    setState(() => _errorMessage = null);

    if (_isTextType) {
      if (!_formKey.currentState!.validate()) return;
    } else if (_selectedFile == null) {
      setState(() => _errorMessage = 'Please select a document to upload.');
      return;
    }

    setState(() => _isSubmitting = true);

    final networkRepo = context.read<NetworkProvider>().networkRepo;

    try {
      final response = await networkRepo.submitKyc(
        type: _docType,
        content: _isTextType ? _contentController.text.trim() : null,
        file: _isTextType ? null : _selectedFile,
      );

      if (!mounted) return;

      if (response.success != true) {
        setState(() {
          _isSubmitting = false;
          _errorMessage = response.message ?? 'Could not submit document.';
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
    final allTypes = {..._textTypes, ..._fileTypes};

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        width: 440,
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Add KYC Document',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (_errorMessage != null) ...[
                Container(
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
                const SizedBox(height: 12),
              ],
              DropdownButtonFormField<String>(
                initialValue: _docType,
                decoration: const InputDecoration(
                  labelText: 'Document Type *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                items: allTypes.entries
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.key,
                        child: Text(e.value, style: const TextStyle(fontSize: 13)),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() {
                  _docType = v!;
                  _selectedFile = null;
                  _errorMessage = null;
                }),
              ),
              const SizedBox(height: 14),
              if (_isTextType)
                TextFormField(
                  controller: _contentController,
                  decoration: InputDecoration(
                    labelText: '${allTypes[_docType]} Number *',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'This field is required' : null,
                )
              else
                GestureDetector(
                  onTap: _pickFile,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest
                          .withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: theme.colorScheme.outlineVariant),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.cloud_upload_outlined,
                          size: 32,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _selectedFile != null
                              ? _selectedFile!.path.split('/').last
                              : 'Tap to select document (PNG, JPG)',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: _selectedFile != null
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: _selectedFile != null
                                ? Colors.green
                                : theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Photo, scan, or clear picture of the document',
                          style: TextStyle(
                            fontSize: 10,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 20),
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
                      onPressed: _isSubmitting ? null : _submit,
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
                              'Submit Document',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
