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
  final Color _royalBlue = const Color(0xFF2563EB);

  void _onBottomNavTap(int index) {
    setState(() => _currentIndex = index);
    final routes = [ParentsRoutes.home, ParentsRoutes.busTracking, ParentsRoutes.tickets, ParentsRoutes.moreOptions];
    if (index != 0) Navigator.pushReplacementNamed(context, routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 1. App Header
            _buildAppHeader(),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // 2. TODAY'S FULL DETAILS BOX
                    _buildBluePageTitle(),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // 3. Attendance
                          _buildDottedWrapper(
                            child: _buildSectionContent(
                              icon: Icons.check_circle_outline,
                              iconColor: const Color(0xFF10B981),
                              title: "Attendance",
                              subtitle: "Morning Session",
                              innerContent: Column(
                                children: [
                                  _rowItem("Status", "Present", isBadge: true, badgeBg: const Color(0xFFE8F5E9), textCol: Colors.green),
                                  _rowItem("Marked At", "9:15 AM"),
                                  _rowItem("Marked By", "Mrs. Priya Menon"),
                                  _rowItem("This Month", "95.5% (21/22 days)"),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // 4. Morning Bus
                          _buildDottedWrapper(
                            child: _buildSectionContent(
                              icon: Icons.directions_bus_outlined,
                              iconColor: Colors.orange,
                              title: "Morning Bus",
                              subtitle: "Route 5 • KA-01-AB-1234",
                              innerContent: Column(
                                children: [
                                  _rowItem("Pickup Time", "7:45 AM"),
                                  _rowItem("Reached School", "8:12 AM"),
                                  _rowItem("Status", "On Time", isBadge: true, badgeBg: const Color(0xFFE8F5E9), textCol: Colors.green),
                                  _rowItem("Driver", "Mr. Ramesh Kumar"),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // 5. Today's Schedule
                          _buildDottedWrapper(
                            child: _buildSectionContent(
                              icon: Icons.menu_book_outlined,
                              iconColor: Colors.blue,
                              title: "Today's Schedule",
                              subtitle: "6 Classes • 1 Lab",
                              innerContent: Column(
                                children: [
                                  _scheduleLine("9:00 AM", "Mathematics", "Ms. Lakshmi • Room 201", "Done"),
                                  _scheduleLine("10:00 AM", "Science", "Mr. Rajiv • Room 105", "Done"),
                                  _scheduleLine("11:00 AM", "English", "Ms. Sarah • Room 302", "Now", isNow: true),
                                  _scheduleLine("12:00 PM", "Lunch Break", "Cafeteria", ""),
                                  _scheduleLine("1:00 PM", "Social Studies", "Mr. Anil • Room 204", ""),
                                  _scheduleLine("2:00 PM", "Computer Lab", "Ms. Kavya • Lab 2", ""),
                                  _scheduleLine("3:00 PM", "Physical Education", "Mr. Suresh • Playground", ""),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // 6. Homework
                          _buildDottedWrapper(
                            child: _buildSectionContent(
                              icon: Icons.assignment_outlined,
                              iconColor: Colors.purple,
                              title: "Homework",
                              subtitle: "1 Assignment Due",
                              innerContent: _buildHomeworkBox(),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // 7. Today's Event
                          _buildDottedWrapper(
                            child: _buildSectionContent(
                              icon: Icons.calendar_today_outlined,
                              iconColor: Colors.pink,
                              title: "Today's Event",
                              subtitle: "After regular classes",
                              innerContent: _buildEventBox(),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // 8. Evening Bus
                          _buildDottedWrapper(
                            child: _buildSectionContent(
                              icon: Icons.directions_bus_filled,
                              iconColor: Colors.orange,
                              title: "Evening Bus",
                              subtitle: "Return Journey",
                              innerContent: _buildEveningBusBox(),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // 9. Quick Summary
                          _buildBottomSummary(),
                          const SizedBox(height: 20),

                          // ✅ 10. UPDATED CLOSE BUTTON (Halka Green Style)
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE8F5E9), // Halka Green Background
                                foregroundColor: const Color(0xFF1B5E20), // Dark Green Text
                                elevation: 0, // Flat look
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(color: Color(0xFFA5D6A7), width: 1), // Light Green Border
                                ),
                              ),
                              child: const Text(
                                "CLOSE DETAILS",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 1),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
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
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // --- DESIGN PIECES ---

  Widget _buildAppHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: _primaryOrange, borderRadius: BorderRadius.circular(8)),
            child: const Text("A", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Aditya International School", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              Text("Powered by Toki Tech", style: TextStyle(color: Color(0xFF757575), fontSize: 11)),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(8)),
            child: const Text("తెలుగు", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 12)),
          ),
        ],
      ),
    );
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
              decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle),
              child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 14),
            ),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Today's Full Details", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text("Monday, November 9, 2025", style: TextStyle(color: Colors.white70, fontSize: 13)),
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

  Widget _buildSectionContent({required IconData icon, required Color iconColor, required String title, required String subtitle, required Widget innerContent}) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(backgroundColor: iconColor.withOpacity(0.1), radius: 18, child: Icon(icon, color: iconColor, size: 20)),
              const SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(subtitle, style: const TextStyle(color: Color(0xFF757575), fontSize: 12)),
              ]),
            ],
          ),
          const SizedBox(height: 12),
          innerContent,
        ],
      ),
    );
  }

  Widget _rowItem(String label, String val, {bool isBadge = false, Color? badgeBg, Color? textCol}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF757575), fontSize: 14)),
          isBadge
              ? Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: badgeBg, borderRadius: BorderRadius.circular(6)), child: Text(val, style: TextStyle(color: textCol, fontWeight: FontWeight.bold, fontSize: 11)))
              : Text(val, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _scheduleLine(String time, String title, String sub, String status, {bool isNow = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(width: 55, child: Text(time, style: const TextStyle(color: Color(0xFF757575), fontSize: 11))),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), Text(sub, style: const TextStyle(color: Color(0xFF757575), fontSize: 11))])),
          if (status.isNotEmpty) Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: isNow ? const Color(0xFFE0F2FE) : const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(4)), child: Text(status, style: TextStyle(color: isNow ? Colors.blue : Colors.green, fontSize: 10, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  Widget _buildHomeworkBox() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFFFFF7ED), borderRadius: BorderRadius.circular(12), border: Border.all(color: Color(0xFFFFE0B2))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Mathematics - Exercise 5.2", style: TextStyle(fontWeight: FontWeight.bold)), Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)), child: const Text("Due Today", style: TextStyle(color: Colors.white, fontSize: 10)))]),
          const SizedBox(height: 8),
          const Text("Complete questions 1-10 from chapter 5.", style: TextStyle(fontSize: 12, color: Colors.black54)),
          const Divider(height: 20),
          _hwMiniRow("Subject", "Mathematics"),
          _hwMiniRow("Assigned By", "Ms. Lakshmi"),
          _hwMiniRow("Due Date", "Today, 4:00 PM", valCol: Colors.red),
        ],
      ),
    );
  }

  Widget _buildEventBox() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFFFDF2F8), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Sports Day Practice", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text("Practice session for upcoming sports day.", style: TextStyle(fontSize: 12, color: Colors.black54)),
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
        _rowItem("Time Remaining", "2h 15m", isBadge: true, badgeBg: const Color(0xFFE0F2FE), textCol: Colors.blue),
        _rowItem("Bus Route", "Route 5"),
        _rowItem("Vehicle", "KA-01-AB-1234"),
        const SizedBox(height: 12),
        SizedBox(width: double.infinity, height: 45, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: _royalBlue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), child: const Text("Track Live Location", style: TextStyle(color: Colors.white)))),
      ],
    );
  }

  Widget _buildBottomSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: _royalBlue, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Quick Summary", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(children: [_summaryTile("7", "Total Classes"), const SizedBox(width: 10), _summaryTile("1", "Homework Due")]),
          const SizedBox(height: 10),
          Row(children: [_summaryTile("1", "Event Today"), const SizedBox(width: 10), _summaryTile("35m", "Bus Journey")]),
        ],
      ),
    );
  }

  Widget _summaryTile(String val, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(val, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11))]),
      ),
    );
  }

  Widget _hwMiniRow(String l, String v, {Color? valCol}) => Padding(padding: const EdgeInsets.symmetric(vertical: 2), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(l, style: const TextStyle(fontSize: 12, color: Color(0xFF757575))), Text(v, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: valCol ?? Colors.black))]));

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: _onBottomNavTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: _primaryOrange,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.directions_bus_outlined), label: "Bus"),
        BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: "Tickets"),
        BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "More"),
      ],
    );
  }
}