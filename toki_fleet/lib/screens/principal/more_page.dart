import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../widgets/common_widgets.dart';
import '../../routes/principal_routes.dart';

class MorePage extends StatefulWidget {
  final String? initialSection;

  const MorePage({
    super.key,
    this.initialSection,
  });

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  int _currentIndex = 3;
  bool _isTelugu = true;
  bool _isDarkMode = false;

  // --- Menu Data Lists ---
  final List<Map<String, dynamic>> _managementItems = [
    {
      'title': 'Pending Approvals',
      'id': 'approvals',
      'icon': Icons.check_circle_outline,
      'color': Colors.blue,
      'hasBadge': true,
      'badgeCount': 6,
      'badgeColor': CommonWidgets.warningColor,
    },
    {
      'title': 'Tickets',
      'id': 'tickets',
      'icon': Icons.receipt_long,
      'color': Colors.purple,
      'hasBadge': true,
      'badgeCount': 8,
      'badgeColor': CommonWidgets.errorColor,
    },
    {
      'title': 'Upcoming Events',
      'id': 'events',
      'icon': Icons.event,
      'color': Colors.green,
      'hasBadge': false,
    },
    {
      'title': 'Manage Timetable',
      'id': 'timetable',
      'icon': Icons.schedule,
      'color': Colors.orange,
      'hasBadge': false,
    },
    {
      'title': 'Announcements',
      'id': 'announcements',
      'icon': Icons.campaign,
      'color': Colors.red,
      'hasBadge': false,
    },
  ];

  final List<Map<String, dynamic>> _settingsItems = [
    {
      'title': 'Feedbacks',
      'id': 'feedbacks',
      'icon': Icons.feedback,
      'color': Colors.teal,
      'hasBadge': true,
      'badgeCount': 3,
      'badgeColor': Colors.red,
    },
    {
      'title': 'Privacy & Security',
      'id': 'privacy',
      'icon': Icons.security,
      'color': Colors.indigo,
      'hasBadge': false,
    },
    {
      'title': 'Language Preferences',
      'id': 'language',
      'icon': Icons.language,
      'color': Colors.blueGrey,
      'hasBadge': false,
    },
  ];

  final List<Map<String, dynamic>> _preferencesItems = [
    {
      'title': 'Dark Mode',
      'id': 'dark_mode',
      'icon': Icons.dark_mode,
      'color': Colors.deepPurple,
      'isToggle': true,
    },
    {
      'title': 'Download Reports',
      'id': 'downloads',
      'icon': Icons.download,
      'color': Colors.brown,
      'isToggle': false,
    },
    {
      'title': 'Share App',
      'id': 'share',
      'icon': Icons.share,
      'color': Colors.cyan,
      'isToggle': false,
    },
  ];

  final List<Map<String, dynamic>> _supportItems = [
    {
      'title': 'Help Center',
      'id': 'help',
      'icon': Icons.help_center,
      'color': Colors.amber,
      'hasBadge': false,
    },
    {
      'title': 'Contact Toki Tech Support',
      'id': 'contact',
      'icon': Icons.support_agent,
      'color': Colors.pink,
      'hasBadge': false,
    },
    {
      'title': 'About Toki Tech',
      'id': 'about',
      'icon': Icons.info,
      'color': Colors.lightBlue,
      'hasBadge': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialSection != null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _handleInitialSection(widget.initialSection!);
      });
    }
  }

  void _handleInitialSection(String sectionId) {
    if (['approvals', 'tickets', 'events', 'timetable', 'announcements'].contains(sectionId)) {
      _showSectionMessage(sectionId);
    }
  }

  void _toggleLanguage() {
    setState(() {
      _isTelugu = !_isTelugu;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Language switched to ${_isTelugu ? 'Telugu' : 'English'}'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${value ? 'Dark' : 'Light'} mode ${value ? 'enabled' : 'disabled'}'),
          backgroundColor: value ? Colors.grey[800] : Colors.blue,
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  void _navigateTo(String routeName, {Map<String, dynamic>? arguments}) {
    if (arguments != null) {
      Navigator.pushNamed(context, routeName, arguments: arguments);
    } else {
      Navigator.pushNamed(context, routeName);
    }
  }

  void _onBottomNavTapped(int index) {
    if (_currentIndex == index) return;

    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        _navigateTo(PrincipalRoutes.home);
        break;
      case 1:
        _navigateTo(PrincipalRoutes.search);
        break;
      case 2:
        _navigateTo(PrincipalRoutes.gradesAnalytics);
        break;
      case 3:
        break;
    }
  }

  void _onMenuItemTap(Map<String, dynamic> item) {
    final String id = item['id'];
    final String title = item['title'];

    if (['approvals', 'tickets', 'events', 'timetable', 'announcements', 'feedbacks', 'privacy', 'downloads', 'help'].contains(id)) {
      _showSectionMessage(id);
      return;
    }

    switch (id) {
      case 'language':
        _toggleLanguage();
        break;
      case 'share':
        _shareApp();
        break;
      case 'contact':
        _contactSupport();
        break;
      case 'about':
        _showAboutDialog();
        break;
    }
  }

  void _showSectionMessage(String sectionId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$sectionId section would open here'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _shareApp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Share App'),
        content: const Text('Share Toki Tech app with your colleagues'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Sharing functionality would be implemented here'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Share'),
          ),
        ],
      ),
    );
  }

  void _contactSupport() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.support_agent, color: Colors.blue),
            SizedBox(width: 8),
            Text('Contact Support'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('We\'re here to help you!', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            _buildContactInfo(
              Icons.email,
              'Email',
              'support@tokitech.com',
              Colors.red,
            ),
            const SizedBox(height: 12),
            _buildContactInfo(
              Icons.phone,
              'Phone',
              '+91 98765 43210',
              Colors.green,
            ),
            const SizedBox(height: 12),
            _buildContactInfo(
              Icons.access_time,
              'Available',
              '9 AM - 6 PM (Mon-Sat)',
              Colors.blue,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Calling support...'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            icon: const Icon(Icons.phone, size: 20),
            label: const Text('Call Now'),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String label, String value, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.info, color: Colors.blue),
            SizedBox(width: 8),
            Text('About Toki Tech'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Toki Tech - School Management System',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.verified_user, color: Colors.blue, size: 16),
                  SizedBox(width: 8),
                  Text('Version 2.0.1', style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Comprehensive school management solution designed to streamline administrative tasks, enhance communication, and improve educational outcomes.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Text(
              '© 2025 Toki Tech. All rights reserved.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _logout() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.logout, color: Colors.red),
            SizedBox(width: 8),
            Text('Logout'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Are you sure you want to logout?'),
            SizedBox(height: 8),
            Text(
              'You will need to login again to access your account.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (result == true) {
      // Show loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      // Simulate logout process
      await Future.delayed(const Duration(seconds: 1));

      // Navigate to login screen
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/login', // Replace with your actual login route
            (route) => false,
      );

      // Show logout success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logged out successfully'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            CommonWidgets.appHeader(
              selectedLanguage: _isTelugu ? 'తెలుగు' : 'English',
              onLanguageToggle: _toggleLanguage,
            ),
            Expanded(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: _buildProfileCard(),
                    ),
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          _buildSectionTitle("Management"),
                        ],
                      ),
                    ),
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) => _buildMenuItemWithUI(_managementItems[index]),
                        childCount: _managementItems.length,
                      ),
                    ),
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          _buildSectionTitle("Settings"),
                        ],
                      ),
                    ),
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) => _buildMenuItemWithUI(_settingsItems[index]),
                        childCount: _settingsItems.length,
                      ),
                    ),
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          _buildSectionTitle("Preferences"),
                        ],
                      ),
                    ),
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) => _buildMenuItemWithUI(_preferencesItems[index]),
                        childCount: _preferencesItems.length,
                      ),
                    ),
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          _buildSectionTitle("Support"),
                        ],
                      ),
                    ),
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) => _buildMenuItemWithUI(_supportItems[index]),
                        childCount: _supportItems.length,
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(height: 32),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: ElevatedButton.icon(
                            onPressed: _logout,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            icon: const Icon(Icons.logout, size: 20),
                            label: const Text(
                              "Logout",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: Column(
                            children: [
                              Text(
                                "Version 2.0.1",
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "© 2025 Toki Tech",
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _isDarkMode
              ? [Colors.grey[850]!, Colors.grey[900]!]
              : [Colors.white, Colors.grey[50]!],
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.blue[400]!, Colors.blue[700]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 35,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dr. Ramesh Kumar",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: _isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Principal",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue[700],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () => _showSectionMessage('profile'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.blue,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.blue.withOpacity(0.3)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  icon: const Icon(Icons.edit, size: 16),
                  label: const Text(
                    "Edit Profile",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItemWithUI(Map<String, dynamic> item) {
    final color = item['color'] as Color;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: _isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(15),
        elevation: 2,
        child: InkWell(
          onTap: item['isToggle'] == true ? null : () => _onMenuItemTap(item),
          borderRadius: BorderRadius.circular(15),
          splashColor: color.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color.withOpacity(0.9), color],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'],
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: _isDarkMode ? Colors.white : Colors.black87,
                        ),
                      ),
                      if (item['id'] == 'contact' || item['id'] == 'about') ...[
                        const SizedBox(height: 4),
                        Text(
                          item['id'] == 'contact' ? 'Get help from our team' : 'Learn more about Toki Tech',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                if (item['isToggle'] == true)
                  Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                      value: _isDarkMode,
                      onChanged: _toggleDarkMode,
                      activeColor: Colors.blue,
                    ),
                  )
                else if (item['hasBadge'] == true)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [item['badgeColor'], item['badgeColor']!.withOpacity(0.8)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: item['badgeColor']!.withOpacity(0.3),
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Text(
                      item['badgeCount'].toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey[400],
                    size: 24,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: _isDarkMode ? Colors.white : Colors.black87,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onBottomNavTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.white,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey[600],
          selectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          elevation: 10,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: _currentIndex == 0
                      ? Colors.blue.withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: Icon(
                  Icons.home,
                  size: _currentIndex == 0 ? 26 : 24,
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: _currentIndex == 1
                      ? Colors.blue.withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: Icon(
                  Icons.search,
                  size: _currentIndex == 1 ? 26 : 24,
                ),
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: _currentIndex == 2
                      ? Colors.blue.withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: Icon(
                  Icons.show_chart,
                  size: _currentIndex == 2 ? 26 : 24,
                ),
              ),
              label: 'Activity',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: _currentIndex == 3
                      ? Colors.blue.withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: Icon(
                  Icons.more_horiz,
                  size: _currentIndex == 3 ? 26 : 24,
                ),
              ),
              label: 'More',
            ),
          ],
        ),
      ),
    );
  }
}