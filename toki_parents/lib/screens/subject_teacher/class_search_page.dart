import 'package:flutter/material.dart';
import '../../routes/subject_teacher_routes.dart';

class ClassSearchPage extends StatefulWidget {
  const ClassSearchPage({super.key});

  @override
  State<ClassSearchPage> createState() => _ClassSearchPageState();
}

class _ClassSearchPageState extends State<ClassSearchPage> {
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

  final List<Map<String, dynamic>> _classes = [
    {
      'className': 'Class 8A',
      'section': 'Section A',
      'teacher': 'Miss Raghini Sharma',
      'avgGrade': 82.0,
      'totalStudents': 42,
      'circle': '8A',
    },
    {
      'className': 'Class 12B',
      'section': 'Section B',
      'teacher': 'Mr. Rajesh Kumar',
      'avgGrade': 78.0,
      'totalStudents': 38,
      'circle': '12B',
    },
    {
      'className': 'Class 12A',
      'section': 'Section A',
      'teacher': 'Mrs. Priya Singh',
      'avgGrade': 85.0,
      'totalStudents': 45,
      'circle': '12A',
    },
    {
      'className': 'Class 11',
      'section': 'Science Stream',
      'teacher': 'Mr. Amit Verma',
      'avgGrade': 76.0,
      'totalStudents': 40,
      'circle': '11',
    },
    {
      'className': 'Class 10B',
      'section': 'Section B',
      'teacher': 'Mrs. Sneha Reddy',
      'avgGrade': 80.0,
      'totalStudents': 43,
      'circle': '10B',
    },
    {
      'className': 'Class 9A',
      'section': 'Section A',
      'teacher': 'Mr. Suresh Patel',
      'avgGrade': 79.5,
      'totalStudents': 41,
      'circle': '9A',
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

  void _onClassTap(Map<String, dynamic> classData) {
    _navigateTo(SubjectTeacherRoutes.classDetails, arguments: classData);
  }

  @override
  Widget build(BuildContext context) {
    // Filter classes based on selected tab
    List<Map<String, dynamic>> visibleClasses = _classes.where((classData) {
      if (_selectedFilter == "All Classes") return true;
      return classData['className'] == _selectedFilter;
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
                            'Search Classes',
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
                                  hintText: "Search classes...",
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

                    // CLASS CARDS
                    Column(
                      children: visibleClasses.map((classData) {
                        return _buildClassCard(classData);
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
          Container(
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
        ],
      ),
    );
  }

  Widget _buildClassCard(Map<String, dynamic> classData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => _onClassTap(classData),
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
                  // ROUND PURPLE CLASS TAG
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3E8FF),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      classData['circle'].toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF7C3AED),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        classData['className'].toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        classData['section'].toString(),
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "Avg Grade",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        "${classData['avgGrade']}%",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF7C3AED),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                "Class Teacher",
                style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 4),
              Text(
                classData['teacher'].toString(),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
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