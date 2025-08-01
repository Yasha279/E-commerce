import 'package:frontend/utils/import_export.dart';
import 'package:get/get.dart';
import 'package:frontend/theme/app_theme.dart';
import '../../controllers/user_controller.dart';

class OTPVerificationScreen extends StatefulWidget {
  final Map<String, dynamic> userData;
  const OTPVerificationScreen({super.key, required this.userData});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // --- Resend OTP Timer Logic ---
  late Timer _timer;
  int _secondsRemaining = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _canResend = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer.cancel();
        setState(() {
          _canResend = true;
        });
      }
    });
  }

  void _resendOtp() {
    // In a real app, call your API to resend the OTP
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('A new OTP has been sent.')),
    );
    setState(() {
      _secondsRemaining = 60;
    });
    _startTimer();
  }

  Future<void> _verifyOtp() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 2));

    if (_otpController.text == "123456") {
      if (mounted) {
        // ✅ FIX: Extract username correctly from the userData map.
        final String usernameFromSignup = widget.userData['username'] ?? 'User';
        final userController = Get.find<UserController>();
        userController.loginUser(newUsername: usernameFromSignup);
        context.go('/home');
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Invalid OTP. Please try again.'),
            backgroundColor: AppTheme.primaryRed,
          ),
        );
      }
    }
    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _timer.cancel();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String emailForDisplay = widget.userData['email'] ?? 'your email';

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      decoration: BoxDecoration(
        // ✅ THEME: Used AppTheme color
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );

    return Scaffold(
      // ✅ THEME: Used AppTheme color
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        // ✅ THEME: Used AppTheme color
        backgroundColor: AppTheme.surface,
        elevation: 0,
        // ✅ THEME: Used AppTheme color
        iconTheme: const IconThemeData(color: AppTheme.textDark),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Image.asset('assets/images/Golek-dark.jpg', height: 70),
                const SizedBox(height: 50),
                Text(
                  'Verify Your Account',
                  // ✅ THEME: Used AppTheme color
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.textDark),
                ),
                const SizedBox(height: 12),
                Text(
                  'Enter the 6-digit code sent to\n$emailForDisplay',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: AppTheme.textLight, height: 1.5),
                ),
                const SizedBox(height: 40),
                Pinput(
                  length: 6,
                  controller: _otpController,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      // ✅ THEME: Used AppTheme color
                      border: Border.all(color: AppTheme.primaryRed),
                    ),
                  ),
                  validator: (value) => value == '123456' ? null : 'Pin is incorrect',
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _verifyOtp,
                    style: ElevatedButton.styleFrom(
                      // ✅ THEME: Used AppTheme colors
                        backgroundColor: AppTheme.primaryRed,
                        foregroundColor: AppTheme.surface,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Verify Account', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ✅ THEME: Used AppTheme color
                    const Text("Didn't receive the code?", style: TextStyle(color: AppTheme.textLight)),
                    TextButton(
                      onPressed: _canResend ? _resendOtp : null,
                      child: Text(
                        _canResend ? 'Resend OTP' : 'Resend in $_secondsRemaining' + 's',
                        style: TextStyle(
                          // ✅ THEME: Used AppTheme colors
                          color: _canResend ? AppTheme.primaryRed : AppTheme.textLight,
                          fontWeight: FontWeight.bold,
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
    );
  }
}