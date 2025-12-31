import 'package:flutter/material.dart';
import '../../routes/subject_teacher_routes.dart';

class SubjectTeacherProfilePage extends StatefulWidget {
  final Map<String, dynamic> teacherData;

  const SubjectTeacherProfilePage({super.key, required this.teacherData});

  @override
  State<SubjectTeacherProfilePage> createState() =>
      _SubjectTeacherProfilePageState();
}

class _SubjectTeacherProfilePageState extends State<SubjectTeacherProfilePage> {
  bool _isTelugu = false;

  final Color _primaryPurple = const Color(0xFF7C3AED);
  final Color _indigoDeep = const Color(0xFF4338CA);
  final Color _bgLight = const Color(0xFFF8FAFC);

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
                child: Column(
                  children: [
                    _buildPremiumHeroSection(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          _buildInfoSection('Contact Information', [
                            _buildContactItem(Icons.phone_rounded, Colors.green,
                                'Phone', widget.teacherData['phone']),
                            _buildContactItem(Icons.email_rounded, Colors.blue,
                                'Email', widget.teacherData['email']),
                            _buildContactItem(
                                Icons.location_on_rounded,
                                Colors.orange,
                                'Address',
                                widget.teacherData['address']),
                          ]),
                          const SizedBox(height: 20),
                          _buildInfoSection('Work & Teaching', [
                            _buildWorkRow('Shift Timing', '9:00 AM - 5:00 PM'),
                            _buildWorkRow(
                                'Join Date', widget.teacherData['joinDate']),
                            _buildWorkRow('Work Location',
                                widget.teacherData['workLocation']),
                            const Divider(height: 32),
                            _buildWorkRow(
                                'Subjects', widget.teacherData['subjects']),
                            _buildWorkRow('Assigned Classes',
                                widget.teacherData['assignedClass']),
                            _buildWorkRow('Total Students', '132 Students'),
                          ]),
                          const SizedBox(height: 20),
                          _buildPerformanceCard(),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- 1. HEADER (Synced Style) ---
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
          const Text("My Profile",
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

  // --- 2. PREMIUM HERO SECTION ---
  Widget _buildPremiumHeroSection() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [_indigoDeep, _primaryPurple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
              color: _indigoDeep.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10))
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white24)),
                child: const Icon(Icons.person_rounded,
                    color: Colors.white, size: 40),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.teacherData['name'],
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w900)),
                    Text(widget.teacherData['role'],
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              _statusBadge(),
            ],
          ),
          const SizedBox(height: 24),
          _buildHeroStatsHub(),
        ],
      ),
    );
  }

  Widget _buildHeroStatsHub() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _heroStatItem(widget.teacherData['employeeId'], 'ID'),
          _verticalDivider(),
          _heroStatItem(widget.teacherData['department'], 'Dept'),
          _verticalDivider(),
          _heroStatItem('88.5%', 'Rating'),
        ],
      ),
    );
  }

  // --- 3. INFO SECTION HELPER ---
  Widget _buildInfoSection(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E293B))),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  // --- 4. PERFORMANCE CARD ---
  Widget _buildPerformanceCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Performance Overview',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _metricCol("92%", "Attendance"),
              _metricCol("85%", "Avg Grade"),
              _metricCol("88%", "Tasks"),
            ],
          ),
          const SizedBox(height: 20),
          _performanceInsights(),
        ],
      ),
    );
  }

  // --- SMALLER HELPERS ---
  Widget _statusBadge() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.greenAccent.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10)),
        child: const Text('ACTIVE',
            style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 10,
                fontWeight: FontWeight.w900)),
      );

  Widget _heroStatItem(String val, String label) => Column(children: [
        Text(val,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w900)),
        Text(label,
            style: const TextStyle(
                color: Colors.white70,
                fontSize: 10,
                fontWeight: FontWeight.bold)),
      ]);

  Widget _verticalDivider() =>
      Container(width: 1, height: 25, color: Colors.white12);

  Widget _buildContactItem(
          IconData icon, Color color, String label, String value) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: color.withOpacity(0.1), shape: BoxShape.circle),
                child: Icon(icon, color: color, size: 18)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(label,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                            fontWeight: FontWeight.bold)),
                    Text(value,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(0xFF334155))),
                  ]),
            ),
          ],
        ),
      );

  Widget _buildWorkRow(String label, String value) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(label,
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.w500)),
          Text(value,
              style: const TextStyle(
                  color: Color(0xFF1E293B),
                  fontSize: 13,
                  fontWeight: FontWeight.w800)),
        ]),
      );

  Widget _metricCol(String val, String label) => Column(children: [
        Text(val,
            style: TextStyle(
                color: _primaryPurple,
                fontSize: 20,
                fontWeight: FontWeight.w900)),
        Text(label,
            style: const TextStyle(
                color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
      ]);

  Widget _performanceInsights() => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: _primaryPurple.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _primaryPurple.withOpacity(0.1))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Performance Insights',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: _primaryPurple)),
          const SizedBox(height: 8),
          const Text(
              '• Strong performance in Class 8B\n• Timely task submissions maintain rating',
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.blueGrey,
                  height: 1.5,
                  fontWeight: FontWeight.w500)),
        ]),
      );
}
