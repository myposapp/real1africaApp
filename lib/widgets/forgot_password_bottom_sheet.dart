import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/country.dart';
import '../data/countries_data.dart';
import '../network/provider/network_provider.dart';
import 'phone_input_field.dart';

class ForgotPasswordBottomSheet extends StatefulWidget {
  final ValueChanged<String>? onSuccess;

  const ForgotPasswordBottomSheet({super.key, this.onSuccess});

  static Future<void> show(
    BuildContext context, {
    ValueChanged<String>? onSuccess,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: ForgotPasswordBottomSheet(onSuccess: onSuccess),
      ),
    );
  }

  @override
  State<ForgotPasswordBottomSheet> createState() =>
      _ForgotPasswordBottomSheetState();
}

class _ForgotPasswordBottomSheetState extends State<ForgotPasswordBottomSheet> {
  // Step 0: Identify (Email or Phone)
  // Step 1: Verify OTP (4 digits)
  // Step 2: Set New Password
  int _currentStep = 0;

  bool _isPhoneMode = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  Country _selectedCountry = kCountries.first;

  // OTP 4 boxes
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _otpFocusNodes = List.generate(4, (_) => FocusNode());

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscurePassword = true;

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    for (var c in _otpControllers) {
      c.dispose();
    }
    for (var f in _otpFocusNodes) {
      f.dispose();
    }
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSendOtp() async {
    setState(() => _errorMessage = null);

    if (!_isPhoneMode) {
      if (_emailController.text.trim().isEmpty) {
        setState(
          () => _errorMessage = 'Please enter your registered email address.',
        );
        return;
      }
      if (!_emailController.text.contains('@')) {
        setState(() => _errorMessage = 'Please enter a valid email format.');
        return;
      }
    } else {
      if (_phoneController.text.trim().length < 10) {
        setState(
          () => _errorMessage = 'Please enter a valid 10-digit phone number.',
        );
        return;
      }
    }

    final networkRepo = context.read<NetworkProvider>().networkRepo;
    final identifier = _isPhoneMode
        ? '${_selectedCountry.dialCode}${_phoneController.text.trim()}'
        : _emailController.text.trim();

    setState(() => _isLoading = true);

    try {
      final response = await networkRepo.requestForgotPasswordOtp(
        email: _isPhoneMode ? null : identifier,
        phone: _isPhoneMode ? identifier : null,
      );

      if (!mounted) return;

      if (response.success != true) {
        setState(() {
          _isLoading = false;
          _errorMessage =
              response.message ?? 'Could not send the verification code.';
        });
        return;
      }

      setState(() {
        _isLoading = false;
        _currentStep = 1;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = 'Something went wrong. Please check your connection.';
      });
    }
  }

  Future<void> _handleVerifyOtp() async {
    setState(() => _errorMessage = null);
    final otp = _otpControllers.map((c) => c.text).join();

    if (otp.length < 4) {
      setState(
        () => _errorMessage = 'Please enter all 4 digits of the OTP code.',
      );
      return;
    }

    // The code is verified together with the new password in the final step;
    // there is no standalone OTP-verification endpoint.
    setState(() => _currentStep = 2);
  }

  Future<void> _handleResetPassword() async {
    setState(() => _errorMessage = null);

    if (_passwordController.text.length < 6) {
      setState(() => _errorMessage = 'Password must be at least 6 characters.');
      return;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() => _errorMessage = 'Passwords do not match.');
      return;
    }

    final networkRepo = context.read<NetworkProvider>().networkRepo;
    final identifier = _isPhoneMode
        ? '${_selectedCountry.dialCode}${_phoneController.text.trim()}'
        : _emailController.text.trim();
    final otp = _otpControllers.map((c) => c.text).join();

    setState(() => _isLoading = true);

    try {
      final response = await networkRepo.resetPassword(
        email: _isPhoneMode ? null : identifier,
        phone: _isPhoneMode ? identifier : null,
        code: otp,
        password: _passwordController.text,
      );

      if (!mounted) return;

      if (response.success != true) {
        setState(() {
          _isLoading = false;
          _errorMessage = response.message ?? 'Could not reset your password.';
        });
        return;
      }

      setState(() => _isLoading = false);

      Navigator.pop(context);
      widget.onSuccess?.call(
        'Password reset successfully! You can now log in.',
      );
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = 'Something went wrong. Please check your connection.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drag Handle
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Header Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: theme.colorScheme.primaryContainer,
                      child: Icon(
                        Icons.lock_reset,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _currentStep == 0
                              ? 'Reset Password'
                              : _currentStep == 1
                              ? 'Verify OTP'
                              : 'New Password',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Step ${_currentStep + 1} of 3',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Error Banner Indicator
            if (_errorMessage != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: theme.colorScheme.error,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(
                          color: theme.colorScheme.onErrorContainer,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Step 0: Identify
            if (_currentStep == 0) ...[
              Text(
                'Enter your account email or phone number to receive a verification OTP code.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16),

              // Mode Switch (Email vs Phone)
              SegmentedButton<bool>(
                segments: const [
                  ButtonSegment(
                    value: false,
                    label: Text('Email'),
                    icon: Icon(Icons.email_outlined, size: 16),
                  ),
                  ButtonSegment(
                    value: true,
                    label: Text('Phone'),
                    icon: Icon(Icons.phone_outlined, size: 16),
                  ),
                ],
                selected: {_isPhoneMode},
                onSelectionChanged: (val) {
                  setState(() {
                    _isPhoneMode = val.first;
                    _errorMessage = null;
                  });
                },
              ),
              const SizedBox(height: 16),

              if (!_isPhoneMode)
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    prefixIcon: const Icon(Icons.mail_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                )
              else
                PhoneInputField(
                  controller: _phoneController,
                  selectedCountry: _selectedCountry,
                  onCountryChanged: (c) => setState(() => _selectedCountry = c),
                ),

              const SizedBox(height: 24),

              // Submit Button with Loader Indicator
              FilledButton(
                onPressed: _isLoading ? null : _handleSendOtp,
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Send Verification Code',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
              ),
            ],

            // Step 1: Verify OTP
            if (_currentStep == 1) ...[
              Text(
                'Enter the 4-digit code sent to ${_isPhoneMode ? "${_selectedCountry.dialCode} ${_phoneController.text}" : _emailController.text}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 20),

              // 4 OTP Boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 56,
                    height: 56,
                    child: TextField(
                      controller: _otpControllers[index],
                      focusNode: _otpFocusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onChanged: (val) {
                        if (val.isNotEmpty && index < 3) {
                          _otpFocusNodes[index + 1].requestFocus();
                        } else if (val.isEmpty && index > 0) {
                          _otpFocusNodes[index - 1].requestFocus();
                        }
                      },
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _isLoading
                          ? null
                          : () => setState(() => _currentStep = 0),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text('Back'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: FilledButton(
                      onPressed: _isLoading ? null : _handleVerifyOtp,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Verify Code',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                ],
              ),
            ],

            // Step 2: Set New Password
            if (_currentStep == 2) ...[
              Text(
                'Create a strong new password for your account.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              TextField(
                controller: _confirmPasswordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Re-type New Password',
                  prefixIcon: const Icon(Icons.lock_reset),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              FilledButton(
                onPressed: _isLoading ? null : _handleResetPassword,
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Reset Password & Log In',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
              ),
            ],
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
