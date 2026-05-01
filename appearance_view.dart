import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../main.dart';

class AppearanceSettingsScreen extends StatefulWidget {
  const AppearanceSettingsScreen({super.key});

  @override
  State<AppearanceSettingsScreen> createState() =>
      _AppearanceSettingsScreenState();
}

class _AppearanceSettingsScreenState extends State<AppearanceSettingsScreen> {
  final AuthController _authController = AuthController();
  String _selectedTheme = 'system';

  final List<Map<String, dynamic>> _themes = [
    {
      'name': 'System Default',
      'mode': 'system',
      'icon': Icons.brightness_auto_rounded,
      'desc': 'Matches your phone\'s system settings',
    },
    {
      'name': 'Light Mode',
      'mode': 'light',
      'icon': Icons.light_mode_rounded,
      'desc': 'Classic bright appearance',
    },
    {
      'name': 'Dark Mode',
      'mode': 'dark',
      'icon': Icons.dark_mode_rounded,
      'desc': 'Easy on the eyes in low light',
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final theme = await _authController.getThemeMode();
    setState(() => _selectedTheme = theme);
  }

  Future<void> _updateTheme(String mode) async {
    await _authController.setThemeMode(mode);
    setState(() => _selectedTheme = mode);

    if (mounted) {
      final appState = ElectionAssistantApp.of(context);
      if (mode == 'light') {
        appState?.changeTheme(ThemeMode.light);
      } else if (mode == 'dark') {
        appState?.changeTheme(ThemeMode.dark);
      } else {
        appState?.changeTheme(ThemeMode.system);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.grey[50]
          : Colors.grey[900],
      appBar: AppBar(
        title: const Text(
          'Appearance',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: _themes.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final theme = _themes[index];
          final isSelected = _selectedTheme == theme['mode'];
          final isDark = Theme.of(context).brightness == Brightness.dark;

          return InkWell(
            onTap: () => _updateTheme(theme['mode']),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.indigo.withValues(alpha: 0.1)
                    : (isDark ? Colors.grey[850] : Colors.white),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? Colors.indigo
                      : (isDark ? Colors.grey[800]! : Colors.grey[200]!),
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.indigo
                          : (isDark ? Colors.grey[800] : Colors.grey[100]),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      theme['icon'],
                      color: isSelected
                          ? Colors.white
                          : (isDark ? Colors.white70 : Colors.indigo),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          theme['name'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: isSelected
                                ? Colors.indigo
                                : (isDark ? Colors.white : Colors.black87),
                          ),
                        ),
                        Text(
                          theme['desc'],
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark ? Colors.white60 : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    const Icon(
                      Icons.check_circle_rounded,
                      color: Colors.indigo,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
