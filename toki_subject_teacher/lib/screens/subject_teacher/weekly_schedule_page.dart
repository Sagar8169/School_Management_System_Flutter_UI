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

  bool _isTelugu = true;
  bool _isMonthlySummary = false;

  final List<String> _days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];
  late Map<int, List<Map<String, dynamic>>> _weeklySchedules;

  final Color _primaryBlue = const Color(0xFF448AFF);
  final Color _primaryPurple = const Color(0xFF7C3AED); // Sync with your theme
  final Color _bgLight = const Color(0xFFF8FAFC);

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
      int classCount = 3;
      List<Map<String, dynamic>> dayClasses = [];
      for (int j = 0; j < classCount; j++) {
        dayClasses.add({
          'className': "Class ${classes[random.nextInt(classes.length)]}",
          'subject': subjects[random.nextInt(subjects.length)],
          'time': "${9 + j}:00 - ${9 + j}:45 AM",
          'room': "Room ${rooms[random.nextInt(rooms.length)]}",
          'isCurrent': i == 0 && j == 0,
        });
      }
      _weeklySchedules[i] = dayClasses;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildExactHeader(), // ✅ Original Style Header with Back Button
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
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
            ),
          ],
        ),
      ),
    );
  }

  // --- HEADER: PREVIOUS STYLE (Back Button + Title + Language Toggle) ---
  Widget _buildExactHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 1, offset: Offset(0, 1))
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _primaryPurple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.arrow_back_ios_new_rounded,
                  color: _primaryPurple, size: 20),
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            "Weekly Schedule",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B)),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => setState(() => _isTelugu = !_isTelugu),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: _primaryPurple.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _isTelugu ? "తెలుగు" : "English",
                style: TextStyle(
                    color: _primaryPurple,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
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
          const Text("Weekly Schedule",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.calendar_today, color: Colors.white, size: 16),
                    SizedBox(width: 8),
                    Text("Saturday, November 9, 2025",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                const Text("You have 3 classes scheduled today",
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
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
            onTap: () => setState(() => _selectedDayIndex = index),
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
                    fontSize: 13),
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
          children: classes.map((data) => _buildClassCard(data)).toList()),
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
          border: Border.all(color: Colors.grey.shade200)),
      child: Row(
        children: [
          Icon(Icons.access_time,
              color: isCurrent ? Colors.blue : Colors.grey, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data['className'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Text("${data['subject']} • ${data['room']}",
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
                Text(data['time'],
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          if (isCurrent)
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(
                  context, SubjectTeacherRoutes.takeAttendance),
              style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              child: const Text("Take Attendance",
                  style: TextStyle(fontSize: 12, color: Colors.white)),
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
          const Text("Today's Events",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200)),
            child: Row(
              children: [
                const Icon(Icons.person, color: Colors.orange),
                const SizedBox(width: 16),
                const Text("You are the class teacher for 8B today",
                    style: TextStyle(fontSize: 13)),
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
                  _isMonthlySummary
                      ? "This Month's Summary"
                      : "This Week's Summary",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14)),
              GestureDetector(
                onTap: () =>
                    setState(() => _isMonthlySummary = !_isMonthlySummary),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(_isMonthlySummary ? "Monthly" : "Weekly",
                      style: const TextStyle(fontSize: 12)),
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
                border: Border.all(color: Colors.grey.shade200)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _summaryItem(_isMonthlySummary ? "84" : "21", "Total Classes",
                    Colors.blue),
                _summaryItem(
                    _isMonthlySummary ? "72" : "18", "Completed", Colors.green),
                _summaryItem(
                    _isMonthlySummary ? "12" : "3", "Remaining", Colors.orange),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryItem(String count, String label, Color color) {
    return Column(
      children: [
        Text(count,
            style: TextStyle(
                color: color, fontSize: 24, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11)),
      ],
    );
  }
}
