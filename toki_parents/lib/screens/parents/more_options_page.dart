// lib/screens/parents/more_options_page.dart
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
final Color _accentOrange = const Color(0xFFFF5722);
final Color _primaryOrange = const Color(0xFFFF5722);

class MoreOptionsPage extends StatefulWidget {
  const MoreOptionsPage({Key? key}) : super(key: key);

  @override
  _MoreOptionsPageState createState() => _MoreOptionsPageState();
}

class _MoreOptionsPageState extends State<MoreOptionsPage> {
  String _selectedLanguage = 'తెలుగు';
  int _currentIndex = 3;
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  bool _pushNotifications = true;
  bool _smsAlerts = false;

  String userName = 'Rajesh & Priya Sharma';
  String userEmail = 'parent@aditya.edu';
  String userPhone = '+91 98765 43210';

  final Color _headerOrange = const Color(0xFFFF5722);
  final Color _profileCardColor = const Color(0xFFC63F25);
  final Color _avatarColor = const Color(0xFF5D4037);
  final Color _scaffoldBg = const Color(0xFFF8FAFC);
  final Color _textPrimary = const Color(0xFF1F2937);
  final Color _textSecondary = const Color(0xFF6B7280);

  final Color _blueIconBg = const Color(0xFFEFF6FF);
  final Color _blueIconColor = const Color(0xFF3B82F6);
  final Color _purpleIconBg = const Color(0xFFF3E8FF);
  final Color _purpleIconColor = const Color(0xFF9333EA);
  final Color _orangeIconBg = const Color(0xFFFFF7ED);
  final Color _orangeIconColor = const Color(0xFFF97316);
  final Color _redIconBg = const Color(0xFFFEF2F2);
  final Color _redIconColor = const Color(0xFFEF4444);

  // --- NAVIGATION LOGIC ---
  void _onBottomNavTap(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
    switch (index) {
      case 0: Navigator.pushReplacementNamed(context, '/parents/home'); break;
      case 1: Navigator.pushReplacementNamed(context, '/parents/reports'); break;
      case 2: Navigator.pushReplacementNamed(context, '/parents/bus-tracking'); break;
      case 3: break;
    }
  }

  // --- 1. PREMIUM LOGOUT DIALOG ---
  void _logout() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) => Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 35),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: Material(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _redIconBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.logout_rounded, color: _redIconColor, size: 40),
                ),
                const SizedBox(height: 20),
                // Text content
                const Text(
                  "Sign Out",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF1F2937)),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Are you sure you want to logout?\nYou will need to login again to access your data.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Color(0xFF6B7280), height: 1.5),
                ),
                const SizedBox(height: 32),
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade300),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        child: const Text("CANCEL", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushReplacementNamed(context, '/'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _redIconColor,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        child: const Text("LOGOUT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- 2. SETTINGS SHEET ---
  void _showSettingsSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => Padding(
          padding: EdgeInsets.fromLTRB(24, 24, 24, MediaQuery.of(context).viewPadding.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),
              const SizedBox(height: 20),
              const Text("Settings", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
              SwitchListTile(
                title: const Text("Push Notifications"),
                subtitle: const Text("Receive daily updates"),
                activeColor: _headerOrange,
                value: _pushNotifications,
                onChanged: (v) { setSheetState(() => _pushNotifications = v); setState(() {}); },
              ),
              SwitchListTile(
                title: const Text("SMS Alerts"),
                subtitle: const Text("Emergency notices via SMS"),
                activeColor: _headerOrange,
                value: _smsAlerts,
                onChanged: (v) { setSheetState(() => _smsAlerts = v); setState(() {}); },
              ),
              const SizedBox(height: 20),
              _buildModernButton("SAVE", () => Navigator.pop(context)),
            ],
          ),
        ),
      ),
    );
  }

  // --- 3. ACADEMIC CALENDAR SHEET ---
  void _showCalendarSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text("Academic Calendar 2025-26", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildEventTile("Jan 15", "Pongal Holidays", "School closed"),
                  _buildEventTile("Jan 26", "Republic Day", "Flag hoisting at 8:30 AM"),
                  _buildEventTile("Feb 12", "Unit Test - II", "Syllabus in reports"),
                  _buildEventTile("Mar 05", "Annual Sports Meet", "School Ground"),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: _buildModernButton("CLOSE", () => Navigator.pop(context)),
            ),
          ],
        ),
      ),
    );
  }

  // --- 4. PROFILE FORM ---
  void _showProfileForm() {
    final nameCtrl = TextEditingController(text: userName);
    final emailCtrl = TextEditingController(text: userEmail);
    final phoneCtrl = TextEditingController(text: userPhone);
    final mediaQuery = MediaQuery.of(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          padding: EdgeInsets.fromLTRB(
            24,
            12,
            24,
            mediaQuery.viewInsets.bottom + // keyboard
                mediaQuery.viewPadding.bottom + // system safe area (gesture bar)
                16,
          ),
          child: SingleChildScrollView( // Added scroll for smaller screens
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Premium Drag Handle
                Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 24),

                /// Header Section
                const Text(
                  "Edit Profile",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Update your details to stay connected",
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                ),

                const SizedBox(height: 32),

                /// Enhanced Profile Image
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: _headerOrange.withOpacity(0.2), width: 4),
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.shade100,
                        backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                        child: _profileImage == null
                            ? Text(
                          userName.isNotEmpty ? userName[0].toUpperCase() : 'A',
                          style: TextStyle(
                              color: _headerOrange,
                              fontSize: 36,
                              fontWeight: FontWeight.bold),
                        )
                            : null,
                      ),
                    ),
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: GestureDetector(
                        onTap: () async {
                          final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                          if (image != null) {
                            setState(() => _profileImage = File(image.path));
                            setSheetState(() {});
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: _headerOrange,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: _headerOrange.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.edit_rounded, size: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                /// Inputs with Better Feedback
                _buildModernInput("Full Name", nameCtrl, Icons.person_rounded),
                _buildModernInput("Email Address", emailCtrl, Icons.email_rounded),
                _buildModernInput("Phone Number", phoneCtrl, Icons.phone_android_rounded),

                const SizedBox(height: 32),

                /// Action Button
                Container(
                  width: double.infinity,
                  height: 58,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: _headerOrange.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _headerOrange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      elevation: 0,
                    ),
                    onPressed: () {
                      setState(() {
                        userName = nameCtrl.text;
                        userEmail = emailCtrl.text;
                        userPhone = phoneCtrl.text;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Save Profile",
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                // Extra space for system bottom bar
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModernInput(String label, TextEditingController ctrl, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextField(
        controller: ctrl,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey.shade500, fontWeight: FontWeight.w500),
          prefixIcon: Icon(icon, color: _headerOrange, size: 22),
          filled: true,
          fillColor: Colors.grey.shade50,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: _headerOrange, width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        ),
      ),
    );
  }
  void _showSupportSheet() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(24, 16, 24, MediaQuery.of(context).padding.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Top Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 24),

            /// Header
            const Text(
              "Help & Support",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "How can we help you today?",
              style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
            ),
            const SizedBox(height: 28),

            /// Support Options
            _buildSupportCard(
              icon: Icons.auto_stories_rounded,
              title: "User Manual",
              subtitle: "Complete guide to master the app",
              color: Colors.blue.shade50,
              iconColor: Colors.blue.shade700,
              onTap: () {},
            ),
            _buildSupportCard(
              icon: Icons.quiz_rounded,
              title: "FAQs",
              subtitle: "Quick answers to common questions",
              color: Colors.orange.shade50,
              iconColor: Colors.orange.shade700,
              onTap: () {},
            ),
            _buildSupportCard(
              icon: Icons.bug_report_rounded, // Ya Icons.bug_report_rounded
              title: "Report an Issue",
              subtitle: "Found a bug? Let us fix it for you",
              color: Colors.red.shade50,
              iconColor: Colors.red.shade700,
              onTap: () {},
            ),

            const SizedBox(height: 12),

            /// Optional: Contact Support Button
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Dismiss",
                style: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSupportCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade100),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: iconColor, size: 26),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2D2D2D),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: Colors.grey.shade300),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageToggle() {
    return GestureDetector(
      onTap: _toggleLanguage,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),
        child: Row(
          children: [
            Icon(Icons.translate, size: 14, color: _primaryOrange),
            const SizedBox(width: 4),
            Text(_selectedLanguage, style: TextStyle(color: _primaryOrange, fontWeight: FontWeight.bold, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  void _toggleLanguage() {
    setState(() {
      _selectedLanguage = _selectedLanguage == 'తెలుగు' ? 'English' : 'తెలుగు';
    });
  }

  void _showContactSheet() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(24, 16, 24, MediaQuery.of(context).padding.bottom + 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 24),

            /// Header with Icon
            const Icon(Icons.school_rounded, size: 40, color: Color(0xFF6C63FF)), // Theme color
            const SizedBox(height: 12),
            const Text(
              "Contact School",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "We're here to help you with your queries",
              style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
            ),
            const SizedBox(height: 28),

            /// Contact Methods
            _buildActionContactCard(
              icon: Icons.phone_forwarded_rounded,
              title: "Call Office",
              value: "+91 888 777 6666",
              gradient: [Color(0xFF4CAF50), Color(0xFF81C784)], // Green Gradient
              onTap: () {
                // Action: Call
              },
            ),
            _buildActionContactCard(
              icon: Icons.alternate_email_rounded,
              title: "Email Support",
              value: "office@aditya.edu",
              gradient: [Color(0xFF2196F3), Color(0xFF64B5F6)], // Blue Gradient
              onTap: () {
                // Action: Email
              },
            ),
            _buildActionContactCard(
              icon: Icons.location_on_rounded,
              title: "Visit Campus",
              value: "Surampalem Campus, Andhra Pradesh",
              gradient: [Color(0xFFFF7043), Color(0xFFFFAB91)], // Orange/Red Gradient
              onTap: () {
                // Action: Maps
              },
            ),

            const SizedBox(height: 16),

            /// Working Hours Info
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.access_time_filled_rounded, size: 16, color: Colors.grey.shade400),
                  const SizedBox(width: 8),
                  Text(
                    "Available: Mon - Sat (9:00 AM - 5:00 PM)",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionContactCard({
    required IconData icon,
    required String title,
    required String value,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              /// Icon with Gradient Background
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 16),

              /// Text Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
              ),

              /// Action Icon
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey.shade400),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _buildHeroSection(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle('Profile & Settings'),
                          const SizedBox(height: 12),
                          _buildSettingsCard('My Profile', 'View and edit details', Icons.person_outline, _blueIconBg, _blueIconColor, _showProfileForm),
                          _buildSettingsCard('Settings', 'App preferences', Icons.settings_outlined, _purpleIconBg, _purpleIconColor, _showSettingsSheet),
                          const SizedBox(height: 24),
                          _buildSectionTitle('Academic'),
                          const SizedBox(height: 12),
                          _buildSettingsCard('Academic Calendar', 'View year schedule', Icons.calendar_today_outlined, _orangeIconBg, _orangeIconColor, _showCalendarSheet),
                          const SizedBox(height: 24),
                          _buildSectionTitle('Support'),
                          const SizedBox(height: 12),
                          _buildSettingsCard('Help & Support', 'Get app help', Icons.info_outline, _redIconBg, _redIconColor, _showSupportSheet),
                          _buildSettingsCard('Contact School', 'Phone & email', Icons.chat_bubble_outline, _blueIconBg, _blueIconColor, _showContactSheet),
                          _buildSettingsCard('Logout', 'Sign out of account', Icons.logout, _redIconBg, _redIconColor, _logout),
                          const SizedBox(height: 30),
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
      bottomNavigationBar: _buildBottomNav(),
    );
  }


  Widget _buildAppHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade100, width: 1)),
      ),
      child: Row(
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [_primaryOrange, _primaryOrange.withOpacity(0.8)]),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [BoxShadow(color: _primaryOrange.withOpacity(0.25), blurRadius: 12, offset: const Offset(0, 6))],
            ),
            alignment: Alignment.center,
            child: const Text("A", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 22)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Aditya International", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17, letterSpacing: -0.6, color: Color(0xFF1A1A1A))),
                Row(
                  children: [
                    Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFF10B981), shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    Text("Support Portal Active", style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
          _buildLanguageToggle(),
        ],
      ),
    );
  }



  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      decoration: BoxDecoration(color: _headerOrange, borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('More Options', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: _profileCardColor, borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: _avatarColor,
                  backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                  child: _profileImage == null ? const Text('A', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)) : null,
                ),
                const SizedBox(width: 16),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(userName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  const Text('Parents of Ananya Sharma', style: TextStyle(color: Colors.white70, fontSize: 12)),
                ])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard(String title, String sub, IconData icon, Color bg, Color iconCol, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
        child: Row(children: [
          Container(width: 44, height: 44, decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: iconCol, size: 22)),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: title == 'Logout' ? _redIconColor : _textPrimary)),
            Text(sub, style: TextStyle(fontSize: 12, color: _textSecondary)),
          ])),
          Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
        ]),
      ),
    );
  }

  Widget _buildSectionTitle(String title) => Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _textPrimary));

  Widget _buildCustomInput(String label, TextEditingController ctrl, IconData icon) => Padding(
    padding: const EdgeInsets.only(top: 12),
    child: TextField(
      controller: ctrl,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: _headerOrange, size: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );

  Widget _buildModernButton(String text, VoidCallback onSave) => SizedBox(
    width: double.infinity, height: 50,
    child: ElevatedButton(onPressed: onSave, style: ElevatedButton.styleFrom(backgroundColor: _headerOrange, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
  );

  Widget _buildEventTile(String date, String title, String sub) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(15)),
    child: Row(children: [
      Text(date, style: TextStyle(color: _headerOrange, fontWeight: FontWeight.bold)),
      const SizedBox(width: 16),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(sub, style: TextStyle(color: _textSecondary, fontSize: 13)),
      ])),
    ]),
  );

  Widget _buildListTile(IconData icon, String title, String sub) => ListTile(
    leading: Icon(icon, color: _headerOrange),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    subtitle: Text(sub),
    trailing: const Icon(Icons.arrow_forward_ios, size: 14),
    onTap: () {},
  );

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: 3,
      onTap: _onBottomNavTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: _accentOrange,
      backgroundColor: Colors.white,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 11),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home_rounded), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.analytics_outlined), activeIcon: Icon(Icons.analytics_rounded), label: "Reports"),
        BottomNavigationBarItem(icon: Icon(Icons.directions_bus_outlined), activeIcon: Icon(Icons.directions_bus_rounded), label: "Bus"),
        BottomNavigationBarItem(icon: Icon(Icons.grid_view_outlined), activeIcon: Icon(Icons.grid_view_rounded), label: "More"),
      ],
    );
  }

}