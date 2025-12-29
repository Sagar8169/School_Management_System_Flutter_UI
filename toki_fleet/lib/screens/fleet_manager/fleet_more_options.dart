import 'package:flutter/material.dart';
import '../../routes/fleet_manager_routes.dart';
import 'fleet_settings_page.dart';
import '.././mobile_login_page.dart';

class FleetMoreOptions extends StatefulWidget {
  const FleetMoreOptions({Key? key}) : super(key: key);

  @override
  State<FleetMoreOptions> createState() => _FleetMoreOptionsState();
}

class _FleetMoreOptionsState extends State<FleetMoreOptions> {
  static const Color primaryTeal = Color(0xFF0D9488);
  static const Color scaffoldBg = Colors.white;

  int _bottomIndex = 3;

  void _onBottomTap(int index) {
    if (index == _bottomIndex) return;
    setState(() => _bottomIndex = index);

    switch (index) {
      case 0:
        Navigator.pushNamed(context, FleetManagerRoutes.home);
        break;
      case 1:
        Navigator.pushNamed(context, FleetManagerRoutes.search);
        break;
      case 2:
        Navigator.pushNamed(context, FleetManagerRoutes.tickets);
        break;
      case 3:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // 1. Aditya International Branding Header
            _buildWhiteTopBar(),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // 2. Curvy Menu Header + Floating Profile
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        _buildCurvyMenuHeader(),
                        _buildFloatingProfileCard(),
                      ],
                    ),

                    const SizedBox(height: 75), // Space for floating card

                    // 3. Scrollable Menu Sections
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sectionHeader('DRIVER MANAGEMENT'),
                          _buildMenuBox([
                            _menuItem(Icons.badge_rounded, Colors.teal,
                                'Driver Directory', 'Contact & license info',
                                onTap: () => Navigator.pushNamed(context,
                                    FleetManagerRoutes.driverDirectory)),
                            _menuDivider(),
                            _menuItem(
                                Icons.event_busy_rounded,
                                Colors.deepOrange,
                                'Leave Management',
                                'Approve/Reject requests',
                                onTap: () => Navigator.pushNamed(
                                    context, FleetManagerRoutes.leaveMgmt)),
                            _menuDivider(),
                            _menuItem(
                                Icons.assignment_turned_in_rounded,
                                Colors.green,
                                'Attendance Report',
                                'Monthly log overview',
                                onTap: () => Navigator.pushNamed(
                                    context, FleetManagerRoutes.attendance)),
                          ]),
                          const SizedBox(height: 24),
                          _sectionHeader('SYSTEM'),
                          _buildMenuBox([
                            _menuItem(
                                Icons.help_center_rounded,
                                Colors.amber.shade800,
                                'Help & Support',
                                'FAQs, Guide & Contact us',
                                onTap: _showHelpSheet),
                            _menuDivider(),
                            _menuItem(
                                Icons.settings_suggest_rounded,
                                Colors.blueGrey,
                                'App Settings',
                                'Theme, Notifications & Privacy',
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FleetSettingsPage()))),
                          ]),
                          const SizedBox(height: 30),
                          _buildLogoutButton(),
                          const SizedBox(height: 30),
                          _buildAppVersion(),
                          const SizedBox(height: 40),
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
      // bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildWhiteTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: primaryTeal.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(Icons.school_rounded, color: primaryTeal, size: 22),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Aditya International',
                    style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                Text('Fleet Management System',
                    style: TextStyle(color: Colors.grey, fontSize: 10)),
              ],
            ),
          ),
          Text("తెలుగు",
              style: TextStyle(
                  color: primaryTeal,
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
        ],
      ),
    );
  }

  // --- TOP BRANDING HEADER ---
  Widget _buildTopBrandingHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: primaryTeal, borderRadius: BorderRadius.circular(10)),
            child:
                const Icon(Icons.school_rounded, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Aditya International',
                    style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                Text('Fleet Management System',
                    style: TextStyle(color: Colors.grey, fontSize: 10)),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
                backgroundColor: primaryTeal.withOpacity(0.1),
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(horizontal: 12)),
            child: const Text('తెలుగు',
                style: TextStyle(
                    color: primaryTeal,
                    fontWeight: FontWeight.bold,
                    fontSize: 11)),
          ),
        ],
      ),
    );
  }

  // --- CURVY MENU HEADER (Ticket Analytics Style) ---
  Widget _buildCurvyMenuHeader() {
    return Container(
      width: double.infinity,
      height: 110,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF0F766E), // dark teal
            Color(0xFF14B8A6), // light teal
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(32), // 👈 same as analytics
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: const Align(
        alignment: Alignment.topLeft,
        child: Text(
          'ACCOUNT MENU',
          style: TextStyle(
            color: Colors.white70, // 👈 same muted white
            fontWeight: FontWeight.w800,
            fontSize: 12, // 👈 same size
            letterSpacing: 1.6, // 👈 SAME MAGIC ✨
          ),
        ),
      ),
    );
  }

  // --- FLOATING PROFILE CARD ---
  Widget _buildFloatingProfileCard() {
    return Positioned(
      bottom: -45,
      child: InkWell(
        onTap: () =>
            Navigator.pushNamed(context, FleetManagerRoutes.profileEdit),
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.88,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
                color: Colors.black.withOpacity(0.08)), // Slight border
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 8)),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: primaryTeal.withOpacity(0.1),
                child: const Icon(Icons.person_rounded,
                    size: 32, color: primaryTeal),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Suresh Kumar',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                    Text('Senior Fleet Manager',
                        style: TextStyle(color: Colors.blueGrey, fontSize: 12)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded,
                  size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  // --- MENU COMPONENTS ---
  Widget _buildMenuBox(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: Colors.black.withOpacity(0.08)), // Slight black border
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _menuItem(IconData icon, Color color, String title, String sub,
      {VoidCallback? onTap}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(title,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xFF334155))),
      subtitle:
          Text(sub, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      trailing:
          const Icon(Icons.chevron_right_rounded, color: Colors.grey, size: 18),
      onTap: onTap,
    );
  }

  Widget _menuDivider() =>
      Divider(height: 1, indent: 65, color: Colors.black.withOpacity(0.05));

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 10),
      child: Text(title,
          style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: Colors.blueGrey.shade400,
              letterSpacing: 1.1)),
    );
  }

  Widget _buildLogoutButton() {
    return InkWell(
      onTap: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MobileLoginPage()),
          (route) => false, // 🔥 clears full stack
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.red.withOpacity(0.2)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout_rounded, color: Colors.redAccent, size: 20),
            SizedBox(width: 10),
            Text(
              'Logout Account',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- 4. INTERACTIVE HELP SHEET ---
  void _showHelpSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10))),
            const SizedBox(height: 25),
            const Text('Help & Support',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            const Text('Our team is available 24/7 for you',
                style: TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(height: 25),

            // Call Option
            _contactCard(Icons.call_rounded, Colors.green, 'Call Support',
                '+91 98765 43210', () {
              // Yahan url_launcher use kar sakte ho asli call ke liye
              print("Calling Support...");
            }),

            const SizedBox(height: 12),

            // Email Option
            _contactCard(Icons.email_rounded, Colors.blue, 'Email Us',
                'support@tokitech.com', () {
              print("Opening Email...");
            }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _contactCard(IconData icon, Color color, String title, String sub,
      VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.05)),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            CircleAvatar(
                backgroundColor: color.withOpacity(0.1),
                child: Icon(icon, color: color, size: 20)),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                Text(sub,
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_rounded,
                size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildAppVersion() {
    return Center(
      child: Column(
        children: const [
          Text('Version 2.4.0',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                  fontWeight: FontWeight.bold)),
          Text('Powered by Toki Tech',
              style: TextStyle(color: Colors.grey, fontSize: 9)),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _bottomIndex,
      onTap: _onBottomTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primaryTeal,
      unselectedItemColor: Colors.grey.shade400,
      backgroundColor: Colors.white,
      selectedFontSize: 11,
      unselectedFontSize: 11,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded), label: 'Search'),
        BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_num_rounded), label: 'Tickets'),
        BottomNavigationBarItem(icon: Icon(Icons.menu_rounded), label: 'More'),
      ],
    );
  }
}
