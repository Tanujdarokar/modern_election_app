import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';

class NotificationsSettingsScreen extends StatefulWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  State<NotificationsSettingsScreen> createState() => _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState extends State<NotificationsSettingsScreen> {
  final AuthController _authController = AuthController();
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  bool _updateAlerts = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final enabled = await _authController.isNotificationsEnabled();
    final sound = await _authController.isNotificationSoundEnabled();
    setState(() {
      _notificationsEnabled = enabled;
      _soundEnabled = sound;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Notifications', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('GENERAL'),
            _buildSwitchTile(
              Icons.notifications_active_outlined,
              'Allow Notifications',
              'Receive alerts and updates',
              _notificationsEnabled,
              (val) async {
                await _authController.setNotificationsEnabled(val);
                setState(() => _notificationsEnabled = val);
              },
            ),
            const SizedBox(height: 30),
            _buildSectionHeader('ALERTS'),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10)],
              ),
              child: Column(
                children: [
                  _buildSwitchTile(
                    Icons.volume_up_outlined,
                    'Sound',
                    'Play sound for notifications',
                    _soundEnabled,
                    (val) async {
                      await _authController.setNotificationSound(val);
                      setState(() => _soundEnabled = val);
                    },
                    isFirst: true,
                  ),
                  Divider(height: 1, indent: 60, color: Colors.grey[100]),
                  _buildSwitchTile(
                    Icons.vibration_rounded,
                    'Vibration',
                    'Vibrate on new alert',
                    _vibrationEnabled,
                    (val) => setState(() => _vibrationEnabled = val),
                  ),
                  Divider(height: 1, indent: 60, color: Colors.grey[100]),
                  _buildSwitchTile(
                    Icons.update_rounded,
                    'Election Updates',
                    'Live results and news',
                    _updateAlerts,
                    (val) => setState(() => _updateAlerts = val),
                    isLast: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildSectionHeader('PREVIEW'),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.indigo[50],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.indigo[100]!),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline_rounded, color: Colors.indigo),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Notifications are sent to inform you about registration deadlines and important election dates.',
                      style: TextStyle(color: Colors.indigo[900], fontSize: 13, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
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
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.2),
      ),
    );
  }

  Widget _buildSwitchTile(
    IconData icon,
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged, {
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(isFirst ? 20 : 0),
          bottom: Radius.circular(isLast ? 20 : 0),
        ),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: Colors.indigo[700], size: 20),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: Colors.indigo,
        ),
      ),
    );
  }
}
