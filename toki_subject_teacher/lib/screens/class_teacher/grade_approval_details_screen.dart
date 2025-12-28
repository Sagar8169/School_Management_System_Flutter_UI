import 'package:flutter/material.dart';
import '../../routes/class_teacher_routes.dart';

class GradeApprovalDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> approval;

  const GradeApprovalDetailsScreen({Key? key, required this.approval}) : super(key: key);

  @override
  _GradeApprovalDetailsScreenState createState() => _GradeApprovalDetailsScreenState();
}

class _GradeApprovalDetailsScreenState extends State<GradeApprovalDetailsScreen> {
  int _currentIndex = 2;
  bool _isTelugu = true;
  final TextEditingController _commentController = TextEditingController();

  final Color _primaryBlue = const Color(0xFF2979FF);
  final Color _bgGrey = const Color(0xFFF9FAFB);
  final Color _textDark = const Color(0xFF1A1A1A);
  final Color _greenBtn = const Color(0xFF2ECC71);
  final Color _primaryYellow = const Color(0xFFFFB74D);
  final Color _selectedPurple = const Color(0xFFEADDFF);

  final List<Map<String, dynamic>> _students = [
    {'name': 'Rajesh Singh', 'roll': '15', 'score': '42/50', 'grade': 'Grade B+', 'color': 0xFF2979FF, 'bg': 0xFFE3F2FD},
    {'name': 'Priya Sharma', 'roll': '28', 'score': '46/50', 'grade': 'Grade A', 'color': 0xFF00C853, 'bg': 0xFFE8F5E9},
    {'name': 'Amit Kumar', 'roll': '05', 'score': '38/50', 'grade': 'Grade B', 'color': 0xFF2979FF, 'bg': 0xFFE3F2FD},
    {'name': 'Sneha Reddy', 'roll': '32', 'score': '48/50', 'grade': 'Grade A+', 'color': 0xFF00C853, 'bg': 0xFFE8F5E9},
    {'name': 'Kiran Patel', 'roll': '22', 'score': '35/50', 'grade': 'Grade C+', 'color': 0xFFFFAB00, 'bg': 0xFFFFF8E1},
  ];

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

    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(context, ClassTeacherRoutes.home, (route) => false);
        break;
      case 1:
        Navigator.pushNamedAndRemoveUntil(context, ClassTeacherRoutes.search, (route) => false);
        break;
      case 2:
        Navigator.pushNamedAndRemoveUntil(context, ClassTeacherRoutes.activity, (route) => false);
        break;
      case 3:
        Navigator.pushNamedAndRemoveUntil(context, ClassTeacherRoutes.settings, (route) => false);
        break;
    }
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
            color: Colors.white,
            child: Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(color: Color(0xFFF3F4F6), shape: BoxShape.circle),
                    child: const Icon(Icons.chevron_left, color: Colors.black, size: 20),
                  ),
                ),
                const SizedBox(width: 12),
                const Text('Grade Approval Details', style: TextStyle(color: Color(0xFF111827), fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMainInfoCard(),
                  const SizedBox(height: 20),
                  const Text('Student Grades (Top 5)', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF1A1A1A))),
                  const SizedBox(height: 12),
                  ..._students.map((s) => _buildStudentCard(s)).toList(),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(color: const Color(0xFFF5F7FF), borderRadius: BorderRadius.circular(8)),
                    child: Center(child: Text('View All ${widget.approval['students']} Students', style: TextStyle(color: _primaryBlue, fontWeight: FontWeight.w600, fontSize: 13))),
                  ),
                  const SizedBox(height: 24),
                  const Text('Add Comment (Optional)', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  const SizedBox(height: 8),
                  Container(
                    height: 120,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: const Color(0xFFF5F7FF), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
                    child: TextField(
                      controller: _commentController,
                      maxLines: null,
                      decoration: const InputDecoration(border: InputBorder.none, hintText: 'Add any feedback or comments for the teacher...', hintStyle: TextStyle(fontSize: 13, color: Colors.grey)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(backgroundColor: _greenBtn, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                            child: const Text('Approve Grades', style: TextStyle(fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(foregroundColor: _primaryBlue, side: BorderSide(color: _primaryBlue), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                            child: const Text('Request Changes', style: TextStyle(fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
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

  Widget _buildMainInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 2))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(widget.approval['subject'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFFFFF8E1), borderRadius: BorderRadius.circular(6)),
                child: const Text('Pending', style: TextStyle(color: Color(0xFFFFA000), fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(widget.approval['title'], style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 4),
          Text('Teacher: ${widget.approval['teacher']}', style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 4),
          Text('Submitted: ${widget.approval['date']}', style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoStat('Total Students', '${widget.approval['students']}', _primaryBlue),
              _buildInfoStat('Average Score', widget.approval['avgScore'], const Color(0xFFFFAB00)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoStat(String label, String val, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 4),
        Text(val, style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildStudentCard(Map<String, dynamic> student) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(student['name'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              const SizedBox(height: 4),
              Text('Roll No: ${student['roll']}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(student['score'], style: TextStyle(color: Color(student['color']), fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: Color(student['bg']), borderRadius: BorderRadius.circular(6)),
                child: Text(student['grade'], style: TextStyle(color: Color(student['color']), fontSize: 11, fontWeight: FontWeight.bold)),
              ),
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