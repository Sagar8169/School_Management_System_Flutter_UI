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

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => Container(
          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
          padding: EdgeInsets.fromLTRB(24, 12, 24, MediaQuery.of(context).viewInsets.bottom + MediaQuery.of(context).viewPadding.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),
              const SizedBox(height: 20),
              const Text("Edit Profile", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
              const SizedBox(height: 20),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: _avatarColor,
                    backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                    child: _profileImage == null ? const Text('A', style: TextStyle(color: Colors.white, fontSize: 30)) : null,
                  ),
                  Positioned(
                    bottom: 0, right: 0,
                    child: GestureDetector(
                      onTap: () async {
                        final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          setState(() => _profileImage = File(image.path));
                          setSheetState(() {});
                        }
                      },
                      child: CircleAvatar(radius: 16, backgroundColor: _headerOrange, child: const Icon(Icons.camera_alt, size: 16, color: Colors.white)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildCustomInput("Full Name", nameCtrl, Icons.person_outline),
              _buildCustomInput("Email Address", emailCtrl, Icons.mail_outline),
              _buildCustomInput("Phone Number", phoneCtrl, Icons.phone_android_outlined),
              const SizedBox(height: 24),
              _buildModernButton("SAVE", () {
                setState(() { userName = nameCtrl.text; userEmail = emailCtrl.text; userPhone = phoneCtrl.text; });
                Navigator.pop(context);
              }),
            ],
          ),
        ),
      ),
    );
  }

  // --- HELP & SUPPORT / CONTACT ---
  void _showSupportSheet() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(24, 24, 24, MediaQuery.of(context).viewPadding.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Help & Support", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
            const SizedBox(height: 10),
            _buildListTile(Icons.description_outlined, "User Manual", "Learn how to use"),
            _buildListTile(Icons.question_answer_outlined, "FAQs", "Common questions"),
            _buildListTile(Icons.bug_report_outlined, "Report Issue", "Submit feedback"),
          ],
        ),
      ),
    );
  }

  void _showContactSheet() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(24, 24, 24, MediaQuery.of(context).viewPadding.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Contact School", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
            const SizedBox(height: 10),
            _buildListTile(Icons.phone, "Call Office", "+91 888 777 6666"),
            _buildListTile(Icons.email, "Email Support", "office@aditya.edu"),
            _buildListTile(Icons.location_on, "Visit Campus", "Surampalem Campus"),
          ],
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

  // --- UI ELEMENTS ---
  Widget _buildAppHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(color: _headerOrange, borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            child: const Text("A", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          ),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text("Aditya International School", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            Text("Powered by Toki Tech", style: TextStyle(color: Colors.grey[500], fontSize: 11)),
          ])),
          GestureDetector(
            onTap: () => setState(() => _selectedLanguage = _selectedLanguage == 'తెలుగు' ? 'English' : 'తెలుగు'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Text(_selectedLanguage, style: TextStyle(color: _headerOrange, fontWeight: FontWeight.w600, fontSize: 12)),
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
    return BottomNavigationBar(currentIndex: _currentIndex, onTap: _onBottomNavTap, type: BottomNavigationBarType.fixed, selectedItemColor: _headerOrange, items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.directions_bus_outlined), label: "reports"),
      BottomNavigationBarItem(icon: Icon(Icons.confirmation_number_outlined), label: "bus"),
      BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "More"),
    ]);
  }
}