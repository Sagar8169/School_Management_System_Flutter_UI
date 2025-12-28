// lib/screens/driver/profile_page.dart
import 'package:flutter/material.dart';
import '../../routes/driver_routes.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../widgets/driver_widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  File? _profileImage;
  final ImagePicker _picker = ImagePicker();


  int _currentIndex = 3;
  bool _isTelugu = true;
  bool _editMode = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _licenseController = TextEditingController();

  @override
  void initState() {

    super.initState();
    _nameController.text = 'Krishna Murthy';
    _phoneController.text = '+91 9876543210';
    _emailController.text = 'krishna.driver@aditya.edu';
    _licenseController.text = 'DL12345678901234';
    _nameController.addListener(() {
      setState(() {});
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? picked = await _picker.pickImage(
      source: source,
      imageQuality: 70, // thoda compress
    );

    if (picked != null) {
      setState(() {
        _profileImage = File(picked.path);
      });
    }
  }

  void _navigateToPage(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
    switch (index) {
      case 0: Navigator.pushNamedAndRemoveUntil(context, DriverRoutes.home, (route) => false); break;
      case 1: Navigator.pushNamed(context, DriverRoutes.tripHistory); break;
      case 2: Navigator.pushNamed(context, DriverRoutes.tickets); break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double px = MediaQuery.of(context).size.width > 600 ? 40.0 : 20.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      resizeToAvoidBottomInset: true,

      body: SafeArea(
        bottom: false, // 👈 bottom nav handle karega
        child: Column(
          children: [
            /// ✅ SAME COMMON HEADER (HomeDriver style)
            DriverWidgets.appHeader(
              schoolName: 'Aditya International School',
              schoolInitial: 'A',
              selectedLanguage: _isTelugu ? 'తెలుగు' : 'English',
              onLanguageToggle: () =>
                  setState(() => _isTelugu = !_isTelugu),
            ),

            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  /// 👤 Hero Header
                  _buildHeroHeader(px),

                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: px, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildEditControlRow(),
                        const SizedBox(height: 20),

                        _buildSectionTitle("PERSONAL INFORMATION"),
                        const SizedBox(height: 16),
                        _profileInfoTile(
                          'Full Name',
                          _nameController,
                          Icons.person_outline_rounded,
                        ),
                        _profileInfoTile(
                          'Phone Number',
                          _phoneController,
                          Icons.phone_android_rounded,
                        ),
                        _profileInfoTile(
                          'Email Address',
                          _emailController,
                          Icons.alternate_email_rounded,
                        ),
                        _profileInfoTile(
                          'License Number',
                          _licenseController,
                          Icons.badge_outlined,
                        ),

                        const SizedBox(height: 32),
                        _buildSectionTitle("PERFORMANCE STATS"),
                        const SizedBox(height: 16),
                        _buildStatsGrid(),

                        const SizedBox(height: 32),
                        _buildSectionTitle("ACCOUNT SETTINGS"),
                        const SizedBox(height: 16),
                        _buildActionCard(
                          Icons.notifications_none_rounded,
                          'Notifications',
                          'Trip & safety alerts',
                              () => _showNotificationSheet(context),
                        ),
                        _buildActionCard(
                          Icons.lock_outline_rounded,
                          'Change Password',
                          'Update login security',
                              () => _showPasswordSheet(context),
                        ),
                        _buildActionCard(
                          Icons.help_outline_rounded,
                          'Help & Support',
                          'FAQs and contact us',
                              () => _showSupportSheet(context),
                        ),
                        _buildActionCard(
                          Icons.logout_rounded,
                          'Logout',
                          'Sign out of account',
                          _handleLogout,
                          isRed: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      /// ✅ Bottom navigation
      bottomNavigationBar: SafeArea(
        top: false,
        child: _buildModernNav(),
      ),
    );
  }



  // --- UI COMPONENTS WITH SAFE AREA ---

  Widget _buildCustomAppBar(double px) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: px, vertical: 12),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          ),
          const Expanded(
            child: Text(
              'My Profile',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
          _langToggle(),
        ],
      ),
    );
  }

  Widget _langToggle() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(20)),
    child: Text(_isTelugu ? "తెలుగు" : "English", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFFE65100))),
  );

  Widget _buildHeroHeader(px) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE65100), Color(0xFFFB8C00)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              /// 👤 Profile Image / Dummy Image
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                backgroundImage:
                _profileImage != null ? FileImage(_profileImage!) : null,
                child: _profileImage == null
                    ? const Icon(
                  Icons.person,
                  size: 50,
                  color: Color(0xFFE65100),
                )
                    : null,
              ),

              /// 📸 Camera icon only in edit mode
              if (_editMode)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => _showImagePicker(context),
                    child: const CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.camera_alt_rounded,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 16),

          const Text(
            'Krishna Murthy',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),

          const Text(
            'ID: AIS-DRIVER-102',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Choose Profile Photo",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 20),

            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () async {
                Navigator.pop(context);
                await _pickImage(ImageSource.camera);
              },
            ),

            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Gallery"),
              onTap: () async {
                Navigator.pop(context);
                await _pickImage(ImageSource.gallery);
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildEditControlRow() {
    final bool isEdit = _editMode;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton.icon(
          onPressed: () => setState(() => _editMode = !isEdit),
          style: ElevatedButton.styleFrom(
            backgroundColor:
            isEdit ? const Color(0xFF16A34A) : const Color(0xFFE65100),
            foregroundColor: Colors.white, // ✅ icon + text white
            elevation: 2,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          icon: Icon(
            isEdit ? Icons.check_circle_outline : Icons.edit_note_rounded,
            size: 18,
            color: Colors.white, // ✅ icon white
          ),
          label: Text(
            isEdit ? 'SAVE' : 'EDIT PROFILE',
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 12,
              color: Colors.white, // ✅ text white
              letterSpacing: 0.6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _profileInfoTile(
      String label,
      TextEditingController ctrl,
      IconData icon,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: _editMode
              ? const Color(0xFFE65100)
              : const Color(0xFFE5E7EB),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: Colors.black87),
          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Label (small)
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF64748B),
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 4),

                // 🔹 Value
                _editMode
                    ? TextField(
                  controller: ctrl,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                  ),
                )
                    : Text(
                  ctrl.text,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.8,
      children: [
        _simpleStatItem('Trips', '458', Icons.directions_bus),
        _simpleStatItem('Safety', '98%', Icons.security),
        _simpleStatItem('Distance', '12k km', Icons.speed),
        _simpleStatItem('Rating', '4.8', Icons.star),
      ],
    );
  }

  Widget _simpleStatItem(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 22, color: const Color(0xFFE65100)),
          const SizedBox(width: 12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _statItem(String l, String v, IconData i, Color c) => Container(
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(i, color: c, size: 22), Text(v, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18)), Text(l, style: const TextStyle(color: Colors.grey, fontSize: 11))]),
  );

  Widget _buildActionCard(IconData icon, String title, String sub, VoidCallback onTap, {bool isRed = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(backgroundColor: isRed ? Colors.red.withOpacity(0.1) : const Color(0xFFF1F5F9), child: Icon(icon, color: isRed ? Colors.red : Colors.blueGrey, size: 20)),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isRed ? Colors.red : Colors.black)),
        subtitle: Text(sub, style: const TextStyle(fontSize: 11)),
        trailing: const Icon(Icons.chevron_right, size: 18),
      ),
    );
  }

  // --- FUNCTIONAL LOGIC ---


  void _showPasswordSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 Drag handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E7EB),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              /// 🔐 Title
              const Text(
                "Change Password",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Update your account security",
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF64748B),
                ),
              ),

              const SizedBox(height: 24),

              /// 🔑 Current Password
              _passwordField(
                label: "Current Password",
                icon: Icons.lock_outline_rounded,
              ),
              const SizedBox(height: 14),

              /// 🆕 New Password
              _passwordField(
                label: "New Password",
                icon: Icons.lock_reset_rounded,
              ),

              const SizedBox(height: 28),

              /// ✅ Update Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF16A34A),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Update Password",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
  Widget _passwordField({
    required String label,
    required IconData icon,
  }) {
    return TextField(
      obscureText: true,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color(0xFF475569),
        ),
        floatingLabelStyle: const TextStyle(
          color: Color(0xFF1E293B),
          fontWeight: FontWeight.w600,
        ),
        prefixIcon: Icon(icon, color: const Color(0xFF64748B)),
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF16A34A), width: 1.5),
        ),
      ),
    );
  }

  void _showNotificationSheet(BuildContext context) {
    bool tripUpdates = true;   // 👈 dummy state
    bool safetyAlerts = true; // 👈 dummy state

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => SafeArea(
        top: false,
        child: StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔹 Drag handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  /// 🔔 Title
                  const Text(
                    "Notifications",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Manage alerts and updates",
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF64748B),
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// 🚍 Trip Updates
                  _notificationTile(
                    icon: Icons.alt_route_rounded,
                    title: "Trip Updates",
                    subtitle: "Route, pickup & drop alerts",
                    value: tripUpdates,
                    onChanged: (v) {
                      setModalState(() {
                        tripUpdates = v;
                      });
                    },
                  ),

                  const SizedBox(height: 12),

                  /// 🛡 Safety Alerts
                  _notificationTile(
                    icon: Icons.security_rounded,
                    title: "Safety Alerts",
                    subtitle: "Emergency and safety notifications",
                    value: safetyAlerts,
                    onChanged: (v) {
                      setModalState(() {
                        safetyAlerts = v;
                      });
                    },
                  ),

                  const SizedBox(height: 12),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _notificationTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFFFFEDD5),
            child: Icon(
              icon,
              color: const Color(0xFFEA580C),
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFFEA580C),
          ),
        ],
      ),
    );
  }


  void _showSupportSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 Drag handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E7EB),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              /// 🔹 Title
              const Text(
                "Support",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Get help or contact support",
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF64748B),
                ),
              ),

              const SizedBox(height: 24),

              /// ☎️ Call Admin
              _supportTile(
                icon: Icons.call_rounded,
                iconColor: const Color(0xFF16A34A),
                title: "Call Admin",
                subtitle: "Speak directly with administrator",
                onTap: () {
                  Navigator.pop(context);
                  // call logic here
                },
              ),

              const SizedBox(height: 12),

              /// 💬 WhatsApp Support
              _supportTile(
                icon: Icons.chat_bubble_rounded,
                iconColor: const Color(0xFF22C55E),
                title: "WhatsApp Support",
                subtitle: "Chat with support team",
                onTap: () {
                  Navigator.pop(context);
                  // whatsapp logic here
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
  Widget _supportTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: iconColor.withOpacity(0.12),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF94A3B8),
            ),
          ],
        ),
      ),
    );
  }


  void _handleLogout() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
        actionsPadding: const EdgeInsets.fromLTRB(16, 16, 16, 20),

        /// 🔴 Title with icon
        title: Row(
          children: const [
            Icon(Icons.logout_rounded, color: Color(0xFFE11D48)),
            SizedBox(width: 10),
            Text(
              "Logout",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1E293B),
              ),
            ),
          ],
        ),

        /// 🔹 Message
        content: const Text(
          "Are you sure you want to logout?",
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF475569),
          ),
        ),

        /// 🔹 Actions
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF475569),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "Cancel",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/mobile-login',
                    (r) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE11D48),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "Logout",
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildSectionTitle(String t) => Text(t, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Colors.black, letterSpacing: 1.2));

  Widget _buildModernNav() {
    return Container(
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xFFF1F5F9)))),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex, onTap: _navigateToPage, type: BottomNavigationBarType.fixed, selectedItemColor: const Color(0xFFE65100), elevation: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.alt_route_rounded), label: 'Trip'),
          BottomNavigationBarItem(icon: Icon(Icons.confirmation_number_outlined), label: 'Tickets'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}