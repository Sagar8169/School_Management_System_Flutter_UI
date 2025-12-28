import 'package:flutter/material.dart';
import '../../routes/subject_teacher_routes.dart';

class TasksListPage extends StatefulWidget {
  const TasksListPage({Key? key}) : super(key: key);

  @override
  State<TasksListPage> createState() => _TasksListPageState();
}

class _TasksListPageState extends State<TasksListPage> {
  int _currentIndex = 2;
  bool _isTelugu = true;
  String _selectedFilter = "All";

  final List<Map<String, dynamic>> _allTasks = [
    {
      "title": "Grade Mid-term Papers",
      "class": "Class 8B",
      "status": "Pending",
      "tag": "Grading",
      "submissions": "44/44",
      "dueDate": "Nov 12, 2025",
      "description": "Grade all mid-term examination papers for Class 8B. Focus on chapters 4-6, specifically checking for understanding of Newton's laws. Ensure feedback is provided for the essay section.",
      "assignedBy": "Mrs Raghini Sharma",
      "assigneeRole": "Class Teacher"
    },
    {
      "title": "Chapter 5 Homework",
      "class": "Class 9A",
      "status": "In Progress",
      "tag": "Homework",
      "submissions": "28/42",
      "dueDate": "Nov 15, 2025",
      "description": "Review the homework submissions for Chapter 5: Chemical Reactions. Check if students have balanced the equations correctly. Identify common errors in stoichiometry.",
      "assignedBy": "Mr. Vijay Prasad",
      "assigneeRole": "Science Teacher"
    },
    {
      "title": "Lab Report Submission",
      "class": "Class 10C",
      "status": "In Progress",
      "tag": "Assignment",
      "submissions": "35/46",
      "dueDate": "Nov 18, 2025",
      "description": "Evaluation of the Biology Lab Report on Plant Photosynthesis. Check for proper formatting, hypothesis clarity, and accuracy of data analysis. Late submissions lose 10% marks.",
      "assignedBy": "Mr. Vijay Prasad",
      "assigneeRole": "Science Teacher"
    },
    {
      "title": "Unit Test 4 Preparation",
      "class": "Class 8B",
      "status": "Pending",
      "tag": "Assignment",
      "submissions": "0/44",
      "dueDate": "Nov 20, 2025",
      "description": "Prepare and upload the study guide and practice questions for the upcoming Unit Test 4 covering Electricity and Magnetism.",
      "assignedBy": "Principal's Office",
      "assigneeRole": "Administration"
    },
    {
      "title": "Science Project Review",
      "class": "Class 9A",
      "status": "Completed",
      "tag": "Grading",
      "submissions": "42/42",
      "dueDate": "Nov 10, 2025",
      "description": "Final review of the semester science projects. tally scores from the presentation day and the written report. Submit final grades to the portal.",
      "assignedBy": "Mrs Raghini Sharma",
      "assigneeRole": "Class Teacher"
    },
  ];

  final Color _primaryPurple = const Color(0xFF9570FF);
  final Color _bgGrey = const Color(0xFFF8F9FA);

  void _toggleLanguage() {
    setState(() {
      _isTelugu = !_isTelugu;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isTelugu ? 'తెలుగు భాషలో మార్చబడింది' : 'Switched to English'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _onTabTapped(int index) {
    if (_currentIndex == index) return;

    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(
            context,
            SubjectTeacherRoutes.home,
                (route) => false
        );
        break;
      case 1:
        Navigator.pushNamedAndRemoveUntil(
            context,
            SubjectTeacherRoutes.search,
                (route) => false
        );
        break;
      case 2:
        Navigator.pushNamedAndRemoveUntil(
            context,
            SubjectTeacherRoutes.activity,
                (route) => false
        );
        break;
      case 3:
        Navigator.pushNamedAndRemoveUntil(
            context,
            SubjectTeacherRoutes.settings,
                (route) => false
        );
        break;
    }
  }

  List<Map<String, dynamic>> get _filteredTasks {
    if (_selectedFilter == "All") return _allTasks;
    if (_selectedFilter.startsWith("Pending")) return _allTasks.where((t) => t['status'] == "Pending").toList();
    if (_selectedFilter.startsWith("In Progress")) return _allTasks.where((t) => t['status'] == "In Progress").toList();
    if (_selectedFilter.startsWith("Completed")) return _allTasks.where((t) => t['status'] == "Completed").toList();
    return _allTasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Tasks & Homework',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: _toggleLanguage,
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _isTelugu ? 'తెలుగు' : 'English',
                style: const TextStyle(color: Colors.blue, fontSize: 12),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          _buildHeaderStats(),
          _buildFilterChips(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredTasks.length,
              itemBuilder: (context, index) {
                return _buildTaskItem(_filteredTasks[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeaderStats() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      decoration: BoxDecoration(
        color: _primaryPurple,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          _buildStatCard("2", "Pending", Colors.white.withOpacity(0.2)),
          const SizedBox(width: 12),
          _buildStatCard("2", "In Progress", Colors.white.withOpacity(0.2)),
          const SizedBox(width: 12),
          _buildStatCard("1", "Completed", Colors.white.withOpacity(0.2)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String count, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(count, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = ["All (5)", "Pending (2)", "In Progress (2)", "Completed (1)"];
    return Container(
      height: 60,
      margin: const EdgeInsets.only(top: 10),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (c, i) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          bool isSelected = _selectedFilter == filter.split(" ")[0] || (_selectedFilter == "All" && filter.startsWith("All"));

          return ActionChip(
            label: Text(filter),
            backgroundColor: isSelected ? _primaryPurple : Colors.white,
            labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: isSelected ? Colors.transparent : Colors.grey.shade300)
            ),
            onPressed: () {
              setState(() {
                _selectedFilter = filter.split(" ")[0];
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildTaskItem(Map<String, dynamic> task) {
    Color statusBg = Colors.grey.shade100;
    Color statusTxt = Colors.grey;
    Color tagBg = Colors.blue.shade50;
    Color tagTxt = Colors.blue;

    if (task['status'] == 'Pending') {
      statusBg = const Color(0xFFFFF3E0);
      statusTxt = Colors.orange;
    } else if (task['status'] == 'In Progress') {
      statusBg = const Color(0xFFE3F2FD);
      statusTxt = Colors.blue;
    } else if (task['status'] == 'Completed') {
      statusBg = const Color(0xFFE8F5E9);
      statusTxt = Colors.green;
    }

    return GestureDetector(
      onTap: () {
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
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 4),
            Text(task['class'], style: const TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(8)),
                  child: Text(task['status'], style: TextStyle(color: statusTxt, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: tagBg, borderRadius: BorderRadius.circular(8)),
                  child: Text(task['tag'], style: TextStyle(color: tagTxt, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Submissions: ${task['submissions']}", style: TextStyle(color: Colors.grey.shade700, fontSize: 12)),
                Text("Due: ${task['dueDate']}", style: TextStyle(color: Colors.grey.shade700, fontSize: 12)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: _primaryPurple,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_vert),
            label: 'More',
          ),
        ],
      ),
    );
  }
}