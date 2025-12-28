// lib/screens/class_teacher/task_assignment_screen.dart
import 'package:flutter/material.dart';
import '../../routes/class_teacher_routes.dart';

class TaskAssignmentScreen extends StatefulWidget {
  const TaskAssignmentScreen({Key? key}) : super(key: key);

  @override
  _TaskAssignmentScreenState createState() => _TaskAssignmentScreenState();
}

class _TaskAssignmentScreenState extends State<TaskAssignmentScreen> {
  int _currentIndex = 2;
  int _selectedFilterIndex = 0;
  bool _isTelugu = true;
  bool _showMyPendingOnly = false;
  final String _currentUser = 'Mr. Vijay Prasad';

  final Color _headerPurple = const Color(0xFF9575CD);
  final Color _cardPurple = const Color(0xFF7E57C2);
  final Color _primaryBlue = const Color(0xFF2979FF);
  final Color _textDark = const Color(0xFF1A1A1A);
  final Color _bgGrey = const Color(0xFFF9FAFB);
  final Color _selectedPurple = const Color(0xFFEADDFF);

  final List<String> _filters = ['All', 'Pending', 'In Progress', 'Completed'];

  final List<Map<String, dynamic>> _tasks = [
    {
      'title': 'Upload Term 1 Grades',
      'teacher': 'Mr. Vijay Prasad',
      'subject': 'Science',
      'status': 'Pending',
      'priority': 'High',
      'dueDate': 'Nov 15, 2025',
    },
    {
      'title': 'Prepare Unit Test 4',
      'teacher': 'Mrs. Anita Desai',
      'subject': 'English',
      'status': 'In Progress',
      'priority': 'Medium',
      'dueDate': 'Nov 20, 2025',
    },
    {
      'title': 'Submit Lesson Plan',
      'teacher': 'Mrs. Lakshmi Devi',
      'subject': 'Hindi',
      'status': 'Pending',
      'priority': 'High',
      'dueDate': 'Nov 12, 2025',
    },
    {
      'title': 'Sports Day Preparation',
      'teacher': 'Mr. Suresh Babu',
      'subject': 'Physical Education',
      'status': 'In Progress',
      'priority': 'Medium',
      'dueDate': 'Nov 18, 2025',
    },
    {
      'title': 'Science Fair Project Review',
      'teacher': 'Mr. Vijay Prasad',
      'subject': 'Science',
      'status': 'Completed',
      'priority': 'Low',
      'dueDate': 'Nov 10, 2025',
    },
    {
      'title': 'Lab Equipment Audit',
      'teacher': 'Mr. Vijay Prasad',
      'subject': 'Science',
      'status': 'Pending',
      'priority': 'Medium',
      'dueDate': 'Nov 25, 2025',
    },
  ];

  List<Map<String, dynamic>> get _filteredTasks {
    return _tasks.where((task) {
      if (_showMyPendingOnly) {
        return task['teacher'] == _currentUser && task['status'] == 'Pending';
      }
      if (_selectedFilterIndex == 0) return true;
      String filterStatus = _filters[_selectedFilterIndex];
      return task['status'] == filterStatus;
    }).toList();
  }

  void _toggleLanguage() {
    setState(() {
      _isTelugu = !_isTelugu;
    });
  }

  void _onTabTapped(int index) {
    if (index == _currentIndex) return;

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
              decoration: BoxDecoration(
                color: _headerPurple,
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
                          decoration: BoxDecoration(color: Colors.black.withOpacity(0.1), shape: BoxShape.circle),
                          child: const Icon(Icons.chevron_left, color: Colors.white, size: 20),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text('Task Assignment', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      _buildStatCard('2', 'Pending'),
                      const SizedBox(width: 12),
                      _buildStatCard('2', 'In Progress'),
                      const SizedBox(width: 12),
                      _buildStatCard('1', 'Completed'),
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
                  final isSelected = _selectedFilterIndex == index && !_showMyPendingOnly;
                  return GestureDetector(
                    onTap: () => setState(() {
                      _selectedFilterIndex = index;
                      _showMyPendingOnly = false;
                    }),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? _primaryBlue : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: isSelected ? null : Border.all(color: Colors.grey.shade200),
                      ),
                      child: Text(_filters[index], style: TextStyle(color: isSelected ? Colors.white : _textDark, fontSize: 13, fontWeight: FontWeight.w600)),
                    ),
                  );
                }),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                  color: _showMyPendingOnly ? Colors.orange.shade50 : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: _showMyPendingOnly ? Border.all(color: Colors.orange.shade200) : null),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person_outline, size: 20, color: _showMyPendingOnly ? Colors.orange[800] : Colors.grey[600]),
                      const SizedBox(width: 8),
                      Text("My Pending Tasks Only", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _showMyPendingOnly ? Colors.orange[800] : _textDark)),
                    ],
                  ),
                  Switch(
                    value: _showMyPendingOnly,
                    activeColor: Colors.orange,
                    onChanged: (val) => setState(() => _showMyPendingOnly = val),
                  ),
                ],
              ),
            ),
            ListView.builder(
              padding: const EdgeInsets.all(16),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _filteredTasks.length,
              itemBuilder: (context, index) => _buildTaskCard(_filteredTasks[index]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, ClassTeacherRoutes.createNewTask), // FIXED: Changed to named route
                  style: ElevatedButton.styleFrom(backgroundColor: _primaryBlue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 2),
                  child: const Text('+ Create New Task', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
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
        decoration: BoxDecoration(color: _cardPurple, borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(count, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            Text(label, style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 11)),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    Color statusBg = const Color(0xFFFFF8E1);
    Color statusText = const Color(0xFFFFA000);
    if (task['status'] == 'In Progress') {
      statusBg = const Color(0xFFE3F2FD);
      statusText = const Color(0xFF2979FF);
    } else if (task['status'] == 'Completed') {
      statusBg = const Color(0xFFE8F5E9);
      statusText = const Color(0xFF00C853);
    }

    Color priorityBg = const Color(0xFFFFEBEE);
    Color priorityText = const Color(0xFFD32F2F);
    if (task['priority'] == 'Medium') {
      priorityBg = const Color(0xFFFFF8E1);
      priorityText = const Color(0xFFFFA000);
    } else if (task['priority'] == 'Low') {
      priorityBg = const Color(0xFFFFF8E1);
      priorityText = const Color(0xFFFFA000);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 5, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(task['title'], style: TextStyle(color: _textDark, fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 4),
          Text('${task['teacher']} • ${task['subject']}', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(6)),
                child: Text(task['status'], style: TextStyle(color: statusText, fontSize: 12, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: priorityBg, borderRadius: BorderRadius.circular(6)),
                child: Text(task['priority'], style: TextStyle(color: priorityText, fontSize: 12, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.calendar_today_outlined, size: 14, color: Colors.grey[600]),
              const SizedBox(width: 6),
              Text('Due: ${task['dueDate']}', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            ],
          ),
        ],
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