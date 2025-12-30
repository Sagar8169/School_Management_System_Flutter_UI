import 'package:flutter/material.dart';
import '../../routes/principal_routes.dart';

class ClassTimetablePage extends StatefulWidget {
  final Map<String, dynamic> classData;

  const ClassTimetablePage({Key? key, required this.classData})
      : super(key: key);

  @override
  _ClassTimetablePageState createState() => _ClassTimetablePageState();
}

class _ClassTimetablePageState extends State<ClassTimetablePage> {
  // int _currentIndex = 3;
  int _selectedDayIndex = 0;
  bool _isTelugu = false;

  final List<String> _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  final Map<String, List<Map<String, dynamic>>> _timetableData = {
    'Monday': [
      {
        'subject': 'Mathematics',
        'teacher': 'Miss Raghini Sharma',
        'startTime': '08:30 AM',
        'endTime': '09:15 AM',
        'type': 'class',
        'room': 'Room 101'
      },
      {
        'subject': 'Science',
        'teacher': 'Mr. Vijay Prasad',
        'startTime': '09:15 AM',
        'endTime': '10:00 AM',
        'type': 'class',
        'room': 'Lab 1'
      },
      {
        'subject': 'English',
        'teacher': 'Mrs. Anita Desai',
        'startTime': '10:00 AM',
        'endTime': '10:45 AM',
        'type': 'class',
        'room': 'Room 101'
      },
      {
        'subject': 'Break',
        'teacher': '',
        'startTime': '10:45 AM',
        'endTime': '11:00 AM',
        'type': 'break',
        'room': ''
      },
      {
        'subject': 'Hindi',
        'teacher': 'Mrs. Lakshmi Devi',
        'startTime': '11:00 AM',
        'endTime': '11:45 AM',
        'type': 'class',
        'room': 'Room 102'
      },
      {
        'subject': 'Social Studies',
        'teacher': 'Mr. K. Rao',
        'startTime': '11:45 AM',
        'endTime': '12:30 PM',
        'type': 'class',
        'room': 'Room 101'
      },
      {
        'subject': 'Games',
        'teacher': 'Mr. Suresh Babu',
        'startTime': '12:30 PM',
        'endTime': '01:15 PM',
        'type': 'class',
        'room': 'Playground'
      },
    ],
    'Tuesday': [
      {
        'subject': 'English',
        'teacher': 'Mrs. Anita Desai',
        'startTime': '08:30 AM',
        'endTime': '09:15 AM',
        'type': 'class',
        'room': 'Room 101'
      },
      {
        'subject': 'Mathematics',
        'teacher': 'Miss Raghini Sharma',
        'startTime': '09:15 AM',
        'endTime': '10:00 AM',
        'type': 'class',
        'room': 'Room 101'
      },
      {
        'subject': 'Science Lab',
        'teacher': 'Mr. Vijay Prasad',
        'startTime': '10:00 AM',
        'endTime': '10:45 AM',
        'type': 'lab',
        'room': 'Lab 1'
      },
      {
        'subject': 'Break',
        'teacher': '',
        'startTime': '10:45 AM',
        'endTime': '11:00 AM',
        'type': 'break',
        'room': ''
      },
      {
        'subject': 'Hindi',
        'teacher': 'Mrs. Lakshmi Devi',
        'startTime': '11:00 AM',
        'endTime': '11:45 AM',
        'type': 'class',
        'room': 'Room 102'
      },
      {
        'subject': 'Moral Science',
        'teacher': 'Mrs. Sunita Rao',
        'startTime': '11:45 AM',
        'endTime': '12:30 PM',
        'type': 'class',
        'room': 'Room 101'
      },
    ],
    'Wednesday': [
      {
        'subject': 'Computers',
        'teacher': 'Ms. Techy',
        'startTime': '08:30 AM',
        'endTime': '09:15 AM',
        'type': 'lab',
        'room': 'Computer Lab'
      },
      {
        'subject': 'Library',
        'teacher': 'Mr. Bookman',
        'startTime': '09:15 AM',
        'endTime': '10:00 AM',
        'type': 'library',
        'room': 'Library'
      },
      {
        'subject': 'English',
        'teacher': 'Mrs. Anita Desai',
        'startTime': '10:00 AM',
        'endTime': '10:45 AM',
        'type': 'class',
        'room': 'Room 101'
      },
      {
        'subject': 'Break',
        'teacher': '',
        'startTime': '10:45 AM',
        'endTime': '11:00 AM',
        'type': 'break',
        'room': ''
      },
      {
        'subject': 'Mathematics',
        'teacher': 'Miss Raghini Sharma',
        'startTime': '11:00 AM',
        'endTime': '11:45 AM',
        'type': 'class',
        'room': 'Room 101'
      },
      {
        'subject': 'Art & Craft',
        'teacher': 'Ms. Creative',
        'startTime': '11:45 AM',
        'endTime': '12:30 PM',
        'type': 'class',
        'room': 'Art Room'
      },
    ],
    'Thursday': [
      {
        'subject': 'Science',
        'teacher': 'Mr. Vijay Prasad',
        'startTime': '08:30 AM',
        'endTime': '09:15 AM',
        'type': 'class',
        'room': 'Room 101'
      },
      {
        'subject': 'Hindi',
        'teacher': 'Mrs. Lakshmi Devi',
        'startTime': '09:15 AM',
        'endTime': '10:00 AM',
        'type': 'class',
        'room': 'Room 102'
      },
      {
        'subject': 'English',
        'teacher': 'Mrs. Anita Desai',
        'startTime': '10:00 AM',
        'endTime': '10:45 AM',
        'type': 'class',
        'room': 'Room 101'
      },
      {
        'subject': 'Break',
        'teacher': '',
        'startTime': '10:45 AM',
        'endTime': '11:00 AM',
        'type': 'break',
        'room': ''
      },
      {
        'subject': 'Mathematics',
        'teacher': 'Miss Raghini Sharma',
        'startTime': '11:00 AM',
        'endTime': '11:45 AM',
        'type': 'class',
        'room': 'Room 101'
      },
      {
        'subject': 'Physical Education',
        'teacher': 'Mr. Suresh Babu',
        'startTime': '11:45 AM',
        'endTime': '12:30 PM',
        'type': 'class',
        'room': 'Playground'
      },
    ],
    'Friday': [
      {
        'subject': 'English',
        'teacher': 'Mrs. Anita Desai',
        'startTime': '08:30 AM',
        'endTime': '09:15 AM',
        'type': 'class',
        'room': 'Room 101'
      },
      {
        'subject': 'Science',
        'teacher': 'Mr. Vijay Prasad',
        'startTime': '09:15 AM',
        'endTime': '10:00 AM',
        'type': 'class',
        'room': 'Room 101'
      },
      {
        'subject': 'Hindi',
        'teacher': 'Mrs. Lakshmi Devi',
        'startTime': '10:00 AM',
        'endTime': '10:45 AM',
        'type': 'class',
        'room': 'Room 102'
      },
      {
        'subject': 'Break',
        'teacher': '',
        'startTime': '10:45 AM',
        'endTime': '11:00 AM',
        'type': 'break',
        'room': ''
      },
      {
        'subject': 'Mathematics',
        'teacher': 'Miss Raghini Sharma',
        'startTime': '11:00 AM',
        'endTime': '11:45 AM',
        'type': 'class',
        'room': 'Room 101'
      },
      {
        'subject': 'General Knowledge',
        'teacher': 'Mr. K. Rao',
        'startTime': '11:45 AM',
        'endTime': '12:30 PM',
        'type': 'class',
        'room': 'Room 101'
      },
    ],
    'Saturday': [
      {
        'subject': 'Social Studies',
        'teacher': 'Mr. K. Rao',
        'startTime': '08:30 AM',
        'endTime': '09:15 AM',
        'type': 'class',
        'room': 'Room 101'
      },
      {
        'subject': 'English',
        'teacher': 'Mrs. Anita Desai',
        'startTime': '09:15 AM',
        'endTime': '10:00 AM',
        'type': 'class',
        'room': 'Room 101'
      },
      {
        'subject': 'Mathematics',
        'teacher': 'Miss Raghini Sharma',
        'startTime': '10:00 AM',
        'endTime': '10:45 AM',
        'type': 'class',
        'room': 'Room 101'
      },
      {
        'subject': 'Break',
        'teacher': '',
        'startTime': '10:45 AM',
        'endTime': '11:00 AM',
        'type': 'break',
        'room': ''
      },
      {
        'subject': 'Club Activities',
        'teacher': 'Various',
        'startTime': '11:00 AM',
        'endTime': '12:30 PM',
        'type': 'activity',
        'room': 'Various'
      },
    ],
  };

  void _toggleLanguage() {
    setState(() {
      _isTelugu = !_isTelugu;
    });
  }

  // void _onBottomNavTap(int index) {
  //   if (index == _currentIndex) return;

  //   setState(() {
  //     _currentIndex = index;
  //   });

  //   switch (index) {
  //     case 0:
  //       Navigator.pushNamed(context, PrincipalRoutes.home);
  //       break;
  //     case 1:
  //       Navigator.pushNamed(context, PrincipalRoutes.search);
  //       break;
  //     case 2:
  //       Navigator.pushNamed(context, PrincipalRoutes.activity);
  //       break;
  //     case 3:
  //       Navigator.pushNamed(
  //         context,
  //         PrincipalRoutes.morePage,
  //         arguments: {'section': null},
  //       );
  //       break;
  //   }
  // }

  Color _getPeriodColor(String type) {
    switch (type) {
      case 'lab':
        return const Color(0xFFFF9800);
      case 'library':
        return const Color(0xFF9C27B0);
      case 'break':
        return const Color(0xFF757575);
      case 'activity':
        return const Color(0xFF4CAF50);
      case 'class':
      default:
        return const Color(0xFF2196F3);
    }
  }

  @override
  Widget build(BuildContext context) {
    String currentDayName = _days[_selectedDayIndex];
    List<Map<String, dynamic>> periods = _timetableData[currentDayName] ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildDaySelector(),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: periods.asMap().entries.map((entry) {
                  final period = entry.value;
                  return _buildPeriodCard(period, entry.key);
                }).toList(),
              ),
            ),
            _buildClassSummary(),
            const SizedBox(height: 30),
          ],
        ),
      ),
      // bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xff4E7CF9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                "A",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.classData['className'],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Text(
                _isTelugu ? "టైమ్ టేబుల్" : "Timetable",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        GestureDetector(
          onTap: _toggleLanguage,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(
              _isTelugu ? "తెలుగు" : "English",
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff4A7BFF),
            Color(0xff3366FF),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.classData['className']} Timetable',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Class Teacher: ${widget.classData['classTeacher']}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHeaderStat(
                    '${widget.classData['totalStudents']}', 'Students'),
                _buildHeaderStat('7', 'Periods/Day'),
                _buildHeaderStat('6', 'Working Days'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildDaySelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(_days.length, (index) {
          final isSelected = _selectedDayIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedDayIndex = index),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xff4A7BFF) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xff4A7BFF)
                      : Colors.grey.shade300,
                ),
              ),
              child: Text(
                _days[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPeriodCard(Map<String, dynamic> period, int index) {
    bool isBreak = period['type'] == 'break';
    Color periodColor = _getPeriodColor(period['type']);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: periodColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'P${index + 1}',
                    style: TextStyle(
                      color: periodColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  period['startTime'],
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  period['endTime'],
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: periodColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        period['type'].toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        period['subject'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                if (!isBreak) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.person_outline, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        period['teacher'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.room_outlined, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        period['room'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          Icon(
            isBreak ? Icons.coffee_outlined : Icons.book_outlined,
            color: periodColor,
          ),
        ],
      ),
    );
  }

  Widget _buildClassSummary() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        // --- PREMIUM LIGHT BORDER ---
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E293B).withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- HEADER WITH ACCENT ---
          Row(
            children: [
              Container(
                width: 3,
                height: 16,
                decoration: BoxDecoration(
                  color: const Color(0xFF1D4ED8),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Class Overview',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E293B),
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // --- GRID LAYOUT ---
          Row(
            children: [
              _buildModernInfoTile(
                Icons.people_alt_rounded,
                'Students',
                '${widget.classData['totalStudents']}',
                const Color(0xFF6366F1),
              ),
              _buildDivider(),
              _buildModernInfoTile(
                Icons.meeting_room_rounded,
                'Room No.',
                widget.classData['room'],
                const Color(0xFFF59E0B),
              ),
            ],
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: Color(0xFFF1F5F9), thickness: 1),
          ),

          Row(
            children: [
              _buildModernInfoTile(
                Icons.layers_rounded,
                'Floor',
                widget.classData['floor'],
                const Color(0xFF10B981),
              ),
              _buildDivider(),
              _buildModernInfoTile(
                Icons.category_rounded,
                'Section',
                widget.classData['section'],
                const Color(0xFFEC4899),
              ),
            ],
          ),
        ],
      ),
    );
  }

// Helper: Modern Info Tile
  Widget _buildModernInfoTile(
      IconData icon, String label, String value, Color color) {
    return Expanded(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade500,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 30,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: const Color(0xFFF1F5F9),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 24, color: const Color(0xff4A7BFF)),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildBottomNavigationBar() {
  //   return Container(
  //     decoration: const BoxDecoration(
  //       color: Colors.white,
  //       border: Border(
  //         top: BorderSide(
  //           color: Colors.black12,
  //           width: 1,
  //         ),
  //       ),
  //     ),
  //     child: BottomNavigationBar(
  //       type: BottomNavigationBarType.fixed,
  //       backgroundColor: Colors.transparent,
  //       elevation: 0,
  //       currentIndex: _currentIndex,
  //       selectedItemColor: const Color(0xff4A7BFF),
  //       unselectedItemColor: Colors.grey,
  //       onTap: _onBottomNavTap,
  //       items: const [
  //         BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
  //         BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
  //         BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Activity'),
  //         BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
  //       ],
  //     ),
  //   );
  // }
}
