import 'package:flutter/material.dart';
import '../../routes/class_teacher_routes.dart';

class StaffSearchPage extends StatefulWidget {
  const StaffSearchPage({super.key});

  @override
  State<StaffSearchPage> createState() => _StaffSearchPageState();
}

class _StaffSearchPageState extends State<StaffSearchPage> {
  int _currentIndex = 1;
  bool _isTelugu = true;
  int _selectedFilter = 0;
  final TextEditingController _searchController = TextEditingController();

  // Filters
  final List<String> _filters = ['All Staff', 'Teachers', 'Administrative', 'Support Staff'];

  // Mock data for staff members
  final List<Map<String, dynamic>> _allStaffMembers = [
    // Teachers
    {
      'name': 'Rajesh Sharma',
      'role': 'Mathematics Teacher',
      'department': 'Teaching',
      'employeeId': 'TCH-001',
      'isActive': true,
      'type': 'teacher',
      'isClassTeacher': true,
      'assignedClass': 'Class 10-A',
      'avatarColor': Color(0xFF2563EB),
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
      'avatarColor': Color(0xFF10B981),
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
      'avatarColor': Color(0xFF8B5CF6),
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
      'avatarColor': Color(0xFFEC4899),
    },
    // Administrative Staff
    {
      'name': 'Anil Verma',
      'role': 'Administrative Officer',
      'department': 'Administration',
      'employeeId': 'ADM-001',
      'isActive': true,
      'type': 'administrative',
      'avatarColor': Color(0xFFF59E0B),
    },
    {
      'name': 'Kavita Joshi',
      'role': 'Accounts Manager',
      'department': 'Administration',
      'employeeId': 'ADM-002',
      'isActive': true,
      'type': 'administrative',
      'avatarColor': Color(0xFF06B6D4),
    },
    // Support Staff
    {
      'name': 'Ramesh Kumar',
      'role': 'Bus Driver',
      'department': 'Fleet Management',
      'employeeId': 'STF-001',
      'isActive': true,
      'type': 'support',
      'avatarColor': Color(0xFFF97316),
    },
    {
      'name': 'Manoj Gupta',
      'role': 'Lab Assistant',
      'department': 'Science Lab',
      'employeeId': 'STF-002',
      'isActive': true,
      'type': 'support',
      'avatarColor': Color(0xFF84CC16),
    },
    {
      'name': 'Vijay Singh',
      'role': 'Security Officer',
      'department': 'Security',
      'employeeId': 'STF-003',
      'isActive': true,
      'type': 'support',
      'avatarColor': Color(0xFF6366F1),
    },
  ];

  List<Map<String, dynamic>> get _filteredStaffMembers {
    if (_selectedFilter == 0) return _allStaffMembers;
    if (_selectedFilter == 1) return _allStaffMembers.where((staff) => staff['type'] == 'teacher').toList();
    if (_selectedFilter == 2) return _allStaffMembers.where((staff) => staff['type'] == 'administrative').toList();
    if (_selectedFilter == 3) return _allStaffMembers.where((staff) => staff['type'] == 'support').toList();
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

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.of(context).pushNamedAndRemoveUntil(
          ClassTeacherRoutes.home,
              (route) => false,
        );
        break;
      case 1:
        break;
      case 2:
        _navigateTo(ClassTeacherRoutes.activity);
        break;
      case 3:
        _navigateTo(ClassTeacherRoutes.settings);
        break;
    }
  }

  void _onStaffTap(Map<String, dynamic> staffData) {
    _navigateTo(ClassTeacherRoutes.staffProfile, arguments: staffData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),
            const SizedBox(height: 8),

            // Sub-Header with Back Button
            _buildSubHeader(),
            const SizedBox(height: 8),

            // Divider
            Container(height: 1, color: const Color(0xFFE5E7EB)),

            // Filter Tabs
            _buildFilterTabs(),
            const SizedBox(height: 8),

            // Search Field
            _buildSearchField(),
            const SizedBox(height: 8),

            // Scrollable Body Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Staff List
                    _buildStaffList(),
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

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF1D4ED8),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: const Text(
              'A',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Aditya International School',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Powered by Toki Tech',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: _toggleLanguage,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Text(
                _isTelugu ? 'తెలుగు' : 'English',
                style: const TextStyle(
                  color: Color(0xFF1D4ED8),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubHeader() {
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
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Color(0xFF374151),
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'Search Staff',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      height: 44,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: List.generate(_filters.length, (index) {
          final isSelected = index == _selectedFilter;
          return Expanded(
            child: GestureDetector(
              onTap: () => _updateFilter(index),
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF2563EB) : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    _filters[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : const Color(0xFF374151),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search for staff by name, role, or department',
            hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            suffixIcon: Icon(
              Icons.search,
              color: Color(0xFF6B7280),
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStaffList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Text(
            'Showing ${_filteredStaffMembers.length} staff members',
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _filteredStaffMembers.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final staff = _filteredStaffMembers[index];
              return _buildStaffCard(staff);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStaffCard(Map<String, dynamic> staff) {
    final bool isActive = staff['isActive'] as bool;
    final bool isClassTeacher = staff['isClassTeacher'] ?? false;
    final Color statusColor = isActive ? const Color(0xFF10B981) : const Color(0xFFF59E0B);
    final Color statusBgColor = isActive ? const Color(0xFFECFDF5) : const Color(0xFFFFF7ED);
    final String statusText = isActive ? 'Active' : 'Not Active';

    return GestureDetector(
      onTap: () => _onStaffTap(staff),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isClassTeacher ? const Color(0xFF2563EB) : const Color(0xFFE5E7EB),
            width: isClassTeacher ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Row 1 - Header
            Row(
              children: [
                // Avatar
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: staff['avatarColor'],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    staff['type'] == 'teacher' ? Icons.person : Icons.badge,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),

                // Info Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        staff['name'].toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        staff['role'].toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      if (staff['type'] == 'teacher' && staff['assignedClass'] != null)
                        const SizedBox(height: 4),
                      if (staff['type'] == 'teacher' && staff['assignedClass'] != null)
                        Text(
                          staff['assignedClass'].toString(),
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF2563EB),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                ),

                // Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      fontSize: 12,
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            Container(
              height: 1,
              color: const Color(0xFFE5E7EB),
            ),
            const SizedBox(height: 12),

            // Row 2 - Details
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Department',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      Text(
                        staff['department'].toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Employee ID',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    Text(
                      staff['employeeId'].toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF2563EB),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (isClassTeacher)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF2563EB).withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star,
                        size: 12,
                        color: const Color(0xFF2563EB),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Class Teacher',
                        style: TextStyle(
                          fontSize: 12,
                          color: const Color(0xFF2563EB),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
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
      selectedItemColor: const Color(0xFF1D4ED8),
      unselectedItemColor: const Color(0xFF6B7280),
      selectedFontSize: 12,
      unselectedFontSize: 12,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_rounded),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.show_chart_rounded),
          label: 'Activity',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz_rounded),
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