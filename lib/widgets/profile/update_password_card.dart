import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../network/provider/network_provider.dart';

class UpdatePasswordCard extends StatefulWidget {
  final Color primaryRed;

  const UpdatePasswordCard({super.key, required this.primaryRed});

  @override
  State<UpdatePasswordCard> createState() => _UpdatePasswordCardState();
}

class _UpdatePasswordCardState extends State<UpdatePasswordCard> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _showOldPass = false;
  bool _showNewPass = false;
  bool _showConfirmPass = false;
  bool _isUpdating = false;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
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

  Future<void> _update() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isUpdating = true);

    final networkRepo = context.read<NetworkProvider>().networkRepo;

    try {
      final response = await networkRepo.updateProfile(
        oldPassword: _oldPasswordController.text,
        password: _newPasswordController.text,
      );

      if (!mounted) return;

      if (response.success != true) {
        setState(() => _isUpdating = false);
        _showSnackBar(response.message ?? 'Could not update password.');
        return;
      }

      setState(() => _isUpdating = false);
      _oldPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
      _showSnackBar('Password updated successfully!');
    } catch (_) {
      if (!mounted) return;
      setState(() => _isUpdating = false);
      _showSnackBar('Could not update password. Check your connection.');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                'Update Password',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _oldPasswordController,
                obscureText: !_showOldPass,
                decoration: InputDecoration(
                  labelText: 'Old Password *',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showOldPass ? Icons.visibility_off : Icons.visibility,
                      size: 18,
                    ),
                    onPressed: () =>
                        setState(() => _showOldPass = !_showOldPass),
                  ),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _newPasswordController,
                obscureText: !_showNewPass,
                decoration: InputDecoration(
                  labelText: 'New Password *',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showNewPass ? Icons.visibility_off : Icons.visibility,
                      size: 18,
                    ),
                    onPressed: () =>
                        setState(() => _showNewPass = !_showNewPass),
                  ),
                ),
                validator: (v) =>
                    v != null && v.length < 6 ? 'Min 6 chars' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: !_showConfirmPass,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password *',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showConfirmPass
                          ? Icons.visibility_off
                          : Icons.visibility,
                      size: 18,
                    ),
                    onPressed: () =>
                        setState(() => _showConfirmPass = !_showConfirmPass),
                  ),
                ),
                validator: (v) => v != _newPasswordController.text
                    ? 'Passwords do not match'
                    : null,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _isUpdating ? null : _update,
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.primaryRed,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isUpdating
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Update Password',
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
