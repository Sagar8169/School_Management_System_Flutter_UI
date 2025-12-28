// lib/screens/parents/reports_page.dart
import 'package:flutter/material.dart';
import '../../routes/parents_routes.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  // ✅ ORIGINAL NAMES MAINTAINED
  String _selectedLanguage = 'తెలుగు';

  // Premium Palette
  final Color _primaryPurple = const Color(0xFF6366F1);
  final Color _bgLight = const Color(0xFFF1F5F9);
  final Color _accentOrange = const Color(0xFFFF5722);
  final Color _textDeep = const Color(0xFF0F172A);

  // 🎨 NEW HERO GRADIENT COLORS
  final Color _heroStart = const Color(0xFF0F172A); // Deep Navy
  final Color _heroEnd = const Color(0xFF0D9488);   // Deep Teal

  void _toggleLanguage() {
    setState(() => _selectedLanguage = _selectedLanguage == 'తెలుగు' ? 'English' : 'తెలుగు');
  }

  void _onBottomNavTap(int index) {
    if (index == 1) return;
    final routes = [
      ParentsRoutes.home,
      '', // Current
      ParentsRoutes.busTracking,
      ParentsRoutes.moreOptions
    ];
    Navigator.pushReplacementNamed(context, routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      body: SafeArea(
        child: Column(
          children: [
            _buildModernHeader(),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const SizedBox(height: 24),
                  _buildPremiumStudentCard(), // ✅ Updated Color inside this
                  const SizedBox(height: 32),
                  _buildSectionLabel("Academic Performance"),
                  const SizedBox(height: 16),

                  // 🟢 Attendance Card
                  _buildAdvanceReportCard(
                    title: "Attendance",
                    value: "95.5%",
                    status: "Excellent Track Record",
                    icon: Icons.event_available_rounded,
                    color: const Color(0xFF10B981),
                    progress: 0.95,
                    onTap: () => Navigator.pushNamed(context, ParentsRoutes.attendance),
                  ),

                  // 🟡 Performance Card
                  _buildAdvanceReportCard(
                    title: "Academic Grade",
                    value: "A+",
                    status: "Rank: #3 in Class",
                    icon: Icons.auto_awesome_rounded,
                    color: const Color(0xFFF59E0B),
                    progress: 0.92,
                    onTap: () => Navigator.pushNamed(context, ParentsRoutes.grades),
                  ),

                  // 🟣 Fees Status Card
                  _buildAdvanceReportCard(
                    title: "Fee Status",
                    value: "Pending",
                    status: "Next Due: 15 Jan 2024",
                    icon: Icons.account_balance_wallet_rounded,
                    color: _primaryPurple,
                    progress: 0.60,
                    onTap: () => Navigator.pushNamed(context, ParentsRoutes.feesStatus),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // 1. App Header
  Widget _buildModernHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9), width: 1))
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: _accentOrange, borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.school_rounded, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Aditya International", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, letterSpacing: -0.5)),
              Text("Smart Report Portal", style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
            ]),
          ),
          GestureDetector(
            onTap: _toggleLanguage,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(color: _accentOrange.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
              child: Text(_selectedLanguage, style: TextStyle(color: _accentOrange, fontWeight: FontWeight.w800, fontSize: 12)),
            ),
          )
        ],
      ),
    );
  }

  // 2. Premium Student Profile Hero (UPDATED COLOR)
  Widget _buildPremiumStudentCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_heroStart, _heroEnd] // ✅ New Color Palette
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [BoxShadow(color: _heroStart.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 32,
                backgroundColor: Colors.white24,
                child: Icon(Icons.person_rounded, size: 38, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Ananya Sharma", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 4),
                    Text("Grade 8-B • Roll No. 12", style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 13, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              const Icon(Icons.stars_rounded, color: Colors.white, size: 28),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSimpleStat("Ranking", "#4"),
                _buildSimpleStat("Conduct", "A+"),
                _buildSimpleStat("Activity", "Good"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSimpleStat(String label, String val) => Column(children: [
    Text(label, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 11, fontWeight: FontWeight.w600)),
    const SizedBox(height: 4),
    Text(val, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 15)),
  ]);

  // 3. Advance Report Card
  Widget _buildAdvanceReportCard({
    required String title,
    required String value,
    required String status,
    required IconData icon,
    required Color color,
    required double progress,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  /// 🔹 Icon
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(icon, color: color, size: 24),
                  ),

                  const SizedBox(width: 16),

                  /// 🔹 Title + Status
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: _textDeep,
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          status,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// 🔹 Value + Arrow
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        value,
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 22,
                        color: Colors.grey.shade400,
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// 🔹 Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: color.withOpacity(0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String text) => Padding(
    padding: const EdgeInsets.only(left: 4),
    child: Text(text.toUpperCase(), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Color(0xFF94A3B8), letterSpacing: 1.5)),
  );

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: 1,
      onTap: _onBottomNavTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: _accentOrange,
      backgroundColor: Colors.white,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 11),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home_rounded), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.analytics_outlined), activeIcon: Icon(Icons.analytics_rounded), label: "Reports"),
        BottomNavigationBarItem(icon: Icon(Icons.directions_bus_outlined), activeIcon: Icon(Icons.directions_bus_rounded), label: "Bus"),
        BottomNavigationBarItem(icon: Icon(Icons.grid_view_outlined), activeIcon: Icon(Icons.grid_view_rounded), label: "More"),
      ],
    );
  }
}