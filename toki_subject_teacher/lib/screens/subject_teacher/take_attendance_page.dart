import 'package:flutter/material.dart';
import 'package:toki/routes/subject_teacher_routes.dart';

class TakeAttendancePage extends StatefulWidget {
  const TakeAttendancePage({Key? key}) : super(key: key);

  @override
  State<TakeAttendancePage> createState() => _TakeAttendancePageState();
}

class _TakeAttendancePageState extends State<TakeAttendancePage> {
  bool _isTelugu = false;

  // Selection Data
  String selectedClass = 'Class 8B';
  String selectedSection = 'Section B';
  final List<String> _classList = [
    'Class 8A',
    'Class 8B',
    'Class 9A',
    'Class 9B',
    'Class 10A'
  ];
  final List<String> _sectionList = [
    'Section A',
    'Section B',
    'Section C',
    'Section D'
  ];

  Map<int, String> studentAttendance = {
    1: 'Present',
    2: 'Absent',
    3: 'Present',
    4: 'Present',
    5: 'Present',
    6: 'Present',
    7: 'Present',
    8: 'Present',
    9: 'Present',
    10: 'Present',
  };

  final List<Map<String, dynamic>> students = [
    {'id': 1, 'name': 'Aarav Patel', 'rollNo': '101'},
    {'id': 2, 'name': 'Aditi Sharma', 'rollNo': '102'},
    {'id': 3, 'name': 'Arjun Reddy', 'rollNo': '103'},
    {'id': 4, 'name': 'Diya Singh', 'rollNo': '104'},
    {'id': 5, 'name': 'Ishan Kumar', 'rollNo': '105'},
    {'id': 6, 'name': 'Kavya Nair', 'rollNo': '106'},
    {'id': 7, 'name': 'Rohan Verma', 'rollNo': '107'},
    {'id': 8, 'name': 'Sneha Gupta', 'rollNo': '108'},
    {'id': 9, 'name': 'Vikram Joshi', 'rollNo': '109'},
    {'id': 10, 'name': 'Priya Desai', 'rollNo': '110'},
  ];

  final Color _primaryPurple = const Color(0xFF7C3AED);
  final Color _bgLight = const Color(0xFFF8FAFC);

  // ✅ 1. FUNCTION: DROPDOWN PICKER
  void _showPicker(String title, List<String> items, bool isClass) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10))),
              const SizedBox(height: 20),
              Text("Select $title",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w900)),
              const Divider(thickness: 1, indent: 20, endIndent: 20),
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.4),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final bool isSelected = isClass
                        ? selectedClass == item
                        : selectedSection == item;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isClass)
                            selectedClass = item;
                          else
                            selectedSection = item;
                        });
                        Navigator.pop(context);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? _primaryPurple.withOpacity(0.1)
                              : Colors.grey[50],
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: isSelected
                                  ? _primaryPurple
                                  : Colors.transparent,
                              width: 1.5),
                        ),
                        child: Center(
                            child: Text(item,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? _primaryPurple
                                        : Colors.black87))),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ 2. FUNCTION: SUBMIT LOGIC
  void _submitAttendanceLogic() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Icon(Icons.check_circle, color: Colors.green, size: 60),
        content: const Text("Attendance Submitted Successfully!",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Center(
              child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("OK",
                      style: TextStyle(
                          color: _primaryPurple,
                          fontWeight: FontWeight.bold)))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int presentCount =
        studentAttendance.values.where((v) => v == 'Present').length;
    int absentCount = studentAttendance.length - presentCount;

    return Scaffold(
      backgroundColor: _bgLight,
      body: SafeArea(
        child: Column(
          children: [
            _buildExactHeader(), // Header Fixed as required
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildModernClassSelector(),
                    const SizedBox(height: 20),
                    _buildSummaryCard(presentCount, absentCount),
                    const SizedBox(height: 24),
                    const Text("Students List",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF1E293B))),
                    const SizedBox(height: 12),
                    _buildStudentList(),
                    const SizedBox(height: 30),
                    _buildSubmitButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- HEADER: PREVIOUS STYLE (Back Button + Title side-by-side) ---
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
          const Text("Take Attendance",
              style: TextStyle(
                  color: Color(0xFF1E293B),
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
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

  Widget _buildModernClassSelector() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 20,
                offset: const Offset(0, 10))
          ]),
      child: Row(
        children: [
          Expanded(
              child: InkWell(
                  onTap: () => _showPicker("Class", _classList, true),
                  borderRadius:
                      const BorderRadius.horizontal(left: Radius.circular(24)),
                  child: _selectorTile(
                      "Class", selectedClass, Icons.school_outlined))),
          Container(height: 40, width: 1, color: Colors.grey[200]),
          Expanded(
              child: InkWell(
                  onTap: () => _showPicker("Section", _sectionList, false),
                  borderRadius:
                      const BorderRadius.horizontal(right: Radius.circular(24)),
                  child: _selectorTile(
                      "Section", selectedSection, Icons.layers_outlined))),
        ],
      ),
    );
  }

  Widget _selectorTile(String l, String v, IconData i) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(i, size: 12, color: Colors.grey),
            const SizedBox(width: 4),
            Text(l.toUpperCase(),
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1))
          ]),
          const SizedBox(height: 6),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(v,
                style:
                    const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
            const Icon(Icons.keyboard_arrow_down_rounded,
                color: Colors.grey, size: 18)
          ]),
        ]),
      );

  Widget _buildSummaryCard(int p, int a) {
    return Row(children: [
      _statBox("Present", p.toString(), Colors.green),
      const SizedBox(width: 12),
      _statBox("Absent", a.toString(), Colors.red),
    ]);
  }

  Widget _statBox(String l, String v, Color c) => Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
              color: c.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: c.withOpacity(0.2))),
          child: Column(children: [
            Text(v,
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: c)),
            Text(l,
                style: TextStyle(
                    fontSize: 12, color: c, fontWeight: FontWeight.bold))
          ]),
        ),
      );

  Widget _buildStudentList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: students.length,
      itemBuilder: (context, index) {
        final student = students[index];
        final isP = studentAttendance[student['id']] == 'Present';
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.black.withOpacity(0.02))),
          child: Row(
            children: [
              CircleAvatar(
                  radius: 16,
                  backgroundColor: _bgLight,
                  child: Text(student['id'].toString(),
                      style:
                          const TextStyle(fontSize: 10, color: Colors.grey))),
              const SizedBox(width: 12),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(student['name'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    Text("Roll No: ${student['rollNo']}",
                        style:
                            const TextStyle(fontSize: 11, color: Colors.grey))
                  ])),
              _attBtn(student['id'], 'P', isP),
              const SizedBox(width: 8),
              _attBtn(student['id'], 'A', !isP),
            ],
          ),
        );
      },
    );
  }

  Widget _attBtn(int id, String l, bool active) {
    Color c = l == 'P' ? Colors.green : Colors.red;
    return GestureDetector(
      onTap: () => setState(
          () => studentAttendance[id] = l == 'P' ? 'Present' : 'Absent'),
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              color: active ? c : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: active ? c : Colors.grey.shade300)),
          child: Center(
              child: Text(l,
                  style: TextStyle(
                      color: active ? Colors.white : Colors.grey,
                      fontWeight: FontWeight.bold)))),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
          onPressed: _submitAttendanceLogic,
          style: ElevatedButton.styleFrom(
              backgroundColor: _primaryPurple,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 4),
          child: const Text('Submit Attendance',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold))),
    );
  }
}
