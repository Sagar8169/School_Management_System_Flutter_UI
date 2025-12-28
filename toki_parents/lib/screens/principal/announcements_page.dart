import 'package:flutter/material.dart';
import '../../routes/principal_routes.dart';

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({super.key});

  @override
  State<AnnouncementsPage> createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  int _currentIndex = 2;
  bool _isTelugu = true;
  int _selectedTab = 0; // 0: All, 1: Teachers, 2: Students, 3: Parents
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Mock announcement data
  final List<Map<String, dynamic>> _announcements = [
    {
      'id': '1',
      'title': 'School Closed Tomorrow',
      'description': 'School will remain closed tomorrow due to heavy rain predicted by the meteorological department. All classes will resume the day after.',
      'target': 'All',
      'time': '1h ago',
      'isUrgent': false,
      'category': 'general',
      'author': 'Principal Office',
      'date': 'Nov 9, 2025',
    },
    {
      'id': '2',
      'title': 'Cyclone Alert - School Closure',
      'description': 'Cyclone Alert: Due to severe cyclone warning, school is closed for the next two days. Stay safe and avoid unnecessary travel.',
      'target': 'All',
      'time': '1d ago',
      'isUrgent': true,
      'category': 'emergency',
      'author': 'Safety Committee',
      'date': 'Nov 8, 2025',
    },
    {
      'id': '3',
      'title': 'Annual Sports Day Preparations',
      'description': 'All teachers are requested to submit their students\' participation lists for Annual Sports Day by Friday. Practice sessions start next week.',
      'target': 'Teachers',
      'time': '2d ago',
      'isUrgent': false,
      'category': 'event',
      'author': 'Sports Department',
      'date': 'Nov 7, 2025',
    },
    {
      'id': '4',
      'title': 'Mid-term Examination Schedule',
      'description': 'Mid-term examinations for classes 6-10 will be conducted from November 15-25, 2025. Timetable will be shared by respective class teachers.',
      'target': 'Students & Parents',
      'time': '3d ago',
      'isUrgent': false,
      'category': 'academic',
      'author': 'Examination Department',
      'date': 'Nov 6, 2025',
    },
    {
      'id': '5',
      'title': 'Parent-Teacher Meeting',
      'description': 'Monthly Parent-Teacher Meeting scheduled for November 20, 2025 from 10:00 AM to 1:00 PM. Parents are requested to attend.',
      'target': 'Parents',
      'time': '4d ago',
      'isUrgent': false,
      'category': 'meeting',
      'author': 'Principal Office',
      'date': 'Nov 5, 2025',
    },
    {
      'id': '6',
      'title': 'Science Exhibition Projects',
      'description': 'Students participating in the Science Exhibition must submit their project proposals by November 12, 2025. Required materials will be provided.',
      'target': 'Students',
      'time': '5d ago',
      'isUrgent': false,
      'category': 'event',
      'author': 'Science Department',
      'date': 'Nov 4, 2025',
    },
    {
      'id': '7',
      'title': 'Library Renovation Notice',
      'description': 'School library will be closed for renovation from November 10-20, 2025. Please return all borrowed books before November 9.',
      'target': 'All',
      'time': '6d ago',
      'isUrgent': false,
      'category': 'facility',
      'author': 'Library Management',
      'date': 'Nov 3, 2025',
    },
    {
      'id': '8',
      'title': 'Transport Fee Revision',
      'description': 'Bus transport fees will be revised starting from December 1, 2025. New fee structure will be shared with parents next week.',
      'target': 'Parents',
      'time': '1w ago',
      'isUrgent': false,
      'category': 'finance',
      'author': 'Transport Department',
      'date': 'Nov 1, 2025',
    },
  ];

  // Filtered announcements based on selected tab
  List<Map<String, dynamic>> get _filteredAnnouncements {
    if (_selectedTab == 0) return _announcements;
    if (_selectedTab == 1) return _announcements.where((a) => a['target'] == 'Teachers' || a['target'] == 'All').toList();
    if (_selectedTab == 2) return _announcements.where((a) => a['target'] == 'Students' || a['target'] == 'All' || a['target'] == 'Students & Parents').toList();
    if (_selectedTab == 3) return _announcements.where((a) => a['target'] == 'Parents' || a['target'] == 'All' || a['target'] == 'Students & Parents').toList();
    return _announcements;
  }

  final List<String> _tabs = ['All', 'Teachers', 'Students', 'Parents'];

  void _toggleLanguage() {
    setState(() {
      _isTelugu = !_isTelugu;
    });
  }

  void _updateTab(int index) {
    setState(() {
      _selectedTab = index;
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
          PrincipalRoutes.home,
              (route) => false,
        );
        break;
      case 1:
        _navigateTo(PrincipalRoutes.search);
        break;
      case 2:
        break;
      case 3:
        _navigateTo(PrincipalRoutes.morePage);
        break;
    }
  }

  void _showNewAnnouncementDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => _buildNewAnnouncementForm(),
    );
  }

  Widget _buildNewAnnouncementForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create New Announcement',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF212121),
              ),
            ),
            const SizedBox(height: 20),

            // Title Field
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              ),
            ),
            const SizedBox(height: 16),

            // Description Field
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              ),
            ),
            const SizedBox(height: 16),

            // Target Audience
            const Text(
              'Target Audience',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF212121),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['All', 'Teachers', 'Students', 'Parents'].map((target) {
                return FilterChip(
                  label: Text(target),
                  selected: true,
                  onSelected: (_) {},
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _showSuccessMessage();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF534AF0),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Publish',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Announcement published successfully!'),
        backgroundColor: Color(0xFF534AF0),
      ),
    );
  }

  void _viewAnnouncementDetails(Map<String, dynamic> announcement) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => _buildAnnouncementDetails(announcement),
    );
  }

  Widget _buildAnnouncementDetails(Map<String, dynamic> announcement) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with close button
            Row(
              children: [
                Expanded(
                  child: Text(
                    announcement['title'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF212121),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Target and Time
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    announcement['target'],
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF757575),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '• ${announcement['time']}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF757575),
                  ),
                ),
                if (announcement['isUrgent']) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEBEE),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'URGENT',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFFD32F2F),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),

            const SizedBox(height: 20),

            // Description
            Text(
              announcement['description'],
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF212121),
                height: 1.5,
              ),
            ),

            const SizedBox(height: 20),

            // Details Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Details',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF212121),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _detailRow('Author:', announcement['author']),
                  _detailRow('Category:', announcement['category']),
                  _detailRow('Published:', announcement['date']),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Action Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF534AF0),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Close',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF757575),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF212121),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            // Header with Logo and Language - Fixed at top
            _buildAppBar(),
            const SizedBox(height: 8),

            // Tabs - Fixed
            _buildTabs(),

            // Search Field - Fixed
            _buildSearchField(),
            const SizedBox(height: 8),

            // Latest Announcements Section - Fixed
            _buildLatestAnnouncementsSection(),

            // Scrollable Announcements List
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  // Simulate refresh
                  await Future.delayed(const Duration(seconds: 1));
                  setState(() {});
                },
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      // Announcement List
                      _buildAnnouncementList(),
                      const SizedBox(height: 32),

                      // Add some extra space at the bottom for FAB
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showNewAnnouncementDialog,
        backgroundColor: const Color(0xFF534AF0),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          // Logo Box
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF534AF0),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: const Text(
              'A',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // School Info
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Aditya International School',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF212121),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Powered by Toki Tech',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF757575),
                  ),
                ),
              ],
            ),
          ),

          // Language Selector
          OutlinedButton(
            onPressed: _toggleLanguage,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              side: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            child: Text(
              _isTelugu ? 'తెలుగు' : 'English',
              style: const TextStyle(
                color: Color(0xFF212121),
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      height: 44,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: List.generate(_tabs.length, (index) {
          final isSelected = index == _selectedTab;
          return Expanded(
            child: GestureDetector(
              onTap: () => _updateTab(index),
              child: Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF534AF0) : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    _tabs[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : const Color(0xFF757575),
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search announcements...',
            hintStyle: TextStyle(color: Color(0xFF9E9E9E)),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            prefixIcon: Icon(Icons.search, color: Color(0xFF757575)),
          ),
        ),
      ),
    );
  }

  Widget _buildLatestAnnouncementsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Latest Announcements',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF212121),
            ),
          ),
          TextButton(
            onPressed: () {
              // Show all announcements
            },
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF448AFF),
            ),
            child: const Text(
              'View All',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: List.generate(_filteredAnnouncements.length, (index) {
          final announcement = _filteredAnnouncements[index];
          return GestureDetector(
            onTap: () => _viewAnnouncementDetails(announcement),
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: announcement['isUrgent']
                    ? const Color(0xFFFFEBEE)
                    : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: announcement['isUrgent']
                      ? const Color(0xFFFFCDD2)
                      : const Color(0xFFE0E0E0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      announcement['title'],
                      style: TextStyle(
                        fontSize: 14,
                        color: announcement['isUrgent']
                            ? const Color(0xFFB71C1C)
                            : const Color(0xFF212121),
                        height: 1.4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Description Preview
                    Text(
                      announcement['description'].length > 100
                          ? '${announcement['description'].substring(0, 100)}...'
                          : announcement['description'],
                      style: TextStyle(
                        fontSize: 13,
                        color: announcement['isUrgent']
                            ? const Color(0xFFB71C1C)
                            : const Color(0xFF212121),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Footer with target and time
                    Row(
                      children: [
                        Text(
                          'To: ${announcement['target']}',
                          style: TextStyle(
                            fontSize: 12,
                            color: announcement['isUrgent']
                                ? const Color(0xFFD32F2F)
                                : const Color(0xFF757575),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '| ${announcement['time']}',
                          style: TextStyle(
                            fontSize: 12,
                            color: announcement['isUrgent']
                                ? const Color(0xFFD32F2F)
                                : const Color(0xFF757575),
                          ),
                        ),
                        if (announcement['isUrgent']) ...[
                          const SizedBox(width: 8),
                          Text(
                            '(URGENT)',
                            style: TextStyle(
                              fontSize: 12,
                              color: const Color(0xFFD32F2F),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onBottomNavTapped,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 8,
      selectedItemColor: const Color(0xFF534AF0),
      unselectedItemColor: const Color(0xFF757575),
      selectedFontSize: 12,
      unselectedFontSize: 12,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart_outlined),
          activeIcon: Icon(Icons.bar_chart_rounded),
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
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}