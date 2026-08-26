import 'package:flutter/material.dart';
import 'basic_info_card.dart';
import 'kyc_documents_card.dart';
import 'preferences_card.dart';
import 'update_password_card.dart';

class ProfileInfoTab extends StatelessWidget {
  final Color primaryRed;

  const ProfileInfoTab({super.key, required this.primaryRed});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KycDocumentsCard(primaryRed: primaryRed),
          const SizedBox(height: 16),
          BasicInfoCard(primaryRed: primaryRed),
          const SizedBox(height: 16),
          UpdatePasswordCard(primaryRed: primaryRed),
          const SizedBox(height: 16),
          PreferencesCard(primaryRed: primaryRed),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
