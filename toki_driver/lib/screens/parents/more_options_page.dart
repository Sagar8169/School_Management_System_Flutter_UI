// lib/screens/parents/more_options_page.dart
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class MoreOptionsPage extends StatefulWidget {
  const MoreOptionsPage({Key? key}) : super(key: key);

  @override
  _MoreOptionsPageState createState() => _MoreOptionsPageState();
}

class _MoreOptionsPageState extends State<MoreOptionsPage> {
  String _selectedLanguage = 'తెలుగు';
  int _currentIndex = 3;

  final Color _headerOrange = const Color(0xFFFF5722);
  final Color _profileCardColor = const Color(0xFFC63F25);
  final Color _avatarColor = const Color(0xFF5D4037);
  final Color _scaffoldBg = Colors.white;
  final Color _textPrimary = const Color(0xFF1F2937);
  final Color _textSecondary = const Color(0xFF6B7280);

  // Icon Background Colors
  final Color _blueIconBg = const Color(0xFFEFF6FF);
  final Color _blueIconColor = const Color(0xFF3B82F6);
  final Color _purpleIconBg = const Color(0xFFF3E8FF);
  final Color _purpleIconColor = const Color(0xFF9333EA);
  final Color _orangeIconBg = const Color(0xFFFFF7ED);
  final Color _orangeIconColor = const Color(0xFFF97316);
  final Color _redIconBg = const Color(0xFFFEF2F2);
  final Color _redIconColor = const Color(0xFFEF4444);

  void _toggleLanguage() {
    setState(() {
      _selectedLanguage = _selectedLanguage == 'తెలుగు' ? 'English' : 'తెలుగు';
    });
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/parents/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/parents/reports');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/parents/bus-tracking');
        break;
      case 3:
      // Already on more options page
        break;
    }
  }

  void _logout() {
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            // 1. App Header
            _buildAppHeader(),

            // 2. Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Orange Hero Section
                    _buildHeroSection(),

                    // Body Content
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle('Profile & Settings'),
                          const SizedBox(height: 12),
                          _buildSettingsCard(
                            title: 'My Profile',
                            subtitle: 'View and edit your details',
                            icon: Icons.person_outline,
                            iconBg: _blueIconBg,
                            iconColor: _blueIconColor,
                            onTap: () => Navigator.pushNamed(context, '/parents/profile'),
                          ),
                          _buildSettingsCard(
                            title: 'Settings',
                            subtitle: 'App preferences',
                            icon: Icons.settings_outlined,
                            iconBg: _purpleIconBg,
                            iconColor: _purpleIconColor,
                            onTap: () => Navigator.pushNamed(context, '/parents/settings'),
                          ),

                          const SizedBox(height: 24),
                          _buildSectionTitle('Academic'),
                          const SizedBox(height: 12),
                          _buildSettingsCard(
                            title: 'Academic Calendar',
                            subtitle: 'View full year schedule',
                            icon: Icons.calendar_today_outlined,
                            iconBg: _orangeIconBg,
                            iconColor: _orangeIconColor,
                            onTap: () => Navigator.pushNamed(context, '/parents/academic-calendar'),
                          ),

                          const SizedBox(height: 24),
                          _buildSectionTitle('Support'),
                          const SizedBox(height: 12),
                          _buildSettingsCard(
                            title: 'Help & Support',
                            subtitle: 'Get help using the app',
                            icon: Icons.info_outline,
                            iconBg: _redIconBg,
                            iconColor: _redIconColor,
                            onTap: () => Navigator.pushNamed(context, '/parents/support'),
                          ),
                          _buildSettingsCard(
                            title: 'Contact School',
                            subtitle: 'Phone & email details',
                            icon: Icons.chat_bubble_outline,
                            iconBg: _blueIconBg,
                            iconColor: _blueIconColor,
                            onTap: () => Navigator.pushNamed(context, '/parents/contact-school'),
                          ),
                          _buildSettingsCard(
                            title: 'Logout',
                            subtitle: 'Sign out of your account',
                            icon: Icons.logout,
                            iconBg: _redIconBg,
                            iconColor: _redIconColor,
                            onTap: _logout,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFFF5722),
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.directions_bus_outlined), label: "reports"),
          BottomNavigationBarItem(icon: Icon(Icons.confirmation_number_outlined), label: "bus"),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "More"),
        ],
      ),
    );
  }

  Widget _buildAppHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(color: const Color(0xFFFF5722), borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            child: const Text("A", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Aditya International School", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Text("Powered by Toki Tech", style: TextStyle(color: Colors.grey[500], fontSize: 11)),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: _toggleLanguage,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Text(_selectedLanguage, style: const TextStyle(color: Color(0xFFFF5722), fontWeight: FontWeight.w600, fontSize: 12)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      decoration: BoxDecoration(
        color: _headerOrange,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'More Options',
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _profileCardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _avatarColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      'A',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Rajesh & Priya Sharma',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Parents of Ananya Sharma',
                        style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: _textPrimary,
      ),
    );
  }

  Widget _buildSettingsCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: title == 'Logout' ? _redIconColor : _textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: _textSecondary),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
          ],
        ),
      ),
    );
  }
}

// Placeholder screens for the routes mentioned in MoreOptionsPage

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xFFFF5722),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.settings, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'Settings Page',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'This page will contain app preferences and settings.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AcademicCalendarPage extends StatelessWidget {
  const AcademicCalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Academic Calendar'),
        backgroundColor: const Color(0xFFFF5722),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calendar_month, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'Academic Calendar',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'This page will show the full academic year schedule.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SupportPage extends StatelessWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        backgroundColor: const Color(0xFFFF5722),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.help_outline, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'Help & Support',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'This page will provide help and support information.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}