import 'package:flutter/material.dart';
import 'package:toki/routes/subject_teacher_routes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  bool _isTelugu = false;

  final Color _primaryPurple = const Color(0xFF7C3AED);
  final Color _bgLight = const Color(0xFFF8FAFC);

  // ✅ LOGIC: View Profile Details
  void _showReadOnlyProfile() {
    Navigator.pushNamed(
      context,
      SubjectTeacherRoutes.profile,
      arguments: {
        'name': 'Mr. Vijay Prasad',
        'role': 'Senior Science Teacher',
        'employeeId': 'ST2024',
        'department': 'Science',
        'phone': '+91 98765 43210',
        'email': 'vijay.prasad@adityaschool.edu',
        'address': '123 Staff Quarters, School Campus',
        'joinDate': 'January 15, 2020',
        'workLocation': 'Main Campus',
        'subjects': 'Science',
        'assignedClass': '8B, 9A, 10C',
      },
    );
  }

  // ✅ LOGIC: Logout Confirmation
  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Logout Session',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text(
            'Are you sure you want to logout from Aditya International School?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.grey))),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // --- 🟢 DYNAMIC BOTTOM SHEETS (Safe Area Optimized) ---

  void _showCustomSheet(
      {required String title, required String desc, required IconData icon}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final bottomGap = MediaQuery.of(context).padding.bottom;
        return Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
          padding: EdgeInsets.fromLTRB(24, 12, 24, bottomGap + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10))),
              const SizedBox(height: 24),
              Icon(icon, size: 45, color: _primaryPurple),
              const SizedBox(height: 16),
              Text(title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text(desc,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey[600], fontSize: 14, height: 1.5)),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: _primaryPurple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: const Text("Understood",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold))),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showContactSupport() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        padding: EdgeInsets.fromLTRB(
            24, 12, 24, MediaQuery.of(context).padding.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10))),
            const SizedBox(height: 20),
            const Text("Contact Support",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _supportItem(
                Icons.call, "Call Helpline", "+91 800-123-4567", Colors.blue),
            _supportItem(
                Icons.mail, "Email Support", "help@tokitech.edu", Colors.green),
            _supportItem(
                Icons.chat, "WhatsApp Support", "Instant Chat", Colors.teal),
          ],
        ),
      ),
    );
  }

  Widget _supportItem(IconData icon, String t, String s, Color c) => ListTile(
        leading: CircleAvatar(
            backgroundColor: c.withOpacity(0.1),
            child: Icon(icon, color: c, size: 18)),
        title: Text(t,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(s, style: const TextStyle(fontSize: 12)),
        onTap: () => Navigator.pop(context),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      body: SafeArea(
        child: Column(
          children: [
            _buildExactHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileCard(),
                    const SizedBox(height: 32),
                    _buildSectionLabel("Preferences"),
                    const SizedBox(height: 12),
                    _buildMenuCard(
                      icon: Icons.nightlight_round,
                      title: 'Dark Mode',
                      trailing: Switch(
                          value: _isDarkMode,
                          onChanged: (v) => setState(() => _isDarkMode = v),
                          activeTrackColor: _primaryPurple),
                    ),
                    _buildMenuCard(
                      icon: Icons.file_download_outlined,
                      title: 'Download Reports',
                      onTap: () => _showCustomSheet(
                          title: "Academic Reports",
                          desc:
                              "Generating PDF reports for your assigned classes. You will be notified once they are ready for download.",
                          icon: Icons.cloud_download),
                      trailing: const Icon(Icons.chevron_right,
                          size: 20, color: Colors.grey),
                    ),
                    _buildMenuCard(
                      icon: Icons.language_rounded,
                      title: 'Language Preferences',
                      onTap: () => _showCustomSheet(
                          title: "App Language",
                          desc:
                              "App language is currently set to English. Telugu support is being optimized in the next update.",
                          icon: Icons.translate),
                      trailing: const Icon(Icons.chevron_right,
                          size: 20, color: Colors.grey),
                    ),
                    const SizedBox(height: 24),
                    _buildSectionLabel("Support & Legal"),
                    const SizedBox(height: 12),
                    _buildMenuCard(
                      icon: Icons.security_outlined,
                      title: 'Privacy & Security',
                      onTap: () => _showCustomSheet(
                          title: "Data Security",
                          desc:
                              "Your teaching data is encrypted. We strictly follow school data protection policies.",
                          icon: Icons.verified_user),
                      trailing: const Icon(Icons.chevron_right,
                          size: 20, color: Colors.grey),
                    ),
                    _buildMenuCard(
                      icon: Icons.headset_mic_outlined,
                      title: 'Contact Support',
                      onTap: _showContactSupport,
                      trailing: const Icon(Icons.chevron_right,
                          size: 20, color: Colors.grey),
                    ),
                    _buildMenuCard(
                      icon: Icons.info_outline,
                      title: 'About Toki Tech',
                      onTap: () => _showCustomSheet(
                          title: "Toki Tech v2.0.1",
                          desc:
                              "The ultimate school management companion. Empowering educators since 2025.",
                          icon: Icons.auto_awesome),
                      trailing: const Icon(Icons.chevron_right,
                          size: 20, color: Colors.grey),
                    ),
                    const SizedBox(height: 32),
                    _buildLogoutButton(),
                    const SizedBox(height: 24),
                    _buildFooterVersion(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- UI BUILDING BLOCKS ---

  Widget _buildExactHeader() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 1)]),
        child: Row(
          children: [
            Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                    color: _primaryPurple,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                    child: Text("ST",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold)))),
            const SizedBox(width: 12),
            const Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text("Settings",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("Aditya International School",
                      style: TextStyle(fontSize: 10, color: Colors.grey))
                ])),
            _langBadge(),
          ],
        ),
      );

  Widget _buildProfileCard() => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20)
            ]),
        child: Column(
          children: [
            Row(children: [
              CircleAvatar(
                  radius: 28,
                  backgroundColor: _primaryPurple.withOpacity(0.1),
                  child: Icon(Icons.person_3_rounded,
                      color: _primaryPurple, size: 30)),
              const SizedBox(width: 16),
              const Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text("Mr. Vijay Prasad",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w900)),
                    Text("Senior Science Teacher",
                        style: TextStyle(fontSize: 13, color: Colors.grey))
                  ])),
            ]),
            const SizedBox(height: 16),
            SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                    onPressed: _showReadOnlyProfile,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: _primaryPurple.withOpacity(0.08),
                        foregroundColor: _primaryPurple,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14))),
                    child: const Text("View Profile Details",
                        style: TextStyle(fontWeight: FontWeight.w800)))),
          ],
        ),
      );

  Widget _buildMenuCard(
          {required IconData icon,
          required String title,
          required Widget trailing,
          VoidCallback? onTap}) =>
      InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.black.withOpacity(0.02))),
          child: Row(children: [
            Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: _bgLight, borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: _primaryPurple, size: 20)),
            const SizedBox(width: 16),
            Expanded(
                child: Text(title,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF334155)))),
            trailing,
          ]),
        ),
      );

  Widget _buildSectionLabel(String t) => Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(t.toUpperCase(),
          style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w900,
              color: Colors.grey,
              letterSpacing: 1.2)));

  Widget _buildLogoutButton() => SizedBox(
      width: double.infinity,
      height: 58,
      child: OutlinedButton(
          onPressed: _showLogoutConfirmation,
          style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.redAccent, width: 1.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18))),
          child: const Text("Logout Session",
              style: TextStyle(
                  color: Colors.redAccent, fontWeight: FontWeight.w900))));

  Widget _langBadge() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
          border: Border.all(color: _primaryPurple.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(20)),
      child: Text(_isTelugu ? 'తెలుగు' : 'English',
          style: TextStyle(
              color: _primaryPurple,
              fontSize: 12,
              fontWeight: FontWeight.w800)));

  Widget _buildFooterVersion() => const Center(
      child: Text("Toki Tech • v2.0.1",
          style: TextStyle(
              color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)));
}
