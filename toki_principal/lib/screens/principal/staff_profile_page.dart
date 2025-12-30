import 'package:flutter/material.dart';
import '../../routes/principal_routes.dart';

class StaffProfilePage extends StatefulWidget {
  final Map<String, dynamic> staffData;

  const StaffProfilePage({super.key, required this.staffData});

  @override
  State<StaffProfilePage> createState() => _StaffProfilePageState();
}

class _StaffProfilePageState extends State<StaffProfilePage> {
  int _currentIndex = 1;
  bool _isTelugu = true;

  // ==========================================
  // --- ORIGINAL LOGIC FUNCTIONS (Unchanged) ---
  // ==========================================

  void _toggleLanguage() {
    setState(() {
      _isTelugu = !_isTelugu;
    });
  }

  void _navigateTo(String routeName, {Map<String, dynamic>? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  // void _onBottomNavTapped(int index) {
  //   if (index == _currentIndex) return;
  //   setState(() {
  //     _currentIndex = index;
  //   });

  //   switch (index) {
  //     case 0:
  //       Navigator.of(context).pushNamedAndRemoveUntil(
  //         PrincipalRoutes.home,
  //             (route) => false,
  //       );
  //       break;
  //     case 1:
  //       break;
  //     case 2:
  //       _navigateTo(PrincipalRoutes.activity);
  //       break;
  //     case 3:
  //       _navigateTo(PrincipalRoutes.morePage);
  //       break;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ✨ SCREENSHOT STYLE HEADER: Compact and Premium
            _buildScreenshotStyleHeader(),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // Main Profile Card
                    _buildPremiumProfileCard(),

                    const SizedBox(height: 24),

                    // Contact Info
                    _buildInfoSection("Contact Information",
                        Icons.contact_phone_outlined, _buildContactContent()),

                    const SizedBox(height: 20),

                    // Work Details
                    _buildInfoSection("Work Details",
                        Icons.work_history_rounded, _buildWorkContent()),

                    // Class Information (only for teachers)
                    if (widget.staffData['type'] == 'teacher') ...[
                      const SizedBox(height: 20),
                      _buildInfoSection("Class Information",
                          Icons.school_rounded, _buildClassContent()),
                    ],

                    const SizedBox(height: 30),

                    // Action Buttons (Including View Class Details with Working Logic)
                    _buildActionButtons(),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // ==========================================
  // --- ✨ UI COMPONENTS (EXACT SCREENSHOT STYLE) ---
  // ==========================================

  Widget _buildScreenshotStyleHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9), width: 1)),
      ),
      child: Row(
        children: [
          // Back Button as per Screenshot
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(width: 16),
          // Title and School Name Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Staff Profile',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1E293B),
                  ),
                ),
                Text(
                  'Aditya International School',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // Language Pill
          GestureDetector(
            onTap: _toggleLanguage,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _isTelugu ? 'తెలుగు' : 'English',
                style: const TextStyle(
                  color: Color(0xFF1D4ED8),
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumProfileCard() {
    final bool isActive = widget.staffData['isActive'] as bool;
    // ✨ Teacher Profile wala vibrant theme colors
    const Color gradientStart = Color(0xFFBE481E);
    const Color gradientEnd = Color(0xFFD75B28);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        // ✨ Wahi Bold Gradient jo Teacher Profile mein tha
        gradient: const LinearGradient(
          colors: [gradientStart, gradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: gradientEnd.withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // ✨ White-Glass Container for Icon/Avatar
              Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                ),
                child: Icon(
                    widget.staffData['type'] == 'teacher'
                        ? Icons.person_rounded
                        : Icons.badge_rounded,
                    size: 30,
                    color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.staffData['name'],
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Colors.white)),
                    Text(widget.staffData['role'].toString().toUpperCase(),
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5)),
                    const SizedBox(height: 10),
                    // ✨ Status Badge customized for Gradient Background
                    _buildStatusBadgeOnGradient(isActive),
                  ],
                ),
              ),
            ],
          ),

          // ✨ White Transparent Divider
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Divider(height: 1, color: Colors.white24),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCompactInfoOnGradient(
                  "DEPARTMENT", widget.staffData['department']),
              _buildCompactInfoOnGradient(
                  "EMPLOYEE ID", widget.staffData['employeeId']),
            ],
          ),
        ],
      ),
    );
  }

// ✨ Helper for Info on Gradient
  Widget _buildCompactInfoOnGradient(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 9,
                color: Colors.white70,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.8)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Colors.white)),
      ],
    );
  }

// ✨ Status Badge for Gradient (Modified colors for contrast)
  Widget _buildStatusBadgeOnGradient(bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? Colors.white.withOpacity(0.2) : Colors.black12,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF4ADE80) : Colors.white60,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            isActive ? "ACTIVE" : "INACTIVE",
            style: const TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
          color: active ? const Color(0xFFE6F9ED) : const Color(0xFFFFF1F2),
          borderRadius: BorderRadius.circular(8)),
      child: Text(active ? 'ACTIVE' : 'AWAY',
          style: TextStyle(
              color: active ? const Color(0xFF16A34A) : const Color(0xFFE11D48),
              fontSize: 9,
              fontWeight: FontWeight.w900)),
    );
  }

  Widget _buildCompactInfo(String label, String value, {bool isBlue = false}) {
    return Column(
      crossAxisAlignment:
          isBlue ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF94A3B8),
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5)),
        const SizedBox(height: 4),
        Text(value,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: isBlue
                    ? const Color(0xFF1D4ED8)
                    : const Color(0xFF334155))),
      ],
    );
  }

  Widget _buildInfoSection(String title, IconData icon, Widget content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: const Color(0xFF1D4ED8)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF334155),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // ✅ SINGLE CARD WITH PROPER BORDER
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),

              // 👇 THIS IS THE ONLY BORDER (ON THE CARD)
              border: Border.all(
                color: const Color(0xFFE2E8F0), // slightly darker than F1F5F9
                width: 1,
              ),

              // optional soft depth (very subtle)
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1E293B).withOpacity(0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget _buildContactContent() {
    return Column(children: [
      _buildDataRow("Phone", "+91 98765 43210"),
      const Divider(height: 24, color: Color(0xFFF1F5F9)),
      _buildDataRow(
        "Email",
        "${widget.staffData['name'].toString().toLowerCase().replaceAll(' ', '.')}@adityaschool.in",
      ),
      const Divider(height: 24, color: Color(0xFFF1F5F9)),
      _buildDataRow("Address", "Sector 4, School Campus"),
    ]);
  }

  Widget _buildWorkContent() {
    return Column(children: [
      _buildDataRow("Shift Timing", "09:00 AM - 05:00 PM"),
      const Divider(height: 24, color: Color(0xFFF1F5F9)),
      _buildDataRow("Join Date", "January 15, 2020"),
      const Divider(height: 24, color: Color(0xFFF1F5F9)),
      _buildDataRow("Work Location", "Main Campus"),
    ]);
  }

  Widget _buildClassContent() {
    return Column(children: [
      _buildDataRow(
          "Assigned Class", widget.staffData['assignedClass'] ?? 'N/A'),
      const Divider(height: 24, color: Color(0xFFF1F5F9)),
      _buildDataRow("Strength", "42 students"),
    ]);
  }

  Widget _buildDataRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF94A3B8),
                fontWeight: FontWeight.w700)),
        Text(value,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1E293B))),
      ],
    );
  }

  // --- 1. ACTION BUTTONS UI ---
  Widget _buildActionButtons() {
    final bool isTeacher = widget.staffData['type'] == 'teacher';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "QUICK ACTIONS",
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w900,
                color: Color(0xFF64748B),
                letterSpacing: 1.2),
          ),
          const SizedBox(height: 16),
          _actionTile(
            label: "View Schedule",
            icon: Icons.event_note_rounded,
            color: const Color(0xFF1D4ED8),
            isFullWidth: true,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text('Opening Schedule for ${widget.staffData['name']}'),
                behavior: SnackBarBehavior.floating,
              ));
            },
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _actionTile(
                  label: "Contact Staff",
                  icon: Icons.chat_bubble_outline_rounded,
                  color: const Color(0xFF1D4ED8),
                  isFullWidth: false,
                  onTap: () =>
                      _showContactOptions(context, widget.staffData['name']),
                ),
              ),
              if (isTeacher) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: _actionTile(
                    label: "Class Details",
                    icon: Icons.grid_view_rounded,
                    color: const Color(0xFF10B981),
                    isFullWidth: false,
                    onTap: () {
                      _navigateTo(PrincipalRoutes.classDetails, arguments: {
                        'className': widget.staffData['assignedClass'],
                        'teacher': widget.staffData['name'],
                        'section': widget.staffData['assignedClass']
                            .toString()
                            .split(' ')
                            .last,
                      });
                    },
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  // --- 2. REUSABLE PREMIUM TILE ---
  Widget _actionTile(
      {required String label,
      required IconData icon,
      required Color color,
      required bool isFullWidth,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: isFullWidth ? 18 : 20),
        decoration: BoxDecoration(
          color: isFullWidth ? color : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: isFullWidth
              ? null
              : Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: isFullWidth
                  ? color.withOpacity(0.3)
                  : Colors.black.withOpacity(0.03),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: isFullWidth
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: Colors.white, size: 20),
                  const SizedBox(width: 10),
                  Text(label,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 15)),
                ],
              )
            : Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: color.withOpacity(0.1), shape: BoxShape.circle),
                    child: Icon(icon, color: color, size: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(label,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                          color: Color(0xFF1E293B))),
                ],
              ),
      ),
    );
  }

  // --- 3. THE MISSING METHOD (Fixes the Error) ---
  void _showContactOptions(BuildContext context, String staffName) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).padding.bottom + 20),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
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
            Text("Contact $staffName",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A))),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _contactMethod(Icons.call_rounded, "Call",
                    const Color(0xFF1D4ED8), () => Navigator.pop(context)),
                _contactMethod(Icons.chat_bubble_rounded, "Message",
                    const Color(0xFF10B981), () => Navigator.pop(context)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _contactMethod(
      IconData icon, String label, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label,
              style: TextStyle(
                  fontWeight: FontWeight.w800, fontSize: 13, color: color)),
        ],
      ),
    );
  }

  Widget _buildBtn(String label, IconData icon, Color color, bool isPrimary,
      VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: isPrimary
          ? ElevatedButton.icon(
              onPressed: onTap,
              icon: Icon(icon, size: 18),
              label: Text(label,
                  style: const TextStyle(fontWeight: FontWeight.w800)),
              style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 0),
            )
          : OutlinedButton.icon(
              onPressed: onTap,
              icon: Icon(icon, size: 18, color: color),
              label: Text(label,
                  style: TextStyle(fontWeight: FontWeight.w800, color: color)),
              style: OutlinedButton.styleFrom(
                  side: BorderSide(color: color, width: 1.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16))),
            ),
    );
  }

  // Widget _buildBottomNavigationBar() {
  //   return Container(
  //     decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xFFF1F5F9)))),
  //     child: BottomNavigationBar(
  //       currentIndex: _currentIndex, onTap: _onBottomNavTapped,
  //       type: BottomNavigationBarType.fixed, backgroundColor: Colors.white,
  //       selectedItemColor: const Color(0xFF1D4ED8), unselectedItemColor: const Color(0xFF94A3B8),
  //       elevation: 0, selectedFontSize: 11, unselectedFontSize: 11,
  //       items: const [
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.home_rounded),
  //           label: "Home",
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.search_rounded),
  //           label: "Search",
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.analytics_rounded),
  //           label: "Activity",
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.grid_view_rounded),
  //           label: "More",
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  void dispose() {
    super.dispose();
  }
}
