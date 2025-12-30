import 'package:flutter/material.dart';
import '../../widgets/common_widgets.dart';
import '../../routes/principal_routes.dart';

class TeacherSearchPage extends StatefulWidget {
  const TeacherSearchPage({super.key});

  @override
  State<TeacherSearchPage> createState() => _TeacherSearchPageState();
}

class _TeacherSearchPageState extends State<TeacherSearchPage> {
  // int _currentIndex = 1;
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
      'subject': 'English Language',
      'role': 'Class Teacher',
      'classes': '8A, 9A',
      'experience': '08 Years',
      'isClassTeacher': true,
      'color': const Color(0xFF1D4ED8),
    },
    {
      'name': 'Mrs. Ruchita Rai',
      'subject': 'Mathematics',
      'role': 'Subject Teacher',
      'classes': '10A, 11, 12A',
      'experience': '06 Years',
      'isClassTeacher': false,
      'color': const Color(0xFF7C3AED),
    },
    {
      'name': 'Miss Raghini Sharma',
      'subject': 'Physics & Math',
      'role': 'Class Teacher',
      'classes': '8A, 9B',
      'experience': '08 Years',
      'isClassTeacher': true,
      'color': const Color(0xFF10B981),
    },
    {
      'name': 'Mr. Rajesh Kumar',
      'subject': 'Social Science',
      'role': 'Subject Teacher',
      'classes': '9A, 10A, 11',
      'experience': '10 Years',
      'isClassTeacher': false,
      'color': const Color(0xFFF59E0B),
    },
    {
      'name': 'Mrs. Priya Singh',
      'subject': 'History & Civics',
      'role': 'Class Teacher',
      'classes': '12A',
      'experience': '12 Years',
      'isClassTeacher': true,
      'color': const Color(0xFFEF4444),
    },
  ];

  void _onFilterSelected(String filter) =>
      setState(() => _selectedFilter = filter);

  void _onBottomNavTap(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, PrincipalRoutes.home);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, PrincipalRoutes.search);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, PrincipalRoutes.activity);
        break;
      case 3:
        Navigator.pushReplacementNamed(
          context,
          PrincipalRoutes.morePage,
          arguments: {'section': null},
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> visibleTeachers = _teachers.where((teacher) {
      if (_selectedFilter == "All Classes") return true;
      return (teacher['classes'] as String)
          .contains(_selectedFilter.split(' ').last);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ✨ PREMIUM COMPACT HEADER
            _buildPremiumHeader(),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // ✨ SEARCH INPUT
                    _buildSearchBar(),

                    const SizedBox(height: 25),

                    // ✨ HORIZONTAL PILL FILTERS
                    _buildFilterTabs(),

                    const SizedBox(height: 25),

                    // ✨ TEACHER CARDS LIST
                    _buildTeacherList(visibleTeachers),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildPremiumHeader() {
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
            offset: const Offset(0, 6), // 👈 shadow only at bottom
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
                color: Color(0xFF1E293B),
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
                  'Faculaty Search',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'School Statistics Insights',
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
          GestureDetector(
            onTap: () => setState(() => _isTelugu = !_isTelugu),
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

  Widget _buildLanguagePill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
          color: const Color(0xFFEFF6FF),
          borderRadius: BorderRadius.circular(20)),
      child: Text(_isTelugu ? 'తెలుగు' : 'English',
          style: const TextStyle(
              color: Color(0xFF1D4ED8),
              fontWeight: FontWeight.w800,
              fontSize: 11)),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 15,
                offset: const Offset(0, 8))
          ],
        ),
        child: TextField(
          controller: _searchController,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            hintText: "Search name, subject or class...",
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            prefixIcon: const Icon(Icons.search_rounded,
                color: Color(0xFF1D4ED8), size: 22),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (ctx, i) {
          bool selected = _filters[i] == _selectedFilter;
          return GestureDetector(
            onTap: () => _onFilterSelected(_filters[i]),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: selected ? const Color(0xFF1D4ED8) : Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                    color: selected
                        ? const Color(0xFF1D4ED8)
                        : const Color(0xFFE2E8F0)),
                boxShadow: selected
                    ? [
                        BoxShadow(
                            color: const Color(0xFF1D4ED8).withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4))
                      ]
                    : null,
              ),
              child: Center(
                child: Text(
                  _filters[i],
                  style: TextStyle(
                      color: selected ? Colors.white : const Color(0xFF64748B),
                      fontWeight: FontWeight.w700,
                      fontSize: 12),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTeacherList(List<Map<String, dynamic>> teachers) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'FACULTY PROFILES',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  color: Colors.blueGrey.withOpacity(0.6),
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                '${teachers.length} Found',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),

        // Teacher Cards
        ...teachers.map((t) => _buildPremiumTeacherCard(t)),
      ],
    );
  }

  Widget _buildPremiumTeacherCard(Map<String, dynamic> t) {
    final bool isCT = t['isClassTeacher'] as bool;
    final Color accentColor = t['color'] as Color;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          PrincipalRoutes.teacherProfile,
          arguments: t,
        ),
        borderRadius: BorderRadius.circular(28),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),

            // 🌟 CLEAN LIGHT BORDER (Same as other cards)
            border: Border.all(
              color: const Color(0xFFE2E8F0),
              width: 1,
            ),

            // 🌟 SOFT PREMIUM DEPTH
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1E293B).withOpacity(0.025),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              // --- TOP ROW ---
              Row(
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: accentColor.withOpacity(0.15),
                      ),
                    ),
                    child: Icon(
                      Icons.person_pin_rounded,
                      color: accentColor,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          t['subject'],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF94A3B8),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildRoleBadge(t['role'], isCT),
                ],
              ),

              const SizedBox(height: 18),

              // --- SOFT DIVIDER ---
              Container(
                height: 1,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Color(0xFFF1F5F9),
                      Colors.white,
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // --- METRICS ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildMetric("EXP", t['experience'], accentColor),
                  _buildMetric(
                      "CLASSES", t['classes'], const Color(0xFF475569)),
                  _buildMetric("STATUS", "Online", const Color(0xFF10B981)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleBadge(String label, bool isCT) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isCT ? const Color(0xFFE6F9ED) : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
            color: isCT ? const Color(0xFF16A34A) : const Color(0xFF64748B),
            fontSize: 9,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5),
      ),
    );
  }

  Widget _buildMetric(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w900,
                color: Color(0xFFCBD5E1),
                letterSpacing: 0.5)),
        const SizedBox(height: 4),
        Text(value,
            style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.w800, color: color)),
      ],
    );
  }

  // Widget _buildBottomNavigationBar() {
  //   return Container(
  //     decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xFFF1F5F9)))),
  //     child: BottomNavigationBar(
  //       currentIndex: _currentIndex, onTap: _onBottomNavTap,
  //       type: BottomNavigationBarType.fixed, backgroundColor: Colors.white,
  //       selectedItemColor: const Color(0xFF1D4ED8), unselectedItemColor: const Color(0xFF94A3B8),
  //       elevation: 0, selectedFontSize: 11, unselectedFontSize: 11,
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
