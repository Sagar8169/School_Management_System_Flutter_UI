import 'package:flutter/material.dart';
import '../../routes/subject_teacher_routes.dart';

class TeacherSearchPage extends StatefulWidget {
  const TeacherSearchPage({super.key});

  @override
  State<TeacherSearchPage> createState() => _TeacherSearchPageState();
}

class _TeacherSearchPageState extends State<TeacherSearchPage> {
  int _currentIndex = 1;
  bool _isTelugu = true;
  String _selectedFilter = "All Teachers";
  final TextEditingController _searchController = TextEditingController();

  final List<String> _filters = [
    "All Teachers",
    "Science",
    "Mathematics",
    "English",
    "Hindi",
  ];

  final List<Map<String, dynamic>> _teachers = [
    {
      'name': 'Mr. Vijay Prasad',
      'role': 'Science Teacher',
      'employeeId': 'ST2024',
      'department': 'Science',
      'type': 'teacher',
      'isActive': true,
      'assignedClass': '8B, 9A, 10C',
      'subjects': 'Science',
      'phone': '+91 98765 43210',
      'email': 'vijay.prasad@adityaschool.edu',
      'experience': '8 years',
    },
    {
      'name': 'Miss Raghini Sharma',
      'role': 'Mathematics Teacher',
      'employeeId': 'ST2025',
      'department': 'Mathematics',
      'type': 'teacher',
      'isActive': true,
      'assignedClass': '8A, 9B',
      'subjects': 'Mathematics',
      'phone': '+91 98765 43211',
      'email': 'raghini.sharma@adityaschool.edu',
      'experience': '6 years',
    },
    {
      'name': 'Mrs. Priya Singh',
      'role': 'English Teacher',
      'employeeId': 'ST2026',
      'department': 'English',
      'type': 'teacher',
      'isActive': true,
      'assignedClass': '10A, 11B',
      'subjects': 'English',
      'phone': '+91 98765 43212',
      'email': 'priya.singh@adityaschool.edu',
      'experience': '10 years',
    },
    {
      'name': 'Mr. Rajesh Kumar',
      'role': 'Hindi Teacher',
      'employeeId': 'ST2027',
      'department': 'Languages',
      'type': 'teacher',
      'isActive': true,
      'assignedClass': '9A, 10C',
      'subjects': 'Hindi',
      'phone': '+91 98765 43213',
      'email': 'rajesh.kumar@adityaschool.edu',
      'experience': '7 years',
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
          SubjectTeacherRoutes.home,
              (route) => false,
        );
        break;
      case 1:
      // Already on search
        break;
      case 2:
        _navigateTo(SubjectTeacherRoutes.activity);
        break;
      case 3:
        _navigateTo(SubjectTeacherRoutes.settings);
        break;
    }
  }

  void _onTeacherTap(Map<String, dynamic> teacherData) {
    _navigateTo(SubjectTeacherRoutes.teacherProfile, arguments: teacherData);
  }

  @override
  Widget build(BuildContext context) {
    // Filter teachers based on selected tab
    List<Map<String, dynamic>> visibleTeachers = _teachers.where((teacher) {
      if (_selectedFilter == "All Teachers") return true;
      return teacher['department'] == _selectedFilter ||
          teacher['subjects'] == _selectedFilter;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: Column(
          children: [
            // Header Section for Subject Teacher
            _buildSubjectTeacherHeader(),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    // Title Row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.black12.withOpacity(0.08),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.arrow_back, size: 20),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Search Teachers',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Search Box
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                decoration: const InputDecoration(
                                  hintText: "Search teachers...",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                            const Icon(Icons.search, color: Colors.grey, size: 22),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Horizontal Tabs
                    Container(
                      height: 40,
                      padding: const EdgeInsets.only(left: 16),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: _filters.map((tab) {
                          final bool isSelected = tab == _selectedFilter;

                          return GestureDetector(
                            onTap: () => _onFilterSelected(tab),
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF7C3AED)
                                    : const Color(0xFFF1F3F6),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                tab,
                                style: TextStyle(
                                  color:
                                  isSelected ? Colors.white : Colors.black87,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // TEACHER CARDS
                    Column(
                      children: visibleTeachers.map((teacherData) {
                        return _buildTeacherCard(teacherData);
                      }).toList(),
                    ),

                    const SizedBox(height: 20),
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

  Widget _buildSubjectTeacherHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF7C3AED),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Subject Teacher',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Aditya International School',
                  style: TextStyle(
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Text(
                _isTelugu ? 'తెలుగు' : 'English',
                style: const TextStyle(
                  color: Color(0xFF7C3AED),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeacherCard(Map<String, dynamic> teacherData) {
    final bool isActive = teacherData['isActive'] as bool;
    final Color statusColor = isActive ? const Color(0xFF27AE60) : const Color(0xFFE6A100);
    final Color statusBgColor = isActive ? const Color(0xFFE5FFF0) : const Color(0xFFFFF4D9);
    final String statusText = isActive ? 'Active' : 'Not Active';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => _onTeacherTap(teacherData),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.black12, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Avatar
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3D9),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      Icons.person,
                      color: Colors.orange[700],
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          teacherData['name'].toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          teacherData['role'].toString(),
                          style: const TextStyle(
                            fontSize: 13,
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
                      statusText,
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
              Container(
                height: 1,
                color: Colors.black12,
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Department",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        teacherData['department'].toString(),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "Employee ID",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        teacherData['employeeId'].toString(),
                        style: const TextStyle(
                          color: Color(0xFF7C3AED),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                "Subjects: ${teacherData['subjects']}",
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Classes: ${teacherData['assignedClass']}",
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onBottomNavTapped,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF7C3AED),
      unselectedItemColor: const Color(0xFF6B7280),
      selectedLabelStyle:
      const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
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
          icon: Icon(Icons.show_chart_outlined),
          activeIcon: Icon(Icons.show_chart),
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