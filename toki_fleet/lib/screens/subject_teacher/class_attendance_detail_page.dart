import 'package:flutter/material.dart';
import 'package:toki/routes/principal_routes.dart';
import '../../routes/subject_teacher_routes.dart';

class ClassAttendanceDetailPage extends StatefulWidget {
  final Map<String, dynamic> classData;

  const ClassAttendanceDetailPage({Key? key, required this.classData}) : super(key: key);

  @override
  State<ClassAttendanceDetailPage> createState() => _ClassAttendanceDetailPageState();
}

class _ClassAttendanceDetailPageState extends State<ClassAttendanceDetailPage> {
  int _currentIndex = 2;

  final Color _primaryPurple = const Color(0xFF9570FF);

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

  @override
  Widget build(BuildContext context) {
    final String className = widget.classData['className'] ?? "Class 8B";
    final String present = widget.classData['present'] ?? "42";
    final String absent = widget.classData['absent'] ?? "2";
    final String rate = widget.classData['percent'] ?? "95.5%";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "$className Attendance",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(child: Text("తెలుగు", style: TextStyle(color: Colors.blue, fontSize: 12))),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Today's Summary", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))
                  ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSummaryDetail(present, "Present", const Color(0xFF2DC58C)),
                  Container(width: 1, height: 40, color: Colors.grey.shade200),
                  _buildSummaryDetail(absent, "Absent", Colors.red),
                  Container(width: 1, height: 40, color: Colors.grey.shade200),
                  _buildSummaryDetail(rate, "Rate", Colors.blue),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text("Weekly Trend", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  _buildTrendRow("Monday", 0.932, "93.2%"),
                  const SizedBox(height: 20),
                  _buildTrendRow("Tuesday", 0.955, "95.5%"),
                  const SizedBox(height: 20),
                  _buildTrendRow("Wednesday", 0.909, "90.9%"),
                  const SizedBox(height: 20),
                  _buildTrendRow("Thursday", 0.977, "97.7%"),
                  const SizedBox(height: 20),
                  _buildTrendRow("Friday", 0.932, "93.2%"),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SubjectTeacherRoutes.attendanceSummary);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Color(0xFF2962FF)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("View History", style: TextStyle(color: Color(0xFF2962FF), fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SubjectTeacherRoutes.takeAttendance);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xFF2962FF),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Take Attendance", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildSummaryDetail(String val, String label, Color color) {
    return Column(
      children: [
        Text(val, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildTrendRow(String day, double value, String label) {
    return Row(
      children: [
        SizedBox(width: 80, child: Text(day, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500))),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: value,
              backgroundColor: Colors.grey.shade100,
              color: const Color(0xFF2DC58C),
              minHeight: 8,
            ),
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
            width: 40,
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              textAlign: TextAlign.end,
            )
        ),
      ],
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