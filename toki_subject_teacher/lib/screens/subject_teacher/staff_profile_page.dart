import 'package:flutter/material.dart';
import 'package:toki/routes/subject_teacher_routes.dart';
import '../../widgets/common_widgets.dart';

class StaffProfilePage extends StatefulWidget {
  final Map<String, dynamic> staffData;

  const StaffProfilePage({super.key, required this.staffData});

  @override
  State<StaffProfilePage> createState() => _StaffProfilePageState();
}

class _StaffProfilePageState extends State<StaffProfilePage> {
  bool _isTelugu = true;

  void _toggleLanguage() {
    setState(() {
      _isTelugu = !_isTelugu;
    });
  }

  void _navigateTo(String routeName, {Map<String, dynamic>? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: Column(
          children: [
            CommonWidgets.appHeader(
              selectedLanguage: _isTelugu ? 'తెలుగు' : 'English',
              onLanguageToggle: _toggleLanguage,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 16),

                    // Back + Title Row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.black12.withOpacity(0.06),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.arrow_back, size: 18),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            "Staff Profile",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Staff Profile Card - Updated UI
                    _buildProfileCard(),

                    const SizedBox(height: 20),

                    // Contact Information Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          _buildSectionTitle("Contact Information"),
                          const SizedBox(height: 12),
                          _buildContactInformation(),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Work Details Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          _buildSectionTitle("Work Details"),
                          const SizedBox(height: 12),
                          _buildWorkDetails(),
                        ],
                      ),
                    ),

                    // Class Information (for teachers)
                    if (widget.staffData['type'] == 'teacher') ...[
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            _buildSectionTitle("Class Information"),
                            const SizedBox(height: 12),
                            _buildClassInformation(),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 30),

                    // Action Buttons
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _buildActionButtons(),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    final bool isActive = widget.staffData['isActive'] as bool;
    final bool isClassTeacher = widget.staffData['isClassTeacher'] ?? false;
    final Color statusColor =
        isActive ? const Color(0xFF27AE60) : const Color(0xFFE6A100);
    final Color statusBgColor =
        isActive ? const Color(0xFFE5FFF0) : const Color(0xFFFFF4D9);
    final String statusText = isActive ? 'Active' : 'Not Active';
    final Color avatarColor = widget.staffData['type'] == 'teacher'
        ? const Color(0xFFFFF3D9)
        : const Color(0xFFEAF2FF);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.black12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.03),
              blurRadius: 6,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar, Name, Role, Status
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: avatarColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    widget.staffData['type'] == 'teacher'
                        ? Icons.person
                        : Icons.badge,
                    size: 24,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 12),
                // Name and Role
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.staffData['name'].toString(),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.staffData['role'].toString(),
                        style:
                            const TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                // Status Chip
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(height: 1, color: Colors.black12),
            const SizedBox(height: 12),
            // Department and Employee ID
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Department
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Department",
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                    const SizedBox(height: 6),
                    Text(
                      widget.staffData['department'].toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                // Employee ID
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text("Employee ID",
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                    const SizedBox(height: 6),
                    Text(
                      widget.staffData['employeeId'].toString(),
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              ],
            ),
            // Class Information for Teachers
            if (widget.staffData['type'] == 'teacher') ...[
              const SizedBox(height: 16),
              Container(height: 1, color: Colors.black12),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Assigned Class
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Assigned Class",
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                      const SizedBox(height: 6),
                      Text(
                        widget.staffData['assignedClass']?.toString() ??
                            'Multiple Classes',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  // Class Teacher Badge
                  if (isClassTeacher)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5FFF0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 12,
                            color: const Color(0xFF27AE60),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Class Teacher',
                            style: TextStyle(
                              color: const Color(0xFF27AE60),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildContactInformation() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [
          _buildContactItem('Phone Number', '+91 98765 43210'),
          const SizedBox(height: 12),
          Divider(height: 1, color: Colors.grey.shade200),
          const SizedBox(height: 12),
          _buildContactItem('Email Address',
              '${widget.staffData['name'].toString().toLowerCase().replaceAll(' ', '.')}@adityaschool.edu'),
          const SizedBox(height: 12),
          Divider(height: 1, color: Colors.grey.shade200),
          const SizedBox(height: 12),
          _buildContactItem('Address', '123 Staff Quarters, School Campus'),
        ],
      ),
    );
  }

  Widget _buildContactItem(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF6B7280),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildWorkDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [
          _buildWorkDetailItem('Shift Timing', '9:00 AM - 5:00 PM'),
          const SizedBox(height: 12),
          Divider(height: 1, color: Colors.grey.shade200),
          const SizedBox(height: 12),
          _buildWorkDetailItem('Join Date', 'January 15, 2020'),
          const SizedBox(height: 12),
          Divider(height: 1, color: Colors.grey.shade200),
          const SizedBox(height: 12),
          _buildWorkDetailItem('Work Location', 'Main Campus'),
          if (widget.staffData['department'] == 'Fleet Management') ...[
            const SizedBox(height: 12),
            Divider(height: 1, color: Colors.grey.shade200),
            const SizedBox(height: 12),
            _buildWorkDetailItem(
                'License Number', 'DL-${widget.staffData['employeeId']}'),
          ],
        ],
      ),
    );
  }

  Widget _buildClassInformation() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [
          _buildWorkDetailItem(
              'Subjects Taught', getSubjectsForRole(widget.staffData['role'])),
          const SizedBox(height: 12),
          Divider(height: 1, color: Colors.grey.shade200),
          const SizedBox(height: 12),
          _buildWorkDetailItem('Class Strength', '42 students'),
          const SizedBox(height: 12),
          Divider(height: 1, color: Colors.grey.shade200),
          const SizedBox(height: 12),
          _buildWorkDetailItem('Classroom', 'Room 101 - 2nd Floor'),
        ],
      ),
    );
  }

  String getSubjectsForRole(String role) {
    if (role.contains('Mathematics')) return 'Mathematics';
    if (role.contains('Science')) return 'Physics, Chemistry, Biology';
    if (role.contains('English')) return 'English Language & Literature';
    if (role.contains('Social')) return 'History, Geography, Civics';
    return 'General Subjects';
  }

  Widget _buildWorkDetailItem(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF6B7280),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        // View Schedule Button
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              _showScheduleMessage();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563EB),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'View Schedule',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Contact Staff Button
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton(
            onPressed: () {
              _showContactMessage();
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF2563EB),
              side: const BorderSide(color: Color(0xFF2563EB)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              backgroundColor: Colors.white,
            ),
            child: const Text(
              'Contact Staff',
              style: TextStyle(
                color: Color(0xFF2563EB),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        if (widget.staffData['type'] == 'teacher') ...[
          const SizedBox(height: 12),
        ],
        if (widget.staffData['department'] == 'Fleet Management') ...[
          const SizedBox(height: 12),
          // View Bus Details Button
        ],
      ],
    );
  }

  void _showScheduleMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Schedule for ${widget.staffData['name']}'),
        backgroundColor: const Color(0xFF10B981),
      ),
    );
  }

  void _showContactMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Contact ${widget.staffData['name']}'),
        backgroundColor: const Color(0xFF10B981),
      ),
    );
  }
}
