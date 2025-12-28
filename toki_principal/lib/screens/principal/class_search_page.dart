import 'package:flutter/material.dart';
import '../../widgets/common_widgets.dart';
import '../../routes/principal_routes.dart';

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

  // --- ORIGINAL DATA ---
  final List<String> _filters = [
    "All Classes",
    "Class 8A",
    "Class 12B",
    "Class 12A",
    "Class 11",
    "Class 10B",
  ];

  final List<Map<String, dynamic>> _classes = [
    {'className': 'Class 8A', 'section': 'Section A', 'teacher': 'Miss Raghini Sharma', 'avgGrade': 82.0, 'totalStudents': 42, 'circle': '8A'},
    {'className': 'Class 12B', 'section': 'Section B', 'teacher': 'Mr. Rajesh Kumar', 'avgGrade': 78.0, 'totalStudents': 38, 'circle': '12B'},
    {'className': 'Class 12A', 'section': 'Section A', 'teacher': 'Mrs. Priya Singh', 'avgGrade': 85.0, 'totalStudents': 45, 'circle': '12A'},
    {'className': 'Class 11', 'section': 'Science Stream', 'teacher': 'Mr. Amit Verma', 'avgGrade': 76.0, 'totalStudents': 40, 'circle': '11'},
    {'className': 'Class 10B', 'section': 'Section B', 'teacher': 'Mrs. Sneha Reddy', 'avgGrade': 80.0, 'totalStudents': 43, 'circle': '10B'},
    {'className': 'Class 9A', 'section': 'Section A', 'teacher': 'Mr. Suresh Patel', 'avgGrade': 79.5, 'totalStudents': 41, 'circle': '9A'},
  ];

  // --- ORIGINAL FUNCTIONS ---
  void _toggleLanguage() => setState(() => _isTelugu = !_isTelugu);

  void _navigateTo(String routeName, {Map<String, dynamic>? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  void _onFilterSelected(String filter) => setState(() => _selectedFilter = filter);

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

  void _onClassTap(Map<String, dynamic> classData) {
    _navigateTo(PrincipalRoutes.classDetails, arguments: classData);
  }

  @override
  Widget build(BuildContext context) {
    // Filter logic preserved
    List<Map<String, dynamic>> visibleClasses = _classes.where((classData) {
      if (_selectedFilter == "All Classes") return true;
      return classData['className'] == _selectedFilter;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ✨ PREMIUM BRANDING HEADER (Screenshot Style)
            _buildPremiumHeader(),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // ✨ MODERN SEARCH BAR
                    _buildSearchBar(),

                    const SizedBox(height: 25),

                    // ✨ FILTER TABS (Pill Style)
                    _buildFilterTabs(),

                    const SizedBox(height: 25),

                    // ✨ RESULTS SECTION
                    _buildClassResults(visibleClasses),

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
                  'Clas Search',
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

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 15, offset: const Offset(0, 8))],
        ),
        child: TextField(
          controller: _searchController,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            hintText: "Search by class or teacher...",
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF1D4ED8), size: 22),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (ctx, i) {
          bool selected = _filters[i] == _selectedFilter;
          return GestureDetector(
            onTap: () => _onFilterSelected(_filters[i]),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: selected ? const Color(0xFF1D4ED8) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: selected ? const Color(0xFF1D4ED8) : const Color(0xFFE2E8F0)),
              ),
              child: Center(
                child: Text(
                  _filters[i],
                  style: TextStyle(color: selected ? Colors.white : const Color(0xFF64748B), fontWeight: FontWeight.w700, fontSize: 12),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildClassResults(List<Map<String, dynamic>> visibleClasses) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ACTIVE CLASSES', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.blueGrey.withOpacity(0.6), letterSpacing: 1)),
              Text('${visibleClasses.length} found', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF64748B))),
            ],
          ),
        ),
        ...visibleClasses.map((c) => _buildPremiumClassCard(c)),
      ],
    );
  }
  Widget _buildPremiumClassCard(Map<String, dynamic> classData) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        // ✨ LIGHT PREMIUM BORDER (Aapne jo manga tha)
        border: Border.all(color: const Color(0xFFF1F5F9), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E293B).withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: InkWell(
          onTap: () => _onClassTap(classData),
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- TOP ROW: IDENTITY & PERFORMANCE ---
                Row(
                  children: [
                    // Circle Number (Detailed)
                    Container(
                      width: 54, height: 54,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFDBEAFE), width: 1),
                      ),
                      child: Center(
                        child: Text(
                          classData['circle'].toString(),
                          style: const TextStyle(color: Color(0xFF1D4ED8), fontWeight: FontWeight.w900, fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Class & Section (Detailed)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            classData['className'],
                            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), letterSpacing: -0.5),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Section ${classData['section']}",
                            style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8), fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    // Avg Grade (Detailed Metric)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${classData['avgGrade']}%",
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF10B981)),
                        ),
                        const Text(
                          "AVG GRADE",
                          style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: Color(0xFFCBD5E1), letterSpacing: 0.5),
                        ),
                      ],
                    ),
                  ],
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Divider(height: 1, color: Color(0xFFF1F5F9), thickness: 1.2),
                ),

                // --- BOTTOM ROW: TEACHER & ENROLLMENT ---
                Row(
                  children: [
                    // Teacher Detail
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.person_outline_rounded, size: 16, color: Colors.blue.shade300),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("CLASS TEACHER", style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: Color(0xFFCBD5E1))),
                                Text(
                                  classData['teacher'],
                                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF475569)),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Enrollment Detail
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.groups_outlined, size: 14, color: Color(0xFF64748B)),
                          const SizedBox(width: 6),
                          Text(
                            "${classData['totalStudents']} enrolled",
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF64748B)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildMetric(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(label, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Color(0xFFCBD5E1))),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF1D4ED8))),
      ],
    );
  }

  Widget _buildCardFooterInfo(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 14, color: const Color(0xFF94A3B8)),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Color(0xFFCBD5E1))),
            Text(value, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF475569))),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xFFF1F5F9)))),
      child: BottomNavigationBar(
        currentIndex: _currentIndex, onTap: _onBottomNavTap,
        type: BottomNavigationBarType.fixed, backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF1D4ED8), unselectedItemColor: const Color(0xFF94A3B8),
        elevation: 0, selectedFontSize: 11, unselectedFontSize: 11,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_rounded),
            label: "Activity",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: "More",
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}