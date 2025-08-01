import 'package:frontend/utils/import_export.dart';

// Re-using the same UI constants for a consistent look
const Color kPrimaryColor = Color(0xFFD32F2F);
const Color kDarkText = Color(0xFF333333);

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions', style: TextStyle(color: kDarkText)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: kDarkText),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: '1. Introduction',
              content: 'Welcome to our application. By creating an account, you agree to be bound by these Terms and Conditions. Please read them carefully.',
            ),
            _buildSection(
              title: '2. User Accounts',
              content: 'You are responsible for maintaining the confidentiality of your account and password. You agree to accept responsibility for all activities that occur under your account.',
            ),
            _buildSection(
              title: '3. Prohibited Activities',
              content: 'You may not use the service for any illegal or unauthorized purpose. Users agree to comply with all local laws regarding online conduct and acceptable content.',
            ),
            _buildSection(
              title: '4. Privacy Policy',
              content: 'Our Privacy Policy, which is available on our website, describes how we handle the information you provide to us when you use our services. You understand that through your use of the services you consent to the collection and use of this information.',
            ),
            _buildSection(
              title: '5. Changes to Terms',
              content: 'We reserve the right to modify these terms at any time. We will notify you of any changes by posting the new Terms and Conditions on this page.',
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for consistent section styling
  Widget _buildSection({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kDarkText),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(fontSize: 16, color: Colors.black54, height: 1.5),
          ),
        ],
      ),
    );
  }
}