import 'package:flutter/material.dart';
import 'package:toki/routes/subject_teacher_routes.dart';

class TeacherProfilePage extends StatefulWidget {
  final Map<String, dynamic> teacherData;

  const TeacherProfilePage({super.key, required this.teacherData});

  @override
  State<TeacherProfilePage> createState() => _TeacherProfilePageState();
}

class _TeacherProfilePageState extends State<TeacherProfilePage> {
  bool _isTelugu = true;

  final List<Map<String, dynamic>> _assignedClasses = [
    {
      'className': 'Class 8A',
      'students': 42,
      'avgGrade': 85.0,
      'attendance': 94.0,
    },
    {
      'className': 'Class 9B',
      'students': 38,
      'avgGrade': 82.0,
      'attendance': 91.0,
    },
  ];

  void _toggleLanguage() {
    setState(() {
      _isTelugu = !_isTelugu;
    });
  }

  void _navigateTo(String routeName, {Map<String, dynamic>? arguments}) {
    if (arguments != null) {
      Navigator.pushNamed(context, routeName, arguments: arguments);
    } else {
      Navigator.pushNamed(context, routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    _buildOrangeHeader(context),
                    const SizedBox(height: 28),
                    _buildContactInformation(),
                    const SizedBox(height: 28),
                    _buildAssignedClasses(),
                    const SizedBox(height: 28),
                    _buildPerformanceSummary(),
                    const SizedBox(height: 32),
                    _buildActionButtons(),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
                color: const Color(0xFF7C3AED).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Color(0xFF7C3AED), size: 20),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              "Teacher Profile",
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
                border:
                    Border.all(color: const Color(0xFF7C3AED).withOpacity(0.3)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _isTelugu ? 'తెలుగు' : 'English',
                style: const TextStyle(
                  color: Color(0xFF7C3AED),
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

  Widget _buildOrangeHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [Color(0xFFBE481E), Color(0xFFD75B28)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFFBE481E).withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8))
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(18)),
                alignment: Alignment.center,
                child: Text(
                  widget.teacherData['name'].toString().isNotEmpty
                      ? widget.teacherData['name'].toString()[0].toUpperCase()
                      : "?",
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.teacherData['name'].toString(),
                        style: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                          widget.teacherData['role']?.toString() ?? 'Teacher',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Divider(color: Colors.white24, height: 1)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _heroMetric("Subject",
                  widget.teacherData['subject']?.toString() ?? 'N/A'),
              _heroMetric("Experience",
                  widget.teacherData['experience']?.toString() ?? 'N/A'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _heroMetric(String l, String v) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(l, style: const TextStyle(color: Colors.white70, fontSize: 13)),
        const SizedBox(height: 4),
        Text(v,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
      ]);

  Widget _buildContactInformation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.black.withOpacity(0.05)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Contact Information",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B))),
            const SizedBox(height: 20),
            _infoRow(Icons.email_outlined, "Email Address",
                "raghini.sharma@adityaschool.edu"),
            const Divider(height: 24, color: Color(0xFFF1F5F9)),
            _infoRow(Icons.phone_outlined, "Phone Number", "+91 98765 43210"),
            const Divider(height: 24, color: Color(0xFFF1F5F9)),
            _infoRow(Icons.badge_outlined, "Employee ID", "TCH-2016-045"),
          ],
        ),
      ),
    );
  }

  // ✅ FIXED INFO ROW: Full Email Visibility with Vertical Layout
  Widget _infoRow(IconData i, String t, String v) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(i, color: const Color(0xFF64748B), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(
                  v,
                  softWrap: true, // ✅ NEXT LINE ME AA JAYEGA PURA DIKHEGA
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF1E293B)),
                ),
              ],
            ),
          ),
        ],
      );

  Widget _buildAssignedClasses() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Assigned Classes",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B))),
          const SizedBox(height: 16),
          ..._assignedClasses.map((c) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black.withOpacity(0.05)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 2))
                    ]),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(c['className'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFF1E293B))),
                            const SizedBox(height: 4),
                            Text("${c['students']} students",
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 13)),
                          ]),
                    ),
                    _miniStat("Avg Grade", "${c['avgGrade']}%", Colors.orange),
                    const SizedBox(width: 20),
                    _miniStat(
                        "Attendance", "${c['attendance']}%", Colors.green),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _miniStat(String l, String v, Color c) =>
      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Text(l, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(v,
            style:
                TextStyle(fontWeight: FontWeight.bold, color: c, fontSize: 15)),
      ]);

  Widget _buildPerformanceSummary() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.black.withOpacity(0.05)),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _statBox("98%", "Attendance Rate", Colors.green),
            _statBox("89%", "Passing rate", Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _statBox(String v, String l, Color c) => Column(children: [
        Text(v,
            style:
                TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: c)),
        const SizedBox(height: 6),
        Text(l, style: const TextStyle(color: Colors.grey, fontSize: 13)),
      ]);

// --- ACTION BUTTONS: REDIRECTION ADDED ---
  Widget _buildActionButtons() {
    return Column(
      children: [
        _btn("View Class Details", const Color(0xFF2962FF), true, () {
          // ✅ REDIRECTS TO CLASS SEARCH PAGE
          _navigateTo(SubjectTeacherRoutes.classSearch);
        }),
        const SizedBox(height: 12),
        _btn("View Timetable", const Color(0xFF2962FF), false, () {}),
        const SizedBox(height: 12),
        _btn("Contact Teacher", const Color(0xFF2962FF), false, () {}),
      ],
    );
  }

  Widget _btn(String t, Color c, bool primary, VoidCallback onTap) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          height: 54,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: primary ? c : Colors.white,
              foregroundColor: primary ? Colors.white : c,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              side: primary ? null : BorderSide(color: c.withOpacity(0.4)),
            ),
            child: Text(t,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          ),
        ),
      );
}
