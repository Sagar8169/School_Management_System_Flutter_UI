import 'package:flutter/material.dart';
import '../../routes/class_teacher_routes.dart';

class CreateNewTaskScreen extends StatefulWidget {
  const CreateNewTaskScreen({Key? key}) : super(key: key);

  @override
  _CreateNewTaskScreenState createState() => _CreateNewTaskScreenState();
}

class _CreateNewTaskScreenState extends State<CreateNewTaskScreen> {
  int _currentIndex = 2;
  int _selectedPriority = 1;
  bool _isTelugu = true;

  final Color _primaryBlue = const Color(0xFF2979FF);
  final Color _textDark = const Color(0xFF1A1A1A);
  final Color _selectedPurple = const Color(0xFFEADDFF);

  final List<Map<String, String>> _teachers = [
    {'name': 'Mr. Vijay Prasad', 'subject': 'Science'},
    {'name': 'Mrs. Anita Desai', 'subject': 'English'},
    {'name': 'Mrs. Lakshmi Devi', 'subject': 'Hindi'},
    {'name': 'Mr. Ravi Verma', 'subject': 'Social Studies'},
    {'name': 'Mrs. Priya Singh', 'subject': 'Computer Science'},
    {'name': 'Mr. Suresh Babu', 'subject': 'Physical Education'},
    {'name': 'Mrs. Meera Nair', 'subject': 'Art & Craft'},
    {'name': 'Mr. Rajesh Kumar', 'subject': 'Music'},
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
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFF0F0F0)))),
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
                const Text('Create New Task', style: TextStyle(color: Color(0xFF1A1A1A), fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('Task Title'),
                  const SizedBox(height: 8),
                  _buildTextField('e.g., Upload Term 1 Grades'),
                  const SizedBox(height: 24),
                  _buildLabel('Assign to Teacher'),
                  const SizedBox(height: 8),
                  ..._teachers.map((teacher) => _buildTeacherItem(teacher)).toList(),
                  const SizedBox(height: 24),
                  _buildLabel('Due Date'),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
                    child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [SizedBox()]),
                  ),
                  const SizedBox(height: 24),
                  _buildLabel('Priority Level'),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: _buildPriorityBtn(0, 'High', const Color(0xFFD32F2F))),
                      const SizedBox(width: 12),
                      Expanded(child: _buildPriorityBtn(1, 'Medium', const Color(0xFFFFA000))),
                      const SizedBox(width: 12),
                      Expanded(child: _buildPriorityBtn(2, 'Low', const Color(0xFF00C853))),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildLabel('Task Description'),
                  const SizedBox(height: 8),
                  Container(
                    height: 120,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
                    child: const TextField(
                      maxLines: null,
                      decoration: InputDecoration(border: InputBorder.none, hintText: 'Provide detailed instructions for the task...', hintStyle: TextStyle(fontSize: 14, color: Colors.grey)),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(foregroundColor: _primaryBlue, side: BorderSide(color: _primaryBlue), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                            child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300], foregroundColor: Colors.black54, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                            child: const Text('Assign Task', style: TextStyle(fontWeight: FontWeight.w600)),
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

  Widget _buildLabel(String text) {
    return Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1A1A1A)));
  }

  Widget _buildTextField(String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
      child: TextField(decoration: InputDecoration(border: InputBorder.none, hintText: hint, hintStyle: const TextStyle(fontSize: 14, color: Colors.grey))),
    );
  }

  Widget _buildTeacherItem(Map<String, String> teacher) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(teacher['name']!, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(height: 2),
          Text(teacher['subject']!, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildPriorityBtn(int index, String label, Color dotColor) {
    bool isSelected = _selectedPriority == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedPriority = index),
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? _primaryBlue : Colors.grey.shade300, width: isSelected ? 1.5 : 1),
          color: isSelected ? Colors.blue.withOpacity(0.05) : Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 8, height: 8, decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle)),
            const SizedBox(width: 8),
            Text(label, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: isSelected ? Colors.black : Colors.grey[600])),
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