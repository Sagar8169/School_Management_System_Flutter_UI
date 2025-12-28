// lib/screens/class_teacher/settings_screen.dart
import 'package:flutter/material.dart';
import '../../routes/class_teacher_routes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _currentIndex = 3; // 'More' tab is active
  bool _isDarkMode = false;
  bool _isTelugu = true;

  final Color _primaryBlue = const Color(0xFF2979FF);
  final Color _bgGrey = const Color(0xFFFFFFFF);
  final Color _textDark = const Color(0xFF1A1A1A);
  final Color _lightBlueBtn = const Color(0xFFF2F6FF);
  final Color _iconBgBlue = const Color(0xFF2979FF);

  void _toggleLanguage() {
    setState(() {
      _isTelugu = !_isTelugu;
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    ClassTeacherRoutes.handleBottomNavTap(context, index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildCustomHeader(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileCard(),
                    const SizedBox(height: 24),
                    const Text(
                      'Preferences',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildMenuCard(
                      icon: Icons.nightlight_round,
                      title: 'Dark Mode',
                      trailing: Switch(
                        value: _isDarkMode,
                        onChanged: (val) => setState(() => _isDarkMode = val),
                        activeColor: Colors.white,
                        activeTrackColor: _primaryBlue,
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: Colors.grey.shade300,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildMenuCard(
                      icon: Icons.download_rounded,
                      title: 'Download Reports',
                      trailing: Icon(Icons.chevron_right, color: Colors.grey[600], size: 22),
                    ),
                    const SizedBox(height: 12),
                    _buildMenuCard(
                      icon: Icons.language,
                      title: 'Language Preferences',
                      trailing: Icon(Icons.chevron_right, color: Colors.grey[600], size: 22),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Support',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildMenuCard(
                      icon: Icons.security,
                      title: 'Privacy & Security',
                      trailing: Icon(Icons.chevron_right, color: Colors.grey[600], size: 22),
                    ),
                    const SizedBox(height: 12),
                    _buildMenuCard(
                      icon: Icons.headset_mic,
                      title: 'Contact Support',
                      trailing: Icon(Icons.chevron_right, color: Colors.grey[600], size: 22),
                    ),
                    const SizedBox(height: 12),
                    _buildMenuCard(
                      icon: Icons.info,
                      title: 'About Toki Tech',
                      trailing: Icon(Icons.chevron_right, color: Colors.grey[600], size: 22),
                    ),
                    const SizedBox(height: 24),
                    _buildLogoutButton(),
                    const SizedBox(height: 24),
                    _buildFooterVersion(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildCustomHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _primaryBlue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text('A', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Aditya International School',
                style: TextStyle(color: _textDark, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'Powered by Toki Tech',
                style: TextStyle(color: Colors.grey[400], fontSize: 11),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: _toggleLanguage,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _isTelugu ? 'తెలుగు' : 'English',
                style: TextStyle(color: _primaryBlue, fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _primaryBlue,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Mrs. Raghini Sharma',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Class Teacher: Class 8B',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: _showReadOnlyProfile,
            child: Container(
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(
                color: _lightBlueBtn,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  'View Profile',
                  style: TextStyle(
                    color: _primaryBlue,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showReadOnlyProfile() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Profile Details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _textDark),
                  ),
                ),
                const SizedBox(height: 24),
                _buildReadOnlyField("Name", "Mrs. Raghini Sharma"),
                _buildReadOnlyField("Employee ID", "EMP-2023-894"),
                _buildReadOnlyField("Designation", "Class Teacher"),
                _buildReadOnlyField("Class Assigned", "Class 8B"),
                _buildReadOnlyField("Email", "raghini.sharma@adityaschool.com"),
                _buildReadOnlyField("Phone", "+91 98765 43210"),
                const SizedBox(height: 24),
                Center(
                  child: Text(
                    "Read-only access",
                    style: TextStyle(color: Colors.grey[400], fontSize: 12, fontStyle: FontStyle.italic),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryBlue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Close", style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(color: _textDark, fontSize: 15, fontWeight: FontWeight.w500),
          ),
          Divider(color: Colors.grey[200]),
        ],
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required Widget trailing
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: _iconBgBlue,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, color: Colors.white, size: 14),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ),
          trailing,
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: _showLogoutConfirmation,
        borderRadius: BorderRadius.circular(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.logout, color: Color(0xFFFF5252), size: 20),
            SizedBox(width: 8),
            Text(
              'Logout',
              style: TextStyle(
                color: Color(0xFFFF5252),
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/', // Navigate to login screen
                    (route) => false,
              );
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterVersion() {
    return Center(
      child: Column(
        children: [
          Text(
            'Version 2.0.1',
            style: TextStyle(color: Colors.grey[500], fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            '© 2025 Toki Tech',
            style: TextStyle(color: Colors.grey[500], fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: _primaryBlue,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(_currentIndex == 0 ? Icons.home_filled : Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(_currentIndex == 1 ? Icons.search : Icons.search_outlined),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _currentIndex == 2 ? const Color(0xFFEADDFF) : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.show_chart, size: 22),
            ),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(_currentIndex == 3 ? Icons.more_vert : Icons.more_vert_outlined),
            label: 'More',
          ),
        ],
      ),
    );
  }
}