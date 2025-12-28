import 'package:flutter/material.dart';
import '../../routes/subject_teacher_routes.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _currentIndex = 1; // Search page active
  bool _isTelugu = true;
  final TextEditingController _searchController = TextEditingController();

  // Theme Colors
  final Color _primaryPurple = const Color(0xFF7C3AED);
  final Color _scaffoldBg = const Color(0xFFF1F5F9);

  final List<Map<String, dynamic>> _categories = [
    {
      'title': 'Class',
      'subtitle': 'Search for classes and their sections',
      'icon': Icons.class_outlined,
      'iconColor': Colors.black87,
      'bgColor': const Color(0xFFEAF2FF),
      'route': SubjectTeacherRoutes.classSearch,
    },
    {
      'title': 'Teachers',
      'subtitle': 'Search for Teachers',
      'icon': Icons.group_outlined,
      'iconColor': Colors.black87,
      'bgColor': const Color(0xFFFFEFE3),
      'route': SubjectTeacherRoutes.teacherSearch,
    },
    {
      'title': 'Students',
      'subtitle': 'Search for students',
      'icon': Icons.person_2_outlined,
      'iconColor': Colors.black87,
      'bgColor': const Color(0xFFE4FAEB),
      'route': SubjectTeacherRoutes.studentSearch,
    },
  ];

  // LOGIC: Language Toggle (Same as before)
  void _toggleLanguage() {
    setState(() {
      _isTelugu = !_isTelugu;
    });
  }

  // LOGIC: Navigation (Same as before)
  void _navigateTo(String routeName, {Map<String, dynamic>? arguments}) {
    if (arguments != null) {
      Navigator.pushNamed(context, routeName, arguments: arguments);
    } else {
      Navigator.pushNamed(context, routeName);
    }
  }

  // LOGIC: Bottom Nav (Same as before)
  void _onBottomNavTapped(int index) {
    if (_currentIndex == index) return;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _scaffoldBg, // Clean background
      body: SafeArea(
        child: Column(
          children: [
            _buildExactHeader(), // Previous code header logic

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // Modern Page Title
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "Search",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Modern Search Input
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        height: 54,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _searchController,
                          style: const TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            hintText: "Search for classes, teachers, or students",
                            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                            prefixIcon: Icon(Icons.search, color: _primaryPurple),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "Browse by Category",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Categories List using same logic map
                    ..._categories.map((category) => _buildCategoryCardWithUI(category)),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildSubjectTeacherBottomNavigationBar(),
    );
  }

  // HEADER: EXACT AS PREVIOUS CODE
  Widget _buildExactHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
                color: _primaryPurple,
                borderRadius: BorderRadius.circular(8)
            ),
            child: const Center(
                child: Text("ST", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14))
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Subject Teacher", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold)),
                Text("Aditya International School", style: TextStyle(color: Colors.grey, fontSize: 10)),
              ],
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
                  style: TextStyle(color: _primaryPurple, fontSize: 12, fontWeight: FontWeight.bold)
              ),
            ),
          ),
        ],
      ),
    );
  }

  // CATEGORY CARDS: Modern UI, Same Logic
  Widget _buildCategoryCardWithUI(Map<String, dynamic> category) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
      child: InkWell(
        onTap: () => _navigateTo(category['route']),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: category['bgColor'] as Color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  category['icon'] as IconData,
                  color: category['iconColor'] as Color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category['title'].toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      category['subtitle'].toString(),
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey.shade300),
            ],
          ),
        ),
      ),
    );
  }

  // BOTTOM NAV: Same Logic and Labels
  Widget _buildSubjectTeacherBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onBottomNavTapped,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: _primaryPurple,
      unselectedItemColor: const Color(0xFF94A3B8),
      selectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          activeIcon: Icon(Icons.search_rounded),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics_outlined),
          activeIcon: Icon(Icons.analytics_rounded),
          label: 'Activity',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz_outlined),
          activeIcon: Icon(Icons.more_horiz_rounded),
          label: 'More',
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose(); // Logic preserved
    super.dispose();
  }
}