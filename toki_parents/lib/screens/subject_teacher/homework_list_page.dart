import 'package:flutter/material.dart';
import '../../routes/subject_teacher_routes.dart';
import '../../routes/principal_routes.dart';

class HomeworkListPage extends StatefulWidget {
  const HomeworkListPage({Key? key}) : super(key: key);

  @override
  State<HomeworkListPage> createState() => _HomeworkListPageState();
}

class _HomeworkListPageState extends State<HomeworkListPage> {
  int _currentIndex = 2;
  bool _isTelugu = true;
  String _selectedFilter = "All";

  final List<Map<String, dynamic>> _allHomework = [
    {
      "id": 1,
      "title": "Chapter 5: Chemical Reactions",
      "class": "Class 9A",
      "subject": "Science",
      "status": "Active",
      "submissions": "28/42",
      "dueDate": "Nov 15, 2025",
      "assignedDate": "Nov 10, 2025",
      "description": "Complete all chemical equations from Chapter 5. Balance the equations and write chemical formulas.",
      "attachments": 2,
    },
    {
      "id": 2,
      "title": "Newton's Laws Problems",
      "class": "Class 8B",
      "subject": "Physics",
      "status": "Active",
      "submissions": "40/44",
      "dueDate": "Nov 12, 2025",
      "assignedDate": "Nov 8, 2025",
      "description": "Solve problems 1-20 from exercise section. Show complete calculations.",
      "attachments": 1,
    },
    {
      "id": 3,
      "title": "Photosynthesis Lab Report",
      "class": "Class 10C",
      "subject": "Biology",
      "status": "Submitted",
      "submissions": "46/46",
      "dueDate": "Nov 10, 2025",
      "assignedDate": "Nov 5, 2025",
      "description": "Write a detailed lab report on the photosynthesis experiment.",
      "attachments": 3,
    },
    {
      "id": 4,
      "title": "Electricity Circuits",
      "class": "Class 9A",
      "subject": "Physics",
      "status": "Upcoming",
      "submissions": "0/42",
      "dueDate": "Nov 20, 2025",
      "assignedDate": "Nov 18, 2025",
      "description": "Draw circuit diagrams and solve numerical problems.",
      "attachments": 0,
    },
    {
      "id": 5,
      "title": "Periodic Table Study",
      "class": "Class 8B",
      "subject": "Chemistry",
      "status": "Overdue",
      "submissions": "38/44",
      "dueDate": "Nov 5, 2025",
      "assignedDate": "Nov 1, 2025",
      "description": "Memorize first 20 elements with their symbols and atomic numbers.",
      "attachments": 1,
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
            PrincipalRoutes.search,
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

  List<Map<String, dynamic>> get _filteredHomework {
    if (_selectedFilter == "All") return _allHomework;
    if (_selectedFilter == "Active") return _allHomework.where((h) => h['status'] == "Active").toList();
    if (_selectedFilter == "Submitted") return _allHomework.where((h) => h['status'] == "Submitted").toList();
    if (_selectedFilter == "Upcoming") return _allHomework.where((h) => h['status'] == "Upcoming").toList();
    if (_selectedFilter == "Overdue") return _allHomework.where((h) => h['status'] == "Overdue").toList();
    return _allHomework;
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
          "Homework",
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
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
            decoration: BoxDecoration(
              color: _primaryPurple,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Row(
              children: [
                _buildStatCard("2", "Active", Colors.white.withOpacity(0.2)),
                const SizedBox(width: 12),
                _buildStatCard("1", "Submitted", Colors.white.withOpacity(0.2)),
                const SizedBox(width: 12),
                _buildStatCard("2", "Others", Colors.white.withOpacity(0.2)),
              ],
            ),
          ),
          Container(
            height: 60,
            margin: const EdgeInsets.only(top: 10),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: const ["All", "Active", "Submitted", "Upcoming", "Overdue"].length,
              separatorBuilder: (c, i) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final filter = const ["All", "Active", "Submitted", "Upcoming", "Overdue"][index];
                bool isSelected = _selectedFilter == filter;

                return ActionChip(
                  label: Text(
                    filter,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  backgroundColor: isSelected ? _primaryPurple : Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: isSelected ? Colors.transparent : Colors.grey.shade300,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedFilter = filter;
                    });
                  },
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredHomework.length,
              itemBuilder: (context, index) {
                return _buildHomeworkItem(_filteredHomework[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, SubjectTeacherRoutes.addHomework);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "+ Add New Homework",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
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
            Text(
              count,
              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeworkItem(Map<String, dynamic> homework) {
    Color statusBg = Colors.grey.shade100;
    Color statusTxt = Colors.grey;

    switch (homework['status']) {
      case 'Active':
        statusBg = const Color(0xFFE3F2FD);
        statusTxt = Colors.blue;
        break;
      case 'Submitted':
        statusBg = const Color(0xFFE8F5E9);
        statusTxt = Colors.green;
        break;
      case 'Upcoming':
        statusBg = const Color(0xFFFFF3E0);
        statusTxt = Colors.orange;
        break;
      case 'Overdue':
        statusBg = const Color(0xFFFEE2E2);
        statusTxt = Colors.red;
        break;
    }

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          SubjectTeacherRoutes.homeworkDetails,
          arguments: {'homeworkData': homework},
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
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    homework['title'],
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    homework['status'],
                    style: TextStyle(
                      color: statusTxt,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "${homework['class']} • ${homework['subject']}",
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.assignment_turned_in, color: Colors.grey[600], size: 16),
                const SizedBox(width: 4),
                Text(
                  "Submissions: ${homework['submissions']}",
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                const SizedBox(width: 16),
                Icon(Icons.calendar_today, color: Colors.grey[600], size: 16),
                const SizedBox(width: 4),
                Text(
                  "Due: ${homework['dueDate']}",
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
            if (homework['attachments'] > 0) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.attach_file, color: Colors.grey[600], size: 16),
                  const SizedBox(width: 4),
                  Text(
                    "${homework['attachments']} attachment(s)",
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ],
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