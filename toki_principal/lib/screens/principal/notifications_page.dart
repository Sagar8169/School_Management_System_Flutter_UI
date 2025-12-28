import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  String selectedFilter = "All";
  final List<String> filters = ["All", "Approvals", "Alerts", "System"];

  List<Map<String, dynamic>> notifications = [
    {
      "id": 1,
      "title": "Cyclone Alert: School closed on Oct 21-22",
      "subtitle": "Severe weather warning issued by the department. Please stay safe at home.",
      "full_desc": "Due to the severe cyclone warning issued by the meteorological department for the coastal regions, the school administration has decided to keep the campus closed on October 21st and 22nd. Online classes will be conducted as per the regular schedule. Stay safe!",
      "type": "Alerts",
      "time": "2 mins ago",
      "isRead": false,
      "color": const Color(0xFFEF4444),
    },
    {
      "id": 2,
      "title": "Approval: Grade 10 Attendance",
      "subtitle": "Class teacher 'K. Murthy' submitted the records.",
      "full_desc": "The attendance records for Grade 10 (Section A) have been submitted by Mr. K. Murthy. Total students: 45. Present: 42. Three students are on medical leave. Please review and approve for the monthly report generation.",
      "type": "Approvals",
      "time": "1 hour ago",
      "isRead": false,
      "color": const Color(0xFF2563EB),
    },
    {
      "id": 3,
      "title": "System Update Successful",
      "subtitle": "Version 2.4.0 is now live with new features.",
      "full_desc": "We have successfully updated the portal to version 2.4.0. New features include advanced student tracking, automated payroll processing for teachers, and an upgraded parent communication module. Explore the new dashboard now!",
      "type": "System",
      "time": "Yesterday",
      "isRead": true,
      "color": const Color(0xFF8B5CF6),
    },
  ];

  // --- 📱 POPUP DETAILS MODAL (WITH SAFEAREA) ---
  void _showNotificationDetails(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true, // 👈 1. Background safety enable karta hai
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.55,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        // 👈 2. SafeArea wrap kiya taaki niche se buttons clear dikhein
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 10, 24, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Modal Handle Bar
                Center(
                    child: Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10)
                        )
                    )
                ),
                const SizedBox(height: 25),

                // Type & Time
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          color: item['color'].withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text(
                          item['type'],
                          style: TextStyle(
                              color: item['color'],
                              fontWeight: FontWeight.w900,
                              fontSize: 10,
                              letterSpacing: 1
                          )
                      ),
                    ),
                    const Spacer(),
                    Text(item['time'], style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),

                const SizedBox(height: 20),
                Text(
                    item['title'],
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))
                ),
                const SizedBox(height: 15),
                const Divider(),
                const SizedBox(height: 15),

                // Description (Scrollable)
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Text(
                        item['full_desc'],
                        style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xFF64748B),
                            height: 1.6,
                            fontWeight: FontWeight.w500
                        )
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // --- ACTION BUTTONS (Always above Safe Area) ---
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                        ),
                        child: const Text("DISMISS", style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey)),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() => item['isRead'] = true);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2563EB),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        child: const Text("TAKE ACTION", style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Light off-white for contrast
      body: Column(
        children: [
          _buildBlueHeader(),
          _buildFilterBar(),
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
              itemCount: notifications.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = notifications[index];
                if (selectedFilter != "All" && item['type'] != selectedFilter) return const SizedBox.shrink();

                return TweenAnimationBuilder(
                  duration: Duration(milliseconds: 300 + (index * 100)),
                  tween: Tween<double>(begin: 0, end: 1),
                  curve: Curves.easeOut,
                  builder: (context, double value, child) => Opacity(opacity: value, child: Transform.translate(offset: Offset(0, 20 * (1 - value)), child: child)),
                  child: _buildSwipeableCard(item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // --- 🎨 BLUE HEADER: TEXT NEXT TO BACK BTN ---
  Widget _buildBlueHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
      decoration: const BoxDecoration(
        color: Color(0xFF2563EB), // Solid Premium Blue
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
        boxShadow: [BoxShadow(color: Color(0x302563EB), blurRadius: 20, offset: Offset(0, 10))],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), shape: BoxShape.circle),
              child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
            ),
          ),
          const SizedBox(width: 15),
          const Text("Notifications", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: -0.5)),
          const Spacer(),
          _buildCountBadge(),
        ],
      ),
    );
  }

  Widget _buildCountBadge() {
    int unreadCount = notifications.where((n) => !n['isRead']).length;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
      child: Text("$unreadCount New", style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800)),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedFilter == filters[index];
          return GestureDetector(
            onTap: () => setState(() => selectedFilter = filters[index]),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 22),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF1E293B) : Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: isSelected ? Colors.transparent : const Color(0xFFE2E8F0)),
              ),
              alignment: Alignment.center,
              child: Text(filters[index], style: TextStyle(color: isSelected ? Colors.white : const Color(0xFF64748B), fontWeight: FontWeight.w800, fontSize: 12)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSwipeableCard(Map<String, dynamic> item) {
    return Slidable(
      key: ValueKey(item['id']),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.2,
        children: [
          SlidableAction(onPressed: (_) => setState(() => notifications.remove(item)), backgroundColor: const Color(0xFFFEF2F2), foregroundColor: Colors.red, icon: Icons.delete_outline_rounded, borderRadius: BorderRadius.circular(20)),
        ],
      ),
      child: InkWell(
        onTap: () => _showNotificationDetails(item),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: item['isRead'] ? const Color(0xFFF1F5F9) : const Color(0xFFDBEAFE), width: 1.5),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ❌ Icon Box Removed (As per request)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item['type'].toUpperCase(), style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: item['color'], letterSpacing: 0.8)),
                        Text(item['time'], style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(item['title'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
                    const SizedBox(height: 4),
                    Text(item['subtitle'], maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B), height: 1.4)),
                  ],
                ),
              ),
              if (!item['isRead'])
                Container(margin: const EdgeInsets.only(left: 10, top: 30), width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF2563EB), shape: BoxShape.circle)),
            ],
          ),
        ),
      ),
    );
  }
}