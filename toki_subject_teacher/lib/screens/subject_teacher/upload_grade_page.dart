import 'package:flutter/material.dart';
import 'package:toki/routes/subject_teacher_routes.dart';

class UploadGradePage extends StatefulWidget {
  const UploadGradePage({Key? key}) : super(key: key);

  @override
  State<UploadGradePage> createState() => _UploadGradePageState();
}

class _UploadGradePageState extends State<UploadGradePage> {
  int _currentIndex = 2;
  bool _isTelugu = false;

  // Selection Data
  String selectedClass = 'Class 8B';
  String selectedSubject = 'Science';
  String selectedExamType = 'Mid-term Exam';
  DateTime? examDate;

  final List<Map<String, dynamic>> _students = [
    {'id': 1, 'name': 'Aarav Patel', 'rollNo': '101', 'grade': ''},
    {'id': 2, 'name': 'Aditi Sharma', 'rollNo': '102', 'grade': ''},
    {'id': 3, 'name': 'Arjun Reddy', 'rollNo': '103', 'grade': ''},
    {'id': 4, 'name': 'Diya Singh', 'rollNo': '104', 'grade': ''},
    {'id': 5, 'name': 'Ishan Kumar', 'rollNo': '105', 'grade': ''},
  ];

  final List<String> _classes = ['Class 8B', 'Class 9A', 'Class 10C'];
  final List<String> _subjects = ['Science', 'Mathematics', 'Physics', 'Chemistry', 'Biology'];
  final List<String> _examTypes = ['Mid-term Exam', 'Unit Test', 'Final Exam', 'Assignment'];

  final Color _primaryPurple = const Color(0xFF7C3AED);
  final Color _bgLight = const Color(0xFFF8FAFC);

  // ✅ LOGIC: Submit Grades with Validation
  void _submitGradesLogic() {
    // Check Date
    if (examDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select an Exam Date first!"),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Check if any student grade is empty
    bool isIncomplete = _students.any((s) => s['grade'].toString().trim().isEmpty);
    if (isIncomplete) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill grades for all students!"),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Success Dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Icon(Icons.check_circle, color: Colors.green, size: 60),
        content: const Text(
          "Grades Submitted Successfully!",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Awesome!", style: TextStyle(color: _primaryPurple, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  void _onTabTapped(int index) {
    if (_currentIndex == index) return;
    setState(() => _currentIndex = index);
    switch (index) {
      case 0: Navigator.pushReplacementNamed(context, SubjectTeacherRoutes.home); break;
      case 1: Navigator.pushReplacementNamed(context, SubjectTeacherRoutes.search); break;
      case 2: break;
      case 3: Navigator.pushReplacementNamed(context, SubjectTeacherRoutes.settings); break;
    }
  }

  void _showPicker(String title, List<String> items, String currentVal, Function(String) onSelect) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(width: 50, height: 5, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),
              const SizedBox(height: 20),
              Text("Select $title", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
              const Divider(thickness: 1, indent: 20, endIndent: 20),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.4),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final bool isSelected = currentVal == item;
                    return GestureDetector(
                      onTap: () { onSelect(item); Navigator.pop(context); },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: isSelected ? _primaryPurple.withOpacity(0.1) : Colors.grey[50],
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: isSelected ? _primaryPurple : Colors.transparent, width: 1.5),
                        ),
                        child: Center(child: Text(item, style: TextStyle(fontSize: 16, fontWeight: isSelected ? FontWeight.bold : FontWeight.w500, color: isSelected ? _primaryPurple : Colors.black87))),
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

  Future<void> _selectExamDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2026),
      builder: (context, child) => Theme(data: ThemeData.light().copyWith(colorScheme: ColorScheme.light(primary: _primaryPurple)), child: child!),
    );
    if (picked != null) setState(() => examDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      body: SafeArea(
        child: Column(
          children: [
            _buildExactHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSelectionGrid(),
                    const SizedBox(height: 20),
                    _buildDateTile(),
                    const SizedBox(height: 24),
                    const Text("Enter Grades", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
                    const SizedBox(height: 12),
                    _buildStudentGradeList(),
                    const SizedBox(height: 30),
                    _buildSubmitButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildExactHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 1, offset: Offset(0, 1))]),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: _primaryPurple.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
              child: Icon(Icons.arrow_back_ios_new_rounded, color: _primaryPurple, size: 20),
            ),
          ),
          const SizedBox(width: 16),
          const Text("Upload Grades", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
          const Spacer(),
          GestureDetector(
            onTap: () => setState(() => _isTelugu = !_isTelugu),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(border: Border.all(color: _primaryPurple.withOpacity(0.3)), borderRadius: BorderRadius.circular(20)),
              child: Text(_isTelugu ? 'ಕನ್ನಡ' : 'English', style: TextStyle(color: _primaryPurple, fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionGrid() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 10))]),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: InkWell(onTap: () => _showPicker("Class", _classes, selectedClass, (val) => setState(() => selectedClass = val)), child: _selectorTile("Class", selectedClass, Icons.school_outlined))),
              Container(width: 1, height: 40, color: Colors.grey[100]),
              Expanded(child: InkWell(onTap: () => _showPicker("Subject", _subjects, selectedSubject, (val) => setState(() => selectedSubject = val)), child: _selectorTile("Subject", selectedSubject, Icons.book_outlined))),
            ],
          ),
          const Divider(height: 1),
          InkWell(
            onTap: () => _showPicker("Exam Type", _examTypes, selectedExamType, (val) => setState(() => selectedExamType = val)),
            child: _selectorTile("Exam Type", selectedExamType, Icons.assignment_outlined),
          ),
        ],
      ),
    );
  }

  Widget _selectorTile(String l, String v, IconData i) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(i, size: 12, color: Colors.grey), const SizedBox(width: 4), Text(l.toUpperCase(), style: const TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1))]),
      const SizedBox(height: 6),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text(v, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)), const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey, size: 18)]),
    ]),
  );

  Widget _buildDateTile() {
    return InkWell(
      onTap: () => _selectExamDate(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.black.withOpacity(0.05))),
        child: Row(
          children: [
            Icon(Icons.calendar_month_outlined, color: _primaryPurple),
            const SizedBox(width: 12),
            Text("Exam Date", style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w600)),
            const Spacer(),
            Text(examDate == null ? 'Select Date' : '${examDate!.day}/${examDate!.month}/${examDate!.year}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentGradeList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _students.length,
      itemBuilder: (context, index) {
        final student = _students[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: Colors.black.withOpacity(0.02))),
          child: Row(
            children: [
              CircleAvatar(radius: 18, backgroundColor: _bgLight, child: Text(student['id'].toString(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey))),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(student['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)), Text("Roll No: ${student['rollNo']}", style: const TextStyle(fontSize: 11, color: Colors.grey))])),
              SizedBox(
                width: 60,
                child: TextField(
                  textAlign: TextAlign.center,
                  maxLength: 2,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  decoration: InputDecoration(hintText: 'A', counterText: "", contentPadding: EdgeInsets.zero, border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                  onChanged: (v) {
                    setState(() {
                      _students[index]['grade'] = v.toUpperCase();
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity, height: 56,
      child: ElevatedButton(
        onPressed: _submitGradesLogic,
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryPurple,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 5,
          shadowColor: _primaryPurple.withOpacity(0.4),
        ),
        child: const Text('Submit Grades', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _currentIndex, onTap: _onTabTapped, type: BottomNavigationBarType.fixed,
      selectedItemColor: _primaryPurple, unselectedItemColor: Colors.grey, backgroundColor: Colors.white,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.bolt_rounded), label: 'Activity'),
        BottomNavigationBarItem(icon: Icon(Icons.more_horiz_rounded), label: 'More'),
      ],
    );
  }
}