import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'views/splash_view.dart';
import 'controllers/auth_controller.dart';

void main() {
  runApp(const ElectionAssistantApp());
}

class ElectionAssistantApp extends StatefulWidget {
  const ElectionAssistantApp({super.key});

  static ElectionAssistantAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<ElectionAssistantAppState>();

  @override
  State<ElectionAssistantApp> createState() => ElectionAssistantAppState();
}

class ElectionAssistantAppState extends State<ElectionAssistantApp> {
  ThemeMode _themeMode = ThemeMode.system;
  final AuthController _authController = AuthController();

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final mode = await _authController.getThemeMode();
    setState(() {
      _themeMode = _getThemeModeFromString(mode);
    });
  }

  ThemeMode _getThemeModeFromString(String mode) {
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  void changeTheme(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Election Guide AI',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4F46E5),
          primary: const Color(0xFF4F46E5),
          secondary: const Color(0xFF10B981),
          surface: Colors.white,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          color: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          primary: const Color(0xFF6366F1),
          secondary: const Color(0xFF10B981),
          surface: const Color(0xFF0F172A),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          color: const Color(0xFF1E293B),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
