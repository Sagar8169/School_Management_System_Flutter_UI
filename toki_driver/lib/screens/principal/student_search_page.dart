import 'package:flutter/material.dart';
import '../../widgets/common_widgets.dart';
import '../../routes/principal_routes.dart';

class StudentSearchPage extends StatefulWidget {
  const StudentSearchPage({super.key});

  @override
  State<StudentSearchPage> createState() => _StudentSearchPageState();
}

class _StudentSearchPageState extends State<StudentSearchPage> {
  int _currentIndex = 1;
  String _selectedFilter = "Class 8A";
  bool _isTelugu = true;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _filters = [
    "All Classes",
    "Class 8A",
    "Class 12B",
    "Class 10A",
    "Class 9A",
  ];

  final List<Map<String, dynamic>> _students = [
    {
      'name': 'Rajesh Singh',
      'grade': '10A',
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
    setState(() {
      _isTelugu = !_isTelugu;
    });
  }

  void _navigateTo(String routeName, {Map<String, dynamic>? arguments}) {
    if (arguments != null) {
      Navigator.pushNamed(context, routeName, arguments: arguments);
    } else {
      Navigator.pushNamed(context, routeName);
    }
  }

  void _onFilterSelected(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.of(context).pushNamedAndRemoveUntil(
          PrincipalRoutes.home,
              (route) => false,
        );
        break;
      case 1:
      // Already on search
        break;
      case 2:
        _navigateTo(PrincipalRoutes.activity);
        break;
      case 3:
        _navigateTo(
          PrincipalRoutes.morePage,
          arguments: {'section': null},
        );
        break;
    }
  }

  void _onStudentTap(Map<String, dynamic> studentData) {
    _navigateTo(PrincipalRoutes.studentProfile, arguments: studentData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: Column(
          children: [
            // Header Section (Keeping your original header)
            CommonWidgets.appHeader(
              selectedLanguage: _isTelugu ? 'తెలుగు' : 'English',
              onLanguageToggle: _toggleLanguage,
            ),
            const SizedBox(height: 12),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back + Title Row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.black12.withOpacity(0.06),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.arrow_back, size: 18),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Search Students',
                            style: CommonWidgets.headlineMedium().copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Search Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Container(
                        height: 46,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.black12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12.withOpacity(0.03),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                decoration: const InputDecoration(
                                  hintText: "search for any profiles",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            const Icon(Icons.search, color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Tabs
                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, i) {
                          String tab = _filters[i];
                          bool selected = tab == _selectedFilter;

                          return GestureDetector(
                            onTap: () => _onFilterSelected(tab),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: selected
                                    ? const Color(0xFF2962FF)
                                    : const Color(0xFFF2F4F7),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  tab,
                                  style: TextStyle(
                                    color:
                                    selected ? Colors.white : Colors.black87,
                                    fontWeight: selected
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (_, __) =>
                        const SizedBox(width: 10),
                        itemCount: _filters.length,
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Student Cards
                    Column(
                      children: [
                        for (var student in _students) _buildStudentCard(student),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildStudentCard(Map<String, dynamic> student) {
    final bool isCritical = student['isCritical'] as bool;
    final Color statusColor = isCritical
        ? const Color(0xFFD9534F)
        : const Color(0xFF2ECC71);
    final Color statusBgColor = isCritical
        ? const Color(0xFFFFE5E5)
        : const Color(0xFFE5FFF0);
    final Color avgColor = _getGradeColor(student['avgGrade']);
    final Color attColor = _getAttendanceColor(student['attendance']);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => _onStudentTap(student),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.black12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.03),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Avatar Box
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8FFF2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Name + ID
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          student['name'].toString(),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "${student['grade']} • ${student['id']}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Status Chip
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusBgColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      student['status'].toString(),
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Avg Grade
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Avg Grade",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "${student['avgGrade']}%",
                        style: TextStyle(
                          color: avgColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  // Attendance
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "Attendance",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "${student['attendance']}%",
                        style: TextStyle(
                          color: attColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getGradeColor(double grade) {
    if (grade < 40) return const Color(0xFFDC2626);
    if (grade < 60) return const Color(0xFFD97706);
    if (grade < 80) return const Color(0xFF2563EB);
    return const Color(0xFF16A34A);
  }

  Color _getAttendanceColor(double attendance) {
    if (attendance < 75) return const Color(0xFFDC2626);
    if (attendance < 85) return const Color(0xFFD97706);
    return const Color(0xFF16A34A);
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onBottomNavTapped,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF2962FF),
      unselectedItemColor: const Color(0xFF6B7280),
      selectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          activeIcon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics_outlined),
          activeIcon: Icon(Icons.analytics),
          label: 'Activity',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz_outlined),
          activeIcon: Icon(Icons.more_horiz),
          label: 'More',
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}