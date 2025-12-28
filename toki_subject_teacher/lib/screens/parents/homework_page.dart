// lib/screens/parents/homework_page.dart
import 'package:flutter/material.dart';

class HomeworkPage extends StatefulWidget {
  const HomeworkPage({Key? key}) : super(key: key);

  @override
  _HomeworkPageState createState() => _HomeworkPageState();
}

class _HomeworkPageState extends State<HomeworkPage> {
  String _selectedFilter = 'All';

  // Palette colors from screenshot
  final Color _purpleHero = const Color(0xFF8B5CF6);
  final Color _purpleDark = const Color(0xFF7C3AED);
  final Color _scaffoldBg = Colors.white;
  final Color _textSecondary = const Color(0xFF64748B);

  final List<Map<String, dynamic>> _homeworks = [
    {
      "subject": "Mathematics",
      "status": "Pending",
      "title": "Exercise 5.2 - All Qs",
      "desc": "Complete all questions from Exercise 5.2 in your textbook. Show all working.",
      "assigned": "Nov 7, 2025",
      "due": "Nov 9, 2025",
      "color": Colors.blue,
    },
    {
      "subject": "Science",
      "status": "Pending",
      "title": "Lab Report - Chemical Reactions",
      "desc": "Write a detailed report on the chemical reaction experiment conducted in class.",
      "assigned": "Nov 6, 2025",
      "due": "Nov 12, 2025",
      "color": Colors.blue,
    },
    {
      "subject": "English",
      "status": "Pending",
      "title": "Essay Writing - My School",
      "desc": "Write an essay of 200-250 words describing your school and what you like about it.",
      "assigned": "Nov 8, 2025",
      "due": "Nov 15, 2025",
      "color": Colors.blue,
    },
    {
      "subject": "Social Studies",
      "status": "Checked",
      "title": "Map Work - India Political",
      "desc": "Mark all states and capitals on the India political map provided.",
      "assigned": "Nov 1, 2025",
      "due": "Nov 8, 2025",
      "color": Colors.blue,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppHeader(),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildHeroSection(),
                  const SizedBox(height: 20),
                  _buildFilterTabs(),
                  const SizedBox(height: 10),
                  ..._homeworks.where((h) => _selectedFilter == 'All' || h['status'] == _selectedFilter).map((h) => _buildHomeworkCard(h)).toList(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildAppHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9)))),
      child: Row(
        children: [
          Container(
            width: 38, height: 38,
            decoration: BoxDecoration(color: const Color(0xFFFF5722), borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            child: const Text("A", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          ),
          const SizedBox(width: 12),
          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Aditya International School", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            Text("Powered by Toki Tech", style: TextStyle(color: Colors.grey, fontSize: 11)),
          ]),
          const Spacer(),
          const Text("తెలుగు", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
      decoration: BoxDecoration(
        color: _purpleHero,
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const CircleAvatar(backgroundColor: Colors.white24, radius: 18, child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 14)),
              ),
              const SizedBox(width: 12),
              const Text("Homework Assignments", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Homework Summary", style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _statItem("3", "Pending"),
                    _statItem("1", "Submitted"),
                    _statItem("1", "Checked"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statItem(String val, String label) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(val, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
      Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
    ],
  );

  Widget _buildFilterTabs() {
    final tabs = ["All", "Pending", "Submitted", "Checked"];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: tabs.map((tab) => GestureDetector(
          onTap: () => setState(() => _selectedFilter = tab),
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: _selectedFilter == tab ? _purpleHero : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(tab, style: TextStyle(color: _selectedFilter == tab ? Colors.white : Colors.black87, fontSize: 13, fontWeight: FontWeight.w600)),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildHomeworkCard(Map<String, dynamic> h) {
    bool isPending = h['status'] == 'Pending';
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _tag(h['subject'], const Color(0xFFEFF6FF), Colors.blue),
              const SizedBox(width: 8),
              _tag(h['status'], isPending ? const Color(0xFFFFF7ED) : const Color(0xFFECFDF5), isPending ? Colors.orange : Colors.green),
            ],
          ),
          const SizedBox(height: 14),
          Text(h['title'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(h['desc'], style: TextStyle(color: _textSecondary, fontSize: 13, height: 1.4)),
          const Padding(padding: EdgeInsets.symmetric(vertical: 14), child: Divider(height: 1, color: Color(0xFFF1F5F9))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Assigned: ${h['assigned']}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
              Text("Due: ${h['due']}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tag(String txt, Color bg, Color text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
    child: Text(txt, style: TextStyle(color: text, fontSize: 11, fontWeight: FontWeight.bold)),
  );

  Widget _buildBottomNav() => BottomNavigationBar(
    currentIndex: 0,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: const Color(0xFFFF5722),
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.directions_bus_outlined), label: "Bus"),
      BottomNavigationBarItem(icon: Icon(Icons.confirmation_number_rounded), label: "Tickets"),
      BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "More"),
    ],
  );
}