import 'package:flutter/material.dart';
import '../../routes/principal_routes.dart';
import 'dart:math';

class TakeAttendancePage extends StatefulWidget {
  const TakeAttendancePage({super.key});

  @override
  State<TakeAttendancePage> createState() => _TakeAttendancePageState();
}

class _TakeAttendancePageState extends State<TakeAttendancePage> {
  // int _currentIndex = 2;
  bool _isTelugu = true;
  String _selectedClass = 'Class 10-A';
  String _selectedDateLabel = 'Today';
  DateTime _currentDate = DateTime.now();
  bool _isMarking = false;
  bool _allPresent = false;
  bool _isReadOnly = false; // Naya: History mode ke liye

  final List<String> _classes = [
    'Class 10-A',
    'Class 10-B',
    'Class 9-A',
    'Class 9-B',
    'Class 8-A',
    'Class 8-B',
    'Class 7-A',
    'Class 7-B',
  ];

  List<Map<String, dynamic>> _students = [
    {
      'id': '1',
      'name': 'Rahul Sharma',
      'rollNumber': '1001',
      'isPresent': true,
      'avatarColor': Color(0xFF10B981)
    },
    {
      'id': '2',
      'name': 'Priya Patel',
      'rollNumber': '1002',
      'isPresent': true,
      'avatarColor': Color(0xFF2563EB)
    },
    {
      'id': '3',
      'name': 'Amit Kumar',
      'rollNumber': '1003',
      'isPresent': true,
      'avatarColor': Color(0xFFF59E0B)
    },
    {
      'id': '4',
      'name': 'Sneha Reddy',
      'rollNumber': '1004',
      'isPresent': false,
      'avatarColor': Color(0xFF8B5CF6)
    },
    {
      'id': '5',
      'name': 'Vikram Singh',
      'rollNumber': '1005',
      'isPresent': true,
      'avatarColor': Color(0xFFEF4444)
    },
    {
      'id': '6',
      'name': 'Anjali Gupta',
      'rollNumber': '1006',
      'isPresent': true,
      'avatarColor': Color(0xFF06B6D4)
    },
    {
      'id': '7',
      'name': 'Rajesh Iyer',
      'rollNumber': '1007',
      'isPresent': true,
      'avatarColor': Color(0xFF84CC16)
    },
    {
      'id': '8',
      'name': 'Meera Joshi',
      'rollNumber': '1008',
      'isPresent': false,
      'avatarColor': Color(0xFFF97316)
    },
  ];

  final List<String> _dateOptions = ['Today', 'Yesterday', 'Custom Date'];

  // --- LOGIC: DATA LOADING ---
  void _loadAttendanceData(bool readOnly) {
    final random = Random();
    setState(() {
      _isReadOnly = readOnly;
      _allPresent = false;
      for (var student in _students) {
        if (!readOnly) {
          student['isPresent'] = true; // Today marking starts with all present
        } else {
          student['isPresent'] = random.nextBool(); // Dummy History
        }
      }
    });
  }

  Future<void> _selectCustomDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _currentDate,
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF1D4ED8))),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _currentDate = picked;
        _selectedDateLabel = "${picked.day}/${picked.month}/${picked.year}";
      });
      _loadAttendanceData(true); // Purani date = Read Only
    }
  }

  void _handleDateSelection(String option) {
    if (option == 'Today') {
      setState(() {
        _selectedDateLabel = 'Today';
        _currentDate = DateTime.now();
      });
      _loadAttendanceData(false); // Today = Marking Mode
    } else if (option == 'Yesterday') {
      setState(() {
        _selectedDateLabel = 'Yesterday';
        _currentDate = DateTime.now().subtract(const Duration(days: 1));
      });
      _loadAttendanceData(true); // Yesterday = History Mode
    } else {
      _selectCustomDate();
    }
  }

  void _toggleAllPresent() {
    if (_isReadOnly) return;
    setState(() {
      _allPresent = !_allPresent;
      for (var student in _students) {
        student['isPresent'] = _allPresent;
      }
    });
  }

  void _toggleStudentAttendance(int index) {
    if (_isReadOnly) return;
    setState(
        () => _students[index]['isPresent'] = !_students[index]['isPresent']);
  }

  void _saveOrUpdateAttendance() {
    setState(() => _isMarking = true);
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isMarking = false;
        _isReadOnly = true; // After saving, go back to history mode
      });
      _showSuccessDialog();
    });
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
    int presentCount = _students.where((s) => s['isPresent'] == true).length;
    int totalCount = _students.length;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildOriginalHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildClassSelectionCard(),
                    const SizedBox(height: 25),
                    _buildDateSelection(),
                    const SizedBox(height: 25),
                    _buildAttendanceSummary(presentCount, totalCount),
                    const SizedBox(height: 30),
                    _buildStudentsHeader(),
                    const SizedBox(height: 16),
                    _buildStudentsList(),
                    const SizedBox(height: 35),
                    _buildActionButtons(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: _buildModernBottomNav(),
    );
  }

  // --- UI WIDGETS ---
  Widget _buildOriginalHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        MediaQuery.of(context).padding.top + 0,
        20,
        10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6), // 👈 shadow only at bottom
          ),
        ],
      ),
      child: Row(
        children: [
          // 🔙 Circular Back Button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 42,
              width: 42,
              decoration: const BoxDecoration(
                color: Color(0xFFF1F5F9),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: Color(0xFF1D4ED8),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // 🏫 Title + Subtitle
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Attendance Log',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Aditya International School',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),

          // 🌐 Language Toggle
          GestureDetector(
            onTap: () => setState(() => _isTelugu = !_isTelugu),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _isTelugu ? 'తెలుగు' : 'English',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1D4ED8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openClassPickerSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          top: false, // sirf bottom safe area chahiye
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: const BoxDecoration(
              color: Color(0xFFF8FAFC),
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 12),

                // pull handle
                Container(
                  width: 44,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 20),

                // header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 40),
                    const Text(
                      "Select Class",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),

                const Divider(height: 1),

                // list
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                    itemCount: _classes.length,
                    itemBuilder: (context, index) {
                      final cls = _classes[index];
                      final bool isSelected = cls == _selectedClass;

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFEFF6FF)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF1D4ED8)
                                : Colors.grey.shade200,
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            cls,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: isSelected
                                  ? const Color(0xFF1D4ED8)
                                  : const Color(0xFF1E293B),
                            ),
                          ),
                          trailing: isSelected
                              ? const Icon(Icons.check_circle_rounded,
                                  color: Color(0xFF1D4ED8))
                              : const Icon(Icons.arrow_forward_ios_rounded,
                                  size: 14),
                          onTap: () {
                            setState(() => _selectedClass = cls);
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildClassSelectionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E40AF), Color(0xFF3B82F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'SELECTED CLASS',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 10),

          /// 👉 TAP AREA
          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: _openClassPickerSheet,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedClass,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_up_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "DATE CONTEXT",
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w900,
            color: Color(0xFF64748B),
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(height: 14),

        Container(
          height: 54,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: _dateOptions.map((date) {
              final bool isSelected =
                  (date == 'Custom Date' && _selectedDateLabel.contains('/')) ||
                      date == _selectedDateLabel;

              return Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => _handleDateSelection(date),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 280),
                    curve: Curves.easeOutCubic,
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? const LinearGradient(
                              colors: [
                                Color(0xFF1D4ED8),
                                Color(0xFF2563EB),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : null,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (date == "Custom Date")
                            Icon(
                              Icons.calendar_today_rounded,
                              size: 14,
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF94A3B8),
                            ),
                          if (date == "Custom Date") const SizedBox(width: 6),
                          Text(
                            date == 'Custom Date' &&
                                    _selectedDateLabel.contains('/')
                                ? _selectedDateLabel
                                : date,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 8),

        // helper text
        Text(
          _selectedDateLabel == "Today"
              ? "you are marking attendance"
              : "viewing attendance history",
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFF94A3B8),
          ),
        ),
      ],
    );
  }

  Widget _buildAttendanceSummary(int present, int total) {
    int absent = total - present;
    // Percentage calculation for a more detailed insight
    double attendanceRate = total > 0 ? (present / total) * 100 : 0;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E293B).withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildSummaryItem("Present", "$present", Icons.person_pin_rounded,
              const Color(0xFF10B981) // Emerald Green
              ),
          _buildVerticalDivider(),
          _buildSummaryItem("Absent", "$absent", Icons.person_off_rounded,
              const Color(0xFFEF4444) // Rose Red
              ),
          _buildVerticalDivider(),
          _buildSummaryItem(
              "Status",
              _isReadOnly ? "History" : "Editing",
              _isReadOnly
                  ? Icons.auto_stories_rounded
                  : Icons.edit_note_rounded,
              const Color(0xFFF59E0B) // Amber/Orange
              ),
        ],
      ),
    );
  }

// Custom Stat Item Widget
  Widget _buildSummaryItem(
      String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1E293B),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w800,
              color: Colors.grey.shade500,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }

// Subtle Vertical Divider
  Widget _buildVerticalDivider() {
    return Container(
      height: 40,
      width: 1.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.grey.withOpacity(0.0),
            Colors.grey.withOpacity(0.2),
            Colors.grey.withOpacity(0.0),
          ],
        ),
      ),
    );
  }

  Widget _summaryPill(String label, String val, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.2))),
      child: Column(children: [
        Text(val,
            style: TextStyle(
                fontWeight: FontWeight.w900, color: color, fontSize: 16)),
        Text(label,
            style: TextStyle(
                fontSize: 10, color: color, fontWeight: FontWeight.bold))
      ]),
    );
  }

  Widget _buildStudentsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // --- SECTION TITLE WITH STATUS DOT ---
        Row(
          children: [
            Container(
              width: 4,
              height: 16,
              decoration: BoxDecoration(
                color: _isReadOnly
                    ? Colors.blueGrey.shade300
                    : const Color(0xFF1D4ED8),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              _isReadOnly ? "ATTENDANCE HISTORY" : "MARK ATTENDANCE",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w900,
                color: Colors.blueGrey.shade700,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),

        // --- DYNAMIC ACTION BUTTON ---
        if (!_isReadOnly)
          _buildHeaderAction(
            onTap: _toggleAllPresent,
            icon: _allPresent
                ? Icons.check_circle_rounded
                : Icons.radio_button_off_rounded,
            label: _allPresent ? "All Marked" : "Mark All",
            color: const Color(0xFF1D4ED8),
            isOutlined: !_allPresent,
          )
        else
          _buildHeaderAction(
            onTap: () => setState(() => _isReadOnly = false),
            icon: Icons.edit_document,
            label: "Edit Record",
            color: const Color(0xFF1D4ED8),
            isOutlined: true,
          ),
      ],
    );
  }

// Custom Action Button for Header
  Widget _buildHeaderAction({
    required VoidCallback onTap,
    required IconData icon,
    required String label,
    required Color color,
    required bool isOutlined,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isOutlined ? color.withOpacity(0.05) : color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isOutlined ? color.withOpacity(0.2) : Colors.transparent,
            width: 1.2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: isOutlined ? color : Colors.white),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 12,
                color: isOutlined ? color : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentsList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _students.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final student = _students[index];
        final bool present = student['isPresent'];

        // Dynamic Colors based on attendance status
        final Color statusColor = present
            ? const Color(0xFF10B981)
            : const Color(0xFFEF4444); // Green vs Red

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            // --- BORDER COLOR UPDATES ON STATUS ---
            border: Border.all(
              color: statusColor.withOpacity(0.2),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: statusColor.withOpacity(0.03),
                blurRadius: 15,
                offset: const Offset(0, 8),
              )
            ],
          ),
          child: Row(
            children: [
              // 1. Student Avatar with Dynamic Ring
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: statusColor.withOpacity(0.3), width: 1),
                ),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: statusColor.withOpacity(0.08),
                  child: Text(student['name'][0],
                      style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 14)),
                ),
              ),
              const SizedBox(width: 14),

              // 2. Name & Identity
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student['name'],
                      style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                          color: Color(0xFF1E293B)),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "ROLL NO: ${student['rollNumber']}",
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5),
                    ),
                  ],
                ),
              ),

              // 3. Status Button / Badge
              _isReadOnly
                  ? _buildStatusBadge(present, statusColor)
                  : _buildInteractiveToggle(index, present, statusColor),
            ],
          ),
        );
      },
    );
  }

// --- READ ONLY BADGE (Red/Green) ---
  Widget _buildStatusBadge(bool present, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        present ? "PRESENT" : "ABSENT",
        style: TextStyle(
            color: color,
            fontWeight: FontWeight.w900,
            fontSize: 10,
            letterSpacing: 0.5),
      ),
    );
  }

// --- INTERACTIVE TOGGLE (With Red Alert for Absent) ---
  Widget _buildInteractiveToggle(int index, bool present, Color color) {
    return InkWell(
      onTap: () => _toggleStudentAttendance(index),
      borderRadius: BorderRadius.circular(14),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: color, // Full Red or Full Green
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Text(
          present ? "PRESENT" : "ABSENT",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 10,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    if (_isReadOnly) {
      return Container(
        width: double.infinity,
        height: 58,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
        ),
        child: OutlinedButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              size: 18, color: Color(0xFF64748B)),
          label: const Text("Return to Dashboard",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E293B),
                  fontSize: 15)),
          style: OutlinedButton.styleFrom(
            side: BorderSide
                .none, // Custom border container se handle ho raha hai
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
      );
    }

    return Column(
      children: [
        // --- PRIMARY ACTION BUTTON (CONFIRM/SAVE) ---
        Container(
          width: double.infinity,
          height: 62,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF10B981).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: _isMarking ? null : _saveOrUpdateAttendance,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22)),
              elevation: 0,
            ),
            child: _isMarking
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 3),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                          _selectedDateLabel == 'Today'
                              ? Icons.check_circle_outline
                              : Icons.cloud_upload_outlined,
                          size: 20),
                      const SizedBox(width: 10),
                      Text(
                        _selectedDateLabel == 'Today'
                            ? "Confirm Attendance"
                            : "Update Records",
                        style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            letterSpacing: 0.5),
                      ),
                    ],
                  ),
          ),
        ),

        const SizedBox(height: 12),

        // --- SECONDARY ACTION (DISCARD) ---
        TextButton(
          onPressed: () => setState(() => _isReadOnly = true),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.close_rounded, size: 16, color: Colors.red.shade400),
              const SizedBox(width: 6),
              Text(
                "Discard Changes",
                style: TextStyle(
                    color: Colors.red.shade400,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    letterSpacing: 0.3),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: true, // User bahar click karke band kar sake
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Content ke hisaab se height lega
            children: [
              // --- TOP ICON WITH GLOW ---
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: Color(0xFF10B981),
                  size: 60,
                ),
              ),
              const SizedBox(height: 24),

              // --- TITLE ---
              const Text(
                "Sync Successful!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 12),

              // --- CONTENT ---
              Text(
                "Attendance for $_selectedDateLabel has been saved.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 32),

              // --- CUSTOM BUTTON ---
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E293B), // Dark Slate
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Done",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // Widget _buildModernBottomNav() {
  //   return BottomNavigationBar(
  //     currentIndex: _currentIndex, onTap: _onBottomNavTapped,
  //     type: BottomNavigationBarType.fixed, selectedItemColor: const Color(0xFF1D4ED8), unselectedItemColor: const Color(0xFF94A3B8),
  //     elevation: 20, backgroundColor: Colors.white,
  //     selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
  //     items: const [
  //       BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
  //       BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: 'Search'),
  //       BottomNavigationBarItem(icon: Icon(Icons.analytics_rounded), label: 'Activity'),
  //       BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'More'),
  //     ],
  //   );
  // }
}
