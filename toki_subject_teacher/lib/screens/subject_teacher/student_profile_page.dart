import 'package:flutter/material.dart';
import 'package:toki/routes/subject_teacher_routes.dart';

class StudentProfilePage extends StatefulWidget {
  final Map<String, dynamic> studentData;

  const StudentProfilePage({super.key, required this.studentData});

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  int _currentIndex = 1;
  bool _isTelugu = true;

  final List<Map<String, dynamic>> _subjectsPerformance = [
    {'subject': 'Mathematics', 'score': 42, 'status': 'Critical'},
    {'subject': 'Science', 'score': 38, 'status': 'Critical'},
    {'subject': 'English', 'score': 55, 'status': 'Average'},
    {'subject': 'Hindi', 'score': 62, 'status': 'Good'},
    {'subject': 'Social Studies', 'score': 48, 'status': 'Critical'},
  ];

  bool get _isCritical => widget.studentData['isCritical'] as bool;

  void _toggleLanguage() => setState(() => _isTelugu = !_isTelugu);

  // ✅ REDIRECTION LOGIC MAINTAINED
  void _navigateTo(String routeName, {Map<String, dynamic>? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  void _onBottomNavTapped(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
    switch (index) {
      case 0:
        Navigator.of(context).pushNamedAndRemoveUntil(SubjectTeacherRoutes.home, (route) => false);
        break;
      case 1:
        Navigator.pushNamed(context, SubjectTeacherRoutes.search);
        break;
      case 2:
        Navigator.pushNamed(context, SubjectTeacherRoutes.activity);
        break;
      case 3:
        Navigator.pushNamed(context, SubjectTeacherRoutes.morePage, arguments: {'section': null});
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(), // Original Branding Header
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _buildProfileHeroSection(),
                    const SizedBox(height: 8),
                    _buildAcademicPerformanceCard(),
                    const SizedBox(height: 8),
                    _buildSubjectPerformanceList(),
                    const SizedBox(height: 8),
                    _buildParentInformation(),
                    const SizedBox(height: 24),
                    _buildActionButtons(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // --- TOP HEADER (BRANDING) ---
// --- HEADER: MATCHED TO YOUR EXAMPLE CODE ---
// --- HEADER: COLOR & UI MATCHED TO YOUR EXAMPLE ---
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 1,
            offset: Offset(0, 1),
          )
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF7C3AED).withOpacity(0.1), // ✅ Purple Accent
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Color(0xFF7C3AED), // ✅ Purple Color
                  size: 20
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              "Student Profile",
              style: TextStyle(
                color: Color(0xFF1E293B),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: _toggleLanguage,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF7C3AED).withOpacity(0.3)), // ✅ Purple Border
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _isTelugu ? 'తెలుగు' : 'English',
                style: const TextStyle(
                  color: Color(0xFF7C3AED), // ✅ Purple Text
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- PROFILE HERO SECTION (GRADIENT) ---
  Widget _buildProfileHeroSection() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _isCritical ? [const Color(0xFFB63C2E), const Color(0xFFD65747)] : [const Color(0xFF2FAE6C), const Color(0xFF4CC68A)],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white.withOpacity(0.2),
                child: const Icon(Icons.person, color: Colors.white, size: 35),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.studentData['name'].toString(), style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(widget.studentData['details']?.toString() ?? 'Not Specified', style: const TextStyle(color: Colors.white70, fontSize: 13)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                child: Text(_isCritical ? 'Critical' : 'Good', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Divider(color: Colors.white24, height: 1)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHeroStat("STUDENT ID", widget.studentData['details'].toString().split('•').last.trim()),
              _buildHeroStat("ROLL NO", "15"),
              _buildHeroStat("SECTION", "A"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroStat(String l, String v) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(l, style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
    const SizedBox(height: 4),
    Text(v, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
  ]);

  // --- ACADEMIC PERFORMANCE CARD ---
  Widget _buildAcademicPerformanceCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.black.withOpacity(0.05))),
      child: Column(
        children: [
          const Text("Academic Performance", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF334155))),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatValue('${widget.studentData['avgGrade']}%', "Avg Grade", _isCritical ? const Color(0xFFDC2626) : const Color(0xFF2FAE6C)),
              Container(width: 1, height: 40, color: Colors.black12),
              _buildStatValue('${widget.studentData['attendance']}%', "Attendance", const Color(0xFFE67E22)),
            ],
          ),
          if (_isCritical) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: const Color(0xFFFFEAEA), borderRadius: BorderRadius.circular(12)),
              child: const Row(children: [
                Icon(Icons.error_outline, color: Colors.red, size: 20),
                SizedBox(width: 10),
                Expanded(child: Text("Requires Attention: Student performance is extremely below average.", style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w600))),
              ]),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildStatValue(String v, String l, Color c) => Column(children: [
    Text(v, style: TextStyle(color: c, fontSize: 24, fontWeight: FontWeight.bold)),
    Text(l, style: const TextStyle(color: Colors.grey, fontSize: 12)),
  ]);

  // --- SUBJECT LIST: REDIRECTS TO GRADES ANALYTICS ---
  Widget _buildSubjectPerformanceList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Subject Performance", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              TextButton(
                  onPressed: () => _navigateTo(SubjectTeacherRoutes.gradesAnalytics, arguments: {'studentData': widget.studentData}),
                  child: const Text('View Details >', style: TextStyle(color: Color(0xFF2563EB), fontWeight: FontWeight.bold, fontSize: 13))
              ),
            ],
          ),
          const SizedBox(height: 8),
          ..._subjectsPerformance.map((s) {
            final color = _getGradeColor(s['score'].toDouble());
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.black.withOpacity(0.05))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(s['subject'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 4),
                    Text(s['status'], style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
                  ]),
                  Text("${s['score']}%", style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // --- GUARDIAN INFORMATION ---
  Widget _buildParentInformation() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.black.withOpacity(0.05))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Guardian Information", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _infoTile(Icons.person_rounded, "Parent Name", "Mr. Suresh Singh", const Color(0xFF2962FF)),
          const Divider(height: 24),
          _infoTile(Icons.phone_rounded, "Phone Number", "+91 98765 43210", const Color(0xFF2ECC71)),
          const Divider(height: 24),
          _infoTile(Icons.calendar_month, "Date of Birth", "March 15, 2010", const Color(0xFFE67E22)),
        ],
      ),
    );
  }

  Widget _infoTile(IconData i, String t, String v, Color c) => Row(children: [
    CircleAvatar(radius: 18, backgroundColor: c.withOpacity(0.1), child: Icon(i, color: c, size: 18)),
    const SizedBox(width: 12),
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(t, style: const TextStyle(color: Colors.grey, fontSize: 11)),
      Text(v, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
    ]),
  ]);

  // --- ACTION BUTTONS: DEDICATED REDIRECTIONS ---
  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // ✅ REDIRECTS TO GRADES ANALYTICS
          _btn("View Full Academic Report", Icons.analytics_outlined, const Color(0xFF2962FF), true, () {
            _navigateTo(SubjectTeacherRoutes.gradesAnalytics, arguments: {'studentData': widget.studentData});
          }),
          const SizedBox(height: 12),
          // ✅ REDIRECTS TO ATTENDANCE ANALYTICS
          _btn("View Attendance History", Icons.calendar_month_outlined, const Color(0xFF2962FF), false, () {
            _navigateTo(SubjectTeacherRoutes.attendanceAnalytics, arguments: {'studentData': widget.studentData});
          }),
          const SizedBox(height: 12),
          _btn("Contact Parent", Icons.call_outlined, const Color(0xFF2962FF), false, () {}),

          // ✅ SCHEDULE MEETING BUTTON (VISIBLE ONLY IF CRITICAL)
          if (_isCritical) ...[
            const SizedBox(height: 12),
            _btn("Schedule Parent Meeting", Icons.groups_outlined, const Color(0xFFDC2626), true, () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Schedule meeting for ${widget.studentData['name']}'),
                  backgroundColor: Colors.green,
                ),
              );
            }),
          ],
        ],
      ),
    );
  }

  Widget _btn(String t, IconData i, Color c, bool primary, VoidCallback onPressed) => SizedBox(
    width: double.infinity, height: 52,
    child: ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(i, size: 18),
      label: Text(t, style: const TextStyle(fontWeight: FontWeight.w600)),
      style: ElevatedButton.styleFrom(
        backgroundColor: primary ? c : Colors.white,
        foregroundColor: primary ? Colors.white : c,
        elevation: 0,
        side: BorderSide(color: primary ? Colors.transparent : c.withOpacity(0.3)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
  );

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onBottomNavTapped,
      selectedItemColor: const Color(0xFF1D4ED8),
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'Activity'),
        BottomNavigationBarItem(icon: Icon(Icons.more_horiz_rounded), label: 'More'),
      ],
    );
  }

  Color _getGradeColor(double grade) {
    if (grade < 40) return const Color(0xFFDC2626);
    if (grade < 60) return const Color(0xFFD97706);
    return const Color(0xFF16A34A);
  }
}