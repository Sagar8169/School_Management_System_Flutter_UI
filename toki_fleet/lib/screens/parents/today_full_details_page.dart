// lib/screens/parents/today_full_details_page.dart
import 'package:flutter/material.dart';
import '../../routes/parents_routes.dart';

class TodayFullDetailsPage extends StatefulWidget {
  const TodayFullDetailsPage({Key? key}) : super(key: key);

  @override
  _TodayFullDetailsPageState createState() => _TodayFullDetailsPageState();
}

class _TodayFullDetailsPageState extends State<TodayFullDetailsPage> {
  int _currentIndex = 0;
  final Color _primaryOrange = const Color(0xFFFF5722);

  void _onBottomNavTap(int index) {
    setState(() => _currentIndex = index);
    switch (index) {
      case 0:
      // Already on Home or Home-like page
        Navigator.pushReplacementNamed(context, ParentsRoutes.home);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, ParentsRoutes.reports);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, ParentsRoutes.busTracking);
        break;
      case 3:
        Navigator.pushReplacementNamed(context, ParentsRoutes.moreOptions);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // App Header with Back Button
              _buildAppHeader(context),

              // Page Header (now scrollable)
              _buildPageHeader(),

              // Main Content
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Attendance Card
                    _buildCard(
                      icon: Icons.check_circle_outline,
                      iconBg: const Color(0xFF10B981),
                      title: "Attendance",
                      subtitle: "Morning Session",
                      child: Column(
                        children: [
                          _buildDetailRow("Status", _buildStatusBadge("Present", Colors.green)),
                          _buildDetailRow("Marked At", const Text("9:15 AM")),
                          _buildDetailRow("Marked By", const Text("Mrs. Priya Menon")),
                          _buildDetailRow("This Month", const Text("95.5%")),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Morning Bus Card
                    _buildCard(
                      icon: Icons.directions_bus,
                      iconBg: const Color(0xFFF59E0B),
                      title: "Morning Bus",
                      subtitle: "Route 5 • KA-01-AB-1234",
                      child: Column(
                        children: [
                          _buildDetailRow("Pickup", const Text("7:45 AM")),
                          _buildDetailRow("Reached", const Text("8:12 AM")),
                          _buildDetailRow("Status", _buildStatusBadge("On Time", Colors.green)),
                          _buildDetailRow("Driver", const Text("Mr. Ramesh Kumar")),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Schedule Card
                    _buildCard(
                      icon: Icons.menu_book_outlined,
                      iconBg: const Color(0xFF8B5CF6),
                      title: "Today's Schedule",
                      subtitle: "Monday, November 9, 2025",
                      child: Column(
                        children: [
                          _buildScheduleRow("9:00 AM", "Mathematics", "Mrs. Priya Menon", "Room 201", "Done"),
                          _buildScheduleRow("10:00 AM", "Science", "Mr. Rajesh Kumar", "Lab 3", "Done"),
                          _buildScheduleRow("11:00 AM", "English", "Mrs. Meera Sharma", "Room 205", "Now"),
                          _buildScheduleRow("12:00 PM", "Lunch Break", "", "", ""),
                          _buildScheduleRow("1:00 PM", "Social Studies", "Mr. Arun Verma", "Room 202", "Upcoming"),
                          _buildScheduleRow("2:00 PM", "Computer Lab", "Ms. Priyanka Singh", "Lab 4", "Upcoming"),
                          _buildScheduleRow("3:00 PM", "Physical Education", "Mr. Suresh Patel", "Playground", "Upcoming"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Homework Card
                    _buildCard(
                      icon: Icons.assignment_outlined,
                      iconBg: const Color(0xFFEC4899),
                      title: "Homework",
                      subtitle: "Due Today",
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF7ED),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Mathematics - Exercise 5.2",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Color(0xFF1F2937),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFEE2E2),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Text(
                                    "Due Today",
                                    style: TextStyle(
                                      color: Color(0xFFDC2626),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Complete exercise questions 1 to 10 from chapter 5. Submit handwritten solutions.",
                              style: TextStyle(
                                color: Color(0xFF6B7280),
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Divider(height: 1, color: Color(0xFFF3F4F6)),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Subject: Mathematics",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF6B7280),
                                  ),
                                ),
                                Text(
                                  "Due: Today, 4:00 PM",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFDC2626),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Today's Event Card
                    _buildCard(
                      icon: Icons.event_outlined,
                      iconBg: const Color(0xFFF97316),
                      title: "Today's Event",
                      subtitle: "Sports Day Practice",
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFDF2F8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Sports Day Practice",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Practice session for upcoming Annual Sports Day. All students must attend with proper sports uniform.",
                              style: TextStyle(
                                color: Color(0xFF6B7280),
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 16),
                            GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              childAspectRatio: 3,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              children: [
                                _buildEventDetail("Time", "3:30 PM"),
                                _buildEventDetail("Venue", "Playground"),
                                _buildEventDetail("Coordinator", "Mr. Suresh"),
                                _buildEventDetail("Duration", "1.5 hours"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Evening Bus Card
                    _buildCard(
                      icon: Icons.directions_bus,
                      iconBg: const Color(0xFFF97316),
                      title: "Evening Bus",
                      subtitle: "Route 5 • KA-01-AB-1234",
                      child: Column(
                        children: [
                          _buildDetailRow("Departure", const Text("4:00 PM")),
                          _buildDetailRow("Expected Drop", const Text("4:35 PM")),
                          _buildDetailRow("Time Remaining", _buildStatusBadge("2h 15m", Colors.blue)),
                          const SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Text(
                                "Track Live Location",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Quick Summary
                    _buildQuickSummary(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _primaryOrange,
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

  Widget _buildAppHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF1F2937)),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Aditya International School",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xFF1F2937),
                ),
              ),
              Text(
                "Powered by Toki Tech",
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: const Text(
              "English",
              style: TextStyle(
                color: Color(0xFFFF5722),
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF2563EB),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Today's Full Details",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4),
          Text(
            "Monday, November 9, 2025",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required Color iconBg,
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, Widget value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 14,
            ),
          ),
          DefaultTextStyle.merge(
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xFF1F2937),
              fontSize: 14,
            ),
            child: value,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildScheduleRow(String time, String subject, String teacher, String room, String status) {
    Color statusColor = Colors.grey;
    if (status == "Done") statusColor = Colors.green;
    if (status == "Now") statusColor = Colors.blue;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(
              time,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xFF1F2937),
                  ),
                ),
                if (teacher.isNotEmpty && room.isNotEmpty)
                  Text(
                    "$teacher • $room",
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF6B7280),
                    ),
                  ),
              ],
            ),
          ),
          if (status.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEventDetail(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2937),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text(
            "Quick Summary",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: [
              _buildSummaryItem("7", "Total Classes"),
              _buildSummaryItem("1", "Homework Due"),
              _buildSummaryItem("1", "Event Today"),
              _buildSummaryItem("35m", "Bus Journey"),
            ],
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFF374151),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  "Close",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}