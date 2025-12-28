import 'package:flutter/material.dart';

class FleetSettingsPage extends StatefulWidget {
  const FleetSettingsPage({Key? key}) : super(key: key);

  @override
  State<FleetSettingsPage> createState() => _FleetSettingsPageState();
}

class _FleetSettingsPageState extends State<FleetSettingsPage> {
  final Color primaryTeal = const Color(0xFF0D9488);

  // States for dummy interactivity
  bool _pushNotifications = true;
  bool _darkMode = false;

  // --- DUMMY DIALOG FOR INFO & PRIVACY ---
  void _showDummyInfo(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
        content: Text(content, style: const TextStyle(color: Colors.blueGrey, fontSize: 14)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: Color(0xFF0D9488), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildSettingsHeader(context),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              physics: const BouncingScrollPhysics(),
              children: [
                _settingSection('PREFERENCES'),

                // Working Push Notifications
                _settingTile(
                  Icons.notifications_active_rounded,
                  Colors.orange,
                  'Push Notifications',
                  isSwitch: true,
                  switchValue: _pushNotifications,
                  onChanged: (val) => setState(() => _pushNotifications = val),
                ),

                // Working Dark Mode Toggle
                _settingTile(
                  Icons.dark_mode_rounded,
                  Colors.purple,
                  'Dark Mode',
                  isSwitch: true,
                  switchValue: _darkMode,
                  onChanged: (val) => setState(() => _darkMode = val),
                ),

                _settingTile(
                  Icons.language_rounded,
                  Colors.blue,
                  'App Language',
                  trailing: 'English',
                  onTap: () => _showDummyInfo("SettingsLanguage", "Multilingual support (Telugu/English) is being updated."),
                ),

                const SizedBox(height: 25),

                _settingSection('SECURITY & DATA'),
                _settingTile(
                  Icons.lock_rounded,
                  Colors.teal,
                  'Change Password',
                  onTap: () => _showDummyInfo("Security", "Password reset link has been sent to your registered email."),
                ),
                _settingTile(
                  Icons.privacy_tip_rounded,
                  Colors.blueGrey,
                  'Privacy Policy',
                  onTap: () => _showDummyInfo("Privacy", "Your data is secured with end-to-end encryption under Toki Tech standards."),
                ),
                _settingTile(
                  Icons.info_outline_rounded,
                  Colors.indigo,
                  'About Fleet System',
                  onTap: () => _showDummyInfo("About System", "Fleet Manager v2.4.0\nDesigned for Aditya International School."),
                ),

                const SizedBox(height: 40),
                Center(
                  child: Column(
                    children: [
                      Text('Last Sync: Today, 10:30 AM',
                          style: TextStyle(color: Colors.grey.shade400, fontSize: 12, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      const Text('System Status: Optimized', style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsHeader(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0F766E), Color(0xFF14B8A6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                'App Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _settingSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 12, top: 10),
      child: Text(title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.grey.shade500, letterSpacing: 1.5)),
    );
  }

  Widget _settingTile(IconData icon, Color color, String title, {bool isSwitch = false, bool switchValue = false, Function(bool)? onChanged, String? trailing, VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.04)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.01), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF1E293B))),
        trailing: isSwitch
            ? Switch.adaptive(
            value: switchValue,
            activeColor: primaryTeal,
            onChanged: onChanged
        )
            : Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (trailing != null) Text(trailing, style: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w600)),
            const SizedBox(width: 5),
            const Icon(Icons.chevron_right_rounded, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }
}