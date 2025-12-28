// lib/screens/class_teacher/ticket_details.dart
import 'package:flutter/material.dart';
import '../../routes/class_teacher_routes.dart';

class TicketDetailsPage extends StatefulWidget {
  final Map<String, dynamic> ticket;

  const TicketDetailsPage({Key? key, required this.ticket}) : super(key: key);

  @override
  _TicketDetailsPageState createState() => _TicketDetailsPageState();
}

class _TicketDetailsPageState extends State<TicketDetailsPage> {
  int _currentIndex = 0;
  bool _isTelugu = true;
  final TextEditingController _replyController = TextEditingController();

  final Color _primaryBlue = const Color(0xFF2979FF);
  final Color _textDark = const Color(0xFF1A1A1A);
  final Color _bgGrey = const Color(0xFFF9FAFB);
  final Color _selectedPurple = const Color(0xFFEADDFF);

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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: _bgGrey,
            child: Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: Color(0xFFF3F4F6),
                        shape: BoxShape.circle
                    ),
                    child: const Icon(
                        Icons.chevron_left,
                        color: Colors.black,
                        size: 20
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                    'Ticket Details',
                    style: TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                    )
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTicketInfoCard(),
                  const SizedBox(height: 24),
                  const Text(
                      'Add Reply',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF111827)
                      )
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 140,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: const Color(0xFFF5F7FF),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200)
                    ),
                    child: TextField(
                      controller: _replyController,
                      maxLines: null,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Type your message here...',
                          hintStyle: TextStyle(fontSize: 14, color: Colors.grey)
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _buildAttachButton(Icons.add, 'Attach File')),
                      const SizedBox(width: 12),
                      Expanded(child: _buildAttachButton(Icons.mic_none_outlined, 'Voice Note')),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: _primaryBlue,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)
                                )
                            ),
                            child: const Text('Send Reply', style: TextStyle(fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                                foregroundColor: _primaryBlue,
                                side: BorderSide(color: _primaryBlue),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)
                                )
                            ),
                            child: const Text('Mark as Resolved', style: TextStyle(fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
            decoration: BoxDecoration(
                color: _primaryBlue,
                borderRadius: BorderRadius.circular(8)
            ),
            child: const Center(
              child: Text(
                  'A',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  )
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Aditya International School',
                  style: TextStyle(
                      color: _textDark,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  )
              ),
              Text(
                  'Powered by Toki Tech',
                  style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 11
                  )
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: _toggleLanguage,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Text(
                  _isTelugu ? 'తెలుగు' : 'English',
                  style: TextStyle(
                      color: _primaryBlue,
                      fontSize: 13,
                      fontWeight: FontWeight.w600
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketInfoCard() {
    Color badgeBg = const Color(0xFFFEE2E2);
    Color badgeText = const Color(0xFFEF4444);
    String status = widget.ticket['status'];

    if (status == 'In Progress') {
      badgeBg = const Color(0xFFFFF8E1);
      badgeText = const Color(0xFFFFB300);
    } else if (status == 'Resolved') {
      badgeBg = const Color(0xFFE0F2F1);
      badgeText = const Color(0xFF00BFA5);
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2)
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Text(
                      widget.ticket['title'],
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF111827)
                      )
                  )
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                    color: badgeBg,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Text(
                    status,
                    style: TextStyle(
                        color: badgeText,
                        fontSize: 12,
                        fontWeight: FontWeight.w500
                    )
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
              'Student: ${widget.ticket['parentName'].split(' ').first}',
              style: const TextStyle(color: Colors.grey, fontSize: 13)
          ),
          const SizedBox(height: 4),
          Text(
              'Parent: ${widget.ticket['parentName']}',
              style: const TextStyle(color: Colors.grey, fontSize: 13)
          ),
          const SizedBox(height: 4),
          Text(
              widget.ticket['date'],
              style: const TextStyle(color: Colors.grey, fontSize: 13)
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 16),
          Text(
              widget.ticket['description'],
              style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF374151),
                  height: 1.5
              )
          ),
        ],
      ),
    );
  }

  Widget _buildAttachButton(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: const Color(0xFFEFF6FF),
          borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: _primaryBlue, size: 18),
          const SizedBox(width: 8),
          Text(
              label,
              style: TextStyle(
                  color: _primaryBlue,
                  fontWeight: FontWeight.w500,
                  fontSize: 13
              )
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade200))
      ),
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
          BottomNavigationBarItem(
            icon: Icon(_currentIndex == 0 ? Icons.home_filled : Icons.home_outlined),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _currentIndex == 2 ? _selectedPurple : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.show_chart, size: 22),
            ),
            label: 'Activity',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.more_vert),
            label: 'More',
          ),
        ],
      ),
    );
  }
}