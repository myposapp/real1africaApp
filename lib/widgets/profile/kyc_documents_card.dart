import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/kyc_document.dart';
import '../../network/provider/network_provider.dart';
import '../../providers/person_provider.dart';
import '../add_kyc_document_dialog.dart';
import '../confirmation_dialog.dart';

class KycDocumentsCard extends StatefulWidget {
  final Color primaryRed;

  const KycDocumentsCard({super.key, required this.primaryRed});

  @override
  State<KycDocumentsCard> createState() => _KycDocumentsCardState();
}

class _KycDocumentsCardState extends State<KycDocumentsCard> {
  String? _deletingId;

  static const _labels = {
    'nin': 'NIN',
    'bvn': 'BVN',
    'surcon-id': 'SURCON ID',
    'driving-license': 'Driving License',
    'utility-bill': 'Utility Bill',
    'passport': 'International Passport',
  };

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

  Future<void> _refreshProfile() async {
    final networkRepo = context.read<NetworkProvider>().networkRepo;
    try {
      final response = await networkRepo.getUserProfile();
      if (!mounted) return;
      if (response.success == true && response.data != null) {
        context.read<ProfileProvider>().setUserProfile(
          response.data!,
          source: UserSource.network,
        );
      }
    } catch (_) {
      // Best-effort refresh; the mutating call already succeeded.
    }
  }

  Future<void> _openAddDialog() async {
    final added = await showDialog<bool>(
      context: context,
      builder: (_) => const AddKYCDocumentDialog(),
    );
    if (added == true) {
      await _refreshProfile();
      if (mounted) _showSnackBar('KYC document submitted!');
    }
  }

  Future<void> _deleteDoc(KycDocument doc) async {
    setState(() => _deletingId = doc.id);
    final networkRepo = context.read<NetworkProvider>().networkRepo;
    try {
      final response = await networkRepo.deleteKyc(doc.id);
      if (!mounted) return;
      if (response.success != true) {
        setState(() => _deletingId = null);
        _showSnackBar(response.message ?? 'Could not remove document.');
        return;
      }
      await _refreshProfile();
      if (!mounted) return;
      setState(() => _deletingId = null);
      _showSnackBar('KYC document removed.');
    } catch (_) {
      if (!mounted) return;
      setState(() => _deletingId = null);
      _showSnackBar('Could not remove document. Check your connection.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final docs = context.watch<ProfileProvider>().profile?.kyc ?? [];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'KYC Documents',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Text(
                      'Submit identity documents',
                      style: TextStyle(
                        fontSize: 11,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: _openAddDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.primaryRed,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                  ),
                  icon: const Icon(Icons.add, size: 14),
                  label: const Text(
                    '+ Add',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (docs.isNotEmpty)
              ...docs.map(
                (doc) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    _labels[doc.type] ?? doc.type,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  subtitle: Text(
                    doc.createdAt ?? '',
                    style: const TextStyle(fontSize: 10),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Chip(
                        label: Text(
                          doc.status ?? 'pending-verification',
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                      ),
                      _deletingId == doc.id
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            )
                          : IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                size: 18,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => ConfirmationDialog(
                                    title: 'Delete KYC Document?',
                                    message:
                                        'Are you sure you want to remove this verification document?',
                                    isDestructive: true,
                                    confirmText: 'Delete',
                                    onCancel: () => Navigator.pop(context),
                                    onConfirm: () {
                                      Navigator.pop(context);
                                      _deleteDoc(doc);
                                    },
                                  ),
                                );
                              },
                            ),
                    ],
                  ),
                ),
              )
            else
              const Text(
                'No KYC documents submitted yet.',
                style: TextStyle(fontSize: 11),
              ),
          ],
        ),
      ),
    );
  }
}
