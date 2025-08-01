import 'package:frontend/utils/import_export.dart';

const Color kPrimaryColor = Color(0xFFD32F2F);
const Color kLightGrey = Color(0xFFF7F8FC);
const Color kDarkText = Color(0xFF333333);
const Color kSubtleText = Color(0xFF666666);

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _termsAccepted = false;

  // Future<void> _submitSignUp() async {
  //   // ... (validation code remains the same)
  //
  //   FocusScope.of(context).unfocus();
  //   setState(() => _isLoading = true);
  //
  //   await Future.delayed(const Duration(seconds: 2));
  //
  //   if (mounted) {
  //     // MODIFICATION: Add the mobile number to the userData map
  //     final userData = {
  //       'username': _usernameController.text,
  //       'email': _emailController.text,
  //       'mobile': _mobileController.text, // <-- ADD THIS LINE
  //       'password': _passwordController.text, // Be careful with passwords
  //     };
  //     // The navigation call now sends all three pieces of info
  //     context.go('/verify-otp', extra: userData);
  //   }
  // }

  Future<void> _submitSignUp() async {
    // Validate form first
    if (!_formKey.currentState!.validate()) return;

    // Check if terms are accepted
    if (!_termsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You must accept the Terms & Conditions to continue.'),
        backgroundColor: kPrimaryColor,
      ));
      return;
    }

    FocusScope.of(context).unfocus();
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      final userData = {
        'username': _usernameController.text,
        'email': _emailController.text,
        'mobile': _mobileController.text,
      };
      context.go('/verify-otp', extra: userData);
    }
    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, kLightGrey],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Image.asset('assets/images/Golek-dark.jpg', height: 70),
                  const SizedBox(height: 40),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Create Your Account', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: kDarkText)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(controller: _usernameController, decoration: _buildInputDecoration(labelText: 'Username', icon: Icons.person_outline), validator: (v) => v!.isEmpty ? 'Username is required.' : null),
                  const SizedBox(height: 16),
                  TextFormField(controller: _mobileController, keyboardType: TextInputType.phone, maxLength: 10, decoration: _buildInputDecoration(labelText: 'Mobile Number', icon: Icons.phone_outlined), validator: (v) => v!.length != 10 ? 'Enter a valid 10-digit number.' : null),
                  const SizedBox(height: 16),
                  TextFormField(controller: _emailController, keyboardType: TextInputType.emailAddress, decoration: _buildInputDecoration(labelText: 'Email Address', icon: Icons.email_outlined), validator: (v) => (v!.isEmpty || !v.contains('@')) ? 'Enter a valid email.' : null),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: _buildInputDecoration(
                      labelText: 'Password',
                      icon: Icons.lock_outline,
                    ).copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(_isPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: kSubtleText),
                        onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                      ),
                    ),
                    validator: (v) => (v!.length < 6) ? 'Password must be at least 6 characters.' : null,
                  ),
                  const SizedBox(height: 20),

                  // --- TERMS & CONDITIONS WIDGET ---
                  GestureDetector(
                    onTap: () => setState(() => _termsAccepted = !_termsAccepted),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _termsAccepted,
                          onChanged: (value) => setState(() => _termsAccepted = value ?? false),
                          activeColor: kPrimaryColor,
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(fontSize: 14, color: kSubtleText),
                              children: [
                                const TextSpan(text: 'I agree to the '),
                                TextSpan(
                                  text: 'Terms & Conditions',
                                  style: const TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()..onTap = () => context.push('/terms'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _submitSignUp,
                      style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),
                      child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('Create Account', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?", style: TextStyle(color: kSubtleText)),
                      TextButton(
                        onPressed: () => context.go('/login'),
                        child: const Text('Login', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration({required String labelText, required IconData icon}) {
    return InputDecoration(
      counterText: "",
      labelText: labelText,
      labelStyle: const TextStyle(color: kSubtleText),
      prefixIcon: Icon(icon, color: kSubtleText, size: 20),
      isDense: true,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: const BorderSide(color: kLightGrey)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: const BorderSide(color: kPrimaryColor, width: 2)),
    );
  }
}