import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aqua_life/app/theme/app_colors.dart';
import 'package:aqua_life/features/auth/domain/entities/auth_entity.dart';
import 'package:aqua_life/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:aqua_life/features/dashboard/presentation/pages/dashboard_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  final int initialIndex;
  const LoginPage({super.key, this.initialIndex = 0});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late int _selectedTab;
  final _loginFormKey = GlobalKey<FormState>();
  final _signupFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _agreedToTerms = false;
  String _selectedCountryCode = '+977'; // Default Nepal

  final List<Map<String, String>> _countryCodes = [
    {'code': '+977', 'name': 'Nepal', 'flag': '🇳🇵'},
    {'code': '+91', 'name': 'India', 'flag': '🇮🇳'},
    {'code': '+1', 'name': 'USA', 'flag': '🇺🇸'},
    {'code': '+44', 'name': 'UK', 'flag': '🇬🇧'},
    {'code': '+86', 'name': 'China', 'flag': '🇨🇳'},
  ];

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialIndex;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1628),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0A1628),
              Color(0xFF0D2137),
            ],
            stops: [0.0, 0.4],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                _buildLogo(),
                const SizedBox(height: 30),
                _buildTabBar(),
                const SizedBox(height: 30),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _selectedTab == 0
                      ? _buildLoginForm()
                      : _buildSignupForm(),
                ),
                const SizedBox(height: 20),
                _buildDivider(),
                const SizedBox(height: 20),
                _buildSocialLogin(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Container(
          width: 75,
          height: 75,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF112240),
            border: Border.all(color: const Color(0xFF1E3A5C), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryBlue.withValues(alpha: 0.25),
                blurRadius: 20,
                spreadRadius: 4,
              ),
            ],
          ),
          child: const Icon(
            Icons.water_drop,
            color: AppColors.primaryBlue,
            size: 40,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'AQUALIFE',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 3.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF112240),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1E3A5C)),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = 0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedTab == 0 ? const Color(0xFF1A3A5C) : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Log In',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _selectedTab == 0 ? AppColors.primaryBlue : const Color(0xFF7AB8CC),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = 1),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedTab == 1 ? const Color(0xFF1A3A5C) : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Sign Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _selectedTab == 1 ? AppColors.primaryBlue : const Color(0xFF7AB8CC),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _loginFormKey,
      child: Column(
        key: const ValueKey('login'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            controller: _emailController,
            hint: 'Enter your email',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _passwordController,
            hint: 'Enter your password',
            icon: Icons.lock_outlined,
            isPassword: true,
            isPasswordVisible: _isPasswordVisible,
            onTogglePassword: () {
              setState(() => _isPasswordVisible = !_isPasswordVisible);
            },
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'Forgot Password?',
                style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildSubmitButton('Log In', () async {
            if (_loginFormKey.currentState!.validate()) {
              final authViewModel = ref.read(authViewModelProvider.notifier);
              await authViewModel.login(
                _emailController.text,
                _passwordController.text,
              );
              
              final authState = ref.read(authViewModelProvider);
              if (authState.isSuccess && mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const DashboardPage()),
                );
              } else if (authState.error != null && mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: const Color(0xFF112240),
                    content: Text(authState.error!, style: const TextStyle(color: Colors.redAccent)),
                  ),
                );
              }
            }
          }),
        ],
      ),
    );
  }

  Widget _buildSignupForm() {
    return Form(
      key: _signupFormKey,
      child: Column(
        key: const ValueKey('signup'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            controller: _nameController,
            hint: 'Enter your full name',
            icon: Icons.person_outlined,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _emailController,
            hint: 'Enter your email',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          _buildPhoneField(),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _passwordController,
            hint: 'Enter your password',
            icon: Icons.lock_outlined,
            isPassword: true,
            isPasswordVisible: _isPasswordVisible,
            onTogglePassword: () {
              setState(() => _isPasswordVisible = !_isPasswordVisible);
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _confirmPasswordController,
            hint: 'Confirm your password',
            icon: Icons.lock_outlined,
            isPassword: true,
            isPasswordVisible: _isConfirmPasswordVisible,
            onTogglePassword: () {
              setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible);
            },
          ),
          const SizedBox(height: 16),
          _buildTermsCheckbox(),
          const SizedBox(height: 24),
          _buildSubmitButton('Sign Up', () async {
            if (!_agreedToTerms) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Color(0xFF112240),
                  content: Text('Please agree to the Terms & Conditions', style: TextStyle(color: Colors.amber)),
                ),
              );
              return;
            }
            if (_signupFormKey.currentState!.validate()) {
              final authViewModel = ref.read(authViewModelProvider.notifier);
              await authViewModel.register(
                AuthEntity(
                  fullName: _nameController.text,
                  email: _emailController.text,
                  username: _emailController.text.split('@')[0],
                  password: _passwordController.text,
                  phoneNumber: '$_selectedCountryCode${_phoneController.text}',
                ),
              );
              
              final authState = ref.read(authViewModelProvider);
              if (authState.isSuccess && mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const DashboardPage()),
                );
              } else if (authState.error != null && mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: const Color(0xFF112240),
                    content: Text(authState.error!, style: const TextStyle(color: Colors.redAccent)),
                  ),
                );
              }
            }
          }),
        ],
      ),
    );
  }

  Widget _buildPhoneField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 110,
          decoration: BoxDecoration(
            color: const Color(0xFF0D1F35),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF1E3A5C)),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: const Color(0xFF112240),
            ),
            child: DropdownButtonFormField<String>(
              dropdownColor: const Color(0xFF112240),
              initialValue: _selectedCountryCode,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.transparent,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
              ),
              items: _countryCodes.map((country) {
                return DropdownMenuItem<String>(
                  value: country['code'],
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        country['flag']!,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        country['code']!,
                        style: const TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCountryCode = value!;
                });
              },
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildTextField(
            controller: _phoneController,
            hint: 'Phone Number',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
          ),
        ),
      ],
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: _agreedToTerms,
            checkColor: const Color(0xFF0A1628),
            activeColor: AppColors.primaryBlue,
            side: const BorderSide(color: Color(0xFF1E3A5C)),
            onChanged: (value) {
              setState(() {
                _agreedToTerms = value ?? false;
              });
            },
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            'I agree to the Terms & Conditions',
            style: TextStyle(color: Color(0xFF7AB8CC)),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    bool isPassword = false,
    bool isPasswordVisible = false,
    VoidCallback? onTogglePassword,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0D1F35),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1E3A5C)),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword && !isPasswordVisible,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF4A6B82)),
          prefixIcon: Icon(icon, color: const Color(0xFF7AB8CC)),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: const Color(0xFF7AB8CC),
                  ),
                  onPressed: onTogglePassword,
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
          if (hint.contains('email') && !value.contains('@')) {
            return 'Please enter a valid email';
          }
          if (hint.contains('password') && value.length < 6) {
            return 'Password must be at least 6 characters';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildSubmitButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1A3A5C),
          foregroundColor: AppColors.primaryBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Color(0xFF1E3A5C)),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFF1E3A5C))),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'OR',
            style: TextStyle(color: Color(0xFF4A6B82)),
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFF1E3A5C))),
      ],
    );
  }

  Widget _buildSocialLogin() {
    return Column(
      children: [
        const Text(
          'Continue with',
          style: TextStyle(color: Color(0xFF7AB8CC), fontSize: 14),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(Icons.g_mobiledata, 'Google', Colors.redAccent),
            const SizedBox(width: 20),
            _buildSocialButton(Icons.apple, 'Apple', Colors.white),
            const SizedBox(width: 20),
            _buildSocialButton(Icons.facebook, 'Facebook', Colors.blueAccent),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, String label, Color color) {
    return Container(
      width: 80,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF112240),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1E3A5C)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Color(0xFF7AB8CC), fontSize: 12),
          ),
        ],
      ),
    );
  }
}
