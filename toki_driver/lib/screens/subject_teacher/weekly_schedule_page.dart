import 'package:flutter/material.dart';
import 'dart:math';
import '../../routes/subject_teacher_routes.dart';

class WeeklySchedulePage extends StatefulWidget {
  const WeeklySchedulePage({Key? key}) : super(key: key);

  @override
  State<WeeklySchedulePage> createState() => _WeeklySchedulePageState();
}

class _WeeklySchedulePageState extends State<WeeklySchedulePage> {
  int _selectedDayIndex = 0;
  int _currentIndex = 2;
  bool _isTelugu = true;
  bool _isMonthlySummary = false;

  final List<String> _days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

  late Map<int, List<Map<String, dynamic>>> _weeklySchedules;

  final Color _primaryBlue = const Color(0xFF448AFF);
  final Color _primaryPurple = const Color(0xFF9570FF);

  @override
  void initState() {
    super.initState();
    _generateWeeklySchedules();
  }

  void _generateWeeklySchedules() {
    _weeklySchedules = {};
    final random = Random();
    final subjects = ['Science', 'Math', 'English', 'Physics', 'Chemistry'];
    final rooms = ['204', '305', 'Lab 1', '101', 'Auditorium'];
    final classes = ['8B', '9A', '10C', '7A', '10A'];

    for (int i = 0; i < _days.length; i++) {
      int classCount = 2 + random.nextInt(3);
      List<Map<String, dynamic>> dayClasses = [];

      for (int j = 0; j < classCount; j++) {
        String startTime = "${9 + (j * 2)}:00 AM";
        String endTime = "${9 + (j * 2)}:45 AM";
        if (j > 1) {
          startTime = "0${1 + (j - 2)}:00 PM";
          endTime = "0${1 + (j - 2)}:45 PM";
        }

        dayClasses.add({
          'className': "Class ${classes[random.nextInt(classes.length)]}",
          'subject': subjects[random.nextInt(subjects.length)],
          'time': "$startTime - $endTime",
          'room': j % 2 == 0 ? "Room ${rooms[random.nextInt(rooms.length)]}" : "Lab 1",
          'isCurrent': i == 0 && j == 0,
        });
      }
      _weeklySchedules[i] = dayClasses;
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Weekly Schedule',
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
                _isTelugu ? "తెలుగు" : "English",
                style: const TextStyle(color: Colors.blue, fontSize: 12),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBlueHeader(),
            const SizedBox(height: 16),
            _buildDaySelector(),
            const SizedBox(height: 16),
            _buildScheduleList(),
            _buildTodayEvents(),
            _buildSummarySection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBlueHeader() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _primaryBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            children: const [
              SizedBox(width: 4),
              Text(
                "Weekly Schedule",
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.calendar_today, color: Colors.white, size: 16),
                    SizedBox(width: 8),
                    Text(
                      "Saturday, November 9, 2025",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  "You have 3 classes scheduled today",
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDaySelector() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: _days.length,
        separatorBuilder: (c, i) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final isSelected = _selectedDayIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDayIndex = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? _primaryBlue : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _days[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildScheduleList() {
    final classes = _weeklySchedules[_selectedDayIndex] ?? [];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: classes.map((data) => _buildClassCard(data)).toList(),
      ),
    );
  }

  Widget _buildClassCard(Map<String, dynamic> data) {
    bool isCurrent = data['isCurrent'] ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isCurrent)
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.circle, size: 8, color: Colors.green),
                  SizedBox(width: 6),
                  Text("Current Class", style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isCurrent ? Colors.blue.shade50 : Colors.grey.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.access_time,
                  color: isCurrent ? Colors.blue : Colors.grey,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['className'],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data['time'],
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.home_work_outlined, size: 14, color: Colors.grey.shade600),
                        const SizedBox(width: 4),
                        Text(
                          data['room'],
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (isCurrent)
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SubjectTeacherRoutes.takeAttendance);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    elevation: 0,
                  ),
                  child: const Text("Take Attendance", style: TextStyle(fontSize: 12, color: Colors.white)),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTodayEvents() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Today's Events", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person, color: Colors.orange, size: 20),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Class Teacher",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "You are the class teacher for 8B today",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  _isMonthlySummary ? "This Month's Summary" : "This Week's Summary",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isMonthlySummary = !_isMonthlySummary;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Text(
                        _isMonthlySummary ? "Monthly" : "Weekly",
                        style: const TextStyle(fontSize: 12, color: Colors.black87),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryItem(_isMonthlySummary ? "84" : "21", "Total Classes", Colors.blue),
                _buildSummaryItem(_isMonthlySummary ? "72" : "18", "Completed", Colors.green),
                _buildSummaryItem(_isMonthlySummary ? "12" : "3", "Remaining", Colors.orange),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String count, String label, Color color) {
    return Column(
      children: [
        Text(count, style: TextStyle(color: color, fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11)),
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