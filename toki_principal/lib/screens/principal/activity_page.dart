import 'package:flutter/material.dart';
import '../../routes/principal_routes.dart';

const Color themeBlue = Color(0xFF1E3A8A);
const Color themeLightBlue = Color(0xFF3B82F6);
const Color themeGreen = Color(0xFF059669);
const Color backgroundSlate = Color(0xFFF8FAFC);

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  // int _currentIndex = 2;
  bool _isTelugu = true;

  // --- ORIGINAL DATA LIST ---
  final List<Map<String, dynamic>> _activityItems = [
    {
      'title': 'Take Attendance',
      'subtitle': 'Monthly Average: 96%',
      'icon': Icons.how_to_reg_rounded,
      'iconBgColor': const Color(0xFFE8F5E9), // Very Light Green
      'iconColor': const Color(0xFF2E7D32),
      'route': PrincipalRoutes.takeAttendance,
    },
    {
      'title': 'Add Task (Teachers)',
      'subtitle': '12 Pending Tasks',
      'icon': Icons.task_alt_rounded,
      'iconBgColor': const Color(0xFFE3F2FD), // Very Light Blue
      'iconColor': const Color(0xFF1565C0),
      'route': PrincipalRoutes.pendingApprovals,
    },
    {
      'title': 'Collect Fee',
      'subtitle': 'Academic Session 24-25',
      'icon': Icons.currency_rupee_rounded,
      'iconBgColor': const Color(0xFFFFF8E1), // Very Light Amber
      'iconColor': const Color(0xFFF9A825),
      'route': PrincipalRoutes.collectFee, // ✅
    },
    {
      'title': 'Add Event (School)',
      'subtitle': 'Next: Sports Day (Nov 15)',
      'icon': Icons.event_available_rounded,
      'iconBgColor': const Color(0xFFF3E5F5), // Very Light Purple
      'iconColor': const Color(0xFF7B1FA2),
      'route': PrincipalRoutes.addEvent,
    },
    {
      'title': 'Add Grades',
      'subtitle': 'Unit Exam 2 ongoing',
      'icon': Icons.auto_graph_rounded,
      'iconBgColor': const Color(0xFFFFEBEE), // Very Light Red
      'iconColor': const Color(0xFFC62828),
      'route': PrincipalRoutes.uploadGrades,
    },
    {
      'title': 'Add Homework',
      'subtitle': 'Daily logs for Class 10',
      'icon': Icons.menu_book_rounded,
      'iconBgColor': const Color(0xFFE1F5FE), // Very Light Sky
      'iconColor': const Color(0xFF0277BD),
      'route': PrincipalRoutes.addHomework,
    },
  ];

  // --- ORIGINAL FUNCTIONS ---
  void _toggleLanguage() {
    setState(() {
      _isTelugu = !_isTelugu;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            _isTelugu ? "తెలుగు భాషలోకి మార్చబడింది" : "Switched to English"),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _navigateTo(String routeName, {Map<String, dynamic>? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  Widget _langTogglePill() {
    return GestureDetector(
      onTap: _toggleLanguage,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6FF),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFDBEAFE)),
        ),
        child: Text(_isTelugu ? "తెలుగు" : "English",
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: Color(0xFF3B82F6))),
      ),
    );
  }

  // void _onBottomNavTap(int index) {
  //   switch (index) {
  //     case 0:
  //       Navigator.pushReplacementNamed(context, PrincipalRoutes.home);
  //       break;
  //     case 1:
  //       Navigator.pushReplacementNamed(context, PrincipalRoutes.search);
  //       break;
  //     case 2:
  //       Navigator.pushReplacementNamed(context, PrincipalRoutes.activity);
  //       break;
  //     case 3:
  //       Navigator.pushReplacementNamed(
  //         context,
  //         PrincipalRoutes.morePage,
  //         arguments: {'section': null},
  //       );
  //       break;
  //   }
  // }

  void _handleActivityTap(Map<String, dynamic> item) {
    if (item['route'] != null) {
      _navigateTo(item['route']);
    } else {
      String sectionKey = 'more';
      if (item['title'].contains('Fee')) sectionKey = 'fee';
      if (item['title'].contains('Event')) sectionKey = 'events';
      if (item['title'].contains('Homework')) sectionKey = 'homework';
      Navigator.pushNamed(context, PrincipalRoutes.morePage,
          arguments: {'initialSection': sectionKey});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Pure white background
      appBar: _buildTopBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              const Text(
                "Quick Actions",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              const SizedBox(height: 5),
              Text(
                "Choose an action to manage school",
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 25),
              _buildResponsiveList(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: _buildCleanBottomNav(),
    );
  }

  PreferredSizeWidget _buildTopBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: const BoxDecoration(color: Colors.white),
        child: SafeArea(
          bottom: false,
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [themeBlue, themeLightBlue],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    "A",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Aditya International School",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    Text(
                      "Powered by Toki Tech",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
              ),
              _langTogglePill(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResponsiveList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _activityItems.length,
      itemBuilder: (context, index) {
        final item = _activityItems[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: () => _handleActivityTap(item),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),

                // ✅ PROPER CARD BORDER
                border: Border.all(
                  color: const Color(0xFFE2E8F0), // light slate border
                  width: 1,
                ),

                // ✅ VERY SUBTLE SHADOW (border ko overpower na kare)
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1E293B).withOpacity(0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: item['iconBgColor'],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      item['icon'],
                      color: item['iconColor'],
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title'],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item['subtitle'],
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
                    color: Color(0xFFCBD5E1),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Widget _buildCleanBottomNav() {
  //   return Container(
  //     decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade100, width: 1))),
  //     child: BottomNavigationBar(
  //       currentIndex: _currentIndex,
  //       onTap: _onBottomNavTap,
  //       selectedItemColor: const Color(0xFF1D4ED8),
  //       unselectedItemColor: Colors.grey.shade400,
  //       type: BottomNavigationBarType.fixed,
  //       backgroundColor: Colors.white,
  //       elevation: 0,
  //       selectedFontSize: 12,
  //       unselectedFontSize: 12,
  //       items: const [
  //         BottomNavigationBarItem(icon: Icon(Icons.home_rounded, size: 24), activeIcon: Icon(Icons.home_filled), label: 'Home'),
  //         BottomNavigationBarItem(icon: Icon(Icons.search_rounded, size: 24), label: 'Search'),
  //         BottomNavigationBarItem(icon: Icon(Icons.analytics_rounded, size: 24), label: 'Activity'),
  //         BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded, size: 24), label: 'More'),
  //       ],
  //     ),
  //   );
  // }
}
