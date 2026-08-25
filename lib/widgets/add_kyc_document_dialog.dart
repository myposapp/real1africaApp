import 'package:flutter/material.dart';
import '../models/models.dart';

class AddKYCDocumentDialog extends StatefulWidget {
  final Function(KYCDocument) onAdd;

  const AddKYCDocumentDialog({super.key, required this.onAdd});

  @override
  State<AddKYCDocumentDialog> createState() => _AddKYCDocumentDialogState();
}

class _AddKYCDocumentDialogState extends State<AddKYCDocumentDialog> {
  final _formKey = GlobalKey<FormState>();
  String _docType = 'Government ID';
  String _docName = '';
  String? _selectedFileName;
  bool _isUploading = false;

  final List<String> _docTypes = [
    'Government ID',
    'Driver License',
    'International Passport',
    'Voter Card',
    'Utility Bill (Proof of Address)',
    'Business License / CAC Certificate',
    'Estate Agent Certificate',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
              DropdownButtonFormField<String>(
                value: _docType,
                decoration: const InputDecoration(
                  labelText: 'Document Type *',
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                ),
                items: _docTypes
                    .map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 13))))
                    .toList(),
                onChanged: (v) => setState(() => _docType = v!),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Document Name / Title *',
                  hintText: 'e.g. National ID Card / Slip',
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Document name is required' : null,
                onSaved: (v) => _docName = v ?? '',
              ),
              const SizedBox(height: 14),
              // Document upload box
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedFileName = 'identity_scan_doc.pdf (1.2 MB)';
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceVariant.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: theme.colorScheme.outlineVariant, style: BorderStyle.solid),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.cloud_upload_outlined, size: 32, color: theme.colorScheme.primary),
                      const SizedBox(height: 6),
                      Text(
                        _selectedFileName ?? 'Tap to select document (PDF, PNG, JPG)',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: _selectedFileName != null ? FontWeight.bold : FontWeight.normal,
                          color: _selectedFileName != null ? Colors.green : theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Maximum file size: 10MB',
                        style: TextStyle(fontSize: 10, color: theme.colorScheme.onSurfaceVariant),
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isUploading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                setState(() => _isUploading = true);
                                Future.delayed(const Duration(milliseconds: 600), () {
                                  final newDoc = KYCDocument(
                                    id: 'kyc_${DateTime.now().millisecondsSinceEpoch}',
                                    name: _docName,
                                    type: _docType,
                                    status: 'Pending',
                                    uploadedAt: 'Just now',
                                  );
                                  widget.onAdd(newDoc);
                                  Navigator.pop(context);
                                });
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC00016),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: _isUploading
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : const Text('Submit Document', style: TextStyle(fontWeight: FontWeight.bold)),
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
