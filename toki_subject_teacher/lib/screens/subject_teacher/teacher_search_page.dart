import 'package:flutter/material.dart';
import 'package:toki/routes/subject_teacher_routes.dart';

class TeacherSearchPage extends StatefulWidget {
  const TeacherSearchPage({super.key});

  @override
  State<TeacherSearchPage> createState() => _TeacherSearchPageState();
}

class _TeacherSearchPageState extends State<TeacherSearchPage> {
  String _selectedFilter = "All Classes";
  bool _isTelugu = true;
  final TextEditingController _searchController = TextEditingController();

  // Purple Theme Colors (Matches your previous pages)
  final Color _primaryPurple = const Color(0xFF7C3AED);
  final Color _scaffoldBg = const Color(0xFFF8FAFC);

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

  void _toggleLanguage() => setState(() => _isTelugu = !_isTelugu);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> visibleTeachers = _teachers.where((teacher) {
      if (_selectedFilter == "All Classes") return true;
      return (teacher['classes'] as String)
          .contains(_selectedFilter.split(' ').last);
    }).toList();

    return Scaffold(
      backgroundColor: _scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            // ✅ HEADER: UPDATED TO MATCH YOUR PREVIOUS CODE (Purple Style)
            _buildExactHeader(),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _buildSearchBar(),
                    const SizedBox(height: 25),
                    _buildFilterTabs(),
                    const SizedBox(height: 25),
                    _buildTeacherList(visibleTeachers),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- 1. HEADER (PURPLE THEME MATCHING YOUR SEARCH STUDENTS PAGE) ---
  Widget _buildExactHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 1, offset: Offset(0, 1))
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
              "Faculty Directory",
              style: TextStyle(
                  color: Color(0xFF1E293B),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
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

  // --- 2. SEARCH BAR ---
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
                blurRadius: 10,
                offset: const Offset(0, 4))
          ],
        ),
        child: TextField(
          controller: _searchController,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            hintText: "Search name, subject or class...",
            prefixIcon:
                Icon(Icons.search_rounded, color: _primaryPurple, size: 22),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }

  // --- 3. FILTER TABS (PURPLE PILLS) ---
  Widget _buildFilterTabs() {
    return SizedBox(
      height: 38,
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
                color: selected ? _primaryPurple : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: selected ? _primaryPurple : Colors.grey.shade300),
              ),
              alignment: Alignment.center,
              child: Text(
                _filters[i],
                style: TextStyle(
                  color: selected ? Colors.white : Colors.grey.shade700,
                  fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // --- 4. TEACHER LIST ---
  Widget _buildTeacherList(List<Map<String, dynamic>> teachers) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('FACULTY PROFILES',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: Colors.blueGrey.withOpacity(0.6),
                      letterSpacing: 1)),
              Text('${teachers.length} Found',
                  style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF64748B))),
            ],
          ),
        ),
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
            context, SubjectTeacherRoutes.teacherProfile,
            arguments: t),
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFF1F5F9)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4))
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: accentColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12)),
                    child: Icon(Icons.person_pin_rounded,
                        color: accentColor, size: 26),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t['name'],
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B))),
                        Text(t['subject'],
                            style: TextStyle(
                                color: Colors.grey.shade500, fontSize: 12)),
                      ],
                    ),
                  ),
                  _buildRoleBadge(t['role'], isCT),
                ],
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(height: 1, color: Color(0xFFF1F5F9))),
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isCT ? const Color(0xFFE6F9ED) : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
            color: isCT ? const Color(0xFF16A34A) : const Color(0xFF64748B),
            fontSize: 9,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildMetric(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade400)),
        const SizedBox(height: 2),
        Text(value,
            style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }
}
