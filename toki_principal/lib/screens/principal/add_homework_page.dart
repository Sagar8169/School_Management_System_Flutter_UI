import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // Naya package functional upload ke liye
import '../../routes/principal_routes.dart';

class AddHomeworkPage extends StatefulWidget {
  const AddHomeworkPage({super.key});

  @override
  State<AddHomeworkPage> createState() => _AddHomeworkPageState();
}

class _AddHomeworkPageState extends State<AddHomeworkPage> {
  // int _currentIndex = 2;
  bool _isTelugu = false;
  bool _isAssigning = false;

  // File Upload State
  PlatformFile? _pickedFile; // Selected file store karne ke liye

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  String _selectedClass = 'Class 10-A';
  String _selectedSubject = 'Mathematics';
  DateTime _dueDate = DateTime.now().add(const Duration(days: 1));

  final List<String> _classes = [
    'Class 10-A',
    'Class 10-B',
    'Class 9-A',
    'Class 8-A'
  ];
  final List<String> _subjects = [
    'Mathematics',
    'Science',
    'English',
    'Social Studies',
    'Hindi'
  ];

  // --- LOGIC: FILE PICKER ---
  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'pdf',
          'jpg',
          'jpeg',
          'png'
        ], // PDF aur Images allowed hain
      );

      if (result != null) {
        setState(() {
          _pickedFile = result.files.first;
        });
      }
    } catch (e) {
      debugPrint("Error picking file: $e");
    }
  }

  void _removeFile() {
    setState(() {
      _pickedFile = null;
    });
  }

  // --- LOGIC FUNCTIONS ---
  void _toggleLanguage() => setState(() => _isTelugu = !_isTelugu);

  Future<void> _selectDueDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
    );
    if (picked != null) setState(() => _dueDate = picked);
  }

  void _assignHomework() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please enter homework title"),
          behavior: SnackBarBehavior.floating));
      return;
    }

    setState(() => _isAssigning = true);

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isAssigning = false);
      _showSuccessDialog();
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        title: const Icon(Icons.assignment_turned_in_rounded,
            color: Color(0xFF1D4ED8), size: 50),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Homework Assigned!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 10),
            Text(
              "Homework for $_selectedSubject has been assigned to $_selectedClass.${_pickedFile != null ? '\nWorksheet: ${_pickedFile!.name}' : ''}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("Done",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }

  // void _onBottomNavTapped(int index) {
  //   if (index == _currentIndex) return;
  //   setState(() => _currentIndex = index);
  //   switch (index) {
  //     case 0: Navigator.pushReplacementNamed(context, PrincipalRoutes.home); break;
  //     case 1: Navigator.pushNamed(context, PrincipalRoutes.search); break;
  //     case 3: Navigator.pushNamed(context, PrincipalRoutes.morePage); break;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildScreenshotHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader("1", "Class & Subject Selection"),
                    _buildTargetCard(),
                    const SizedBox(height: 25),
                    _buildSectionHeader("2", "Homework Details"),
                    _buildDetailsCard(),
                    const SizedBox(height: 35),
                    _buildAssignButton(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: _buildScreenshotBottomNav(),
    );
  }

  Widget _buildScreenshotHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios,
                    color: Color(0xFF1D4ED8), size: 22),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Add Homework',
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B))),
                  const SizedBox(height: 2),
                  Text('Aditya International School',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ],
          ),
          InkWell(
            onTap: _toggleLanguage,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(30)),
              child: Text(_isTelugu ? 'తెలుగు' : 'English',
                  style: const TextStyle(
                      color: Color(0xFF1D4ED8),
                      fontWeight: FontWeight.w700,
                      fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 4),
      child: Row(
        children: [
          CircleAvatar(
              radius: 11,
              backgroundColor: const Color(0xFFFBBF24),
              child: Text(number,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold))),
          const SizedBox(width: 10),
          Text(text,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF334155))),
        ],
      ),
    );
  }

  Widget _buildTargetCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),

        // ✅ LIGHT CLEAN BORDER
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1,
        ),

        // existing shadow untouched
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildDropdownField(
            "Select Class",
            _selectedClass,
            _classes,
            (v) => setState(() => _selectedClass = v!),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            "Select Subject",
            _selectedSubject,
            _subjects,
            (v) => setState(() => _selectedSubject = v!),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 15,
              offset: const Offset(0, 5))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel("Homework Title"),
          TextField(
              controller: _titleController,
              decoration: _inputDeco(Icons.edit_note_rounded,
                  hint: "e.g. Exercise 4.2 Fractions")),
          const SizedBox(height: 16),
          _buildLabel("Detailed Instructions"),
          TextField(
              controller: _descController,
              maxLines: 4,
              decoration: _inputDeco(Icons.description_rounded,
                  hint: "Enter homework details or questions...")),
          const SizedBox(height: 16),
          _buildLabel("Submission Deadline"),
          InkWell(
            onTap: _selectDueDate,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12)),
              child: Row(children: [
                const Icon(Icons.calendar_month_rounded,
                    size: 20, color: Color(0xFF1D4ED8)),
                const SizedBox(width: 10),
                Text("${_dueDate.day}/${_dueDate.month}/${_dueDate.year}",
                    style: const TextStyle(fontWeight: FontWeight.w600))
              ]),
            ),
          ),
          const SizedBox(height: 16),
          _buildAttachmentSection(), // Functional File Picker Section
        ],
      ),
    );
  }

  // --- FUNCTIONAL ATTACHMENT SECTION ---
  Widget _buildAttachmentSection() {
    return Column(
      children: [
        if (_pickedFile != null)
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Icon(
                    _pickedFile!.extension == 'pdf'
                        ? Icons.picture_as_pdf
                        : Icons.image,
                    color: Colors.blue),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _pickedFile!.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ),
                IconButton(
                  onPressed: _removeFile,
                  icon: const Icon(Icons.cancel, color: Colors.redAccent),
                )
              ],
            ),
          ),
        OutlinedButton.icon(
          onPressed: _pickFile,
          icon: const Icon(Icons.attach_file_rounded),
          label: Text(_pickedFile == null
              ? "Attach Worksheet (PDF/Image)"
              : "Change File"),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            side: BorderSide(color: Colors.grey.shade200),
          ),
        ),
      ],
    );
  }

  Widget _buildAssignButton() {
    return Container(
      width: double.infinity,
      height: 58,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: const Color(0xFF1D4ED8).withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8))
      ]),
      child: ElevatedButton(
        onPressed: _isAssigning ? null : _assignHomework,
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1D4ED8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            elevation: 0),
        child: _isAssigning
            ? const CircularProgressIndicator(
                color: Colors.white, strokeWidth: 3)
            : const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.send_rounded, color: Colors.white),
                SizedBox(width: 10),
                Text("Assign & Notify Students",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: 16))
              ]),
      ),
    );
  }

  Widget _buildDropdownField(
      String label, String val, List<String> items, Function(String?) onCh) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: val,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  color: Colors.blueGrey),
              items: items
                  .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600))))
                  .toList(),
              onChanged: onCh,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) => Padding(
      padding: const EdgeInsets.only(bottom: 6, left: 2),
      child: Text(text,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey)));

  InputDecoration _inputDeco(IconData icon, {String? hint}) => InputDecoration(
        prefixIcon: Icon(icon, size: 20, color: const Color(0xFF1D4ED8)),
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
      );

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

  // Widget _buildScreenshotBottomNav() {
  //   return BottomNavigationBar(
  //     currentIndex: _currentIndex,
  //     onTap: _onBottomNavTapped,
  //     type: BottomNavigationBarType.fixed,
  //     selectedItemColor: const Color(0xFF1D4ED8),
  //     unselectedItemColor: const Color(0xFF64748B),
  //     items: const [
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.home_rounded),
  //         label: "Home",
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.search_rounded),
  //         label: "Search",
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.analytics_rounded),
  //         label: "Activity",
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.grid_view_rounded),
  //         label: "More",
  //       ),
  //     ],
  //   );
  // }
}
