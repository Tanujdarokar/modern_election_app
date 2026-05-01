import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import 'login_view.dart';
import 'support_view.dart';
import 'security_view.dart';
import 'notifications_view.dart';
import 'language_view.dart';
import 'appearance_view.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AuthController _authController = AuthController();
  String _userName = 'Loading...';
  String _userEmail = 'Loading...';
  String _themeMode = 'system';
  String _language = 'en';

  @override
  void initState() {
    super.initState();
    _loadAllPreferences();
  }

  // Optimized: Load all data in a single batch
  Future<void> _loadAllPreferences() async {
    final results = await Future.wait([
      _authController.getUserName(),
      _authController.getUserEmail(),
      _authController.getThemeMode(),
      _authController.getLanguage(),
    ]);

    if (mounted) {
      setState(() {
        _userName = results[0] ?? 'Election Officer';
        _userEmail = results[1] ?? 'officer@election.gov';
        _themeMode = results[2] as String;
        _language = results[3] as String;
      });
    }
  }

  Future<void> _handleEditProfile() async {
    final nameController = TextEditingController(text: _userName);
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Name'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Display Name',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, nameController.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (result != null && result.trim().isNotEmpty) {
      await _authController.updateName(result.trim());
      setState(() => _userName = result.trim());
    }
  }

  Future<void> _logout(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _authController.logout();
      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            title: const Text(
              'Settings',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: isDark ? Colors.grey[900] : Colors.white,
            foregroundColor: isDark ? Colors.white : Colors.black,
            surfaceTintColor: Colors.transparent,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _buildUserCard(colorScheme, isDark),
                  const SizedBox(height: 30),
                  _buildSettingsGroup(
                    title: 'Account',
                    isDark: isDark,
                    items: [
                      _SettingsItem(
                        Icons.person_outline,
                        'Profile Details',
                        _userName,
                        onTap: _handleEditProfile,
                      ),
                      _SettingsItem(
                        Icons.security_rounded,
                        'Security',
                        'Password and biometric',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SecurityScreen(),
                          ),
                        ),
                      ),
                      _SettingsItem(
                        Icons.notifications_none_rounded,
                        'Notifications',
                        'Alerts & updates',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const NotificationsSettingsScreen(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildSettingsGroup(
                    title: 'Preferences',
                    isDark: isDark,
                    items: [
                      _SettingsItem(
                        Icons.palette_outlined,
                        'Appearance',
                        _themeMode[0].toUpperCase() + _themeMode.substring(1),
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const AppearanceSettingsScreen(),
                            ),
                          );
                          _loadAllPreferences(); // Refresh theme state
                        },
                      ),
                      _SettingsItem(
                        Icons.language_rounded,
                        'Language',
                        _language == 'en'
                            ? 'English'
                            : (_language == 'hi' ? 'Hindi' : 'Marathi'),
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const LanguageSettingsScreen(),
                            ),
                          );
                          _loadAllPreferences(); // Refresh language state
                        },
                      ),
                      _SettingsItem(
                        Icons.help_outline_rounded,
                        'Help & Support',
                        'FAQ & contact',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SupportScreen(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => _logout(context),
                      icon: const Icon(Icons.logout_rounded),
                      label: const Text(
                        'Logout Account',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(
                          color: Colors.redAccent,
                          width: 1.5,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(color: Colors.grey[400], fontSize: 12),
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserCard(ColorScheme colorScheme, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primary,
            colorScheme.primary.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Colors.white24,
              shape: BoxShape.circle,
            ),
            child: const CircleAvatar(
              radius: 35,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Colors.indigo),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _userEmail,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: _handleEditProfile,
            icon: const Icon(Icons.edit_note_rounded, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup({
    required String title,
    required List<_SettingsItem> items,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[900] : Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: isDark ? Border.all(color: Colors.grey[800]!) : null,
            boxShadow: [
              if (!isDark)
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final idx = entry.key;
              final item = entry.value;
              return Column(
                children: [
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[800] : Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        item.icon,
                        color: isDark ? Colors.indigo[300] : Colors.indigo[700],
                        size: 22,
                      ),
                    ),
                    title: Text(
                      item.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Text(
                      item.subtitle,
                      style: TextStyle(color: Colors.grey[500], fontSize: 13),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.grey,
                      size: 20,
                    ),
                    onTap: item.onTap,
                  ),
                  if (idx < items.length - 1)
                    Divider(
                      height: 1,
                      indent: 60,
                      endIndent: 20,
                      color: isDark ? Colors.grey[800] : Colors.grey[100],
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _SettingsItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  _SettingsItem(
    this.icon,
    this.title,
    this.subtitle, {
    this.onTap,
  });
}
