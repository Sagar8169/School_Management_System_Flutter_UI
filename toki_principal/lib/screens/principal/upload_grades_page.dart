import 'dart:io';
import 'package:flutter/material.dart';
import '../../routes/principal_routes.dart';
import 'package:flutter/services.dart';

class UploadGradesPage extends StatefulWidget {
  const UploadGradesPage({super.key});

  @override
  State<UploadGradesPage> createState() => _UploadGradesPageState();
}

class _UploadGradesPageState extends State<UploadGradesPage> {
  // int _currentIndex = 2;
  bool _isTelugu = false;
  bool _isSaving = false;

  // Dropdown values
  String _selectedClass = 'Class 10-A';
  String _selectedSubject = 'Mathematics';
  String _selectedExamType = 'Unit Test 1';

  // Marks configuration
  int _maxMarks = 100;
  final TextEditingController _maxMarksController =
      TextEditingController(text: '100');

  // Student marks data
  final List<Map<String, dynamic>> _studentsMarks = [
    {
      'id': '1',
      'name': 'Rahul Sharma',
      'rollNumber': '1001',
      'marks': '',
      'percentage': 0.0,
      'grade': '-'
    },
    {
      'id': '2',
      'name': 'Priya Patel',
      'rollNumber': '1002',
      'marks': '',
      'percentage': 0.0,
      'grade': '-'
    },
    {
      'id': '3',
      'name': 'Amit Kumar',
      'rollNumber': '1003',
      'marks': '',
      'percentage': 0.0,
      'grade': '-'
    },
    {
      'id': '4',
      'name': 'Sneha Reddy',
      'rollNumber': '1004',
      'marks': '',
      'percentage': 0.0,
      'grade': '-'
    },
    {
      'id': '5',
      'name': 'Vikram Singh',
      'rollNumber': '1005',
      'marks': '',
      'percentage': 0.0,
      'grade': '-'
    },
  ];

  final List<String> _classes = [
    'Class 10-A',
    'Class 10-B',
    'Class 9-A',
    'Class 9-B'
  ];
  final List<String> _subjects = ['Mathematics', 'Science', 'English', 'Hindi'];
  final List<String> _examTypes = [
    'Unit Test 1',
    'Unit Test 2',
    'Half Yearly',
    'Final Exam'
  ];

  @override
  void initState() {
    super.initState();
    _maxMarksController.addListener(() {
      setState(() {
        _maxMarks = int.tryParse(_maxMarksController.text) ?? 100;
        _recalculateAll();
      });
    });
  }

  // --- LOGIC ---
  void _toggleLanguage() {
    setState(() => _isTelugu = !_isTelugu);
  }

  void _updateStudentMarks(int index, String value) {
    double enteredMarks = double.tryParse(value) ?? 0.0;

    // ❌ max marks se zyada allow mat karo
    if (enteredMarks > _maxMarks) {
      enteredMarks = _maxMarks.toDouble(); // ✅ FIX

      // text field ko bhi correct value dikhao
      _studentsMarks[index]['marks'] = _maxMarks.toString();

      // optional: warning snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("marks cannot exceed max marks ($_maxMarks)"),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 1),
        ),
      );
    } else {
      _studentsMarks[index]['marks'] = value;
    }

    double percentage = (_maxMarks > 0) ? (enteredMarks / _maxMarks) * 100 : 0;

    setState(() {
      _studentsMarks[index]['percentage'] =
          percentage > 100 ? 100.0 : percentage;
      _studentsMarks[index]['grade'] =
          _calculateGrade(_studentsMarks[index]['percentage']);
    });
  }

  void _recalculateAll() {
    for (int i = 0; i < _studentsMarks.length; i++) {
      if (_studentsMarks[i]['marks'].isNotEmpty) {
        _updateStudentMarks(i, _studentsMarks[i]['marks']);
      }
    }
  }

  String _calculateGrade(double percentage) {
    if (percentage >= 90) return 'A+';
    if (percentage >= 80) return 'A';
    if (percentage >= 70) return 'B+';
    if (percentage >= 60) return 'B';
    if (percentage >= 35) return 'C'; // ✅ pass from 35%
    return 'F'; // ❌ fail below 35%
  }

  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A+':
        return Colors.green.shade700;
      case 'A':
        return Colors.green;
      case 'B+':
        return Colors.blue;
      case 'B':
        return Colors.blue.shade300;
      case 'C':
        return Colors.orange;
      case 'F':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // void _onBottomNavTapped(int index) {
  //   if (index == _currentIndex) return;
  //   setState(() => _currentIndex = index);
  //   switch (index) {
  //     case 0: Navigator.pushReplacementNamed(context, PrincipalRoutes.home); break;
  //     case 1: Navigator.pushNamed(context, PrincipalRoutes.search); break;
  //     case 3: Navigator.pushNamed(context, PrincipalRoutes.morePage); break;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildScreenshotHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    _buildStepHeader("1", "Configuration Settings"),
                    _buildConfigCard(),
                    const SizedBox(height: 25),
                    _buildStepHeader("2", "Input Students Marks"),
                    _buildStudentList(),
                    const SizedBox(height: 30),
                    _buildSaveButton(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: _buildScreenshotBottomNav(),
    );
  }

  // --- HEADER (AS PER SCREENSHOT) ---
  Widget _buildScreenshotHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        MediaQuery.of(context).padding.top + 0,
        20,
        10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(32),
        ),
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
                color: Color(0xFF1D4ED8),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // 🏫 Title + Subtitle
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Upload Grades',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Aditya International School',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),

          // 🌐 Language Toggle
          InkWell(
            onTap: _toggleLanguage,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _isTelugu ? 'తెలుగు' : 'English',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1D4ED8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepHeader(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18, left: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ✨ STEP BADGE
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: const Color(0xFFFBBF24),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFBBF24).withOpacity(0.35),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // ✨ STEP TITLE
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1E293B),
                letterSpacing: -0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfigCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
            color: const Color(0xFF1D4ED8)
                .withOpacity(0.08)), // Subtle blue border
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1D4ED8).withOpacity(0.04),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// CLASS SELECTION
          _buildModernLabel(Icons.class_rounded, "Target Class"),
          const SizedBox(height: 8),
          _buildModernDropdown(_selectedClass, _classes,
              (v) => setState(() => _selectedClass = v!)),

          const SizedBox(height: 20),

          /// SUBJECT SELECTION
          _buildModernLabel(Icons.book_rounded, "Subject"),
          const SizedBox(height: 8),
          _buildModernDropdown(_selectedSubject, _subjects,
              (v) => setState(() => _selectedSubject = v!)),

          const SizedBox(height: 20),

          /// ROW FOR TYPE AND MAX MARKS
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildModernLabel(Icons.assignment_rounded, "Exam Type"),
                    const SizedBox(height: 8),
                    _buildModernDropdown(_selectedExamType, _examTypes,
                        (v) => setState(() => _selectedExamType = v!)),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildModernLabel(Icons.bolt_rounded, "Max Marks"),
                    const SizedBox(height: 8),
                    _buildMaxMarksInput(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModernLabel(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF1D4ED8)),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: Color(0xFF334155),
          ),
        ),
      ],
    );
  }

// Helper: Styled Dropdown
  Widget _buildModernDropdown(
    String value,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => _openPickerSheet(
        title: "select option",
        items: items,
        selectedValue: value,
        onSelected: (v) => onChanged(v),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E293B),
                ),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down_rounded,
                color: Colors.blueGrey),
          ],
        ),
      ),
    );
  }

// Helper: Max Marks Input
  Widget _buildMaxMarksInput() {
    return TextField(
      controller: _maxMarksController,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: const TextStyle(fontWeight: FontWeight.w800),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildDropdownField(
    String label,
    String value,
    List<String> items,
    Function(String) onSelected,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " $label",
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
        const SizedBox(height: 6),
        InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _openPickerSheet(
            title: label,
            items: items,
            selectedValue: value,
            onSelected: onSelected,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.blueGrey,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _openPickerSheet({
    required String title,
    required List<String> items,
    required String selectedValue,
    required Function(String) onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SafeArea(
          top: false,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.55,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 12),

                // pull handle
                Container(
                  width: 44,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 18),

                // header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close_rounded),
                      ),
                    ],
                  ),
                ),

                const Divider(height: 1),

                // options list
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final bool isSelected = item == selectedValue;

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFEFF6FF)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF1D4ED8)
                                : Colors.grey.shade200,
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            item,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: isSelected
                                  ? const Color(0xFF1D4ED8)
                                  : const Color(0xFF1E293B),
                            ),
                          ),
                          trailing: isSelected
                              ? const Icon(
                                  Icons.check_circle_rounded,
                                  color: Color(0xFF1D4ED8),
                                )
                              : null,
                          onTap: () {
                            onSelected(item);
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStudentList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _studentsMarks.length,
      separatorBuilder: (_, __) =>
          const SizedBox(height: 12), // Spacing thodi badhai hai
      itemBuilder: (context, index) {
        final student = _studentsMarks[index];
        final bool hasMarks = student['marks'].isNotEmpty;
        final bool isError =
            hasMarks && (double.tryParse(student['marks']) ?? 0) > _maxMarks;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            // --- LIGHT BORDER ADDED HERE ---
            border: Border.all(
              color: isError
                  ? Colors.red.withOpacity(0.5)
                  : const Color(0xFFE2E8F0), // Ultra light slate border
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1E293B)
                    .withOpacity(0.03), // Bahut halki shadow
                blurRadius: 15,
                offset: const Offset(0, 6),
              )
            ],
          ),
          child: Row(
            children: [
              // 1. Student Avatar with Initial
              _buildStudentAvatar(index, student['name']),
              const SizedBox(width: 12),

              // 2. Name and Roll Number
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student['name'],
                      style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: Color(0xFF1E293B)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "ROLL NO: ${student['rollNumber']}",
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5),
                    ),
                  ],
                ),
              ),

              // 3. Marks Input Field
              _buildMarksInput(index, isError),

              const SizedBox(width: 12),

              // 4. Percentage & Grade Badge
              _buildGradeBadge(student, hasMarks),
            ],
          ),
        );
      },
    );
  }

// Helper: Student Avatar
  Widget _buildStudentAvatar(int index, String name) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: const Color(0xFF1D4ED8).withOpacity(0.05),
      child: Text(
        name[0], // First Letter
        style: const TextStyle(
            color: Color(0xFF1D4ED8),
            fontWeight: FontWeight.bold,
            fontSize: 14),
      ),
    );
  }

// Helper: Marks Input
  Widget _buildMarksInput(int index, bool isError) {
    return SizedBox(
      width: 75,
      child: TextField(
        onChanged: (v) => _updateStudentMarks(index, v),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 15,
          color: isError ? Colors.red : const Color(0xFF1D4ED8),
        ),
        decoration: InputDecoration(
          hintText: "00",
          hintStyle: TextStyle(color: Colors.grey.shade300, fontSize: 14),
          filled: true,
          fillColor:
              isError ? Colors.red.withOpacity(0.05) : const Color(0xFFF8FAFC),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
                color:
                    isError ? Colors.red.withOpacity(0.2) : Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
                color: isError ? Colors.red : const Color(0xFF1D4ED8)),
          ),
        ),
      ),
    );
  }

// Helper: Grade Badge
  Widget _buildGradeBadge(Map<String, dynamic> student, bool hasMarks) {
    return Column(
      children: [
        Text(
          hasMarks ? '${student['percentage'].toStringAsFixed(0)}%' : '--',
          style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 13,
              color: Color(0xFF1E293B)),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getGradeColor(student['grade']).withOpacity(0.12),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            student['grade'],
            style: TextStyle(
              color: _getGradeColor(student['grade']),
              fontWeight: FontWeight.w900,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
      height: 58,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: const Color(0xFF1D4ED8).withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8))
      ]),
      child: ElevatedButton(
        onPressed: _isSaving
            ? null
            : () {
                setState(() => _isSaving = true);
                Future.delayed(const Duration(seconds: 2), () {
                  setState(() => _isSaving = false);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Grades Synchronized!"),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating));
                });
              },
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1D4ED8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            elevation: 0),
        child: _isSaving
            ? const CircularProgressIndicator(
                color: Colors.white, strokeWidth: 3)
            : const Text("Save Grades",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontSize: 16)),
      ),
    );
  }

  // Widget _buildScreenshotBottomNav() {
  //   return Container(
  //     decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey.shade100, width: 1.5))),
  //     child: BottomNavigationBar(
  //       currentIndex: _currentIndex,
  //       onTap: _onBottomNavTapped,
  //       type: BottomNavigationBarType.fixed,
  //       selectedItemColor: const Color(0xFF1D4ED8),
  //       unselectedItemColor: const Color(0xFF64748B),
  //       backgroundColor: Colors.white,
  //       elevation: 0,
  //       selectedFontSize: 12,
  //       unselectedFontSize: 12,
  //       selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
  //       items: const [
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.home_rounded),
  //           label: "Home",
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.search_rounded),
  //           label: "Search",
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.analytics_rounded),
  //           label: "Activity",
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.grid_view_rounded),
  //           label: "More",
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
