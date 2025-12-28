// lib/screens/parents/attendance_record_page.dart
import 'package:flutter/material.dart';
import '../../routes/parents_routes.dart';

class AttendanceRecordPage extends StatefulWidget {
  const AttendanceRecordPage({Key? key}) : super(key: key);

  @override
  _AttendanceRecordPageState createState() => _AttendanceRecordPageState();
}

class _AttendanceRecordPageState extends State<AttendanceRecordPage> {
  String _selectedLanguage = 'తెలుగు';
  bool _showRecentDays = true;

  // Colors extracted from the image
  final Color _primaryGreen = const Color(0xFF2DB57C); // Main Green
  final Color _darkGreenCard = const Color(0xFF1E825F); // Inner Dark Green
  final Color _bgGreenLight = const Color(0xFFE6F8EF); // present bg
  final Color _textGreen = const Color(0xFF2DB57C); // Text green
  final Color _bgRedLight = const Color(0xFFFEE2E2); //  absent bg
  final Color _textRed = const Color(0xFFEF4444); // Text red
  final Color _bgBlueLight = const Color(0xFFE0F2FE); //  Oct bg
  final Color _textBlue = const Color(0xFF3B82F6); // Text blue
  final Color _scaffoldBg = Colors.white;

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
            // 1. App Header (White part)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
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
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  children: [
                    // Green Summary Card
                    _buildGreenSummaryCard(),
                    const SizedBox(height: 20),

                    // Toggle Tabs
                    _buildToggleTabs(),
                    const SizedBox(height: 20),

                    // Content based on selection
                    _showRecentDays ? _buildRecentDaysList() : _buildMonthlyViewList(),

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

  Widget _buildGreenSummaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _primaryGreen,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back Button & Title
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
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
                "Attendance Record",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Inner Dark Stats Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _darkGreenCard,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "This Month (November)",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "95.5%",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "10th-A",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _buildHeaderStat("21", "Present"),
                    _buildHeaderDivider(),
                    _buildHeaderStat("1", "Absent"),
                    _buildHeaderDivider(),
                    _buildHeaderStat("22", "Total Days"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStat(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderDivider() {
    return Container(
      height: 24,
      width: 1,
      color: Colors.white24,
      margin: const EdgeInsets.symmetric(horizontal: 24),
    );
  }

  Widget _buildToggleTabs() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _showRecentDays = true),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: _showRecentDays ? _primaryGreen : const Color(0xFFF3F4F6),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                "Recent Days",
                style: TextStyle(
                  color: _showRecentDays ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _showRecentDays = false),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: !_showRecentDays ? _primaryGreen : const Color(0xFFF3F4F6),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                "Monthly View",
                style: TextStyle(
                  color: !_showRecentDays ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --- Recent Days View ---

  Widget _buildRecentDaysList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Last 6 Days",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        _buildDayCard("Saturday", "Nov 9", true),
        _buildDayCard("Friday", "Nov 8", true),
        _buildDayCard("Thursday", "Nov 7", true),
        _buildDayCard("Wednesday", "Nov 6", false),
        _buildDayCard("Tuesday", "Nov 5", true),
        _buildDayCard("Monday", "Nov 4", true),
      ],
    );
  }

  Widget _buildDayCard(String day, String date, bool isPresent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isPresent ? _bgGreenLight : _bgRedLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isPresent ? Icons.check_box_outlined : Icons.close,
              color: isPresent ? _textGreen : _textRed,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                day,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                date,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isPresent ? _bgGreenLight : _bgRedLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              isPresent ? "Present" : "Absent",
              style: TextStyle(
                color: isPresent ? _textGreen : _textRed,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Monthly View ---

  Widget _buildMonthlyViewList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Monthly Summary",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        _buildMonthCard(
          "November 2025",
          "95.5%",
          21,
          1,
          22,
          _bgGreenLight,
          _textGreen,
        ),
        _buildMonthCard(
          "October 2025",
          "92.3%",
          24,
          2,
          26,
          _bgBlueLight,
          _textBlue,
        ),
        _buildMonthCard(
          "September 2025",
          "100%",
          22,
          0,
          22,
          _bgGreenLight,
          _textGreen,
        ),
        _buildMonthCard(
          "August 2025",
          "95.8%",
          23,
          1,
          24,
          _bgGreenLight,
          _textGreen,
        ),
      ],
    );
  }

  Widget _buildMonthCard(
      String month,
      String percentage,
      int present,
      int absent,
      int total,
      Color badgeBg,
      Color badgeText,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            month,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: badgeBg,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              percentage,
              style: TextStyle(
                color: badgeText,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFF3F4F6)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMonthStat(present.toString(), "Present", _textGreen),
              _buildMonthStat(absent.toString(), "Absent", _textRed),
              _buildMonthStat(total.toString(), "Total", Colors.black87),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMonthStat(String value, String label, Color valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}