import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/saved_property.dart';
import '../network/provider/network_provider.dart';
import '../providers/estate_provider.dart';

/// A heart icon that saves/unsaves a public property via the API and keeps
/// [EstateProvider]'s shared saved-id set in sync so the fill state stays
/// consistent across Home, Search, and the detail screen.
class SavePropertyButton extends StatefulWidget {
  final String propertyId;
  final double iconSize;
  final Color? backgroundColor;

  const SavePropertyButton({
    super.key,
    required this.propertyId,
    this.iconSize = 18,
    this.backgroundColor,
  });

  @override
  State<SavePropertyButton> createState() => _SavePropertyButtonState();
}

class _SavePropertyButtonState extends State<SavePropertyButton> {
  bool _isBusy = false;

  Future<void> _toggle() async {
    if (_isBusy) return;
    setState(() => _isBusy = true);

    final networkRepo = context.read<NetworkProvider>().networkRepo;
    final estateProvider = context.read<EstateProvider>();
    final wasSaved = estateProvider.isSaved(widget.propertyId);

    try {
      if (wasSaved) {
        final response = await networkRepo.getSavedProperties(pageSize: 100);
        SavedProperty? match;
        for (final saved in response.data ?? const <SavedProperty>[]) {
          if (saved.property.id == widget.propertyId) {
            match = saved;
            break;
          }
        }
        if (match != null) {
          final unsaveResponse = await networkRepo.unsaveProperty(match.id);
          if (unsaveResponse.success == true) {
            estateProvider.markUnsaved(widget.propertyId);
          }
        }
      } else {
        final saveResponse = await networkRepo.saveProperty(widget.propertyId);
        if (saveResponse.success == true) {
          estateProvider.markSaved(widget.propertyId);
        }
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Could not update saved properties. Check your connection.',
            ),
          ),
        );
      }
    }

    if (mounted) setState(() => _isBusy = false);
  }

  @override
  Widget build(BuildContext context) {
    final isSaved = context.watch<EstateProvider>().isSaved(widget.propertyId);

    return CircleAvatar(
      radius: widget.iconSize,
      backgroundColor: widget.backgroundColor ?? Colors.white.withValues(alpha: 0.85),
      child: _isBusy
          ? SizedBox(
              width: widget.iconSize * 0.8,
              height: widget.iconSize * 0.8,
              child: const CircularProgressIndicator(strokeWidth: 2),
            )
          : IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                isSaved ? Icons.favorite : Icons.favorite_border,
                size: widget.iconSize,
                color: Colors.red,
              ),
              onPressed: _toggle,
            ),
    );
  }
}
