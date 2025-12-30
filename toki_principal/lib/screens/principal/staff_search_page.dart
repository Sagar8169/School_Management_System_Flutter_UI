import 'package:flutter/material.dart';
import '../../routes/principal_routes.dart';

class StaffSearchPage extends StatefulWidget {
  const StaffSearchPage({super.key});

  @override
  State<StaffSearchPage> createState() => _StaffSearchPageState();
}

class _StaffSearchPageState extends State<StaffSearchPage> {
  // int _currentIndex = 1;
  bool _isTelugu = true;
  int _selectedFilter = 0;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _filters = ['All Staff', 'Teachers', 'Admin', 'Support'];

  final List<Map<String, dynamic>> _allStaffMembers = [
    {
      'name': 'Rajesh Sharma',
      'role': 'Mathematics Teacher',
      'department': 'Teaching',
      'employeeId': 'TCH-001',
      'isActive': true,
      'type': 'teacher',
      'isClassTeacher': true,
      'assignedClass': 'Class 10-A',
      'avatarColor': const Color(0xFF2563EB),
    },
    {
      'name': 'Priya Patel',
      'role': 'Science Teacher',
      'department': 'Teaching',
      'employeeId': 'TCH-002',
      'isActive': true,
      'type': 'teacher',
      'isClassTeacher': true,
      'assignedClass': 'Class 9-B',
      'avatarColor': const Color(0xFF10B981),
    },
    {
      'name': 'Suresh Kumar',
      'role': 'English Teacher',
      'department': 'Teaching',
      'employeeId': 'TCH-003',
      'isActive': true,
      'type': 'teacher',
      'isClassTeacher': false,
      'assignedClass': 'Multiple Classes',
      'avatarColor': const Color(0xFF8B5CF6),
    },
    {
      'name': 'Anjali Singh',
      'role': 'Social Studies Teacher',
      'department': 'Teaching',
      'employeeId': 'TCH-004',
      'isActive': true,
      'type': 'teacher',
      'isClassTeacher': true,
      'assignedClass': 'Class 8-A',
      'avatarColor': const Color(0xFFEC4899),
    },
    {
      'name': 'Anil Verma',
      'role': 'Administrative Officer',
      'department': 'Administration',
      'employeeId': 'ADM-001',
      'isActive': true,
      'type': 'administrative',
      'avatarColor': const Color(0xFFF59E0B),
    },
    {
      'name': 'Kavita Joshi',
      'role': 'Accounts Manager',
      'department': 'Administration',
      'employeeId': 'ADM-002',
      'isActive': true,
      'type': 'administrative',
      'avatarColor': const Color(0xFF06B6D4),
    },
    {
      'name': 'Ramesh Kumar',
      'role': 'Bus Driver',
      'department': 'Fleet Management',
      'employeeId': 'STF-001',
      'isActive': true,
      'type': 'support',
      'avatarColor': const Color(0xFFF97316),
    },
    {
      'name': 'Manoj Gupta',
      'role': 'Lab Assistant',
      'department': 'Science Lab',
      'employeeId': 'STF-002',
      'isActive': true,
      'type': 'support',
      'avatarColor': const Color(0xFF84CC16),
    },
    {
      'name': 'Vijay Singh',
      'role': 'Security Officer',
      'department': 'Security',
      'employeeId': 'STF-003',
      'isActive': true,
      'type': 'support',
      'avatarColor': const Color(0xFF6366F1),
    },
  ];

  List<Map<String, dynamic>> get _filteredStaffMembers {
    if (_selectedFilter == 0) return _allStaffMembers;
    if (_selectedFilter == 1)
      return _allStaffMembers
          .where((staff) => staff['type'] == 'teacher')
          .toList();
    if (_selectedFilter == 2)
      return _allStaffMembers
          .where((staff) => staff['type'] == 'administrative')
          .toList();
    if (_selectedFilter == 3)
      return _allStaffMembers
          .where((staff) => staff['type'] == 'support')
          .toList();
    return _allStaffMembers;
  }

  void _toggleLanguage() {
    setState(() {
      _isTelugu = !_isTelugu;
    });
  }

  void _updateFilter(int index) {
    setState(() {
      _selectedFilter = index;
    });
  }

  void _navigateTo(String routeName, {Map<String, dynamic>? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

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

  void _onStaffTap(Map<String, dynamic> staffData) {
    _navigateTo(PrincipalRoutes.staffProfile, arguments: staffData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPremiumHeader(),
              _buildSearchAndFilterSection(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildStaffList(),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
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
                  'Staff Search',
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
    return GestureDetector(
      onTap: _toggleLanguage,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(20)),
        child: Text(_isTelugu ? 'తెలుగు' : 'English',
            style: const TextStyle(
                color: Color(0xFF1D4ED8),
                fontWeight: FontWeight.w800,
                fontSize: 11)),
      ),
    );
  }

  Widget _buildSearchAndFilterSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search by name or Employee ID...',
                  hintStyle: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search_rounded,
                      color: Color(0xFF1D4ED8), size: 20),
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: List.generate(_filters.length, (index) {
                final isSelected = index == _selectedFilter;
                return GestureDetector(
                  onTap: () => _updateFilter(index),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color:
                          isSelected ? const Color(0xFF1D4ED8) : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: isSelected
                              ? const Color(0xFF1D4ED8)
                              : const Color(0xFFE2E8F0)),
                    ),
                    child: Text(
                      _filters[index],
                      style: TextStyle(
                        color:
                            isSelected ? Colors.white : const Color(0xFF64748B),
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('STAFF MEMBERS',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: Colors.blueGrey.withOpacity(0.6),
                    letterSpacing: 1)),
            Text('${_filteredStaffMembers.length} Total',
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF64748B))),
          ],
        ),
        const SizedBox(height: 15),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _filteredStaffMembers.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) =>
              _buildStaffCard(_filteredStaffMembers[index]),
        ),
      ],
    );
  }

  Widget _buildStaffCard(Map<String, dynamic> staff) {
    final bool isClassTeacher = staff['isClassTeacher'] ?? false;
    final bool isActive = staff['isActive'] as bool;

    return GestureDetector(
      onTap: () => _onStaffTap(staff),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: isClassTeacher
                  ? const Color(0xFF1D4ED8).withOpacity(0.2)
                  : Colors.white),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 15,
                offset: const Offset(0, 8))
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: staff['avatarColor'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                      staff['type'] == 'teacher'
                          ? Icons.person_rounded
                          : Icons.badge_rounded,
                      color: staff['avatarColor'],
                      size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(staff['name'],
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF1E293B))),
                      Text(staff['role'],
                          style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF94A3B8))),
                    ],
                  ),
                ),
                _buildStatusBadge(isActive),
              ],
            ),
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(height: 1, color: Color(0xFFF1F5F9))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCardInfo('DEPT.', staff['department']),
                _buildCardInfo('EMP ID', staff['employeeId'], isId: true),
              ],
            ),
            if (isClassTeacher) _buildClassTeacherTag(staff['assignedClass']),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: active ? const Color(0xFFE6F9ED) : const Color(0xFFFFF1F2),
          borderRadius: BorderRadius.circular(8)),
      child: Text(active ? 'ACTIVE' : 'AWAY',
          style: TextStyle(
              fontSize: 9,
              color: active ? const Color(0xFF16A34A) : const Color(0xFFE11D48),
              fontWeight: FontWeight.w900)),
    );
  }

  Widget _buildCardInfo(String label, String value, {bool isId = false}) {
    return Column(
      crossAxisAlignment:
          isId ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w900,
                color: Color(0xFFCBD5E1))),
        const SizedBox(height: 2),
        Text(value,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color:
                    isId ? const Color(0xFF1D4ED8) : const Color(0xFF475569))),
      ],
    );
  }

  Widget _buildClassTeacherTag(String? className) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
            color: const Color(0xFFF0F7FF),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            const Icon(Icons.star_rounded, size: 14, color: Color(0xFF1D4ED8)),
            const SizedBox(width: 6),
            Text('Class Teacher: $className',
                style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF1D4ED8),
                    fontWeight: FontWeight.w800)),
          ],
        ),
      ),
    );
  }

  // Widget _buildBottomNavigationBar() {
  //   return Container(
  //     decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xFFF1F5F9), width: 1))),
  //     child: BottomNavigationBar(
  //       currentIndex: _currentIndex,
  //       onTap: _onBottomNavTap,
  //       type: BottomNavigationBarType.fixed,
  //       backgroundColor: Colors.white,
  //       selectedItemColor: const Color(0xFF1D4ED8),
  //       unselectedItemColor: const Color(0xFF94A3B8),
  //       elevation: 0,
  //       selectedFontSize: 11,
  //       unselectedFontSize: 11,
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
