// lib/screens/fleet_manager/fleet_more_options.dart
import 'package:flutter/material.dart';
import '../../routes/fleet_manager_routes.dart';

class FleetMoreOptions extends StatefulWidget {
  const FleetMoreOptions({Key? key}) : super(key: key);

  @override
  State<FleetMoreOptions> createState() => _FleetMoreOptionsState();
}

class _FleetMoreOptionsState extends State<FleetMoreOptions> {
  static const Color primaryTeal = Color(0xFF00BFA5);
  static const Color tealHeader = Color(0xFF26A69A);
  static const Color background = Color(0xFFF9FAFB);

  int _bottomIndex = 3; // More tab active

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
      // already here
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _globalHeader(),
            _headerProfileSection(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
                children: [
                  const SizedBox(height: 8),
                  _sectionHeader('Fleet Management'),
                  const SizedBox(height: 6),
                  _menuItem(
                    icon: Icons.directions_bus,
                    iconBg: primaryTeal.withOpacity(0.08),
                    iconColor: primaryTeal,
                    title: 'All Buses',
                    subtitle: 'View complete bus list',
                    onTap: () {
                      // Existing placeholder route
                      Navigator.pushNamed(context, FleetManagerRoutes.busOverview);
                    },
                  ),
                  const SizedBox(height: 8),
                  _menuItem(
                    icon: Icons.build,
                    iconBg: Colors.yellow.shade100,
                    iconColor: Colors.orange.shade700,
                    title: 'Maintenance Schedule',
                    subtitle: 'View and manage maintenance',
                    onTap: () {
                      // Placeholder – wire in routes file later
                      Navigator.pushNamed(context, '/fleet/maintenance-schedule');
                    },
                  ),
                  const SizedBox(height: 8),
                  _menuItem(
                    icon: Icons.map,
                    iconBg: Colors.purple.shade50,
                    iconColor: Colors.purple,
                    title: 'Route Management',
                    subtitle: 'Edit routes and stops',
                    onTap: () {
                      // You already have FleetManagerRoutes.routes placeholder
                      Navigator.pushNamed(context, FleetManagerRoutes.routes);
                    },
                  ),
                  const SizedBox(height: 20),

                  _sectionHeader('Driver Management'),
                  const SizedBox(height: 6),
                  _menuItem(
                    icon: Icons.event_note,
                    iconBg: Colors.orange.shade50,
                    iconColor: Colors.deepOrange,
                    title: 'Leave Management',
                    subtitle: 'Approve driver leaves',
                    onTap: () {
                      Navigator.pushNamed(context, '/fleet/leave-management');
                    },
                  ),
                  const SizedBox(height: 20),

                  _sectionHeader('Settings & Support'),
                  const SizedBox(height: 6),
                  _menuItem(
                    icon: Icons.person,
                    iconBg: Colors.blue.shade50,
                    iconColor: Colors.blue,
                    title: 'My Profile',
                    subtitle: 'Edit your information',
                    onTap: () {
                      Navigator.pushNamed(context, '/fleet/profile');
                    },
                  ),
                  const SizedBox(height: 8),
                  _menuItem(
                    icon: Icons.info_outline,
                    iconBg: Colors.pink.shade50,
                    iconColor: Colors.pink.shade600,
                    title: 'Help & Support',
                    subtitle: 'Get help using the app',
                    onTap: () {
                      Navigator.pushNamed(context, '/fleet/help');
                    },
                  ),
                  const SizedBox(height: 8),
                  _menuItem(
                    icon: Icons.logout,
                    iconBg: Colors.pink.shade50,
                    iconColor: Colors.red.shade600,
                    title: 'Logout',
                    subtitle: 'Sign out of your account',
                    titleColor: Colors.red.shade700,
                    onTap: () {
                      // For now just a placeholder; hook auth later
                      Navigator.pushNamed(context, '/fleet/logout');
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomIndex,
        onTap: _onBottomTap,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryTeal,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Tickets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_vert),
            label: 'More',
          ),
        ],
      ),
    );
  }

  // Global top header
  Widget _globalHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: primaryTeal,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'A',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Aditya International School',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 2),
                Text(
                  'Powered by Toki Tech',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: primaryTeal),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('తెలుగు'),
          ),
        ],
      ),
    );
  }

  // Teal header + profile card
  Widget _headerProfileSection() {
    return Container(
      color: tealHeader,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'More Options',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF00796B), // darker green
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 34,
                      color: Color(0xFF00796B),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Mr. Suresh Kumar',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Fleet Manager',
                        style: TextStyle(
                          color: Color(0xFFB2DFDB),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 13,
        color: Colors.black87,
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    Color? titleColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x11000000),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: titleColor ?? Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
