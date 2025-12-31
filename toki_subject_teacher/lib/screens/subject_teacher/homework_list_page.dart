import 'package:flutter/material.dart';
import 'package:toki/routes/subject_teacher_routes.dart';

class HomeworkListPage extends StatefulWidget {
  const HomeworkListPage({Key? key}) : super(key: key);

  @override
  State<HomeworkListPage> createState() => _HomeworkListPageState();
}

class _HomeworkListPageState extends State<HomeworkListPage> {
  bool _isTelugu = false;
  String _selectedFilter = "All";

  // Data original wahi rakha hai
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
      "description": "Complete all chemical equations from Chapter 5.",
      "attachments": 2
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
      "description": "Solve problems 1-20 from exercise section.",
      "attachments": 1
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
      "description": "Write a detailed lab report.",
      "attachments": 3
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
      "description": "Draw circuit diagrams.",
      "attachments": 0
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
      "description": "Memorize first 20 elements.",
      "attachments": 1
    },
  ];

  final Color _primaryPurple = const Color(0xFF7C3AED);
  final Color _bgLight = const Color(0xFFF8FAFC);

  List<Map<String, dynamic>> get _filteredHomework {
    if (_selectedFilter == "All") return _allHomework;
    return _allHomework.where((h) => h['status'] == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      body: SafeArea(
        child: Column(
          children: [
            _buildExactHeader(),
            _buildStatHub(),
            _buildFilterBar(),
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                physics: const BouncingScrollPhysics(),
                itemCount: _filteredHomework.length,
                itemBuilder: (context, index) =>
                    _buildHomeworkCard(_filteredHomework[index]),
              ),
            ),
            _buildAddButton(),
          ],
        ),
      ),
    );
  }

  // ✅ 1. HEADER (Synced Style)
  Widget _buildExactHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 1, offset: Offset(0, 1))
      ]),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: _primaryPurple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(Icons.arrow_back_ios_new_rounded,
                  color: _primaryPurple, size: 20),
            ),
          ),
          const SizedBox(width: 16),
          const Text("Homework List",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B))),
          const Spacer(),
          GestureDetector(
            onTap: () => setState(() => _isTelugu = !_isTelugu),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                  border: Border.all(color: _primaryPurple.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(_isTelugu ? 'ಕನ್ನಡ' : 'English',
                  style: TextStyle(
                      color: _primaryPurple,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ 2. STAT HUB (Original Style but Premium)
  Widget _buildStatHub() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient:
            LinearGradient(colors: [_primaryPurple, const Color(0xFF4338CA)]),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
              color: _primaryPurple.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _statItem("02", "ACTIVE"),
          Container(width: 1, height: 40, color: Colors.white24),
          _statItem("01", "SUBMITTED"),
          Container(width: 1, height: 40, color: Colors.white24),
          _statItem("02", "OTHERS"),
        ],
      ),
    );
  }

  Widget _statItem(String val, String label) {
    return Column(
      children: [
        Text(val,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w900)),
        Text(label,
            style: const TextStyle(
                color: Colors.white70,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 1)),
      ],
    );
  }

  // ✅ 3. WORKING FILTER BAR
  Widget _buildFilterBar() {
    final filters = ["All", "Active", "Submitted", "Upcoming", "Overdue"];
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: filters.length,
        itemBuilder: (context, i) {
          bool isSel = _selectedFilter == filters[i];
          return GestureDetector(
            onTap: () => setState(() => _selectedFilter = filters[i]),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isSel ? _primaryPurple : Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    color: isSel ? _primaryPurple : Colors.grey.shade200),
              ),
              child: Center(
                child: Text(filters[i],
                    style: TextStyle(
                        color: isSel ? Colors.white : Colors.grey.shade600,
                        fontWeight: FontWeight.w700,
                        fontSize: 13)),
              ),
            ),
          );
        },
      ),
    );
  }

  // ✅ 4. HOMEWORK LIST CARDS (Fix: Click Redirection Working)
  Widget _buildHomeworkCard(Map<String, dynamic> hw) {
    Color statusCol;
    switch (hw['status']) {
      case 'Active':
        statusCol = Colors.blue;
        break;
      case 'Submitted':
        statusCol = Colors.green;
        break;
      case 'Upcoming':
        statusCol = Colors.orange;
        break;
      case 'Overdue':
        statusCol = Colors.red;
        break;
      default:
        statusCol = Colors.grey;
    }

    return GestureDetector(
      onTap: () {
        // Redirection Fixed: Bhej rahe hain direct homework map
        Navigator.pushNamed(
          context,
          SubjectTeacherRoutes.homeworkDetails,
          arguments: {
            'homeworkData': hw, // ✅ wrap kar diya
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 15,
                offset: const Offset(0, 8))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text(hw['title'],
                        style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: Color(0xFF1E293B)))),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      color: statusCol.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(hw['status'],
                      style: TextStyle(
                          color: statusCol,
                          fontWeight: FontWeight.w800,
                          fontSize: 10)),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text("${hw['class']} • ${hw['subject']}",
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w500)),
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Divider(height: 1)),
            Row(
              children: [
                _hwIconInfo(Icons.groups_rounded, hw['submissions']),
                const SizedBox(width: 16),
                _hwIconInfo(
                    Icons.calendar_today_rounded, "Due: ${hw['dueDate']}"),
                const Spacer(),
                if (hw['attachments'] > 0)
                  Icon(Icons.attach_file_rounded,
                      size: 16, color: _primaryPurple),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _hwIconInfo(IconData icon, String text) => Row(
        children: [
          Icon(icon, size: 14, color: Colors.grey.shade400),
          const SizedBox(width: 6),
          Text(text,
              style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 11,
                  fontWeight: FontWeight.w600)),
        ],
      );

  // ✅ 5. ADD BUTTON
  Widget _buildAddButton() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        height: 58,
        child: ElevatedButton(
          onPressed: () =>
              Navigator.pushNamed(context, SubjectTeacherRoutes.addHomework),
          style: ElevatedButton.styleFrom(
            backgroundColor: _primaryPurple,
            elevation: 8,
            shadowColor: _primaryPurple.withOpacity(0.4),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_rounded, color: Colors.white),
              SizedBox(width: 8),
              Text("Assign New Homework",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800)),
            ],
          ),
        ),
      ),
    );
  }
}
