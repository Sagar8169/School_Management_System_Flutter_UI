import 'package:flutter/material.dart';
import '../../routes/principal_routes.dart';

class TimetablePage extends StatefulWidget {
  const TimetablePage({Key? key}) : super(key: key);

  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  int _currentIndex = 3; // More tab index
  bool _isTelugu = false; // Default to English
  String _selectedFilter = 'All Classes';
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> _allClasses = [
    {
      'className': 'Class 1A',
      'classTeacher': 'Mrs. Priya Sharma',
      'totalStudents': 40,
      'section': 'Primary',
      'floor': 'Ground Floor',
      'currentSubject': 'English',
      'nextSubject': 'Mathematics',
      'nextTime': '10:00 AM',
      'room': 'Room 101',
    },
    {
      'className': 'Class 1B',
      'classTeacher': 'Mr. Ravi Kumar',
      'totalStudents': 42,
      'section': 'Primary',
      'floor': 'Ground Floor',
      'currentSubject': 'Mathematics',
      'nextSubject': 'English',
      'nextTime': '10:45 AM',
      'room': 'Room 102',
    },
    {
      'className': 'Class 2A',
      'classTeacher': 'Miss Anjali Reddy',
      'totalStudents': 38,
      'section': 'Primary',
      'floor': 'Ground Floor',
      'currentSubject': 'English',
      'nextSubject': 'EVS',
      'nextTime': '10:30 AM',
      'room': 'Room 103',
    },
    {
      'className': 'Class 2B',
      'classTeacher': 'Mrs. Lakshmi Nair',
      'totalStudents': 41,
      'section': 'Primary',
      'floor': 'Ground Floor',
      'currentSubject': 'EVS',
      'nextSubject': 'Mathematics',
      'nextTime': '11:15 AM',
      'room': 'Room 104',
    },
    {
      'className': 'Class 3A',
      'classTeacher': 'Mr. Suresh Babu',
      'totalStudents': 45,
      'section': 'Primary',
      'floor': '1st Floor',
      'currentSubject': 'Mathematics',
      'nextSubject': 'Science',
      'nextTime': '10:00 AM',
      'room': 'Room 201',
    },
    {
      'className': 'Class 3B',
      'classTeacher': 'Mrs. Geetha Menon',
      'totalStudents': 43,
      'section': 'Primary',
      'floor': '1st Floor',
      'currentSubject': 'Science',
      'nextSubject': 'Hindi',
      'nextTime': '10:45 AM',
      'room': 'Room 202',
    },
    {
      'className': 'Class 4A',
      'classTeacher': 'Mr. Krishna Murthy',
      'totalStudents': 47,
      'section': 'Primary',
      'floor': '1st Floor',
      'currentSubject': 'Hindi',
      'nextSubject': 'English',
      'nextTime': '11:30 AM',
      'room': 'Room 203',
    },
    {
      'className': 'Class 4B',
      'classTeacher': 'Miss Divya Patel',
      'totalStudents': 44,
      'section': 'Primary',
      'floor': '1st Floor',
      'currentSubject': 'English',
      'nextSubject': 'Mathematics',
      'nextTime': '12:15 PM',
      'room': 'Room 204',
    },
    {
      'className': 'Class 5A',
      'classTeacher': 'Mrs. Meera Singh',
      'totalStudents': 48,
      'section': 'Primary',
      'floor': '2nd Floor',
      'currentSubject': 'Mathematics',
      'nextSubject': 'Science',
      'nextTime': '10:00 AM',
      'room': 'Room 301',
    },
    {
      'className': 'Class 5B',
      'classTeacher': 'Mr. Vijay Kumar',
      'totalStudents': 46,
      'section': 'Primary',
      'floor': '2nd Floor',
      'currentSubject': 'Science',
      'nextSubject': 'Social Studies',
      'nextTime': '10:45 AM',
      'room': 'Room 302',
    },
    {
      'className': 'Class 6A',
      'classTeacher': 'Mrs. Anita Desai',
      'totalStudents': 52,
      'section': 'Secondary',
      'floor': '2nd Floor',
      'currentSubject': 'Social Studies',
      'nextSubject': 'Mathematics',
      'nextTime': '11:30 AM',
      'room': 'Room 303',
    },
    {
      'className': 'Class 6B',
      'classTeacher': 'Mr. Raghunath Sharma',
      'totalStudents': 50,
      'section': 'Secondary',
      'floor': '2nd Floor',
      'currentSubject': 'Mathematics',
      'nextSubject': 'Science',
      'nextTime': '12:15 PM',
      'room': 'Room 304',
    },
    {
      'className': 'Class 7A',
      'classTeacher': 'Miss Ritu Verma',
      'totalStudents': 54,
      'section': 'Secondary',
      'floor': '3rd Floor',
      'currentSubject': 'Science',
      'nextSubject': 'English',
      'nextTime': '10:00 AM',
      'room': 'Room 401',
    },
    {
      'className': 'Class 7B',
      'classTeacher': 'Mr. Prakash Joshi',
      'totalStudents': 53,
      'section': 'Secondary',
      'floor': '3rd Floor',
      'currentSubject': 'English',
      'nextSubject': 'Hindi',
      'nextTime': '10:45 AM',
      'room': 'Room 402',
    },
    {
      'className': 'Class 8A',
      'classTeacher': 'Mrs. Sunita Rao',
      'totalStudents': 55,
      'section': 'Secondary',
      'floor': '3rd Floor',
      'currentSubject': 'Hindi',
      'nextSubject': 'Mathematics',
      'nextTime': '11:30 AM',
      'room': 'Room 403',
    },
    {
      'className': 'Class 8B',
      'classTeacher': 'Mr. Anil Gupta',
      'totalStudents': 56,
      'section': 'Secondary',
      'floor': '3rd Floor',
      'currentSubject': 'Mathematics',
      'nextSubject': 'Science',
      'nextTime': '12:15 PM',
      'room': 'Room 404',
    },
    {
      'className': 'Class 9A',
      'classTeacher': 'Miss Kavita Nair',
      'totalStudents': 58,
      'section': 'Secondary',
      'floor': '4th Floor',
      'currentSubject': 'Physics',
      'nextSubject': 'Chemistry',
      'nextTime': '10:00 AM',
      'room': 'Room 501',
    },
    {
      'className': 'Class 9B',
      'classTeacher': 'Mr. Sanjay Mehta',
      'totalStudents': 57,
      'section': 'Secondary',
      'floor': '4th Floor',
      'currentSubject': 'Chemistry',
      'nextSubject': 'Biology',
      'nextTime': '10:45 AM',
      'room': 'Room 502',
    },
    {
      'className': 'Class 10A',
      'classTeacher': 'Mrs. Radhika Iyer',
      'totalStudents': 60,
      'section': 'Secondary',
      'floor': '4th Floor',
      'currentSubject': 'Mathematics',
      'nextSubject': 'English',
      'nextTime': '11:30 AM',
      'room': 'Room 503',
    },
    {
      'className': 'Class 10B',
      'classTeacher': 'Mr. Manoj Reddy',
      'totalStudents': 59,
      'section': 'Secondary',
      'floor': '4th Floor',
      'currentSubject': 'English',
      'nextSubject': 'Social Studies',
      'nextTime': '12:15 PM',
      'room': 'Room 504',
    },
  ];

  final Map<String, String> _teluguTranslations = {
    'Timetable': 'టైమ్ టేబుల్',
    'All Classes Timetable': 'మొత్తం క్లాస్ టైమ్ టేబుల్',
    'Classes': 'క్లాస్‌లు',
    'Teachers': 'టీచర్లు',
    'Students': 'విద్యార్థులు',
    'Class Teacher': 'క్లాస్ టీచర్',
    'View Full Timetable': 'పూర్తి టైమ్ టేబుల్ చూడండి',
    'Current': 'ప్రస్తుతం',
    'Next': 'తదుపరి',
    'at': 'వద్ద',
    'All Classes': 'అన్ని తరగతులు',
    'Primary': 'ప్రాథమిక',
    'Secondary': 'ద్వితీయ',
    'Search': 'వెతకండి',
  };

  void _toggleLanguage() {
    setState(() {
      _isTelugu = !_isTelugu;
    });
  }

  void _onBottomNavTap(int index) {
    if (index == _currentIndex) return;

    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, PrincipalRoutes.home);
        break;
      case 1:
        Navigator.pushNamed(context, PrincipalRoutes.search);
        break;
      case 2:
        Navigator.pushNamed(context, PrincipalRoutes.activity);
        break;
      case 3:
        Navigator.pushNamed(
          context,
          PrincipalRoutes.morePage,
          arguments: {'section': null},
        );
        break;
    }
  }

  List<Map<String, dynamic>> get _filteredClasses {
    if (_selectedFilter == 'All Classes') {
      return _allClasses;
    } else if (_selectedFilter == 'Primary') {
      return _allClasses.where((c) => c['section'] == 'Primary').toList();
    } else {
      return _allClasses.where((c) => c['section'] == 'Secondary').toList();
    }
  }

  void _openClassTimetable(Map<String, dynamic> classData) {
    Navigator.pushNamed(
      context,
      PrincipalRoutes.classTimetable,
      arguments: classData,
    );
  }

  String _getText(String englishText) {
    if (_isTelugu && _teluguTranslations.containsKey(englishText)) {
      return _teluguTranslations[englishText]!;
    }
    return englishText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Fixed AppBar
            _buildAppBar(),

            // Scrollable Content (including hero section)
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(const Duration(seconds: 1));
                  setState(() {});
                },
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      // Hero Section - Now Scrollable
                      _buildHeader(),

                      // Filter Bar - Now Scrollable
                      _buildFilterBar(),

                      // Class List
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _buildClassList(),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Aditya International School",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Text(
                  _getText('Timetable'),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: _toggleLanguage,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(
                _isTelugu ? "English" : "తెలుగు",
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
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
          Row(
            children: [
              const Icon(Icons.calendar_month_outlined, color: Colors.white, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  _getText('All Classes Timetable'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildStatCard('20', _getText('Classes')),
              const SizedBox(width: 12),
              _buildStatCard('45', _getText('Teachers')),
              const SizedBox(width: 12),
              _buildStatCard('850', _getText('Students')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  _getText('All Classes'),
                  _getText('Primary'),
                  _getText('Secondary')
                ].map((filter) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(filter),
                      selected: _selectedFilter ==
                          (_isTelugu ?
                          (filter == _getText('All Classes') ? 'All Classes' :
                          filter == _getText('Primary') ? 'Primary' : 'Secondary')
                              : filter),
                      selectedColor: const Color(0xff4A7BFF),
                      labelStyle: TextStyle(
                        color: _selectedFilter ==
                            (_isTelugu ?
                            (filter == _getText('All Classes') ? 'All Classes' :
                            filter == _getText('Primary') ? 'Primary' : 'Secondary')
                                : filter) ? Colors.white : Colors.black,
                      ),
                      onSelected: (selected) {
                        setState(() {
                          if (filter == _getText('All Classes')) {
                            _selectedFilter = 'All Classes';
                          } else if (filter == _getText('Primary')) {
                            _selectedFilter = 'Primary';
                          } else {
                            _selectedFilter = 'Secondary';
                          }
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xff4A7BFF)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildClassList() {
    return Column(
      children: List.generate(_filteredClasses.length, (index) {
        final classData = _filteredClasses[index];
        return _buildClassCard(classData);
      }),
    );
  }

  Widget _buildClassCard(Map<String, dynamic> classData) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () => _openClassTimetable(classData),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xff4A7BFF).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.class_outlined,
                      color: Color(0xff4A7BFF),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          classData['className'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '${_getText('Class Teacher')}: ${classData['classTeacher']}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: classData['section'] == 'Primary'
                          ? Colors.green.withOpacity(0.1)
                          : Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _getText(classData['section']),
                      style: TextStyle(
                        color: classData['section'] == 'Primary'
                            ? Colors.green
                            : Colors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoItem(Icons.people_outline, '${classData['totalStudents']} ${_getText('Students')}'),
                  _buildInfoItem(Icons.location_on_outlined, classData['room']),
                  _buildInfoItem(Icons.layers_outlined, classData['floor']),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xffF5F7FF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade100),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: Colors.blue),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${_getText('Current')}: ${classData['currentSubject']} | ${_getText('Next')}: ${classData['nextSubject']} ${_getText('at')} ${classData['nextTime']}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => _openClassTimetable(classData),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _getText('View Full Timetable'),
                        style: const TextStyle(color: Color(0xff4A7BFF)),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward, size: 16, color: Color(0xff4A7BFF)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        const SizedBox(height: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.black12,
            width: 1,
          ),
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xff4A7BFF),
        unselectedItemColor: Colors.grey,
        onTap: _onBottomNavTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Activity'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}