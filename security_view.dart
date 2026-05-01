import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  final AuthController _authController = AuthController();
  bool _biometricsEnabled = false;
  final _formKey = GlobalKey<FormState>();
  final _currentPassController = TextEditingController();
  final _newPassController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSecuritySettings();
  }

  Future<void> _loadSecuritySettings() async {
    final enabled = await _authController.isBiometricsEnabled();
    setState(() => _biometricsEnabled = enabled);
  }

  Future<void> _changePassword() async {
    if (_formKey.currentState!.validate()) {
      final isCorrect = await _authController.verifyPassword(
        _currentPassController.text,
      );
      if (!isCorrect) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Current password is incorrect'),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
        return;
      }

      await _authController.updatePassword(_newPassController.text);
      _currentPassController.clear();
      _newPassController.clear();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Security',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('AUTHENTICATION'),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.fingerprint_rounded,
                  color: Colors.indigo,
                ),
                title: const Text(
                  'Biometric Login',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: const Text('Use fingerprint or face ID'),
                trailing: Switch(
                  value: _biometricsEnabled,
                  onChanged: (value) async {
                    await _authController.setBiometrics(value);
                    setState(() => _biometricsEnabled = value);
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),
            _buildSectionHeader('CHANGE PASSWORD'),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _currentPassController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Current Password',
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (v) =>
                          v!.isEmpty ? 'Enter current password' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _newPassController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        prefixIcon: const Icon(Icons.lock_reset_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (v) => v!.length < 6
                          ? 'Password must be at least 6 chars'
                          : null,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _changePassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo[900],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Update Password',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            _buildSectionHeader('DEVICE HISTORY'),
            _buildHistoryTile('Last Login', 'Today, 10:45 AM', 'Android 14'),
            _buildHistoryTile('Account Created', 'Oct 12, 2023', 'Web Portal'),
            const SizedBox(height: 30),
            _buildSectionHeader('PRIVACY NOTE'),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.indigo.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.indigo.withValues(alpha: 0.1)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.shield_outlined, color: Colors.indigo),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Your sensitive data (including vault documents) is stored locally on this device using 256-bit encryption standards. We never upload your personal IDs to any server.',
                      style: TextStyle(fontSize: 13, height: 1.5, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildHistoryTile(String title, String date, String device) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(
                device,
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
            ],
          ),
          Text(
            date,
            style: TextStyle(
              color: Colors.indigo[700],
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
