// lib/screens/class_teacher/parent_tickets_list.dart
import 'package:flutter/material.dart';
import '../../routes/class_teacher_routes.dart';

class ParentTicketsListPage extends StatefulWidget {
  const ParentTicketsListPage({Key? key}) : super(key: key);

  @override
  _ParentTicketsListPageState createState() => _ParentTicketsListPageState();
}

class _ParentTicketsListPageState extends State<ParentTicketsListPage> {
  int _currentIndex = 0;
  int _selectedFilterIndex = 0;
  bool _isTelugu = true;

  final Color _headerRed = const Color(0xFFE56A54);
  final Color _statCardRed = const Color(0xFFBF3626);
  final Color _primaryBlue = const Color(0xFF2979FF);
  final Color _textDark = const Color(0xFF1A1A1A);
  final Color _bgGrey = const Color(0xFFF5F6F8);
  final Color _selectedPurple = const Color(0xFFEADDFF);

  final List<String> _filters = ['All (5)', 'Open (2)', 'In Progress (2)', 'Resolved (1)'];

  final List<Map<String, dynamic>> _tickets = [
    {
      'title': 'Request for Leave - Medical',
      'status': 'Open',
      'description': 'My son Rajesh has been unwell and needs to take leave for 3 days. Doctor has advised complete rest.',
      'parentName': 'Rajesh Singh',
      'date': 'Nov 8, 2025',
      'replies': 0,
    },
    {
      'title': 'Homework Clarification',
      'status': 'In Progress',
      'description': 'Could you please clarify the Science assignment for this week? My daughter is confused about the diagram.',
      'parentName': 'Priya Sharma',
      'date': 'Nov 7, 2025',
      'replies': 1,
    },
    {
      'title': 'Grade Inquiry',
      'status': 'Resolved',
      'description': 'I noticed my son scored lower in the recent Math test. Can we schedule a meeting to discuss areas of improvement?',
      'parentName': 'Amit Kumar',
      'date': 'Nov 5, 2025',
      'replies': 2,
    },
    {
      'title': 'Bus Route Change Request',
      'status': 'Open',
      'description': 'We\'ve recently moved to a new address. Can the bus route be adjusted accordingly?',
      'parentName': 'Sneha Reddy',
      'date': 'Nov 6, 2025',
      'replies': 0,
    },
    {
      'title': 'Extra Classes Request',
      'status': 'In Progress',
      'description': 'My daughter needs extra help with English. Are there any after-school tutoring sessions available?',
      'parentName': 'Kiran Patel',
      'date': 'Nov 4, 2025',
      'replies': 1,
    },
  ];

  void _toggleLanguage() {
    setState(() {
      _isTelugu = !_isTelugu;
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    ClassTeacherRoutes.handleBottomNavTap(context, index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgGrey,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
            decoration: BoxDecoration(
              color: _headerRed,
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.15), shape: BoxShape.circle),
                        child: const Icon(Icons.chevron_left, color: Colors.white, size: 20),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text('Parent Tickets', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    _buildStatCard('2', 'Open'),
                    const SizedBox(width: 12),
                    _buildStatCard('2', 'In Progress'),
                    const SizedBox(width: 12),
                    _buildStatCard('1', 'Resolved'),
                  ],
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: List.generate(_filters.length, (index) {
                final isSelected = _selectedFilterIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedFilterIndex = index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? _primaryBlue : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(_filters[index], style: TextStyle(color: isSelected ? Colors.white : _textDark, fontSize: 13, fontWeight: FontWeight.w600)),
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _tickets.length,
              itemBuilder: (context, index) => _buildTicketCard(_tickets[index], context),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 70,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: _primaryBlue, borderRadius: BorderRadius.circular(8)),
            child: const Center(child: Text('A', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20))),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Aditya International School', style: TextStyle(color: _textDark, fontSize: 16, fontWeight: FontWeight.bold)),
              Text('Powered by Toki Tech', style: TextStyle(color: Colors.grey[400], fontSize: 11)),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: _toggleLanguage,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade200), borderRadius: BorderRadius.circular(20)),
              child: Text(_isTelugu ? 'తెలుగు' : 'English', style: TextStyle(color: _primaryBlue, fontSize: 13, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String count, String label) {
    return Expanded(
      child: Container(
        height: 75,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: _statCardRed,
            borderRadius: BorderRadius.circular(12)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(count, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            Text(label, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 11)),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketCard(Map<String, dynamic> ticket, BuildContext context) {
    Color badgeBg = const Color(0xFFFEE2E2);
    Color badgeText = const Color(0xFFEF4444);
    String status = ticket['status'];

    if (status == 'In Progress') {
      badgeBg = const Color(0xFFFFF8E1);
      badgeText = const Color(0xFFFFB300);
    } else if (status == 'Resolved') {
      badgeBg = const Color(0xFFE0F2F1);
      badgeText = const Color(0xFF00BFA5);
    }

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ClassTeacherRoutes.ticketDetails,
          arguments: ticket,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 5, offset: const Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(ticket['title'], style: TextStyle(color: _textDark, fontWeight: FontWeight.bold, fontSize: 15), maxLines: 1, overflow: TextOverflow.ellipsis)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: badgeBg, borderRadius: BorderRadius.circular(12)),
                  child: Text(status, style: TextStyle(color: badgeText, fontSize: 11, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(ticket['description'], style: const TextStyle(color: Color(0xFF555555), fontSize: 13, height: 1.4), maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 12),
            const Divider(height: 1, thickness: 0.5),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(ticket['parentName'], style: TextStyle(color: Colors.grey[600], fontSize: 12, fontWeight: FontWeight.w500)),
                      const SizedBox(width: 8),
                      Text('•', style: TextStyle(color: Colors.grey[400])),
                      const SizedBox(width: 8),
                      Text(ticket['date'], style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                    ],
                  ),
                ),
                if (ticket['replies'] > 0)
                  Row(
                    children: [
                      Icon(Icons.chat_bubble_outline, size: 14, color: Colors.grey[500]),
                      const SizedBox(width: 4),
                      Text('${ticket['replies']} ${ticket['replies'] == 1 ? 'reply' : 'replies'}', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey.shade200))),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: _primaryBlue,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        elevation: 0,
        items: [
          BottomNavigationBarItem(icon: Icon(_currentIndex == 0 ? Icons.home_filled : Icons.home_outlined), label: 'Home'),
          const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: _currentIndex == 2 ? _selectedPurple : Colors.transparent, borderRadius: BorderRadius.circular(20)),
              child: const Icon(Icons.show_chart, size: 22),
            ),
            label: 'Activity',
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.more_vert), label: 'More'),
        ],
      ),
    );
  }
}