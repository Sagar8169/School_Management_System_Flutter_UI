import 'package:flutter/material.dart';
import 'package:toki/routes/subject_teacher_routes.dart';

class AddHomeworkPage extends StatefulWidget {
  const AddHomeworkPage({Key? key}) : super(key: key);

  @override
  State<AddHomeworkPage> createState() => _AddHomeworkPageState();
}

class _AddHomeworkPageState extends State<AddHomeworkPage> {
  bool _isTelugu = false;

  String selectedClass = 'Class 8B';
  String selectedSubject = 'Science';
  DateTime? dueDate;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final List<String> classes = ['Class 8B', 'Class 9A', 'Class 10C'];
  final List<String> subjects = [
    'Science',
    'Mathematics',
    'Physics',
    'Chemistry',
    'Biology'
  ];

  final Color _primaryPurple = const Color(0xFF7C3AED);
  final Color _bgLight = const Color(0xFFF8FAFC);

  // ✅ LOGIC: Assign Homework with Validation
  void _handleAssignHomework() {
    if (_titleController.text.trim().isEmpty) {
      _showSnackBar("Please enter a homework title!", Colors.redAccent);
      return;
    }
    if (dueDate == null) {
      _showSnackBar("Please select a due date!", Colors.orange);
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Icon(Icons.check_circle, color: Colors.green, size: 60),
        content: const Text(
          "Homework Assigned Successfully!",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Go back
              },
              child: Text("Done",
                  style: TextStyle(
                      color: _primaryPurple, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // ✅ STYLISH PICKER LOGIC
  void _showPicker(String title, List<String> items, String currentVal,
      Function(String) onSelect) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10))),
              const SizedBox(height: 20),
              Text("Select $title",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w900)),
              const Divider(thickness: 1, indent: 20, endIndent: 20),
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.4),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final bool isSelected = currentVal == item;
                    return GestureDetector(
                      onTap: () {
                        onSelect(item);
                        Navigator.pop(context);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? _primaryPurple.withOpacity(0.1)
                              : Colors.grey[50],
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: isSelected
                                  ? _primaryPurple
                                  : Colors.transparent,
                              width: 1.5),
                        ),
                        child: Center(
                            child: Text(item,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? _primaryPurple
                                        : Colors.black87))),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
      builder: (context, child) => Theme(
          data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(primary: _primaryPurple)),
          child: child!),
    );
    if (picked != null) setState(() => dueDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      body: SafeArea(
        child: Column(
          children: [
            _buildExactHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSelectionGrid(),
                    const SizedBox(height: 24),
                    _buildStylishInputCard(
                        "Homework Title",
                        "e.g. Science Project: Photosynthesis",
                        _titleController,
                        1,
                        Icons.title_rounded),
                    _buildStylishInputCard(
                        "Description",
                        "Detail out the tasks for students...",
                        _descriptionController,
                        5,
                        Icons.description_outlined),
                    _buildAttachmentCard(),
                    const SizedBox(height: 32),
                    _buildAssignButton(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExactHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 1, offset: Offset(0, 1))
      ]),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: _primaryPurple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(Icons.arrow_back_ios_new_rounded,
                  color: _primaryPurple, size: 20),
            ),
          ),
          const SizedBox(width: 16),
          const Text("Add Homework",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B))),
          const Spacer(),
          GestureDetector(
            onTap: () => setState(() => _isTelugu = !_isTelugu),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                  border: Border.all(color: _primaryPurple.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(_isTelugu ? 'ಕನ್ನಡ' : 'English',
                  style: TextStyle(
                      color: _primaryPurple,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionGrid() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 20,
                offset: const Offset(0, 10))
          ]),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: InkWell(
                      onTap: () => _showPicker("Class", classes, selectedClass,
                          (v) => setState(() => selectedClass = v)),
                      child: _selectorTile(
                          "Class", selectedClass, Icons.school_outlined))),
              Container(width: 1, height: 40, color: Colors.grey[100]),
              Expanded(
                  child: InkWell(
                      onTap: () => _showPicker(
                          "Subject",
                          subjects,
                          selectedSubject,
                          (v) => setState(() => selectedSubject = v)),
                      child: _selectorTile(
                          "Subject", selectedSubject, Icons.book_outlined))),
            ],
          ),
          const Divider(height: 1),
          InkWell(
            onTap: () => _selectDueDate(context),
            child: _selectorTile(
                "Due Date",
                dueDate == null
                    ? "Select Deadline"
                    : "${dueDate!.day}/${dueDate!.month}/${dueDate!.year}",
                Icons.calendar_today_outlined),
          ),
        ],
      ),
    );
  }

  Widget _selectorTile(String l, String v, IconData i) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(i, size: 12, color: Colors.grey),
            const SizedBox(width: 4),
            Text(l.toUpperCase(),
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1))
          ]),
          const SizedBox(height: 6),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(v,
                style:
                    const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
            const Icon(Icons.keyboard_arrow_down_rounded,
                color: Colors.grey, size: 18)
          ]),
        ]),
      );

  Widget _buildStylishInputCard(String label, String hint,
      TextEditingController controller, int lines, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 15,
              offset: const Offset(0, 8))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: _primaryPurple.withOpacity(0.7)),
              const SizedBox(width: 8),
              Text(label.toUpperCase(),
                  style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0)),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            maxLines: lines,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E293B)),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
              border: InputBorder.none,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("ATTACHMENTS (OPTIONAL)",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1)),
          const SizedBox(height: 16),
          Row(
            children: [
              _attachBtn(Icons.attach_file, "File"),
              _attachBtn(Icons.camera_alt_outlined, "Photo"),
              _attachBtn(Icons.link, "Link"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _attachBtn(IconData i, String l) => Expanded(
        child: Column(children: [
          CircleAvatar(
              backgroundColor: _bgLight,
              child: Icon(i, color: _primaryPurple, size: 20)),
          const SizedBox(height: 6),
          Text(l,
              style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600)),
        ]),
      );

  Widget _buildAssignButton() {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: _handleAssignHomework,
        style: ElevatedButton.styleFrom(
            backgroundColor: _primaryPurple,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            elevation: 4,
            shadowColor: _primaryPurple.withOpacity(0.4)),
        child: const Text('Assign Homework',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
