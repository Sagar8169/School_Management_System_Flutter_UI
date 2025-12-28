import 'package:flutter/material.dart';
import '../../routes/principal_routes.dart';

class PendingApprovalsPage extends StatefulWidget {
  const PendingApprovalsPage({super.key});

  @override
  State<PendingApprovalsPage> createState() => _PendingApprovalsPageState();
}

class _PendingApprovalsPageState extends State<PendingApprovalsPage> {
  int _currentIndex = 3;
  bool _isTelugu = true;
  int _selectedFilter = 0;
  final List<String> _filters = ['All (6)', 'Grades (3)', 'Attendance (3)'];

  // Mock data for pending approvals
  final List<Map<String, dynamic>> _pendingItems = [
    {
      'id': '1',
      'type': 'Grade',
      'title': 'Class 10-A - Mathematics',
      'description': 'Mid-term examination grades for 45 students',
      'submittedBy': 'Mr. Rajesh Sharma',
      'date': 'Nov 8, 2025',
      'status': 'pending',
      'icon': Icons.grading_rounded,
      'iconColor': Color(0xFF7C3AED),
      'iconBgColor': Color(0xFFF3E8FF),
    },
    {
      'id': '2',
      'type': 'Attendance',
      'title': 'Class 9-B - Monthly Attendance',
      'description': 'October 2025 attendance for 42 students',
      'submittedBy': 'Ms. Priya Patel',
      'date': 'Nov 7, 2025',
      'status': 'pending',
      'icon': Icons.calendar_today_rounded,
      'iconColor': Color(0xFF16A34A),
      'iconBgColor': Color(0xFFE6F9ED),
    },
    {
      'id': '3',
      'type': 'Grade',
      'title': 'Class 8-A - Science',
      'description': 'Unit Test 2 grades for 38 students',
      'submittedBy': 'Mr. Suresh Kumar',
      'date': 'Nov 6, 2025',
      'status': 'pending',
      'icon': Icons.grading_rounded,
      'iconColor': Color(0xFFDC2626),
      'iconBgColor': Color(0xFFFEE2E2),
    },
    {
      'id': '4',
      'type': 'Attendance',
      'title': 'Class 10-B - Weekly Report',
      'description': 'Week 45 attendance for 44 students',
      'submittedBy': 'Ms. Anjali Singh',
      'date': 'Nov 5, 2025',
      'status': 'pending',
      'icon': Icons.calendar_today_rounded,
      'iconColor': Color(0xFF2563EB),
      'iconBgColor': Color(0xFFE0ECFF),
    },
    {
      'id': '5',
      'type': 'Grade',
      'title': 'Class 7-A - English',
      'description': 'Final term grades for 40 students',
      'submittedBy': 'Mrs. Kavita Joshi',
      'date': 'Nov 4, 2025',
      'status': 'pending',
      'icon': Icons.grading_rounded,
      'iconColor': Color(0xFFD97706),
      'iconBgColor': Color(0xFFFFF7ED),
    },
    {
      'id': '6',
      'type': 'Attendance',
      'title': 'Class 6-B - Monthly Attendance',
      'description': 'October 2025 attendance for 39 students',
      'submittedBy': 'Mr. Vikram Reddy',
      'date': 'Nov 3, 2025',
      'status': 'pending',
      'icon': Icons.calendar_today_rounded,
      'iconColor': Color(0xFF9333EA),
      'iconBgColor': Color(0xFFFAF5FF),
    },
  ];

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
    if (index == _currentIndex) return;

    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.of(context).pushNamedAndRemoveUntil(
          PrincipalRoutes.home,
              (route) => false,
        );
        break;
      case 1:
        _navigateTo(PrincipalRoutes.search);
        break;
      case 2:
        _navigateTo(PrincipalRoutes.activity);
        break;
      case 3:
        Navigator.pushNamed(
          context,
          PrincipalRoutes.morePage,
          arguments: {'section': null},
        );
        break;
    }
  }

  void _showApproveDialog(Map<String, dynamic> item, bool approve) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              approve ? Icons.check_circle_rounded : Icons.cancel_rounded,
              color: approve ? Color(0xFF16A34A) : Color(0xFFDC2626),
            ),
            SizedBox(width: 8),
            Text(approve ? 'Approve Request?' : 'Reject Request?'),
          ],
        ),
        content: Text(
          'Are you sure you want to ${approve ? 'approve' : 'reject'} this ${item['type']} request?',
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Color(0xFF6B7280))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _processApproval(item, approve);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: approve ? Color(0xFF16A34A) : Color(0xFFDC2626),
            ),
            child: Text(approve ? 'Approve' : 'Reject', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _processApproval(Map<String, dynamic> item, bool approve) {
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${item['type']} request ${approve ? 'approved' : 'rejected'} successfully!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: approve ? Color(0xFF16A34A) : Color(0xFFDC2626),
      ),
    );
  }

  void _viewDetails(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => _buildDetailsSheet(item),
    );
  }

  Widget _buildDetailsSheet(Map<String, dynamic> item) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _iconCircle(
                icon: item['icon'],
                bgColor: item['iconBgColor'],
                iconColor: item['iconColor'],
                size: 40,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  '${item['type']} Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close_rounded),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            item['title'],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Text(
            item['description'],
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 16),
          _Card(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Submission Details',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 12),
                _detailRow('Submitted by:', item['submittedBy'], Icons.person_rounded),
                SizedBox(height: 8),
                _detailRow('Submission date:', item['date'], Icons.calendar_today_rounded),
                SizedBox(height: 8),
                _detailRow('Status:', 'Pending', Icons.pending_rounded),
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showApproveDialog(item, true);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF16A34A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text('Approve'),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showApproveDialog(item, false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFDC2626),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text('Reject'),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey.shade600),
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Filter items based on selection
    List<Map<String, dynamic>> filteredItems = _pendingItems;
    if (_selectedFilter == 1) {
      filteredItems = _pendingItems.where((item) => item['type'] == 'Grade').toList();
    } else if (_selectedFilter == 2) {
      filteredItems = _pendingItems.where((item) => item['type'] == 'Attendance').toList();
    }

    return Scaffold(
      backgroundColor: Color(0xFFF3F4F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(),
              SizedBox(height: 16),

              // Page Title
              _buildPageTitle(),
              SizedBox(height: 20),

              // Stats Overview
              _buildStatsOverview(),
              SizedBox(height: 20),

              // Filter Tabs
              _buildFilterTabs(),
              SizedBox(height: 20),

              // Pending Approvals List
              _buildPendingItemsList(filteredItems),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xFF1D4ED8),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: Color(0xFFE5E7EB)),
            ),
            child: Text(
              _isTelugu ? 'తెలుగు' : 'English',
              style: TextStyle(
                color: Color(0xFF1D4ED8),
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Saturday, November 9, 2025',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Pending Approvals',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Review and approve pending requests',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsOverview() {
    return _Card(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _iconCircle(
                icon: Icons.pending_actions_rounded,
                bgColor: Color(0xFFE0ECFF),
                iconColor: Color(0xFF2563EB),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Approval Overview',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xFFF97316),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '${_pendingItems.length}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _StatItem(
                  label: 'Grade Approvals',
                  value: '${_pendingItems.where((item) => item['type'] == 'Grade').length}',
                  color: Color(0xFF7C3AED),
                ),
              ),
              Expanded(
                child: _StatItem(
                  label: 'Attendance Approvals',
                  value: '${_pendingItems.where((item) => item['type'] == 'Attendance').length}',
                  color: Color(0xFF2563EB),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_filters.length, (index) {
          final isSelected = index == _selectedFilter;
          return Padding(
            padding: EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => _updateFilter(index),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xFF1D4ED8) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? Color(0xFF1D4ED8) : Color(0xFFE5E7EB),
                  ),
                ),
                child: Text(
                  _filters[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Color(0xFF374151),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPendingItemsList(List<Map<String, dynamic>> items) {
    if (items.isEmpty) {
      return Container(
        padding: EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: -4,
              offset: Offset(0, 6),
              color: Colors.black.withOpacity(0.05),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              Icons.check_circle_outline_rounded,
              color: Colors.grey.shade300,
              size: 64,
            ),
            SizedBox(height: 16),
            Text(
              'No Pending Approvals',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'All requests have been processed',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: items.map((item) {
        return Container(
          margin: EdgeInsets.only(bottom: 16),
          child: _ApprovalCard(
            item: item,
            onViewDetails: () => _viewDetails(item),
            onApprove: () => _showApproveDialog(item, true),
            onReject: () => _showApproveDialog(item, false),
          ),
        );
      }).toList(),
    );
  }

  Widget _iconCircle({
    required IconData icon,
    required Color bgColor,
    required Color iconColor,
    double size = 32,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        icon,
        size: size * 0.5,
        color: iconColor,
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onBottomNavTapped,
      selectedItemColor: Color(0xFF1D4ED8),
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
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
          icon: Icon(Icons.dashboard_rounded),
          label: 'Activity',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz_rounded),
          label: 'More',
        ),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  const _Card({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(12),
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widget = Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: -4,
            offset: Offset(0, 6),
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
      child: child,
    );

    if (onTap == null) return widget;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: widget,
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    Key? key,
    required this.label,
    required this.value,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }
}

class _ApprovalCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onViewDetails;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const _ApprovalCard({
    Key? key,
    required this.item,
    required this.onViewDetails,
    required this.onApprove,
    required this.onReject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Card(
      padding: EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: item['iconBgColor'],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  item['icon'],
                  size: 18,
                  color: item['iconColor'],
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  item['title'],
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: item['type'] == 'Grade'
                      ? Color(0xFFF3E8FF)
                      : Color(0xFFE0ECFF),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  item['type'],
                  style: TextStyle(
                    color: item['type'] == 'Grade'
                        ? Color(0xFF7C3AED)
                        : Color(0xFF2563EB),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            item['description'],
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF6B7280),
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Submitted by',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      item['submittedBy'],
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      item['date'],
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onApprove,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF16A34A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_rounded, size: 16),
                      SizedBox(width: 4),
                      Text('Approve'),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: onReject,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFDC2626),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.close_rounded, size: 16),
                      SizedBox(width: 4),
                      Text('Reject'),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8),
              OutlinedButton(
                onPressed: onViewDetails,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Color(0xFF2563EB),
                  side: BorderSide(color: Color(0xFF2563EB)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                ),
                child: Text('View'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}