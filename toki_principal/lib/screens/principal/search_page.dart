import 'package:flutter/material.dart';
import '../../widgets/common_widgets.dart';
import '../../routes/principal_routes.dart';

const Color themeBlue = Color(0xFF1E3A8A);
const Color themeLightBlue = Color(0xFF3B82F6);
const Color themeGreen = Color(0xFF059669);
const Color backgroundSlate = Color(0xFFF8FAFC);

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, dynamic>> _filteredCategories = [];

  // int _currentIndex = 1;
  bool _isTelugu = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredCategories = List.from(_categories);
  }

  final List<Map<String, dynamic>> _categories = [
    {
      'title': 'Class',
      'subtitle': 'Search for classes and sections',
      'icon': Icons.school_outlined,
      'iconColor': Color(0xFF1D4ED8),
      'bgColor': Color(0xFFEFF6FF),
      'route': PrincipalRoutes.classSearch,
    },
    {
      'title': 'Teachers',
      'subtitle': 'Manage teacher profiles',
      'icon': Icons.supervisor_account_outlined,
      'iconColor': Color(0xFF7C3AED),
      'bgColor': Color(0xFFF5F3FF),
      'route': PrincipalRoutes.teacherSearch,
    },
    {
      'title': 'Staffs',
      'subtitle': 'Admin, Drivers, and Managers',
      'icon': Icons.badge_outlined,
      'iconColor': Color(0xFFD97706),
      'bgColor': Color(0xFFFFFBEB),
      'route': PrincipalRoutes.staffSearch,
    },
    {
      'title': 'Students',
      'subtitle': 'Find student academic records',
      'icon': Icons.face_outlined,
      'iconColor': Color(0xFF059669),
      'bgColor': Color(0xFFECFDF5),
      'route': PrincipalRoutes.studentSearch,
    },
  ];

  Widget _langTogglePill() {
    return GestureDetector(
      onTap: _toggleLanguage,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6FF),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFDBEAFE)),
        ),
        child: Text(_isTelugu ? "తెలుగు" : "English",
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: Color(0xFF3B82F6))),
      ),
    );
  }

  void _toggleLanguage() {
    setState(() => _isTelugu = !_isTelugu);
  }
  // void _onBottomNavTap(int index) {
  //   switch (index) {
  //     case 0:
  //       Navigator.pushReplacementNamed(context, PrincipalRoutes.home);
  //       break;
  //     case 1:
  //       Navigator.pushReplacementNamed(context, PrincipalRoutes.search);
  //       break;
  //     case 2:
  //       Navigator.pushReplacementNamed(context, PrincipalRoutes.activity);
  //       break;
  //     case 3:
  //       Navigator.pushReplacementNamed(
  //         context,
  //         PrincipalRoutes.morePage,
  //         arguments: {'section': null},
  //       );
  //       break;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ✨ Premium Custom Header
            _buildCustomHeader(),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      "Global Search",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0F172A)),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Search for any profiles across the campus",
                      style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
                    ),

                    const SizedBox(height: 25),

                    // ✨ Modern Search Bar
                    _buildSearchBar(),

                    const SizedBox(height: 30),

                    const Text(
                      "Browse by Category",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF334155)),
                    ),

                    const SizedBox(height: 15),

                    // ✨ Categories List
                    ..._filteredCategories
                        .map((cat) => _buildCategoryCard(cat)),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: _buildModernBottomNav(),
    );
  }

  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCategories = List.from(_categories);
      } else {
        _filteredCategories = _categories.where((cat) {
          final title = cat['title'].toString().toLowerCase();
          final subtitle = cat['subtitle'].toString().toLowerCase();
          final q = query.toLowerCase();

          return title.contains(q) || subtitle.contains(q);
        }).toList();
      }
    });
  }

  Widget _buildCustomHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [themeBlue, themeLightBlue]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
                child: Text("A",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20))),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Aditya International School",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1E293B))),
                  Text("Powered by Toki Tech",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                ]),
          ),
          _langTogglePill(),
        ],
      ),
    );
  }

  Widget _buildLanguagePill() {
    return InkWell(
      onTap: _toggleLanguage,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(30)),
        child: Text(_isTelugu ? 'తెలుగు' : 'English',
            style: const TextStyle(
                color: Color(0xFF1D4ED8),
                fontWeight: FontWeight.bold,
                fontSize: 12)),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 15,
              offset: const Offset(0, 8))
        ],
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged, // 🔥 THIS WAS MISSING
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          hintText: "Search students, roll no, teachers...",
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          prefixIcon: const Icon(Icons.search_rounded,
              color: Color(0xFF1D4ED8), size: 22),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> cat) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, cat['route']),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),

            // ✅ CLEAN CARD BORDER (exact card edge)
            border: Border.all(
              color: const Color(0xFFE2E8F0), // better than F1F5F9
              width: 1,
            ),

            // very subtle elevation (optional but recommended)
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1E293B).withOpacity(0.02),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: cat['bgColor'],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  cat['icon'],
                  color: cat['iconColor'],
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cat['title'],
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      cat['subtitle'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFFCBD5E1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildModernBottomNav() {
  //   return BottomNavigationBar(
  //     currentIndex: _currentIndex,
  //     onTap: _onBottomNavTap,
  //     type: BottomNavigationBarType.fixed,
  //     selectedItemColor: const Color(0xFF1D4ED8),
  //     unselectedItemColor: const Color(0xFF94A3B8),
  //     showUnselectedLabels: true,
  //     selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
  //     unselectedLabelStyle: const TextStyle(fontSize: 11),
  //     items: const [
  //       BottomNavigationBarItem(icon: Icon(Icons.home_rounded), activeIcon: Icon(Icons.home_filled), label: 'Home'),
  //       BottomNavigationBarItem(icon: Icon(Icons.search_rounded), activeIcon: Icon(Icons.search), label: 'Search'),
  //       BottomNavigationBarItem(icon: Icon(Icons.analytics_rounded), activeIcon: Icon(Icons.bolt), label: 'Activity'),
  //       BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'More'),
  //     ],
  //   );
  // }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
