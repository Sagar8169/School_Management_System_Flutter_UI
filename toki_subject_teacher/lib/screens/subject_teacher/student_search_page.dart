import 'package:flutter/material.dart';
import '../../routes/subject_teacher_routes.dart';

class StudentSearchPage extends StatefulWidget {
  const StudentSearchPage({super.key});

  @override
  State<StudentSearchPage> createState() => _StudentSearchPageState();
}

class _StudentSearchPageState extends State<StudentSearchPage> {
  String _selectedFilter = "All Students";
  bool _isTelugu = true;
  final TextEditingController _searchController = TextEditingController();

  final Color _primaryPurple = const Color(0xFF7C3AED);
  final Color _scaffoldBg = const Color(0xFFF1F5F9);

  final List<String> _filters = [
    "All Students",
    "Class 8A",
    "Class 9A",
    "Class 10A",
    "Class 12A",
  ];

  final List<Map<String, dynamic>> _students = [
    {
      'name': 'Rajesh Singh',
      'grade': '10A', // Logic uses this for filtering
      'id': 'STU-2021-001',
      'avgGrade': 45.0,
      'attendance': 78.0,
      'status': 'Critical',
      'isCritical': true,
    },
    {
      'name': 'Rachit Pandey',
      'grade': '9B',
      'id': 'STU-2022-042',
      'avgGrade': 82.0,
      'attendance': 92.0,
      'status': 'Normal',
      'isCritical': false,
    },
    {
      'name': 'Kiriti Rai',
      'grade': '8A',
      'id': 'STU-2023-085',
      'avgGrade': 78.0,
      'attendance': 88.0,
      'status': 'Normal',
      'isCritical': false,
    },
    {
      'name': 'Priya Sharma',
      'grade': '8A',
      'id': 'STU-2022-012',
      'avgGrade': 35.0,
      'attendance': 65.0,
      'status': 'Critical',
      'isCritical': true,
    },
    {
      'name': 'Amit Kumar',
      'grade': '12A',
      'id': 'STU-2019-123',
      'avgGrade': 85.0,
      'attendance': 95.0,
      'status': 'Normal',
      'isCritical': false,
    },
  ];

  void _toggleLanguage() {
    setState(() => _isTelugu = !_isTelugu);
  }

  void _navigateTo(String routeName, {Map<String, dynamic>? arguments}) {
    if (arguments != null) {
      Navigator.pushNamed(context, routeName, arguments: arguments);
    } else {
      Navigator.pushNamed(context, routeName);
    }
  }

  // ✅ Working Filter Logic
  void _onFilterSelected(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  void _onStudentTap(Map<String, dynamic> studentData) {
    _navigateTo(SubjectTeacherRoutes.studentProfile, arguments: studentData);
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Logic to filter students based on selected tab
    final List<Map<String, dynamic>> filteredStudents =
        _students.where((student) {
      if (_selectedFilter == "All Students") return true;
      // Extract numeric+alpha part like '8A' from 'Class 8A' to match '8A' in data
      String filterValue = _selectedFilter.replaceAll("Class ", "");
      return student['grade'] == filterValue;
    }).toList();

    return Scaffold(
      backgroundColor: _scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildExactHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildModernSearchBar(),
                    const SizedBox(height: 20),

                    // Filter Tabs
                    SizedBox(
                      height: 38,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 16),
                        itemCount: _filters.length,
                        itemBuilder: (context, index) {
                          final tab = _filters[index];
                          final bool isSelected = tab == _selectedFilter;
                          return GestureDetector(
                            onTap: () => _onFilterSelected(tab),
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color:
                                    isSelected ? _primaryPurple : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: isSelected
                                        ? _primaryPurple
                                        : Colors.grey.shade300),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                tab,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.grey.shade700,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ✅ List now uses filteredStudents
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filteredStudents.length,
                      itemBuilder: (context, index) =>
                          _buildModernStudentCard(filteredStudents[index]),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- UI Components below remain same for consistency ---

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
          const Expanded(
              child: Text("Search Students",
                  style: TextStyle(
                      color: Color(0xFF1E293B),
                      fontSize: 18,
                      fontWeight: FontWeight.bold))),
          GestureDetector(
            onTap: _toggleLanguage,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                  border: Border.all(color: _primaryPurple.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(_isTelugu ? 'తెలుగు' : 'English',
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

  Widget _buildModernSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4))
          ],
        ),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: "Search students...",
            prefixIcon: Icon(Icons.search, color: _primaryPurple),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildModernStudentCard(Map<String, dynamic> student) {
    final bool isCritical = student['isCritical'] as bool;
    final Color statusColor =
        isCritical ? const Color(0xFFEF4444) : const Color(0xFF10B981);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4))
          ]),
      child: InkWell(
        onTap: () => _onStudentTap(student),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12)),
                    child: Icon(Icons.person_outline_rounded,
                        color: statusColor, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(student['name'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xFF1E293B))),
                        Text("${student['grade']} • ${student['id']}",
                            style: TextStyle(
                                color: Colors.grey.shade500, fontSize: 12)),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(student['status'],
                        style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 11)),
                  ),
                ],
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _miniStat("Avg Grade", "${student['avgGrade']}%",
                      _getGradeColor(student['avgGrade'])),
                  _miniStat("Attendance", "${student['attendance']}%",
                      _getAttendanceColor(student['attendance'])),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _miniStat(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11)),
        const SizedBox(height: 2),
        Text(value,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14, color: color)),
      ],
    );
  }

  Color _getGradeColor(double grade) {
    if (grade < 40) return const Color(0xFFEF4444);
    if (grade < 70) return const Color(0xFFF59E0B);
    return const Color(0xFF10B981);
  }

  Color _getAttendanceColor(double att) {
    if (att < 75) return const Color(0xFFEF4444);
    return const Color(0xFF10B981);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
