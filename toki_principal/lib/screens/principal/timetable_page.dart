import 'package:flutter/material.dart';
import '../../routes/principal_routes.dart';

class TimetablePage extends StatefulWidget {
  const TimetablePage({Key? key}) : super(key: key);

  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  final List<String> _classFilters = [
    'All',
    'LKG',
    'UKG',
    '1A',
    '1B',
    '1C',
    '2A',
    '2B',
    '2C',
    '3A',
    '3B',
    '3C',
    '4A',
    '4B',
    '4C',
    '5A',
    '5B',
    '5C',
    '6A',
    '6B',
    '6C',
    '7A',
    '7B',
    '7C',
    '8A',
    '8B',
    '8C',
    '9A',
    '9B',
    '9C',
    '10A',
    '10B',
    '10C',
  ];

  // int _currentIndex = 3;
  bool _isTelugu = false;
  String _selectedFilter = 'All';
  final ScrollController _scrollController = ScrollController();

  // --- DUMMY DATA ---
  final List<Map<String, dynamic>> _allClasses = [
    {
      'classId': 'LKG',
      'className': 'LKG',
      'classTeacher': 'Mrs. Sunita Rao',
      'totalStudents': 32,
      'section': 'Primary',
      'floor': 'Ground Floor',
      'currentSubject': 'Rhymes',
      'nextSubject': 'Drawing',
      'nextTime': '10:00 AM',
      'room': 'Room 001'
    },
    {
      'classId': 'UKG',
      'className': 'UKG',
      'classTeacher': 'Mrs. Anjali Verma',
      'totalStudents': 35,
      'section': 'Primary',
      'floor': 'Ground Floor',
      'currentSubject': 'English',
      'nextSubject': 'Mathematics',
      'nextTime': '10:30 AM',
      'room': 'Room 002'
    },
    {
      'classId': '1A',
      'className': 'Class 1A',
      'classTeacher': 'Mrs. Priya Sharma',
      'totalStudents': 40,
      'section': 'Primary',
      'floor': '1st Floor',
      'currentSubject': 'English',
      'nextSubject': 'Mathematics',
      'nextTime': '10:00 AM',
      'room': 'Room 101'
    },
    {
      'classId': '9A',
      'className': 'Class 9A',
      'classTeacher': 'Miss Kavita Nair',
      'totalStudents': 58,
      'section': 'Secondary',
      'floor': '4th Floor',
      'currentSubject': 'Physics',
      'nextSubject': 'Chemistry',
      'nextTime': '10:00 AM',
      'room': 'Room 501'
    },
    {
      'classId': '10A',
      'className': 'Class 10A',
      'classTeacher': 'Mr. Suresh Patel',
      'totalStudents': 60,
      'section': 'Secondary',
      'floor': '5th Floor',
      'currentSubject': 'Mathematics',
      'nextSubject': 'Science',
      'nextTime': '10:30 AM',
      'room': 'Room 601'
    },
  ];

  final Map<String, String> _teluguTranslations = {
    'Timetable': 'టైమ్ టేబుల్',
    'All Classes': 'అన్ని తరగతులు',
    'Primary': 'ప్రాథమిక',
    'Secondary': 'ద్వితీయ',
    'Class Teacher': 'క్లాస్ టీచర్',
  };

  String _getText(String englishText) {
    if (_isTelugu && _teluguTranslations.containsKey(englishText))
      return _teluguTranslations[englishText]!;
    return englishText;
  }

  List<Map<String, dynamic>> get _filteredClasses {
    if (_selectedFilter == 'All') return _allClasses;
    return _allClasses.where((c) => c['classId'] == _selectedFilter).toList();
  }

  // ==========================================
  // --- ADD / EDIT TIMETABLE LOGIC ---
  // ==========================================
  void _openTimetableEditor(
      {Map<String, dynamic>? classData, bool isAdding = false}) {
    TextEditingController nameCtrl =
        TextEditingController(text: classData?['className'] ?? "");
    TextEditingController subjectCtrl =
        TextEditingController(text: classData?['currentSubject'] ?? "");
    TextEditingController nextSubCtrl =
        TextEditingController(text: classData?['nextSubject'] ?? "");
    TextEditingController timeCtrl =
        TextEditingController(text: classData?['nextTime'] ?? "");
    TextEditingController roomCtrl =
        TextEditingController(text: classData?['room'] ?? "");

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
            // ✨ SAFE AREA & KEYBOARD VIEW INSETS LOGIC
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            left: 24,
            right: 24,
            top: 12),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
        child: SingleChildScrollView(
          // Added for small screens
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10)))),
              const SizedBox(height: 25),
              Text(
                  isAdding
                      ? "Add New Timetable Entry"
                      : "Edit Schedule: ${classData?['className']}",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F172A))),
              const SizedBox(height: 20),

              if (isAdding) ...[
                _buildEditField(
                    "Class ID (e.g. 10B)", nameCtrl, Icons.class_outlined),
                const SizedBox(height: 16),
              ],

              _buildEditField(
                  "Current Subject", subjectCtrl, Icons.play_circle_outline),
              const SizedBox(height: 16),
              _buildEditField(
                  "Next Subject", nextSubCtrl, Icons.update_rounded),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                      child: _buildEditField(
                          "Time", timeCtrl, Icons.access_time_rounded)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _buildEditField(
                          "Room", roomCtrl, Icons.meeting_room_outlined)),
                ],
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (isAdding) {
                        _allClasses.add({
                          'classId': nameCtrl.text,
                          'className': 'Class ${nameCtrl.text}',
                          'classTeacher': 'Not Assigned',
                          'totalStudents': 0,
                          'section': 'General',
                          'floor': 'Unknown',
                          'currentSubject': subjectCtrl.text,
                          'nextSubject': nextSubCtrl.text,
                          'nextTime': timeCtrl.text,
                          'room': roomCtrl.text,
                        });
                      } else {
                        classData?['currentSubject'] = subjectCtrl.text;
                        classData?['nextSubject'] = nextSubCtrl.text;
                        classData?['nextTime'] = timeCtrl.text;
                        classData?['room'] = roomCtrl.text;
                      }
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            isAdding ? "New class added" : "Timetable updated"),
                        backgroundColor: const Color(0xFF059669),
                        behavior: SnackBarBehavior.floating));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1D4ED8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      elevation: 0),
                  child: Text(isAdding ? "ADD ENTRY" : "SAVE CHANGES",
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1)),
                ),
              ),
              // ✨ EXTRA BOTTOM PADDING FOR SAFE AREA
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditField(
      String label, TextEditingController ctrl, IconData icon) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF64748B))),
      const SizedBox(height: 8),
      TextField(
          controller: ctrl,
          style: const TextStyle(fontWeight: FontWeight.w700),
          decoration: InputDecoration(
              prefixIcon: Icon(icon, color: const Color(0xFF1D4ED8), size: 20),
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none))),
    ]);
  }

  // void _onBottomNavTap(int index) {
  //   if (index == _currentIndex) return;
  //   setState(() => _currentIndex = index);
  //   switch (index) {
  //     case 0: Navigator.pushNamed(context, PrincipalRoutes.home); break;
  //     case 1: Navigator.pushNamed(context, PrincipalRoutes.search); break;
  //     case 2: Navigator.pushNamed(context, PrincipalRoutes.activity); break;
  //     case 3: Navigator.pushNamed(context, PrincipalRoutes.morePage); break;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // ✨ ADD BUTTON
          FloatingActionButton(
            heroTag: "add_btn",
            mini: true,
            onPressed: () => _openTimetableEditor(isAdding: true),
            backgroundColor: const Color(0xFF1D4ED8),
            child: const Icon(Icons.add, color: Colors.white),
          ),
          const SizedBox(height: 12),
          // ✨ EDIT BUTTON
          if (_selectedFilter != 'All' && _filteredClasses.isNotEmpty)
            FloatingActionButton.extended(
              heroTag: "edit_btn",
              onPressed: () =>
                  _openTimetableEditor(classData: _filteredClasses.first),
              backgroundColor: const Color(0xFF0F172A),
              icon:
                  const Icon(Icons.edit_calendar_rounded, color: Colors.white),
              label: const Text("EDIT CLASS",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w900)),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildMainHeader(),
            Expanded(
              child: RefreshIndicator(
                color: const Color(0xFF1D4ED8),
                onRefresh: () async =>
                    await Future.delayed(const Duration(seconds: 1)),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      _buildSummaryHeader(),
                      const SizedBox(height: 25),
                      _buildFilterBar(),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: _filteredClasses
                              .map((data) => _buildTimetableCard(data))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 120), // Extra space for FABs
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildMainHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        MediaQuery.of(context).padding.top + 0,
        20,
        12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6), // 👈 bottom-only shadow
          ),
        ],
      ),
      child: Row(
        children: [
          // 🔙 Circular Back Button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 42,
              width: 42,
              decoration: const BoxDecoration(
                color: Color(0xFFF1F5F9),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: Color(0xFF1E293B),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // 📅 Title + Subtitle
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Timetable',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'AIS Schedule Management',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),

          // 🌐 Language Pill
          _buildLanguagePill(),
        ],
      ),
    );
  }

  Widget _buildLanguagePill() {
    return GestureDetector(
      onTap: () => setState(() => _isTelugu = !_isTelugu),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFDBEAFE))),
        child: Text(_isTelugu ? 'తెలుగు' : 'English',
            style: const TextStyle(
                color: Color(0xFF1D4ED8),
                fontWeight: FontWeight.w800,
                fontSize: 11)),
      ),
    );
  }

  Widget _buildSummaryHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [Color(0xFF1E3A8A), Color(0xFF1D4ED8), Color(0xFF3B82F6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF1D4ED8).withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                    _getText(_selectedFilter == 'All'
                        ? 'All Classes'
                        : 'Class $_selectedFilter'),
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(_getText('School Timetable'),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5)),
              ]),
              Material(
                  color: Colors.transparent,
                  child: InkWell(
                      onTap: () {},
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(14)),
                          child: const Icon(Icons.calendar_today_rounded,
                              color: Colors.white, size: 24)))),
            ],
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                    color: Colors.white.withOpacity(0.2), width: 1.5)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _ovStat('${_allClasses.length}', _getText('Classes'),
                      Icons.class_rounded),
                  _buildVerticalDivider(),
                  _ovStat('45', 'Teachers', Icons.person_4_rounded),
                  _buildVerticalDivider(),
                  _ovStat('850', 'Students', Icons.group_rounded),
                ]),
          ),
        ],
      ),
    );
  }

  Widget _ovStat(String value, String label, IconData icon) =>
      Column(children: [
        Icon(icon, color: Colors.white.withOpacity(0.7), size: 16),
        const SizedBox(height: 6),
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w900)),
        Text(label,
            style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 10,
                fontWeight: FontWeight.w600))
      ]);

  Widget _buildVerticalDivider() =>
      Container(height: 30, width: 1, color: Colors.white.withOpacity(0.2));

  Widget _buildFilterBar() {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _classFilters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (ctx, i) {
          final filter = _classFilters[i];
          final bool isSelected = _selectedFilter == filter;
          return GestureDetector(
            onTap: () {
              setState(() => _selectedFilter = filter);
              _scrollController.animateTo(0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF1D4ED8) : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                      color: isSelected
                          ? const Color(0xFF1D4ED8)
                          : const Color(0xFFE2E8F0))),
              child: Center(
                  child: Text(_getText(filter),
                      style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF64748B),
                          fontWeight: FontWeight.w700,
                          fontSize: 13))),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimetableCard(Map<String, dynamic> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 18,
                offset: const Offset(0, 10))
          ]),
      child: InkWell(
        onLongPress: () => _openTimetableEditor(classData: data),
        onTap: () => Navigator.pushNamed(
            context, PrincipalRoutes.classTimetable,
            arguments: data),
        borderRadius: BorderRadius.circular(26),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(data['className'],
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1E293B))),
                  const SizedBox(height: 4),
                  Text('${_getText('Class Teacher')}: ${data['classTeacher']}',
                      style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF94A3B8),
                          fontWeight: FontWeight.w600)),
                ]),
                IconButton(
                    onPressed: () => _openTimetableEditor(classData: data),
                    icon: const Icon(Icons.mode_edit_outline_outlined,
                        color: Color(0xFF94A3B8), size: 20)),
              ]),
              const SizedBox(height: 14),
              const Divider(height: 1, color: Color(0xFFF1F5F9)),
              const SizedBox(height: 14),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                _miniInfo(Icons.room_rounded, data['room']),
                _miniInfo(Icons.layers_rounded, data['floor']),
                _miniInfo(
                    Icons.groups_rounded, '${data['totalStudents']} Students')
              ]),
              const SizedBox(height: 18),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE5E7EB))),
                child: Row(children: [
                  const Icon(Icons.play_circle_fill_rounded,
                      color: Color(0xFF1D4ED8), size: 22),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Text(
                          'Now: ${data['currentSubject']}  •  Next: ${data['nextSubject']} @ ${data['nextTime']}',
                          style: const TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF475569)))),
                  const Icon(Icons.arrow_forward_ios_rounded,
                      size: 13, color: Color(0xFFCBD5E1)),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _miniInfo(IconData icon, String text) => Row(children: [
        Icon(icon, size: 14, color: const Color(0xFF94A3B8)),
        const SizedBox(width: 6),
        Text(text,
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF64748B)))
      ]);

  // Widget _buildBottomNav() {
  //   return Container(
  //     decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xFFF1F5F9)))),
  //     child: BottomNavigationBar(
  //       currentIndex: _currentIndex, onTap: _onBottomNavTap, type: BottomNavigationBarType.fixed, backgroundColor: Colors.white, selectedItemColor: const Color(0xFF1D4ED8), unselectedItemColor: const Color(0xFF94A3B8), elevation: 0,
  //       items: const [
  //         BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
  //         BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: 'Search'),
  //         BottomNavigationBarItem(icon: Icon(Icons.analytics_rounded), label: 'Activity'),
  //         BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'More'),
  //       ],
  //     ),
  //   );
  // }
}
