import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/estate_provider.dart';
import '../providers/person_provider.dart';
import '../providers/preferences_provider.dart';
import '../network/provider/network_provider.dart';
import '../data/static_configs.dart';
import '../models/country.dart';
import '../data/countries_data.dart';
import '../widgets/phone_input_field.dart';
import '../widgets/forgot_password_bottom_sheet.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPhoneMode = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Country _selectedCountry = kCountries.first;
  bool _obscurePassword = true;
  bool _rememberMe = true;
  bool _isLoading = false;
  String? _errorBanner;
  String? _phoneError;

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    setState(() {
      _errorBanner = null;
      _phoneError = null;
    });

    if (_isPhoneMode) {
      if (_phoneController.text.trim().isEmpty) {
        setState(() => _phoneError = 'Phone number is required');
        return;
      }
      if (_phoneController.text.trim().length < 10) {
        setState(() => _phoneError = 'Phone number must be 10 digits');
        return;
      }
    }

    if (!_formKey.currentState!.validate()) {
      setState(() => _errorBanner = 'Please fix the highlighted errors');
      return;
    }

    setState(() => _isLoading = true);

    final networkRepo = context.read<NetworkProvider>().networkRepo;
    final identifier = _isPhoneMode
        ? '${_selectedCountry.dialCode}${_phoneController.text.trim()}'
        : _emailController.text.trim();

    try {
      final response = await networkRepo.login(
        email: _isPhoneMode ? null : identifier,
        phone: _isPhoneMode ? identifier : null,
        password: _passwordController.text,
      );

      if (!mounted) return;

      final profile = response.data;
      if (response.success != true || profile == null) {
        setState(() {
          _isLoading = false;
          _errorBanner =
              response.message ??
              'Invalid credentials. Please verify your password.';
        });
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

      // Keeps the rest of the app's demo/mock UI in sync with the signed-in user.
      Provider.of<EstateProvider>(
        context,
        listen: false,
      ).login(identifier, name: profile.name);

      setState(() => _isLoading = false);

      Navigator.pushReplacementNamed(context, '/main');
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorBanner = 'Something went wrong. Please check your connection.';
      });
    }
  }

  /*void _autofillDemo() {
    setState(() {
      _isPhoneMode = false;
      _emailController.text = 'alex.morgan@estate.com';
      _passwordController.text = 'demo1234';
      _errorBanner = null;
      _phoneError = null;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign In',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo Icon
                  Center(
                    child: Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.primary.withValues(
                              alpha: 0.3,
                            ),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.real_estate_agent,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Welcome Title
                  Text(
                    'Welcome Back',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Log in to explore listings and manage viewings',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Error Banner
                  if (_errorBanner != null) ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.errorContainer,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: theme.colorScheme.error,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _errorBanner!,
                              style: TextStyle(
                                color: theme.colorScheme.onErrorContainer,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, size: 16),
                            color: theme.colorScheme.onErrorContainer,
                            onPressed: () =>
                                setState(() => _errorBanner = null),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Card Container
                  Card(
                    elevation: 0,
                    color: theme.colorScheme.surfaceContainerLow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: BorderSide(
                        color: theme.colorScheme.outlineVariant.withValues(
                          alpha: 0.4,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Segmented toggle: Email vs Phone
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            child: SegmentedButton<bool>(
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
                                  _errorBanner = null;
                                  _phoneError = null;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Email or Phone field
                          if (!_isPhoneMode)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                              ),
                              child: TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: 'Email Address',
                                  hintText: 'alex.morgan@estate.com',
                                  prefixIcon: const Icon(Icons.mail_outline),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                validator: (val) {
                                  if (val == null || val.trim().isEmpty) {
                                    return 'Email is required';
                                  }
                                  if (!val.contains('@')) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                            )
                          else
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                              ),
                              child: PhoneInputField(
                                controller: _phoneController,
                                selectedCountry: _selectedCountry,
                                onCountryChanged: (c) =>
                                    setState(() => _selectedCountry = c),
                                errorText: _phoneError,
                              ),
                            ),

                          const SizedBox(height: 16),

                          // Password field
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () => setState(
                                    () => _obscurePassword = !_obscurePassword,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Password is required';
                                }
                                if (val.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Remember Me & Forgot Password
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: _rememberMe,
                                    onChanged: (val) => setState(
                                      () => _rememberMe = val ?? true,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  Text(
                                    'Remember me',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  ForgotPasswordBottomSheet.show(
                                    context,
                                    onSuccess: (msg) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(msg),
                                          backgroundColor:
                                              theme.colorScheme.primary,
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // Submit Button with Loader
                          FilledButton(
                            onPressed: _isLoading ? null : _handleLogin,
                            style: FilledButton.styleFrom(
                              minimumSize: const Size.fromHeight(52),
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
                                : const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Sign In',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Icon(Icons.arrow_forward, size: 18),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /*const SizedBox(height: 16),

                  // Quick Demo Autofill Button
                  Center(
                    child: TextButton.icon(
                      onPressed: _autofillDemo,
                      icon: const Icon(Icons.bolt, size: 16),
                      label: const Text('Auto-fill Test Demo Credentials'),
                    ),
                  ),*/
                  const SizedBox(height: 20),

                  // Sign up link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushReplacementNamed(context, '/signup'),
                        child: Text(
                          'Sign Up Now',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
