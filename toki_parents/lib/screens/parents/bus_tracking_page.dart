// lib/screens/parents/bus_tracking_page.dart
import 'package:flutter/material.dart';

const Color _primaryOrange = Color(0xFFFF5722);

class BusTrackingPage extends StatefulWidget {
  final bool showBackButton;
  const BusTrackingPage({Key? key, required this.showBackButton})
      : super(key: key);

  @override
  _BusTrackingPageState createState() => _BusTrackingPageState();
}

class _BusTrackingPageState extends State<BusTrackingPage> {
  // ✅ ALL ORIGINAL VARIABLES RETAINED
  String _selectedLanguage = 'తెలుగు';
  bool _isLiveTracking = true;
  final String _userStop = "Sector 13 Circle";
  final String _userChildName = "Ananya Sharma";

  // ✅ ORIGINAL COLOUR PALETTE
  final Color _headerOrange = const Color(0xFFFF9800);
  final Color _darkOrangeCard = const Color(0xFFD97904);
  final Color _scaffoldBg = Colors.white;
  final Color _textPrimary = const Color(0xFF1F2937);
  final Color _textSecondary = const Color(0xFF6B7280);

  final Color _greenBadgeBg = const Color(0xFFECFDF5);
  final Color _greenBadgeText = const Color(0xFF10B981);
  final Color _blueBadgeBg = const Color(0xFFEFF6FF);
  final Color _blueBadgeText = const Color(0xFF3B82F6);

  final Color _userStopBg = const Color(0xFFF0F7FF);
  final Color _userStopBorder = const Color(0xFF3B82F6);
  final Color _userStopIcon = const Color(0xFF3B82F6);

  void _toggleLanguage() {
    setState(() {
      _selectedLanguage = _selectedLanguage == 'తెలుగు' ? 'English' : 'తెలుగు';
    });
  }

  // void _onBottomNavTap(int index) {
  //   if (index == 0)
  //     Navigator.pushReplacementNamed(context, ParentsRoutes.home);
  //   else if (index == 1)
  //     Navigator.pushReplacementNamed(context, ParentsRoutes.reports);
  //   else if (index == 3) Navigator.pushReplacementNamed(
  //       context, ParentsRoutes.moreOptions);
  // }

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
                    _buildHeroSection(widget.showBackButton),
                    const SizedBox(height: 20),
                    _buildToggleButtons(),
                    const SizedBox(height: 24),
                    _isLiveTracking
                        ? _buildLiveTrackingView()
                        : _buildHistoryView(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: _buildBottomNav(), // Custom bottom nav for premium feel
    );
  }

  Widget _buildAppHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border:
            Border(bottom: BorderSide(color: Colors.grey.shade100, width: 1)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [_primaryOrange, _primaryOrange.withOpacity(0.8)]),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                    color: _primaryOrange.withOpacity(0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 6))
              ],
            ),
            alignment: Alignment.center,
            child: const Text("A",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 22)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Aditya International",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                        letterSpacing: -0.6,
                        color: Color(0xFF1A1A1A))),
                Row(
                  children: [
                    Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                            color: Color(0xFF10B981), shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    Text("Support Portal Active",
                        style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 11,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
          _buildLanguageToggle(),
        ],
      ),
    );
  }

  Widget _buildLanguageToggle() {
    return GestureDetector(
      onTap: _toggleLanguage,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade200)),
        child: Row(
          children: [
            const Icon(Icons.translate, size: 14, color: _primaryOrange),
            const SizedBox(width: 4),
            Text(_selectedLanguage,
                style: const TextStyle(
                    color: _primaryOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(bool showBackButton) {
    // Logic to determine session based on current time or data
    bool isMorning = DateTime.now().hour < 12;
    String tripLabel =
        isMorning ? "Morning Trip (Pickup)" : "Evening Trip (Drop)";

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: _headerOrange,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Top Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  /// ⬅ Back Button (only when opened from Home)
                  if (showBackButton)
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white24,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),

                  if (showBackButton) const SizedBox(width: 12),

                  const Text(
                    "Bus Tracking",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),

              /// ✨ Session Badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  isMorning ? "MORNING" : "EVENING",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// 🔹 Hero Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _darkOrangeCard,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.directions_bus,
                      color: Colors.white,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tripLabel,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Text(
                            "Bus Route 5",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.wifi_tethering,
                      color: Colors.greenAccent,
                      size: 20,
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(color: Colors.white24, height: 1),
                ),
                _heroStatRow("Current Location", "Sector 12 Main Road"),
                const SizedBox(height: 8),
                _heroStatRow("Estimated Time", "15 minutes"),
                const SizedBox(height: 8),
                _heroStatRow("Next Stop", "Sector 13 Circle"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildBottomNav() {
  //   return BottomNavigationBar(
  //     currentIndex: 2,
  //     onTap: _onBottomNavTap,
  //     type: BottomNavigationBarType.fixed,
  //     selectedItemColor: _accentOrange,
  //     backgroundColor: Colors.white,
  //     selectedLabelStyle: const TextStyle(
  //         fontWeight: FontWeight.w900, fontSize: 11),
  //     unselectedLabelStyle: const TextStyle(
  //         fontWeight: FontWeight.w700, fontSize: 11),
  //     items: const [
  //       BottomNavigationBarItem(icon: Icon(Icons.home_outlined),
  //           activeIcon: Icon(Icons.home_rounded),
  //           label: "Home"),
  //       BottomNavigationBarItem(icon: Icon(Icons.analytics_outlined),
  //           activeIcon: Icon(Icons.analytics_rounded),
  //           label: "Reports"),
  //       BottomNavigationBarItem(icon: Icon(Icons.directions_bus_outlined),
  //           activeIcon: Icon(Icons.directions_bus_rounded),
  //           label: "Bus"),
  //       BottomNavigationBarItem(icon: Icon(Icons.grid_view_outlined),
  //           activeIcon: Icon(Icons.grid_view_rounded),
  //           label: "More"),
  //     ],
  //   );
  // }

  Widget _heroStatRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style:
                TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildToggleButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(14)),
        child: Row(
          children: [
            _toggleBtn("Live Tracking", _isLiveTracking,
                () => setState(() => _isLiveTracking = true)),
            _toggleBtn("Trip History", !_isLiveTracking,
                () => setState(() => _isLiveTracking = false)),
          ],
        ),
      ),
    );
  }

  Widget _toggleBtn(String title, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? _headerOrange : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                        color: _headerOrange.withOpacity(0.3), blurRadius: 8)
                  ]
                : [],
          ),
          child: Center(
            child: Text(title,
                style: TextStyle(
                    color: isSelected ? Colors.white : _textSecondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14)),
          ),
        ),
      ),
    );
  }

  Widget _buildLiveTrackingView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Route Progress",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 20),
          _timelineStop("School Gate", "7:30 AM", status: "passed"),
          _timelineStop("Sector 11 Park", "7:42 AM", status: "current"),
          _timelineStop(_userStop, "8:00 AM",
              status: "future", isUserStop: true),
          _timelineStop("School", "8:15 AM", status: "future", isLast: true),
        ],
      ),
    );
  }

  Widget _timelineStop(String name, String time,
      {String status = "future",
      bool isUserStop = false,
      bool isLast = false}) {
    Color dotColor = status == "passed"
        ? _greenBadgeText
        : (status == "current" ? _headerOrange : Colors.grey.shade300);
    if (isUserStop) dotColor = _userStopIcon;

    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    if (status == "current" || isUserStop)
                      BoxShadow(
                          color: dotColor.withOpacity(0.4),
                          blurRadius: 10,
                          spreadRadius: 2)
                  ],
                ),
                child: status == "passed"
                    ? const Icon(Icons.check, size: 10, color: Colors.white)
                    : null,
              ),
              if (!isLast)
                Expanded(
                    child: VerticalDivider(
                        color: Colors.grey.shade300, thickness: 2, width: 22)),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isUserStop ? _userStopBg : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: isUserStop ? _userStopBorder : Colors.grey.shade100),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color:
                                    isUserStop ? _userStopIcon : _textPrimary)),
                        Text(
                            isUserStop
                                ? "Registered Stop for $_userChildName"
                                : "Bus Stop",
                            style:
                                TextStyle(color: _textSecondary, fontSize: 11)),
                      ],
                    ),
                  ),
                  Text(time,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _textPrimary,
                          fontSize: 13)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _historyCard(
              "Morning Trip", "Pickup", "Nov 9, 2025", "7:30 AM - 8:15 AM"),
          _historyCard(
              "Evening Trip", "Drop", "Nov 8, 2025", "3:00 PM - 3:45 PM"),
          _historyCard(
              "Morning Trip", "Pickup", "Nov 8, 2025", "7:30 AM - 8:15 AM"),
        ],
      ),
    );
  }

  Widget _historyCard(String session, String type, String date, String time) {
    Color badgeColor = type == "Pickup" ? _blueBadgeText : _greenBadgeText;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: badgeColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12)),
            child: Icon(
                type == "Pickup"
                    ? Icons.wb_sunny_outlined
                    : Icons.nights_stay_outlined,
                color: badgeColor,
                size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(session,
                        style: TextStyle(
                            color: badgeColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5)),
                    const SizedBox(width: 8),
                    Text(date,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xFF1F2937))),
                  ],
                ),
                const SizedBox(height: 2),
                Text(time,
                    style: TextStyle(color: _textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
                color: _greenBadgeBg, borderRadius: BorderRadius.circular(6)),
            child: Text("COMPLETED",
                style: TextStyle(
                    color: _greenBadgeText,
                    fontSize: 9,
                    fontWeight: FontWeight.w900)),
          )
        ],
      ),
    );
  }
}
