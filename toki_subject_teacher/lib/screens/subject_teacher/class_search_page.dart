import 'package:flutter/material.dart';
import '../../routes/subject_teacher_routes.dart';

class ClassSearchPage extends StatefulWidget {
  const ClassSearchPage({super.key});

  @override
  State<ClassSearchPage> createState() => _ClassSearchPageState();
}

class _ClassSearchPageState extends State<ClassSearchPage> {
  String _selectedFilter = "All Classes";
  bool _isTelugu = true;
  final TextEditingController _searchController = TextEditingController();

  // Theme Colors
  final Color _primaryPurple = const Color(0xFF7C3AED);
  final Color _scaffoldBg = const Color(0xFFF1F5F9);

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
    setState(() => _isTelugu = !_isTelugu);
  }

  void _navigateTo(String routeName, {Map<String, dynamic>? arguments}) {
    if (arguments != null) {
      Navigator.pushNamed(context, routeName, arguments: arguments);
    } else {
      Navigator.pushNamed(context, routeName);
    }
  }

  void _onFilterSelected(String filter) {
    setState(() => _selectedFilter = filter);
  }

  void _onClassTap(Map<String, dynamic> classData) {
    _navigateTo(SubjectTeacherRoutes.classDetails, arguments: classData);
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> visibleClasses = _classes.where((classData) {
      if (_selectedFilter == "All Classes") return true;
      return classData['className'] == _selectedFilter;
    }).toList();

    return Scaffold(
      backgroundColor: _scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildExactHeader(), // ✅ Header mein hi Back button aur Title hai

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20), // Top spacing fixed

                    // Modern Search Box
                    Padding(
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
                            hintText: "Search classes...",
                            prefixIcon:
                                Icon(Icons.search, color: _primaryPurple),
                            border: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Modern Filter Tabs
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

                    // Modern Class Cards
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: visibleClasses.length,
                      itemBuilder: (context, index) =>
                          _buildModernClassCard(visibleClasses[index]),
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

  // --- UPDATED HEADER: Removed ST box and added title with back button ---
  Widget _buildExactHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _primaryPurple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.arrow_back_ios_new_rounded,
                  color: _primaryPurple, size: 20),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              "Search Classes",
              style: TextStyle(
                color: Color(0xFF1E293B),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: _toggleLanguage,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: _primaryPurple.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _isTelugu ? 'తెలుగు' : 'English',
                style: TextStyle(
                    color: _primaryPurple,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernClassCard(Map<String, dynamic> classData) {
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
        ],
      ),
      child: InkWell(
        onTap: () => _onClassTap(classData),
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
                        color: _primaryPurple.withOpacity(0.1),
                        shape: BoxShape.circle),
                    child: Center(
                      child: Text(classData['circle'].toString(),
                          style: TextStyle(
                              color: _primaryPurple,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(classData['className'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xFF1E293B))),
                        Text(classData['section'],
                            style: TextStyle(
                                color: Colors.grey.shade500, fontSize: 12)),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text("${classData['avgGrade']}%",
                        style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 12)),
                  ),
                ],
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Class Teacher",
                          style: TextStyle(color: Colors.grey, fontSize: 11)),
                      Text(classData['teacher'],
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: Color(0xFF334155))),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text("Students",
                          style: TextStyle(color: Colors.grey, fontSize: 11)),
                      Text("${classData['totalStudents']}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: Color(0xFF334155))),
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
