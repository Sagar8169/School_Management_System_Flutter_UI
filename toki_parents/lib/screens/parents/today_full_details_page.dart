// lib/screens/parents/today_full_details_page.dart
import 'package:flutter/material.dart';
import '../../routes/parents_routes.dart';

final Color _accentOrange = const Color(0xFFFF5722);

class TodayFullDetailsPage extends StatefulWidget {
  const TodayFullDetailsPage({Key? key}) : super(key: key);

  @override
  _TodayFullDetailsPageState createState() => _TodayFullDetailsPageState();
}

class _TodayFullDetailsPageState extends State<TodayFullDetailsPage> {
  String _selectedLanguage = 'తెలుగు';

  final Color _primaryOrange = const Color(0xFFFF5722);
  final Color _royalBlue = const Color(0xFF2563EB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB), // Modern light background
      body: SafeArea(
        child: Column(
          children: [
            /// 1. App Header (Branding maintained)
            _buildAppHeader(),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    /// 2. Header Title Section
                    _buildBluePageTitle(),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: Column(
                        children: [
                          /// 3. Attendance - Highlighted Card
                          _buildPremiumDetailCard(
                            icon: Icons.verified_user_rounded,
                            iconColor: const Color(0xFF10B981),
                            title: "Attendance Status",
                            subtitle: "Daily Check-in Report",
                            child: Column(
                              children: [
                                _rowItem("Status", "Present",
                                    isBadge: true,
                                    badgeBg: const Color(0xFFD1FAE5),
                                    textCol: const Color(0xFF059669)),
                                _rowItem("Marked At", "9:15 AM"),
                                _rowItem("Supervisor", "Mrs. Priya Menon"),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          /// 4. Transport Tracking (Morning)
                          _buildPremiumDetailCard(
                            icon: Icons.local_shipping_rounded,
                            iconColor: Colors.orange,
                            title: "Morning Transport",
                            subtitle: "Route 5 • KA-01-AB-1234",
                            child: Column(
                              children: [
                                _rowItem("Reached School", "8:12 AM"),
                                _rowItem("Status", "On Time",
                                    isBadge: true,
                                    badgeBg: const Color(0xFFFFF7ED),
                                    textCol: Colors.orange),
                                _rowItem("Driver", "Mr. Ramesh Kumar"),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          /// 5. Today's Schedule (Timeline Style)
                          _buildPremiumDetailCard(
                            icon: Icons.auto_stories_rounded,
                            iconColor: Colors.blue,
                            title: "Daily Schedule",
                            subtitle: "Progress: 3/7 Periods Done",
                            child: _buildTimelineSchedule(),
                          ),

                          const SizedBox(height: 16),

                          /// 6. Homework & Events (Side-by-side or stacked)
                          _buildPremiumDetailCard(
                            icon: Icons.assignment_turned_in_rounded,
                            iconColor: Colors.purple,
                            title: "Assignments",
                            subtitle: "1 Task Pending",
                            child: _buildHomeworkBox(),
                          ),

                          const SizedBox(height: 24),

                          /// 7. Action Button (Refined)
                          _buildCloseButton(context),

                          const SizedBox(height: 20),
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
    );
  }

  /// --- Section 1: Premium Card Wrapper ---
  Widget _buildPremiumDetailCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 20,
              offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: iconColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12)),
                  child: Icon(icon, color: iconColor, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              letterSpacing: -0.5)),
                      Text(subtitle,
                          style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 11,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 0.5),
          Padding(
            padding: const EdgeInsets.all(18),
            child: child,
          ),
        ],
      ),
    );
  }

  /// --- Section 2: Timeline Schedule ---
  Widget _buildTimelineSchedule() {
    return Column(
      children: [
        _timelineStep("09:00 AM", "Mathematics", "Room 201", true, false),
        _timelineStep("10:00 AM", "Science", "Room 105", true, false),
        _timelineStep("11:00 AM", "English", "Room 302", false, true), // Active
        _timelineStep("12:00 PM", "Lunch Break", "Cafeteria", false, false),
      ],
    );
  }

  Widget _timelineStep(
      String time, String subject, String room, bool isDone, bool isNow) {
    return Row(
      children: [
        Column(
          children: [
            Icon(
                isDone
                    ? Icons.check_circle
                    : (isNow
                        ? Icons.radio_button_checked
                        : Icons.circle_outlined),
                size: 20,
                color: isNow
                    ? Colors.blue
                    : (isDone ? Colors.green : Colors.grey.shade300)),
            Container(width: 2, height: 30, color: Colors.grey.shade100),
          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subject,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: isNow ? Colors.blue : Colors.black87)),
                Text("$time • $room",
                    style:
                        TextStyle(color: Colors.grey.shade500, fontSize: 11)),
              ],
            ),
          ),
        ),
        if (isNow)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8)),
            child: const Text("NOW",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 10,
                    fontWeight: FontWeight.w800)),
          ),
      ],
    );
  }

  /// --- Section 3: Refined Close Button ---
  Widget _buildCloseButton(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFF10B981).withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF10B981).withOpacity(0.2)),
        ),
        child: const Center(
          child: Text(
            "DISMISS DETAILS",
            style: TextStyle(
                color: Color(0xFF059669),
                fontWeight: FontWeight.w800,
                fontSize: 14,
                letterSpacing: 1),
          ),
        ),
      ),
    );
  }

  // --- DESIGN PIECES ---

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
            Icon(Icons.translate, size: 14, color: _primaryOrange),
            const SizedBox(width: 4),
            Text(_selectedLanguage,
                style: TextStyle(
                    color: _primaryOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 12)),
          ],
        ),
      ),
    );
  }

  void _toggleLanguage() {
    setState(() {
      _selectedLanguage = _selectedLanguage == 'తెలుగు' ? 'English' : 'తెలుగు';
    });
  }

  Widget _buildBluePageTitle() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 35, 20, 35),
      decoration: BoxDecoration(
        color: _royalBlue,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                  color: Colors.white24, shape: BoxShape.circle),
              child: const Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 14),
            ),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Today's Full Details",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text("Monday, November 9, 2025",
                  style: TextStyle(color: Colors.white70, fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDottedWrapper({required Widget child}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE3F2FD), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  Widget _buildSectionContent(
      {required IconData icon,
      required Color iconColor,
      required String title,
      required String subtitle,
      required Widget innerContent}) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                  backgroundColor: iconColor.withOpacity(0.1),
                  radius: 18,
                  child: Icon(icon, color: iconColor, size: 20)),
              const SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Text(subtitle,
                    style: const TextStyle(
                        color: Color(0xFF757575), fontSize: 12)),
              ]),
            ],
          ),
          const SizedBox(height: 12),
          innerContent,
        ],
      ),
    );
  }

  Widget _rowItem(String label, String val,
      {bool isBadge = false, Color? badgeBg, Color? textCol}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(color: Color(0xFF757575), fontSize: 14)),
          isBadge
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                      color: badgeBg, borderRadius: BorderRadius.circular(6)),
                  child: Text(val,
                      style: TextStyle(
                          color: textCol,
                          fontWeight: FontWeight.bold,
                          fontSize: 11)))
              : Text(val,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _scheduleLine(String time, String title, String sub, String status,
      {bool isNow = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
              width: 55,
              child: Text(time,
                  style:
                      const TextStyle(color: Color(0xFF757575), fontSize: 11))),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                Text(sub,
                    style:
                        const TextStyle(color: Color(0xFF757575), fontSize: 11))
              ])),
          if (status.isNotEmpty)
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                    color: isNow
                        ? const Color(0xFFE0F2FE)
                        : const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(status,
                    style: TextStyle(
                        color: isNow ? Colors.blue : Colors.green,
                        fontSize: 10,
                        fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  Widget _buildHomeworkBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 1. Subject & Priority Header
        Row(
          children: [
            // Circular Subject Icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.functions_rounded,
                  size: 18, color: Colors.orange),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                "Mathematics",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                  color: Color(0xFF1A1C1E),
                ),
              ),
            ),
            // Urgent Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFFEE2E2)),
              ),
              child: const Text(
                "Due Today",
                style: TextStyle(
                  color: Color(0xFFEF4444),
                  fontWeight: FontWeight.w800,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        /// 2. Task Description Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Exercise 5.2: Algebra Basics",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              ),
              const SizedBox(height: 6),
              Text(
                "Complete questions 1-10 from chapter 5. Ensure all steps are shown for full credits.",
                style: TextStyle(
                    fontSize: 12, color: Colors.grey.shade600, height: 1.4),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        /// 3. Informational Grid
        Row(
          children: [
            _buildHWMiniStat(Icons.person_outline_rounded, "Ms. Lakshmi"),
            const SizedBox(width: 16),
            _buildHWMiniStat(Icons.alarm_rounded, "4:00 PM Today",
                isAlert: true),
          ],
        ),

        const SizedBox(height: 16),

        /// 4. Submission Progress Bar
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: 0.7, // 70% completed example
                  minHeight: 6,
                  backgroundColor: Color(0xFFF1F5F9),
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "70% Done",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Helper for small stats in Homework Box
  Widget _buildHWMiniStat(IconData icon, String label, {bool isAlert = false}) {
    return Row(
      children: [
        Icon(icon,
            size: 14, color: isAlert ? Colors.red : Colors.grey.shade400),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isAlert ? Colors.red : Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  Widget _buildEventBox() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: const Color(0xFFFDF2F8),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Sports Day Practice",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text("Practice session for upcoming sports day.",
              style: TextStyle(fontSize: 12, color: Colors.black54)),
          const Divider(height: 20),
          _hwMiniRow("Time", "3:30 PM - 4:30 PM"),
          _hwMiniRow("Venue", "School Playground"),
        ],
      ),
    );
  }

  Widget _buildEveningBusBox() {
    return Column(
      children: [
        _rowItem("Departure Time", "4:00 PM"),
        _rowItem("Expected Drop", "4:35 PM"),
        _rowItem("Time Remaining", "2h 15m",
            isBadge: true,
            badgeBg: const Color(0xFFE0F2FE),
            textCol: Colors.blue),
        _rowItem("Bus Route", "Route 5"),
        _rowItem("Vehicle", "KA-01-AB-1234"),
        const SizedBox(height: 12),
        SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: _royalBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                child: const Text("Track Live Location",
                    style: TextStyle(color: Colors.white)))),
      ],
    );
  }

  Widget _buildBottomSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: _royalBlue, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Quick Summary",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(children: [
            _summaryTile("7", "Total Classes"),
            const SizedBox(width: 10),
            _summaryTile("1", "Homework Due")
          ]),
          const SizedBox(height: 10),
          Row(children: [
            _summaryTile("1", "Event Today"),
            const SizedBox(width: 10),
            _summaryTile("35m", "Bus Journey")
          ]),
        ],
      ),
    );
  }

  Widget _summaryTile(String val, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(val,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          Text(label,
              style: const TextStyle(color: Colors.white70, fontSize: 11))
        ]),
      ),
    );
  }

  Widget _hwMiniRow(String l, String v, {Color? valCol}) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(l, style: const TextStyle(fontSize: 12, color: Color(0xFF757575))),
        Text(v,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: valCol ?? Colors.black))
      ]));
}
