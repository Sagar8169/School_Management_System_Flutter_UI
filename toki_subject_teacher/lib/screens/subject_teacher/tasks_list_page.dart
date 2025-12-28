import 'package:flutter/material.dart';
import 'package:toki/routes/subject_teacher_routes.dart';

class TasksListPage extends StatefulWidget {
  const TasksListPage({Key? key}) : super(key: key);

  @override
  State<TasksListPage> createState() => _TasksListPageState();
}

class _TasksListPageState extends State<TasksListPage> {
  int _currentIndex = 2;
  bool _isTelugu = false;
  String _selectedFilter = "All";

  // ✅ Original Data with consistent structure
  final List<Map<String, dynamic>> _allTasks = [
    {"title": "Grade Mid-term Papers", "class": "Class 8B", "status": "Pending", "tag": "Grading", "submissions": "44/44", "dueDate": "Nov 12, 2025", "description": "Grade all mid-term examination papers for Class 8B.", "assignedBy": "Mrs Raghini Sharma", "assigneeRole": "Class Teacher"},
    {"title": "Chapter 5 Homework", "class": "Class 9A", "status": "In Progress", "tag": "Homework", "submissions": "28/42", "dueDate": "Nov 15, 2025", "description": "Review the homework submissions for Chapter 5.", "assignedBy": "Mr. Vijay Prasad", "assigneeRole": "Science Teacher"},
    {"title": "Lab Report Submission", "class": "Class 10C", "status": "In Progress", "tag": "Assignment", "submissions": "35/46", "dueDate": "Nov 18, 2025", "description": "Evaluation of the Biology Lab Report.", "assignedBy": "Mr. Vijay Prasad", "assigneeRole": "Science Teacher"},
    {"title": "Unit Test 4 Preparation", "class": "Class 8B", "status": "Pending", "tag": "Assignment", "submissions": "0/44", "dueDate": "Nov 20, 2025", "description": "Prepare and upload the study guide.", "assignedBy": "Principal's Office", "assigneeRole": "Administration"},
    {"title": "Science Project Review", "class": "Class 9A", "status": "Completed", "tag": "Grading", "submissions": "42/42", "dueDate": "Nov 10, 2025", "description": "Final review of the semester science projects.", "assignedBy": "Mrs Raghini Sharma", "assigneeRole": "Class Teacher"},
  ];

  // ✅ Strictly Original Colors
  final Color _primaryPurple = const Color(0xFF9570FF);
  final Color _bgGrey = const Color(0xFFF8F9FA);

  void _onTabTapped(int index) {
    if (_currentIndex == index) return;
    setState(() => _currentIndex = index);
    switch (index) {
      case 0: Navigator.pushReplacementNamed(context, SubjectTeacherRoutes.home); break;
      case 1: Navigator.pushReplacementNamed(context, SubjectTeacherRoutes.search); break;
      case 2: break;
      case 3: Navigator.pushReplacementNamed(context, SubjectTeacherRoutes.settings); break;
    }
  }

  List<Map<String, dynamic>> get _filteredTasks {
    if (_selectedFilter == "All") return _allTasks;
    return _allTasks.where((t) => t['status'] == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgGrey,
      body: SafeArea(
        child: Column(
          children: [
            _buildExactHeader(),
            _buildHeaderStats(), // ✅ Original Stat Style
            _buildFilterBar(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                physics: const BouncingScrollPhysics(),
                itemCount: _filteredTasks.length,
                itemBuilder: (context, index) => _buildTaskItem(_filteredTasks[index]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // --- 1. HEADER (Previous Pages Synced) ---
  Widget _buildExactHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 1, offset: Offset(0, 1))],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: _primaryPurple.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
              child: Icon(Icons.arrow_back_ios_new_rounded, color: _primaryPurple, size: 20),
            ),
          ),
          const SizedBox(width: 16),
          const Text("Tasks & Homework", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
          const Spacer(),
          GestureDetector(
            onTap: () => setState(() => _isTelugu = !_isTelugu),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(20)),
              child: Text(_isTelugu ? 'తెలుగు' : 'English', style: const TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  // --- 2. ORIGINAL HEADER STATS ---
  Widget _buildHeaderStats() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
      decoration: BoxDecoration(
        color: _primaryPurple,
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
      ),
      child: Row(
        children: [
          _statCard("2", "Pending"),
          const SizedBox(width: 12),
          _statCard("2", "In Progress"),
          const SizedBox(width: 12),
          _statCard("1", "Completed"),
        ],
      ),
    );
  }

  Widget _statCard(String count, String label) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(count, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11)),
        ],
      ),
    ),
  );

  // --- 3. FILTER BAR ---
  Widget _buildFilterBar() {
    final filters = ["All", "Pending", "In Progress", "Completed"];
    return SizedBox(
      height: 60,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, i) {
          bool sel = _selectedFilter == filters[i];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(filters[i]),
              selected: sel,
              onSelected: (val) => setState(() => _selectedFilter = filters[i]),
              selectedColor: _primaryPurple,
              labelStyle: TextStyle(color: sel ? Colors.white : Colors.black87, fontWeight: sel ? FontWeight.bold : FontWeight.normal),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: Colors.grey.shade300)),
            ),
          );
        },
      ),
    );
  }

  // --- 4. TASK ITEM CARD ---
  Widget _buildTaskItem(Map<String, dynamic> task) {
    Color statusBg;
    Color statusTxt;

    if (task['status'] == 'Pending') {
      statusBg = const Color(0xFFFFF3E0); statusTxt = Colors.orange;
    } else if (task['status'] == 'In Progress') {
      statusBg = const Color(0xFFE3F2FD); statusTxt = Colors.blue;
    } else {
      statusBg = const Color(0xFFE8F5E9); statusTxt = Colors.green;
    }

    return GestureDetector(
      onTap: () {
        // ✅ Error-free Redirection Logic
        Navigator.pushNamed(
            context,
            SubjectTeacherRoutes.taskDetails,
            arguments: {'taskData': task}
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1E293B))),
            const SizedBox(height: 4),
            Text(task['class'], style: const TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(height: 12),
            Row(
              children: [
                _badge(task['status'], statusBg, statusTxt),
                const SizedBox(width: 8),
                _badge(task['tag'], const Color(0xFFEEF2FF), Colors.indigo),
              ],
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 14), child: Divider(height: 1)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _iconLabel(Icons.groups_outlined, "Subs: ${task['submissions']}"),
                _iconLabel(Icons.calendar_today_outlined, "Due: ${task['dueDate']}"),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _badge(String txt, Color bg, Color txtCol) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
    child: Text(txt, style: TextStyle(color: txtCol, fontSize: 11, fontWeight: FontWeight.bold)),
  );

  Widget _iconLabel(IconData icon, String txt) => Row(children: [
    Icon(icon, size: 14, color: Colors.grey),
    const SizedBox(width: 4),
    Text(txt, style: const TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.w500)),
  ]);

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _currentIndex, onTap: _onTabTapped, type: BottomNavigationBarType.fixed,
      selectedItemColor: _primaryPurple, unselectedItemColor: Colors.grey, backgroundColor: Colors.white,
      selectedFontSize: 11, unselectedFontSize: 11, elevation: 20,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.bolt_rounded), label: 'Activity'),
        BottomNavigationBarItem(icon: Icon(Icons.more_vert_rounded), label: 'More'),
      ],
    );
  }
}