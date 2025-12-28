// lib/screens/class_teacher/timetable_screen.dart
import 'package:flutter/material.dart';
import '../../routes/class_teacher_routes.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({Key? key}) : super(key: key);

  @override
  _TimetableScreenState createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  int _currentIndex = 0;
  int _selectedDayIndex = 0;
  bool _isTelugu = true;

  final String _userRole = 'class_teacher';
  final String _loggedInTeacherName = 'Mrs. Anita Desai';

  final Color _primaryBlue = const Color(0xFF2979FF);
  final Color _darkBlueGradient = const Color(0xFF1565C0);
  final Color _bgGrey = const Color(0xFFF5F6F8);
  final Color _textDark = const Color(0xFF1A1A1A);
  final Color _textGrey = const Color(0xFF757575);
  final Color _successGreen = const Color(0xFF00C853);
  final Color _lightGreenBg = const Color(0xFFE8F5E9);
  final Color _currentClassBg = const Color(0xFFE3F2FD);
  final Color _selectedPurple = const Color(0xFFEADDFF);

  final List<String> _days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

  final Map<String, List<Map<String, dynamic>>> _timetableData = {
    'Monday': [
      {'subject': 'Mathematics', 'teacher': 'Miss Raghini Sharma', 'startTime': '08:30 AM', 'endTime': '09:15 AM', 'type': 'class'},
      {'subject': 'Science', 'teacher': 'Mr. Vijay Prasad', 'startTime': '09:15 AM', 'endTime': '10:00 AM', 'type': 'class'},
      {'subject': 'English', 'teacher': 'Mrs. Anita Desai', 'startTime': '10:00 AM', 'endTime': '10:45 AM', 'type': 'class'},
      {'subject': 'Break', 'teacher': '', 'startTime': '10:45 AM', 'endTime': '11:00 AM', 'type': 'break'},
      {'subject': 'Hindi', 'teacher': 'Mrs. Lakshmi Devi', 'startTime': '11:00 AM', 'endTime': '11:45 AM', 'type': 'class'},
      {'subject': 'Sports', 'teacher': 'Mr. Suresh Babu', 'startTime': '11:45 AM', 'endTime': '12:30 PM', 'type': 'class'},
    ],
    'Tuesday': [
      {'subject': 'Social Studies', 'teacher': 'Mr. K. Rao', 'startTime': '08:30 AM', 'endTime': '09:15 AM', 'type': 'class'},
      {'subject': 'English', 'teacher': 'Mrs. Anita Desai', 'startTime': '09:15 AM', 'endTime': '10:00 AM', 'type': 'class'},
      {'subject': 'Science Lab', 'teacher': 'Mr. Vijay Prasad', 'startTime': '10:00 AM', 'endTime': '10:45 AM', 'type': 'class'},
      {'subject': 'Break', 'teacher': '', 'startTime': '10:45 AM', 'endTime': '11:00 AM', 'type': 'break'},
      {'subject': 'Mathematics', 'teacher': 'Miss Raghini Sharma', 'startTime': '11:00 AM', 'endTime': '11:45 AM', 'type': 'class'},
    ],
    'Wednesday': [
      {'subject': 'Computers', 'teacher': 'Ms. Techy', 'startTime': '08:30 AM', 'endTime': '09:15 AM', 'type': 'class'},
      {'subject': 'Library', 'teacher': 'Mr. Bookman', 'startTime': '09:15 AM', 'endTime': '10:00 AM', 'type': 'class'},
      {'subject': 'English', 'teacher': 'Mrs. Anita Desai', 'startTime': '10:00 AM', 'endTime': '10:45 AM', 'type': 'class'},
    ],
  };

  final Map<String, Map<String, dynamic>> _eventsData = {
    'Monday': {
      'title': 'Parent-Teacher Meeting',
      'desc': 'Monthly meeting to discuss progress',
      'time': '2:00 PM - 5:00 PM',
      'icon': Icons.calendar_month_outlined,
      'color': Color(0xFFFF9800),
      'bg': Color(0xFFFFF3E0),
    },
    'Tuesday': {
      'title': 'Science Fair Prep',
      'desc': 'Collecting projects from students',
      'time': '1:00 PM - 2:00 PM',
      'icon': Icons.science_outlined,
      'color': Color(0xFF2979FF),
      'bg': Color(0xFFE3F2FD),
    },
    'Wednesday': {
      'title': 'Staff Meeting',
      'desc': 'Principal addressing all staff',
      'time': '4:00 PM - 5:00 PM',
      'icon': Icons.groups_outlined,
      'color': Color(0xFF00C853),
      'bg': Color(0xFFE8F5E9),
    },
  };

  void _toggleLanguage() {
    setState(() {
      _isTelugu = !_isTelugu;
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    ClassTeacherRoutes.handleBottomNavTap(context, index);
  }

  @override
  Widget build(BuildContext context) {
    String currentDayName = _days[_selectedDayIndex];
    List<Map<String, dynamic>> periods = _timetableData[currentDayName] ?? _timetableData['Monday']!;
    Map<String, dynamic>? todayEvent = _eventsData[currentDayName];

    return Scaffold(
      backgroundColor: _bgGrey,
      appBar: _buildCustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBlueHeader(),
            const SizedBox(height: 16),
            _buildDaySelector(),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: periods.asMap().entries.map((entry) {
                  bool isTimeNow = (entry.key == 1);
                  return _buildPeriodCard(entry.value, isTimeNow);
                }).toList(),
              ),
            ),
            if (todayEvent != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text("$currentDayName's Events", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A))),
                    const SizedBox(height: 12),
                    _buildEventCard(todayEvent),
                  ],
                ),
              ),
            _buildWorkSummary(),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  PreferredSizeWidget _buildCustomAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 70,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: _primaryBlue,
                borderRadius: BorderRadius.circular(8)
            ),
            child: const Center(
              child: Text(
                  'A',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  )
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Aditya International School',
                  style: TextStyle(
                      color: _textDark,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  )
              ),
              Text(
                  'Powered by Toki Tech',
                  style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 11
                  )
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: _toggleLanguage,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade50
              ),
              child: Text(
                  _isTelugu ? 'తెలుగు' : 'English',
                  style: TextStyle(
                      color: _primaryBlue,
                      fontSize: 13,
                      fontWeight: FontWeight.w600
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlueHeader() {
    bool canEdit = _userRole == 'principal' || _userRole == 'class_teacher';

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [_primaryBlue, _darkBlueGradient]
          ),
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24)
          )
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle
                    ),
                    child: const Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                        size: 24
                    )
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                  'Timetable            Class 8B',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                  )
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12)
            ),
            child: Row(
              children: [
                Icon(
                    canEdit ? Icons.edit_calendar_rounded : Icons.lock_outline,
                    color: Colors.white,
                    size: 20
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          canEdit ? 'Edit Timetable' : 'Read-Only View',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14
                          )
                      ),
                      const SizedBox(height: 4),
                      Text(
                          canEdit
                              ? 'Tap here to modify the schedule.'
                              : 'Only Class Teacher or Principal can edit.',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12
                          )
                      ),
                    ],
                  ),
                ),
                if (canEdit)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Text(
                        'Edit',
                        style: TextStyle(
                            color: _primaryBlue,
                            fontSize: 12,
                            fontWeight: FontWeight.bold
                        )
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
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
                  color: isSelected ? _primaryBlue : Colors.white,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Text(
                  _days[index],
                  style: TextStyle(
                      color: isSelected ? Colors.white : _textDark,
                      fontWeight: FontWeight.w600,
                      fontSize: 13
                  )
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPeriodCard(Map<String, dynamic> period, bool isTimeNow) {
    bool isBreak = period['type'] == 'break';
    bool isMyClass = period['teacher'] == _loggedInTeacherName;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isTimeNow ? _currentClassBg : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isMyClass
            ? Border.all(color: _primaryBlue, width: 2)
            : Border.all(color: Colors.transparent, width: 0),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 5,
              offset: const Offset(0, 2)
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (isTimeNow) ...[
                Icon(Icons.access_time_filled, size: 16, color: _primaryBlue),
                const SizedBox(width: 8),
              ],
              Text(
                  period['subject'],
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isMyClass ? _primaryBlue : _textDark
                  )
              ),
              if (isMyClass)
                Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.star, size: 14, color: _primaryBlue)
                ),
              const Spacer(),
              Text(
                  '${period['startTime']} - ${period['endTime']}',
                  style: TextStyle(
                      color: isTimeNow ? _primaryBlue : _textGrey,
                      fontWeight: isTimeNow ? FontWeight.bold : FontWeight.normal,
                      fontSize: 12
                  )
              ),
            ],
          ),
          if (!isBreak) ...[
            const SizedBox(height: 12),
            const Divider(height: 1, thickness: 0.5),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(6)
                  ),
                  child: Icon(
                      Icons.person_outline,
                      size: 18,
                      color: Colors.grey.shade700
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                    period['teacher'],
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13
                    )
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: event['bg'],
                borderRadius: BorderRadius.circular(10)
            ),
            child: Icon(event['icon'], color: event['color']),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    event['title'],
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF1A1A1A)
                    )
                ),
                const SizedBox(height: 4),
                Text(
                    event['desc'],
                    style: const TextStyle(color: Colors.grey, fontSize: 12)
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                        event['time'],
                        style: const TextStyle(color: Colors.grey, fontSize: 11)
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

  Widget _buildWorkSummary() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                  "My Work Summary",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A)
                  )
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                      color: _lightGreenBg,
                      borderRadius: BorderRadius.circular(4)
                  ),
                  child: const Text(
                      'Subject Teacher',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.green
                      )
                  )
              )
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: const Color(0xFF37474F),
                borderRadius: BorderRadius.circular(16)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryStat('5', 'Classes\nToday'),
                Container(height: 30, width: 1, color: Colors.white24),
                _buildSummaryStat('2', 'Remaining'),
                Container(height: 30, width : 1, color : Colors.white24),
                _buildSummaryStat('8B', 'Next\nClass'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryStat(String value, String label) {
    return Column(
      children: [
        Text(
            value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold
            )
        ),
        const SizedBox(height: 4),
        Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 10,
                height: 1.2
            )
        ),
      ],
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade200))
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: _primaryBlue,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(_currentIndex == 0 ? Icons.home_filled : Icons.home_outlined),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _currentIndex == 2 ? _selectedPurple : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.show_chart, size: 22),
            ),
            label: 'Activity',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.more_vert),
            label: 'More',
          ),
        ],
      ),
    );
  }
}