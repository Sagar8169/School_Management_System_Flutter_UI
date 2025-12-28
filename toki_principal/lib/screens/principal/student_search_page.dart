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

  // --- ORIGINAL DATA ---
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



  void _onStudentTap(Map<String, dynamic> studentData) {
    _navigateTo(PrincipalRoutes.studentProfile, arguments: studentData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ✨ UPDATED HEADER: "Search Students" is now inside the main header
            _buildPremiumHeader(),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // ✨ MODERN SEARCH BAR
                    _buildSearchBar(),

                    const SizedBox(height: 25),

                    // ✨ FILTER TABS (Pill Style)
                    _buildFilterTabs(),

                    const SizedBox(height: 25),

                    // ✨ RESULTS LIST
                    _buildStudentResults(),

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
                  'Student Search',
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
            hintText: "Search by name or student ID...",
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
            child: Container(
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
  Widget _buildStudentResults() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- ULTRA CLEAN HEADER ---
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              // Blue Accent Indicator
              Container(
                width: 4,
                height: 16,
                decoration: BoxDecoration(
                  color: const Color(0xFF1D4ED8),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                  'STUDENT LIST',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF1E293B), // Darker for better visibility
                      letterSpacing: 0.8
                  )
              ),
              const Spacer(),
              // Minimal Count Pill
              Text(
                  '${_students.length} Total',
                  style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF94A3B8)
                  )
              ),
            ],
          ),
        ),

        // --- MAPPED CARDS (Clean Spacing) ---
        // Humein cards ke beech margin maintain karni hai bas
        ..._students.map((s) => _buildStudentCard(s)),

        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildStudentCard(Map<String, dynamic> student) {
    final bool isCritical = student['isCritical'] as bool;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        // ✨ LIGHT PREMIUM BORDER (Manga tha aapne)
        border: Border.all(
          color: const Color(0xFFCBD5E1), // Soft slate (very light)

          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E293B).withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: InkWell(
          onTap: () => _onStudentTap(student),
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                // --- TOP SECTION: IDENTITY & STATUS ---
                Row(
                  children: [
                    // Avatar with Border
                    Container(
                      width: 54, height: 54,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(16),
                        // ✨ INNER BORDER for Avatar
                        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
                      ),
                      child: const Icon(Icons.person_rounded, color: Color(0xFF1D4ED8), size: 28),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            student['name'],
                            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), letterSpacing: -0.5),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "ID: ${student['id']} • ${student['grade']}",
                            style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8), fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    _buildStatusChip(student['status'], isCritical),
                  ],
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Divider(height: 1, color: Color(0xFFF1F5F9), thickness: 1.2),
                ),

                // --- BOTTOM SECTION: PERFORMANCE METRICS ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildMetricWithAccent("AVG GRADE", "${student['avgGrade']}%", _getGradeColor(student['avgGrade'])),
                    _buildMetricWithAccent("ATTENDANCE", "${student['attendance']}%", _getAttendanceColor(student['attendance'])),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// ✨ Premium Metric Helper
  Widget _buildMetricWithAccent(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: Color(0xFFCBD5E1), letterSpacing: 0.8),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            // Small Color Dot
            Container(
              width: 8, height: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Text(
              value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF334155)),
            ),
          ],
        ),
      ],
    );
  }
  Widget _buildStatusChip(String label, bool critical) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: critical ? const Color(0xFFFFF1F2) : const Color(0xFFE6F9ED),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(color: critical ? const Color(0xFFE11D48) : const Color(0xFF16A34A), fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 0.5),
      ),
    );
  }

  Widget _buildMetric(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color(0xFFCBD5E1))),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: color)),
      ],
    );
  }

  Color _getGradeColor(double grade) {
    if (grade < 40) return const Color(0xFFE11D48);
    if (grade < 65) return const Color(0xFFF59E0B);
    return const Color(0xFF1D4ED8);
  }

  Color _getAttendanceColor(double att) {
    if (att < 75) return const Color(0xFFE11D48);
    return const Color(0xFF16A34A);
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