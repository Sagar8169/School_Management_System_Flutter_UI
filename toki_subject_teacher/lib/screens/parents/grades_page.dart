// lib/screens/parents/grades_page.dart
import 'package:flutter/material.dart';
import '../../routes/parents_routes.dart';

class GradesPage extends StatefulWidget {
  const GradesPage({Key? key}) : super(key: key);

  @override
  _GradesPageState createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  // ✅ ORIGINAL VARIABLE NAMES
  String _selectedLanguage = 'తెలుగు';

  final Color _headerOrange = const Color(0xFFFFAB00);
  final Color _heroCardBg = const Color(0xFFCD8006);
  final Color _scaffoldBg = const Color(0xFFF1F5F9);
  final Color _textPrimary = const Color(0xFF0F172A);
  final Color _textSecondary = const Color(0xFF64748B);

  // Status Colors
  final Color _greenBadgeText = const Color(0xFF16A34A);
  final Color _blueBadgeText = const Color(0xFF2563EB);
  final Color _orangeBadgeText = const Color(0xFFD97706);

  void _toggleLanguage() {
    setState(() => _selectedLanguage = _selectedLanguage == 'తెలుగు' ? 'English' : 'తెలుగు');
  }

  // --- 3 DOTS WORKING LOGIC (FIXED BOTTOM OVERLAP) ---
  void _showResultOptions(String examTitle) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true, // ✅ Screen boundaries ke andar rakhega
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        // ✅ Hardware notch aur navigation bar se upar rakhne ke liye padding
        padding: EdgeInsets.fromLTRB(16, 12, 16, MediaQuery.of(context).viewPadding.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 45, height: 5, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),
            const SizedBox(height: 24),
            Text(examTitle, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
            const SizedBox(height: 24),
            _buildOptionTile(Icons.picture_as_pdf_rounded, "Download PDF Report", "Save result to your phone", Colors.red, () {}),
            _buildOptionTile(Icons.share_rounded, "Share with Family", "Send result via WhatsApp", Colors.blue, () {}),
            _buildOptionTile(Icons.comment_bank_rounded, "Teacher's Remarks", "Read behavioral feedback", Colors.purple, () {
              Navigator.pop(context); // Close current sheet
              _showRemarksSheet(); // Open remarks sheet
            }),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // Teacher Remarks Advanced Sheet
  void _showRemarksSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: EdgeInsets.fromLTRB(24, 12, 24, MediaQuery.of(context).viewPadding.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 45, height: 5, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)))),
            const SizedBox(height: 24),
            const Text("Teacher's Feedback", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade100),
              ),
              child: const Text(
                "Ananya is a bright student and shows great interest in Mathematics. Her problem-solving skills are improving. Needs slightly more focus on Science laboratory work.",
                style: TextStyle(fontSize: 15, height: 1.6, color: Color(0xFF475569)),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _headerOrange,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text("CLOSE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(IconData icon, String title, String sub, Color col, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: col.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: col, size: 22),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Color(0xFF1E293B))),
      subtitle: Text(sub, style: TextStyle(fontSize: 12, color: _textSecondary)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _buildHeroSection(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionHeader("Academic Performance"),
                          const SizedBox(height: 16),
                          _buildExamCard(
                            title: "Mid-term Examination",
                            date: "October 2025",
                            grade: "A+ Grade",
                            percent: "92%",
                            rank: "Rank 3",
                            subjects: [
                              SubjectData("Mathematics", "95/100", "A+", 0.95),
                              SubjectData("Science", "92/100", "A+", 0.92),
                              SubjectData("English", "88/100", "A", 0.88),
                              SubjectData("Hindi", "90/100", "A+", 0.90),
                              SubjectData("Social Studies", "94/100", "A+", 0.94),
                            ],
                          ),
                          _buildExamCard(
                            title: "First Unit Test",
                            date: "September 2025",
                            grade: "A Grade",
                            percent: "88%",
                            rank: "Rank 5",
                            subjects: [
                              SubjectData("Mathematics", "90/100", "A+", 0.90),
                              SubjectData("Science", "85/100", "A", 0.85),
                            ],
                          ),
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
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // --- UI COMPONENTS ---

  Widget _buildAppHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          Container(width: 38, height: 38, decoration: BoxDecoration(color: const Color(0xFFFF5722), borderRadius: BorderRadius.circular(10)), alignment: Alignment.center, child: const Text("A", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18))),
          const SizedBox(width: 12),
          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Aditya International", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15)),
            Text("Smart Report Portal", style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
          ]),
          const Spacer(),
          GestureDetector(
            onTap: _toggleLanguage,
            child: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: BoxDecoration(color: const Color(0xFFFF5722).withOpacity(0.1), borderRadius: BorderRadius.circular(20)), child: Text(_selectedLanguage, style: const TextStyle(color: Color(0xFFFF5722), fontWeight: FontWeight.w800, fontSize: 12))),
          )
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: _headerOrange, borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
      child: Column(
        children: [
          Row(children: [
            GestureDetector(onTap: () => Navigator.pop(context), child: Container(padding: const EdgeInsets.all(8), decoration: const BoxDecoration(color: Colors.black12, shape: BoxShape.circle), child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 16))),
            const SizedBox(width: 12),
            const Text("Performance Report", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
          ]),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: _heroCardBg, borderRadius: BorderRadius.circular(28)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text("Current Standing", style: TextStyle(color: Colors.white70, fontSize: 12)),
                  const Text("A+ Grade", style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 10),
                  Text("Rank: 03 in Class", style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13, fontWeight: FontWeight.w700)),
                ]),
                Stack(alignment: Alignment.center, children: [
                  SizedBox(width: 75, height: 75, child: CircularProgressIndicator(value: 0.92, strokeWidth: 8, backgroundColor: Colors.white12, color: Colors.white)),
                  const Text("92%", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18)),
                ])
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExamCard({required String title, required String date, required String grade, required String percent, required String rank, required List<SubjectData> subjects}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30), border: Border.all(color: Colors.grey.shade100)),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: _textPrimary)), Text(date, style: const TextStyle(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w600))]),
            IconButton(icon: const Icon(Icons.more_vert_rounded, color: Colors.grey), onPressed: () => _showResultOptions(title)),
          ]),
          const SizedBox(height: 16),
          Row(children: [_badge(grade, _greenBadgeText), const SizedBox(width: 8), _badge(percent, _blueBadgeText), const SizedBox(width: 8), _badge(rank, _orangeBadgeText)]),
          const Divider(height: 40),
          ...subjects.map((sub) => Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(sub.name, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: _textPrimary)), Row(children: [Text(sub.score, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13)), const SizedBox(width: 12), _gradeSmallBadge(sub.grade)])]),
              const SizedBox(height: 10),
              ClipRRect(borderRadius: BorderRadius.circular(10), child: LinearProgressIndicator(value: sub.progress, minHeight: 7, backgroundColor: const Color(0xFFF1F5F9), valueColor: AlwaysStoppedAnimation<Color>(_getGradeColor(sub.grade))))
            ]),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) => Text(title.toUpperCase(), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Color(0xFF94A3B8), letterSpacing: 1.5));
  Widget _badge(String t, Color c) => Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: c.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Text(t, style: TextStyle(color: c, fontWeight: FontWeight.w900, fontSize: 11)));
  Widget _gradeSmallBadge(String g) => Container(width: 35, height: 26, alignment: Alignment.center, decoration: BoxDecoration(color: _getGradeColor(g), borderRadius: BorderRadius.circular(8)), child: Text(g, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 11)));
  Color _getGradeColor(String g) => g.contains('A+') ? _greenBadgeText : (g == 'A' ? _blueBadgeText : _orangeBadgeText);

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: 1,
      onTap: (i) => Navigator.pushReplacementNamed(context, [ParentsRoutes.home, '', ParentsRoutes.busTracking, ParentsRoutes.moreOptions][i]),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFFFF5722),
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w900),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.auto_graph_rounded), label: "Reports"),
        BottomNavigationBarItem(icon: Icon(Icons.directions_bus_filled_outlined), label: "Bus"),
        BottomNavigationBarItem(icon: Icon(Icons.widgets_rounded), label: "More"),
      ],
    );
  }
}

class SubjectData {
  final String name, score, grade;
  final double progress;
  SubjectData(this.name, this.score, this.grade, this.progress);
}