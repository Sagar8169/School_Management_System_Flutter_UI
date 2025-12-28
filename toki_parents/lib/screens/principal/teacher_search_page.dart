import 'package:flutter/material.dart';
import '../../widgets/common_widgets.dart';
import '../../routes/principal_routes.dart';

class TeacherSearchPage extends StatefulWidget {
  const TeacherSearchPage({super.key});

  @override
  State<TeacherSearchPage> createState() => _TeacherSearchPageState();
}

class _TeacherSearchPageState extends State<TeacherSearchPage> {
  int _currentIndex = 1;
  String _selectedFilter = "All Classes";
  bool _isTelugu = true;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _filters = [
    "All Classes",
    "Class 8A",
    "Class 12B",
    "Class 12A",
    "Class 11",
    "Class 10B",
  ];

  final List<Map<String, dynamic>> _teachers = [
    {
      'name': 'Mr. Rachit Rai',
      'subject': 'English',
      'role': 'Class Teacher',
      'classes': '8A, 9A',
      'experience': '8 years',
      'isClassTeacher': true,
    },
    {
      'name': 'Mrs. Ruchita Rai',
      'subject': 'Mathematics',
      'role': 'Subject Teacher',
      'classes': '10A, 11, 12A',
      'experience': '6 years',
      'isClassTeacher': false,
    },
    {
      'name': 'Miss Raghini Sharma',
      'subject': 'Mathematics',
      'role': 'Class Teacher',
      'classes': '8A, 9B',
      'experience': '8 years',
      'isClassTeacher': true,
    },
    {
      'name': 'Mr. Rajesh Kumar',
      'subject': 'Science',
      'role': 'Subject Teacher',
      'classes': '9A, 10A, 11',
      'experience': '10 years',
      'isClassTeacher': false,
    },
    {
      'name': 'Mrs. Priya Singh',
      'subject': 'Social Studies',
      'role': 'Class Teacher',
      'classes': '12A',
      'experience': '12 years',
      'isClassTeacher': true,
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

  void _onTeacherTap(Map<String, dynamic> teacherData) {
    _navigateTo(PrincipalRoutes.teacherProfile, arguments: teacherData);
  }

  @override
  Widget build(BuildContext context) {
    // Filter teachers based on selected tab
    List<Map<String, dynamic>> visibleTeachers = _teachers.where((teacher) {
      if (_selectedFilter == "All Classes") return true;
      return (teacher['classes'] as String).contains(_selectedFilter.split(' ').last);
    }).toList();

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

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    // Title + back (matches screenshot style)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                            'Search Teachers',
                            style: CommonWidgets.headlineMedium().copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Search box
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        height: 46,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
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
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            const Icon(Icons.search, color: Colors.grey),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // horizontal tabs
                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        scrollDirection: Axis.horizontal,
                        itemCount: _filters.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (ctx, i) {
                          final tab = _filters[i];
                          final bool isSelected = tab == _selectedFilter;
                          return GestureDetector(
                            onTap: () => _onFilterSelected(tab),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF2962FF)
                                    : const Color(0xFFF1F3F6),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
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
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // teacher cards list
                    Column(
                      children: visibleTeachers.map((teacher) {
                        return _buildTeacherCard(teacher);
                      }).toList(),
                    ),

                    const SizedBox(height: 40),
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

  Widget _buildTeacherCard(Map<String, dynamic> teacher) {
    final bool isClassTeacher = teacher['isClassTeacher'] as bool;
    final String initials = teacher['name']
        .toString()
        .split(' ')
        .map((s) => s.isNotEmpty ? s[0] : '')
        .take(2)
        .join();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: InkWell(
        onTap: () => _onTeacherTap(teacher),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // top row: avatar + name + tag
              Row(
                children: [
                  // avatar circle
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF1F1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        initials,
                        style: const TextStyle(
                          color: Color(0xFFD35400),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // name + subject
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          teacher['name'].toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          teacher['subject'].toString(),
                          style: const TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  // Tag (role)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isClassTeacher
                          ? const Color(0xFFF1F6FF)
                          : const Color(0xFFF2F4F7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      teacher['role'].toString(),
                      style: TextStyle(
                        color: isClassTeacher
                            ? const Color(0xFF2962FF)
                            : const Color(0xFF6B7280),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // classes & experience row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Classes",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          teacher['classes'].toString(),
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "Experience",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        teacher['experience'].toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2962FF),
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