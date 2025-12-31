import 'package:flutter/material.dart';
import '../../routes/subject_teacher_routes.dart';

class TaskDetailsPage extends StatefulWidget {
  final Map<String, dynamic> taskData;

  const TaskDetailsPage({Key? key, required this.taskData}) : super(key: key);

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  bool _isTelugu = false;

  // ✅ Strictly Original Theme Colors
  final Color _primaryPurple = const Color(0xFF9570FF);
  final Color _bgLight = const Color(0xFFF8FAFC);

  @override
  Widget build(BuildContext context) {
    // ✅ Keep Original Status Colors
    Color statusBg;
    Color statusTxt;
    if (widget.taskData['status'] == 'Completed') {
      statusBg = const Color(0xFFE8F5E9);
      statusTxt = Colors.green;
    } else if (widget.taskData['status'] == 'In Progress') {
      statusBg = const Color(0xFFE3F2FD);
      statusTxt = Colors.blue;
    } else {
      statusBg = const Color(0xFFFFF3E0);
      statusTxt = Colors.orange;
    }

    return Scaffold(
      backgroundColor: _bgLight,
      body: SafeArea(
        child: Column(
          children: [
            _buildExactHeader(), // ✅ Synced Header
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- SECTION 1: MAIN INFO CARD ---
                    _buildMainInfoCard(statusBg, statusTxt),
                    const SizedBox(height: 24),

                    // --- SECTION 2: DESCRIPTION ---
                    const Text("Description",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF1E293B))),
                    const SizedBox(height: 12),
                    _buildContentCard(
                      child: Text(
                        widget.taskData['description'] ??
                            "No description available.",
                        style: const TextStyle(
                            color: Color(0xFF475569),
                            height: 1.6,
                            fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // --- SECTION 3: ASSIGNED BY ---
                    const Text("Assigned By",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF1E293B))),
                    const SizedBox(height: 12),
                    _buildAssigneeSection(),
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

  // --- 1. HEADER (SYCNED STYLE) ---
  Widget _buildExactHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 1)],
      ),
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
          const Text("Task Details",
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

  // --- 2. MAIN CARD (Original Logic) ---
  Widget _buildMainInfoCard(Color statusBg, Color statusTxt) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, 10))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.taskData['title'],
              style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E293B))),
          const SizedBox(height: 16),
          Row(
            children: [
              _statusBadge(widget.taskData['status'], statusBg, statusTxt),
              const SizedBox(width: 8),
              _statusBadge(widget.taskData['tag'], const Color(0xFFE8EAF6),
                  const Color(0xFF3949AB)),
            ],
          ),
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Divider(height: 1)),
          _buildDetailRow(
              Icons.class_outlined,
              "Class",
              widget.taskData['class'],
              const Color(0xFFE8EAF6),
              const Color(0xFF3949AB)),
          const SizedBox(height: 16),
          _buildDetailRow(
              Icons.assignment_turned_in_outlined,
              "Submissions",
              widget.taskData['submissions'],
              const Color(0xFFE8F5E9),
              const Color(0xFF4CAF50)),
          const SizedBox(height: 16),
          _buildDetailRow(
              Icons.calendar_today_rounded,
              "Due Date",
              widget.taskData['dueDate'],
              const Color(0xFFFCE4EC),
              const Color(0xFFE91E63)),
        ],
      ),
    );
  }

  // --- 3. ASSIGNEE SECTION ---
  Widget _buildAssigneeSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.03)),
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: const BoxDecoration(
                color: Color(0xFFE3F2FD), shape: BoxShape.circle),
            child:
                const Icon(Icons.person_rounded, color: Colors.blue, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.taskData['assignedBy'] ?? "Admin",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color(0xFF1E293B))),
                Text(widget.taskData['assigneeRole'] ?? "Staff",
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widgets ---
  Widget _statusBadge(String txt, Color bg, Color txtCol) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration:
            BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
        child: Text(txt,
            style: TextStyle(
                color: txtCol, fontSize: 11, fontWeight: FontWeight.w800)),
      );

  Widget _buildDetailRow(
      IconData icon, String label, String value, Color bg, Color iconColor) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration:
              BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(color: Colors.grey, fontSize: 12)),
            Text(value,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF334155))),
          ],
        ),
      ],
    );
  }

  Widget _buildContentCard({required Widget child}) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.black.withOpacity(0.01))),
        child: child,
      );
}
