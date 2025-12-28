// lib/screens/parents/bus_tracking_page.dart
import 'package:flutter/material.dart';
import '../../routes/parents_routes.dart';

class BusTrackingPage extends StatefulWidget {
  const BusTrackingPage({Key? key}) : super(key: key);

  @override
  _BusTrackingPageState createState() => _BusTrackingPageState();
}

class _BusTrackingPageState extends State<BusTrackingPage> {
  String _selectedLanguage = 'తెలుగు';
  bool _isLiveTracking = true;

  // User's stop information
  final String _userStop = "Sector 13 Circle";
  final String _userChildName = "Ananya Sharma";

  // Colors extracted from images
  final Color _headerOrange = const Color(0xFFFF9800); // Main Orange
  final Color _darkOrangeCard = const Color(0xFFD97904); // Inner Darker Orange
  final Color _scaffoldBg = Colors.white;
  final Color _textPrimary = const Color(0xFF1F2937);
  final Color _textSecondary = const Color(0xFF6B7280);

  // Badge/Tag Colors
  final Color _greenBadgeBg = const Color(0xFFECFDF5);
  final Color _greenBadgeText = const Color(0xFF10B981);
  final Color _blueBadgeBg = const Color(0xFFEFF6FF);
  final Color _blueBadgeText = const Color(0xFF3B82F6);
  final Color _orangeBadgeBg = const Color(0xFFFFF7ED);
  final Color _orangeBadgeText = const Color(0xFFF97316);

  // User stop highlight colors
  final Color _userStopBg = const Color(0xFFF0F7FF);
  final Color _userStopBorder = const Color(0xFF3B82F6);
  final Color _userStopIcon = const Color(0xFF3B82F6);

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
      // Already on bus
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, ParentsRoutes.moreOptions);
    }
  }


  bool _isUserStop(String stopName) {
    return stopName == _userStop;
  }

  // trip period (Morning/Evening) timing
  String _getTripPeriod(String timeRange) {
    if (timeRange.contains("AM") || timeRange.toLowerCase().contains("morning")) {
      return "Morning";
    } else if (timeRange.contains("PM") && !timeRange.contains("12")) {
      return "Evening";
    } else {
      return "Day";
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
                  children: [
                    // Hero Section (Orange)
                    _buildHeroSection(),

                    const SizedBox(height: 20),

                    // Toggle Tabs
                    _buildToggleButtons(),

                    const SizedBox(height: 20),

                    // Content Body
                    _isLiveTracking ? _buildLiveTrackingView() : _buildHistoryView(),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Bus tab active
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
            icon: Icon(Icons.directions_bus_filled),
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
        color: _headerOrange,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title "Bus Tracking"
          const Padding(
            padding: EdgeInsets.only(bottom: 16, top: 8),
            child: Text(
              "Bus Tracking",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Inner Dark Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _darkOrangeCard,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Live Status
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFF4ADE80),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Live Tracking",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Bus Icon & Route
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.directions_bus, color: Colors.white, size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Bus Route 5",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "KA-01-AB-1234 • Mr. Ramesh",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Your stop: $_userStop",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 11,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Stats Grid
                Row(
                  children: [
                    Expanded(child: _buildStatLabel("Current Location")),
                    Expanded(child: _buildStatValue("Sector 12 Main Road")),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: _buildStatLabel("Estimated Time")),
                    Expanded(child: _buildStatValue("15 minutes")),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: _buildStatLabel("Next Stop")),
                    Expanded(child: _buildStatValue("Sector 13 Circle")),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white.withOpacity(0.8),
        fontSize: 12,
      ),
    );
  }

  Widget _buildStatValue(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.right,
    );
  }

  Widget _buildToggleButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isLiveTracking = true),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _isLiveTracking ? _headerOrange : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Live Tracking",
                  style: TextStyle(
                    color: _isLiveTracking ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isLiveTracking = false),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: !_isLiveTracking ? _headerOrange : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Trip History",
                  style: TextStyle(
                    color: !_isLiveTracking ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Live Tracking Content ---

  Widget _buildLiveTrackingView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Map Placeholder
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on_outlined, size: 40, color: Colors.grey[500]),
                const SizedBox(height: 8),
                Text(
                  "Live Map View",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "(Map integration coming soon)",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Track your child's bus in real-time",
            style: TextStyle(
              color: _textSecondary,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),

          // Route Stops
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Route Stops",
              style: TextStyle(
                color: _textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(height: 12),

          _buildRouteStopItem("School Gate", "7:30 AM", status: "passed"),
          _buildRouteStopItem("Sector 10 Square", "7:35 AM", status: "passed"),
          _buildRouteStopItem("Sector 11 Park", "7:42 AM", status: "passed", tag: "Reached"),
          _buildRouteStopItem("Sector 12 Main Road", "7:50 AM", status: "current", tag: "Current"),
          _buildRouteStopItem("Sector 13 Circle", "8:00 AM", status: "future", isUserStop: true),
          _buildRouteStopItem("Sector 14 Market", "8:05 AM", status: "future"),
          _buildRouteStopItem("School", "8:15 AM", status: "future"),
        ],
      ),
    );
  }

  Widget _buildRouteStopItem(
      String name,
      String time, {
        required String status,
        String? tag,
        bool isUserStop = false,
      }) {
    // Icons & Colors based on status
    Widget icon;
    Color? tagBg;
    Color? tagText;
    Color? containerBg;
    Color? borderColor;

    if (status == "passed") {
      icon = Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: _greenBadgeBg,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.check,
          color: _greenBadgeText,
          size: 18,
        ),
      );
      tagBg = _greenBadgeBg;
      tagText = _greenBadgeText;
    } else if (status == "current") {
      icon = Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          color: Color(0xFFFEF3C7),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Container(
          width: 14,
          height: 14,
          decoration: const BoxDecoration(
            color: Color(0xFFF59E0B),
            shape: BoxShape.circle,
          ),
        ),
      );
      tagBg = const Color(0xFFFEF3C7);
      tagText = const Color(0xFFD97706);
    } else {
      icon = Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          color: Color(0xFFF3F4F6),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: Color(0xFF9CA3AF),
            shape: BoxShape.circle,
          ),
        ),
      );
    }

    // Highlight user's stop
    if (isUserStop) {
      containerBg = _userStopBg;
      borderColor = _userStopBorder;
      icon = Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: _userStopIcon.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.person_pin_circle,
          color: _userStopIcon,
          size: 20,
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: containerBg ?? Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderColor ?? Colors.grey.shade200,
          width: isUserStop ? 1.5 : 1,
        ),
        boxShadow: isUserStop
            ? [
          BoxShadow(
            color: _userStopBorder.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ]
            : null,
      ),
      child: Row(
        children: [
          Stack(
            children: [
              icon,
              if (isUserStop)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: _userStopIcon,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: isUserStop ? _userStopIcon : _textPrimary,
                      ),
                    ),
                    if (isUserStop) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: _userStopIcon.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "Your Stop",
                          style: TextStyle(
                            color: _userStopIcon,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      time,
                      style: TextStyle(
                        color: _textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    if (isUserStop) ...[
                      const SizedBox(width: 8),
                      Text(
                        "• $_userChildName",
                        style: TextStyle(
                          color: _userStopIcon,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          if (tag != null && !isUserStop)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: tagBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                tag,
                style: TextStyle(
                  color: tagText,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
          if (isUserStop)
            Icon(
              Icons.arrow_forward_ios,
              color: _userStopIcon,
              size: 16,
            ),
        ],
      ),
    );
  }

  // --- Trip History Content ---

  Widget _buildHistoryView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Previous Trips",
            style: TextStyle(
              color: _textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "View your child's past bus trips",
            style: TextStyle(
              color: _textSecondary,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12),

          _buildHistoryCard("Pickup", "Nov 9, 2025", "7:30 AM - 8:15 AM"),
          _buildHistoryCard("Drop", "Nov 8, 2025", "3:00 PM - 3:45 PM"),
          _buildHistoryCard("Pickup", "Nov 8, 2025", "7:30 AM - 8:15 AM"),
          _buildHistoryCard("Drop", "Nov 7, 2025", "3:00 PM - 3:50 PM"),
          _buildHistoryCard("Pickup", "Nov 7, 2025", "7:35 AM - 8:20 AM"),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(String type, String date, String time) {
    Color typeBg = type == "Pickup" ? _blueBadgeBg : _greenBadgeBg;
    Color typeText = type == "Pickup" ? _blueBadgeText : _greenBadgeText;
    String tripPeriod = _getTripPeriod(time);
    Color periodBg = tripPeriod == "Morning" ? const Color(0xFFFEF3C7) : const Color(0xFFFCE7F3);
    Color periodText = tripPeriod == "Morning" ? const Color(0xFFD97706) : const Color(0xFFBE185D);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Badges Row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: typeBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      type == "Pickup" ? Icons.arrow_upward : Icons.arrow_downward,
                      size: 12,
                      color: typeText,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      type,
                      style: TextStyle(
                        color: typeText,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _greenBadgeBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Completed",
                  style: TextStyle(
                    color: _greenBadgeText,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: periodBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      tripPeriod == "Morning" ? Icons.wb_sunny_outlined : Icons.nights_stay_outlined,
                      size: 12,
                      color: periodText,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      tripPeriod,
                      style: TextStyle(
                        color: periodText,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Date
          Text(
            date,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: _textPrimary,
            ),
          ),
          const SizedBox(height: 4),

          // Time with icon
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 14,
                color: _textSecondary,
              ),
              const SizedBox(width: 6),
              Text(
                time,
                style: TextStyle(
                  color: _textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFF3F4F6)),
          const SizedBox(height: 12),

          // Bus and Stop Info
          Row(
            children: [
              Icon(
                Icons.directions_bus,
                size: 14,
                color: _textSecondary,
              ),
              const SizedBox(width: 6),
              Text(
                "KA-01-AB-1234 • Mr. Ramesh",
                style: TextStyle(
                  color: _textSecondary,
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.location_on,
                size: 14,
                color: _textSecondary,
              ),
              const SizedBox(width: 6),
              Text(
                _userStop,
                style: TextStyle(
                  color: _textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Child Info
          Row(
            children: [
              Icon(
                Icons.person_outline,
                size: 14,
                color: _textSecondary,
              ),
              const SizedBox(width: 6),
              Text(
                "Student: $_userChildName",
                style: TextStyle(
                  color: _textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}