import 'package:estate_ease/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/estate_provider.dart';
import '../models/models.dart';

class BookViewingDialog extends StatefulWidget {
  final Property property;

  const BookViewingDialog({super.key, required this.property});

  @override
  State<BookViewingDialog> createState() => _BookViewingDialogState();
}

class _BookViewingDialogState extends State<BookViewingDialog> {
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 2));
  String _timeSlot = '14:00';
  bool _isSubmitted = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_isSubmitted) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle_rounded,
              color: AppColors.emeraldColor,
              size: 60,
            ),
            const SizedBox(height: 16),
            Text(
              'Viewing Confirmed!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your appointment for ${widget.property.title} on ${_selectedDate.toString().split(' ')[0]} at $_timeSlot has been recorded.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Done'),
            ),
          ],
        ),
      );
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      title: Text(
        'Schedule a Viewing',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurface,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.property.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Select Date',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 6),
            InkWell(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 60)),
                );
                if (date != null) setState(() => _selectedDate = date);
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedDate.toString().split(' ')[0],
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(Icons.calendar_today, size: 18),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Time Slot',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              initialValue: _timeSlot,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              items: const [
                DropdownMenuItem(value: '10:00', child: Text('10:00 AM')),
                DropdownMenuItem(value: '11:30', child: Text('11:30 AM')),
                DropdownMenuItem(value: '14:00', child: Text('02:00 PM')),
                DropdownMenuItem(value: '16:00', child: Text('04:00 PM')),
              ],
              onChanged: (v) => setState(() => _timeSlot = v!),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            context.read<EstateProvider>().bookViewing(
              ViewingBooking(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                propertyId: widget.property.id,
                propertyTitle: widget.property.title,
                date: _selectedDate.toString().split(' ')[0],
                time: _timeSlot,
              ),
            );
            setState(() => _isSubmitted = true);
          },
          child: const Text('Confirm Booking'),
        ),
      ],
    );
  }
}
