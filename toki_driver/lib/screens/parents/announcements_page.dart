// lib/screens/parents/announcements_page.dart
import 'package:flutter/material.dart';
import '../../routes/parents_routes.dart';

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({Key? key}) : super(key: key);

  @override
  _AnnouncementsPageState createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  String _selectedLanguage = 'తెలుగు';


  final Color _heroRed = const Color(0xFFD34031); // Main red background
  final Color _heroCardBg = const Color(0xFFB02E23); // Darker red inner card
  final Color _scaffoldBg = Colors.white;
  final Color _textPrimary = const Color(0xFF1F2937);
  final Color _textSecondary = const Color(0xFF6B7280);

  // Icon/Badge Colors
  final Color _redIconBg = const Color(0xFFFFEBEE);
  final Color _redIconColor = const Color(0xFFEF5350);
  final Color _yellowIconBg = const Color(0xFFFFF8E1);
  final Color _yellowIconColor = const Color(0xFFFBC02D);
  final Color _blueIconBg = const Color(0xFFE3F2FD);
  final Color _blueIconColor = const Color(0xFF4285F4);

  void _toggleLanguage() {
    setState(() {
      _selectedLanguage = _selectedLanguage == 'తెలుగు' ? 'English' : 'తెలుగు';
    });
  }

  void _onBottomNavTap(int index) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, ParentsRoutes.home);
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, ParentsRoutes.reports);
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, ParentsRoutes.busTracking);
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, ParentsRoutes.moreOptions);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            // 1. App Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF5722),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "A",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Aditya International School",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Powered by Toki Tech",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 11,
                        ),
                      ),
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
                      child: Text(
                        _selectedLanguage,
                        style: const TextStyle(
                          color: Color(0xFFFF5722),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 2. Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero Section (Red)
                    _buildHeroSection(),

                    const SizedBox(height: 20),

                    // Title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "All Announcements",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // List of Announcements
                    _buildAnnouncementCard(
                      isNew: true,
                      time: "2 hours ago",
                      title: "School Holiday on November 11",
                      message:
                      "School will remain closed on November 11, 2025 due to public holiday. Regular classes will resume from November 12.",
                      iconBg: _redIconBg,
                      iconColor: _redIconColor,
                    ),
                    _buildAnnouncementCard(
                      isNew: true,
                      time: "Yesterday",
                      title: "Mid-term Results Published",
                      message:
                      "Mid-term examination results have been published. Please check the Grades section to view your child's performance.",
                      iconBg: _redIconBg,
                      iconColor: _redIconColor,
                    ),
                    _buildAnnouncementCard(
                      isNew: false,
                      time: "2 days ago",
                      title: "Parent-Teacher Meeting on Nov 15",
                      message:
                      "Parent-Teacher meeting is scheduled for November 15, 2025 from 10:00 AM to 1:00 PM. Please make sure to attend.",
                      iconBg: _yellowIconBg,
                      iconColor: _yellowIconColor,
                    ),
                    _buildAnnouncementCard(
                      isNew: false,
                      time: "3 days ago",
                      title: "Winter Uniform Notice",
                      message:
                      "Students are requested to wear winter uniform starting from November 15, 2025. Summer uniform will not be allowed after this date.",
                      iconBg: _yellowIconBg,
                      iconColor: _yellowIconColor,
                    ),
                    _buildAnnouncementCard(
                      isNew: false,
                      time: "4 days ago",
                      title: "Library Book Return Reminder",
                      message:
                      "All library books must be returned by November 20, 2025. Late fees will be applicable after the due date.",
                      iconBg: _blueIconBg,
                      iconColor: _blueIconColor,
                    ),
                    _buildAnnouncementCard(
                      isNew: false,
                      time: "5 days ago",
                      title: "Annual Sports Day Registration",
                      message:
                      "Registration for Annual Sports Day 2025 is now open. Please contact the sports department to register your child.",
                      iconBg: _yellowIconBg,
                      iconColor: _yellowIconColor,
                    ),
                    _buildAnnouncementCard(
                      isNew: false,
                      time: "1 week ago",
                      title: "Flu Vaccination Camp",
                      message:
                      "A flu vaccination camp will be organized on November 18, 2025. Parents can opt-in through the school office.",
                      iconBg: _blueIconBg,
                      iconColor: _blueIconColor,
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: _onBottomNavTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFFF5722),
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: "Reports",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bus_outlined),
            label: "Bus",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: "More",
          ),
        ],
      ),
    );
  }

  // --- Widgets ---

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: _heroRed,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back Button and Title
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                "School Announcements",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Inner Dark Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _heroCardBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recent Updates",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "2",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "New announcements since your last visit",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementCard({
    required bool isNew,
    required String time,
    required String title,
    required String message,
    required Color iconBg,
    required Color iconColor,
  }) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.info_outline,
              color: iconColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),

          // Right Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: New Badge and Time
                Row(
                  children: [
                    if (isNew) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFEBEE),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          "New",
                          style: TextStyle(
                            color: Color(0xFFE53935),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      time,
                      style: TextStyle(
                        color: _textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // Title
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: _textPrimary,
                  ),
                ),
                const SizedBox(height: 6),

                // Message
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 13,
                    color: _textSecondary,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),

                // Posted by
                Text(
                  "Posted by: Principal",
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}