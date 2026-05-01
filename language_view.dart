import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';

class LanguageSettingsScreen extends StatefulWidget {
  const LanguageSettingsScreen({super.key});

  @override
  State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  final AuthController _authController = AuthController();
  String _selectedLanguage = 'en';

  final List<Map<String, String>> _languages = [
    {'name': 'English (default)', 'code': 'en', 'native': 'English'},
    {'name': 'Hindi', 'code': 'hi', 'native': 'हिन्दी'},
    {'name': 'Marathi', 'code': 'mr', 'native': 'मराठी'},
    {'name': 'Spanish', 'code': 'es', 'native': 'Español'},
    {'name': 'French', 'code': 'fr', 'native': 'Français'},
    {'name': 'Bengali', 'code': 'bn', 'native': 'বাংলা'},
    {'name': 'Telugu', 'code': 'te', 'native': 'తెలుగు'},
  ];

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final lang = await _authController.getLanguage();
    setState(() => _selectedLanguage = lang);
  }

  Future<void> _selectLanguage(String code) async {
    await _authController.setLanguage(code);
    setState(() => _selectedLanguage = code);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Language updated to ${_languages.firstWhere((l) => l['code'] == code)['name']}'),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
      // To see actual language change throughout the app, you'd need to rebuild the entire app 
      // usually via a Locale provider in main.dart.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Language', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: _languages.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final lang = _languages[index];
          final isSelected = _selectedLanguage == lang['code'];

          return InkWell(
            onTap: () => _selectLanguage(lang['code']!),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected ? Colors.indigo[50] : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? Colors.indigo : Colors.grey[200]!,
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: [
                  if (!isSelected)
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    )
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lang['name']!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: isSelected ? Colors.indigo[900] : Colors.black87,
                          ),
                        ),
                        Text(
                          lang['native']!,
                          style: TextStyle(
                            color: isSelected ? Colors.indigo[700] : Colors.grey[500],
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    const Icon(Icons.check_circle_rounded, color: Colors.indigo)
                  else
                    Icon(Icons.circle_outlined, color: Colors.grey[300]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
