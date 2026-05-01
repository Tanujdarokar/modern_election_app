import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static const String _keyEmail = 'user_email';
  static const String _keyPassword = 'user_password';
  static const String _keyName = 'user_name';
  static const String _keyIsLoggedIn = 'is_logged_in';

  Future<bool> register(String name, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString(_keyName, name);
      await prefs.setString(_keyEmail, email);
      await prefs.setString(_keyPassword, password);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString(_keyEmail);
    final savedPassword = prefs.getString(_keyPassword);

    if (savedEmail == email && savedPassword == password) {
      await prefs.setBool(_keyIsLoggedIn, true);
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, false);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }
  
  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyName);
  }

  Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail);
  }

  Future<void> updateName(String newName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyName, newName);
  }

  Future<void> updatePassword(String newPassword) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyPassword, newPassword);
  }

  Future<bool> verifyPassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPassword) == password;
  }

  Future<void> setBiometrics(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('biometrics_enabled', enabled);
  }

  Future<bool> isBiometricsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('biometrics_enabled') ?? false;
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', enabled);
  }

  Future<bool> isNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('notifications_enabled') ?? true;
  }

  Future<void> setNotificationSound(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notification_sound', enabled);
  }

  Future<bool> isNotificationSoundEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('notification_sound') ?? true;
  }

  Future<void> setLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_language', languageCode);
  }

  Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('app_language') ?? 'en';
  }

  Future<void> setThemeMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', mode);
  }

  Future<String> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('theme_mode') ?? 'system';
  }

  Future<void> setDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_mode', value);
  }

  Future<bool> isDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('dark_mode') ?? false;
  }
}
