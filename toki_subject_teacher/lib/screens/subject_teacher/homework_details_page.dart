import 'package:flutter/material.dart';
import 'package:toki/routes/subject_teacher_routes.dart';

class HomeworkDetailsPage extends StatefulWidget {
  final Map<String, dynamic> homeworkData;

  const HomeworkDetailsPage({Key? key, required this.homeworkData})
      : super(key: key);

  @override
  State<HomeworkDetailsPage> createState() => _HomeworkDetailsPageState();
}

class _HomeworkDetailsPageState extends State<HomeworkDetailsPage> {
  bool _isTelugu = false;

  final Color _primaryPurple = const Color(0xFF7C3AED);
  final Color _bgLight = const Color(0xFFF8FAFC);

  @override
  Widget build(BuildContext context) {
    // Status Logic - Keep it exactly like original
    Color statusCol;
    switch (widget.homeworkData['status']) {
      case 'Active':
        statusCol = Colors.blue;
        break;
      case 'Submitted':
        statusCol = Colors.green;
        break;
      case 'Upcoming':
        statusCol = Colors.orange;
        break;
      case 'Overdue':
        statusCol = Colors.red;
        break;
      default:
        statusCol = Colors.grey;
    }

    return Scaffold(
      backgroundColor: _bgLight,
      body: SafeArea(
        child: Column(
          children: [
            _buildExactHeader(), // ✅ Original Synced Header
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMainHeroCard(statusCol),
                    const SizedBox(height: 24),
                    _buildSectionLabel("Description"),
                    const SizedBox(height: 12),
                    _buildDescriptionBox(),
                    const SizedBox(height: 24),
                    if (widget.homeworkData['attachments'] > 0) ...[
                      _buildSectionLabel("Attachments"),
                      const SizedBox(height: 12),
                      _buildAttachmentsList(),
                      const SizedBox(height: 24),
                    ],
                    _buildSectionLabel("Submission Analytics"),
                    const SizedBox(height: 12),
                    _buildSubmissionStats(),
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

  // --- 1. HEADER (PREVIOUS CODE STYLE) ---
  Widget _buildExactHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 1, offset: Offset(0, 1))
        ],
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
          const Text("Homework Detail",
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

  // --- 2. MAIN HERO INFO CARD ---
  Widget _buildMainHeroCard(Color statusCol) {
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
          Text(widget.homeworkData['title'],
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E293B))),
          const SizedBox(height: 16),
          Row(
            children: [
              _badge(widget.homeworkData['status'], statusCol),
              const SizedBox(width: 8),
              _badge(widget.homeworkData['subject'], _primaryPurple),
            ],
          ),
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Divider(height: 1)),
          _infoRow(
              Icons.school_outlined, "Class", widget.homeworkData['class']),
          const SizedBox(height: 12),
          _infoRow(Icons.calendar_today_outlined, "Assigned Date",
              widget.homeworkData['assignedDate']),
          const SizedBox(height: 12),
          _infoRow(Icons.event_busy_outlined, "Due Date",
              widget.homeworkData['dueDate']),
        ],
      ),
    );
  }

  // --- 3. SUBMISSION ANALYTICS ---
  Widget _buildSubmissionStats() {
    final parts = widget.homeworkData['submissions'].split('/');
    final double rate = (int.parse(parts[0]) / int.parse(parts[1]) * 100);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient:
            LinearGradient(colors: [_primaryPurple, const Color(0xFF4338CA)]),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _statItem(parts[0], "DONE", Colors.greenAccent),
          Container(width: 1, height: 30, color: Colors.white12),
          _statItem(parts[1], "TOTAL", Colors.white70),
          Container(width: 1, height: 30, color: Colors.white12),
          _statItem("${rate.toStringAsFixed(1)}%", "RATE", Colors.orangeAccent),
        ],
      ),
    );
  }

  // --- Helper Widgets ---
  Widget _buildDescriptionBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Text(
          widget.homeworkData['description'] ?? "No description available.",
          style: const TextStyle(
              color: Color(0xFF475569), height: 1.6, fontSize: 14)),
    );
  }

  Widget _buildAttachmentsList() {
    return Column(
      children: List.generate(
          widget.homeworkData['attachments'],
          (index) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  children: [
                    const CircleAvatar(
                        backgroundColor: Color(0xFFE3F2FD),
                        child: Icon(Icons.picture_as_pdf_rounded,
                            color: Colors.blue, size: 20)),
                    const SizedBox(width: 12),
                    const Expanded(
                        child: Text("Attachment.pdf",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 13))),
                    Icon(Icons.download_rounded, color: _primaryPurple),
                  ],
                ),
              )),
    );
  }

  Widget _badge(String txt, Color col) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
            color: col.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10)),
        child: Text(txt,
            style: TextStyle(
                color: col, fontSize: 11, fontWeight: FontWeight.w800)),
      );

  Widget _infoRow(IconData icon, String label, String val) => Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey.shade400),
          const SizedBox(width: 12),
          Text("$label: ",
              style: const TextStyle(color: Colors.grey, fontSize: 13)),
          Text(val,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Color(0xFF334155))),
        ],
      );

  Widget _statItem(String val, String label, Color col) => Column(
        children: [
          Text(val,
              style: TextStyle(
                  color: col, fontSize: 24, fontWeight: FontWeight.w900)),
          Text(label,
              style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 9,
                  fontWeight: FontWeight.bold)),
        ],
      );

  Widget _buildSectionLabel(String text) => Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Text(text.toUpperCase(),
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w900,
                color: Colors.grey,
                letterSpacing: 1.2)),
      );
}
