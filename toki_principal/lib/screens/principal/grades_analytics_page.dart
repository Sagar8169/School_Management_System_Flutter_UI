import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../routes/principal_routes.dart';

const Color themeBlue = Color(0xFF1E3A8A);
const Color themeLightBlue = Color(0xFF3B82F6);
const Color themeGreen = Color(0xFF059669);
const Color backgroundSlate = Color(0xFFF8FAFC);

class GradesAnalyticsPage extends StatefulWidget {
  const GradesAnalyticsPage({super.key});

  @override
  State<GradesAnalyticsPage> createState() => _GradesAnalyticsPageState();
}

class _GradesAnalyticsPageState extends State<GradesAnalyticsPage> {
  // int _currentIndex = 2;
  int _selectedTimeFilter = 0;
  bool _isTelugu = false;
  bool _sortAscending = false;

  final List<String> _timeFilters = ['Monthly', '3 Months', 'Term 1', 'Term 2'];

  late List<Map<String, dynamic>> _classPerformance;

  final Map<int, List<Map<String, dynamic>>> _timeFilterData = {
    0: [
      {
        'className': 'Class 10-A',
        'teacher': 'Mr. Rajesh Sharma',
        'average': 76.5,
        'distribution': {'A': 40, 'B': 30, 'C': 20, 'D': 10}
      },
      {
        'className': 'Class 9-A',
        'teacher': 'Mr. Suresh Kumar',
        'average': 82.4,
        'distribution': {'A': 50, 'B': 25, 'C': 15, 'D': 10}
      },
    ],
    // ... logic same as yours
  };

  final Map<int, Map<String, dynamic>> _overallGradeData = {
    0: {'average': 78.5, 'totalStudents': 850, 'classes': 20},
    // ... logic same as yours
  };

  @override
  void initState() {
    super.initState();
    _updateDataForFilter(0);
  }

  void _updateDataForFilter(int index) {
    setState(() {
      _selectedTimeFilter = index;
      _classPerformance =
          List.from(_timeFilterData[index] ?? _timeFilterData[0]!);
      _applySort();
    });
  }

  void _applySort() {
    setState(() {
      _classPerformance.sort((a, b) => _sortAscending
          ? (a['average'] as double).compareTo(b['average'] as double)
          : (b['average'] as double).compareTo(a['average'] as double));
    });
  }

  @override
  Widget build(BuildContext context) {
    final overall =
        _overallGradeData[_selectedTimeFilter] ?? _overallGradeData[0]!;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Modern Slate BG
      body: Column(
        children: [
          _buildPremiumHeader(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildOverviewHero(overall),
                  const SizedBox(height: 25),
                  _buildResponsiveFilterBar(),
                  const SizedBox(height: 25),
                  _buildPerformanceSection(),
                  const SizedBox(height: 25),
                  _buildFooterActions(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: _buildBottomNav(),
    );
  }

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

  // --- 1. PREMIUM HEADER ---
  Widget _buildPremiumHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(
          20, MediaQuery.of(context).padding.top + 10, 20, 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          _circleIconBtn(
              Icons.arrow_back_ios_new_rounded, () => Navigator.pop(context)),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Grades Insights',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0F172A))),
                Text('Aditya International School',
                    style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          _buildLanguageToggle(),
        ],
      ),
    );
  }

  // --- 2. HERO OVERVIEW CARD ---
  Widget _buildOverviewHero(Map<String, dynamic> data) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3A8A), Color(0xFF1D4ED8), Color(0xFF3B82F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF1D4ED8).withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10))
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _heroStat('${data['average']}%', 'Avg Performance',
                  Icons.analytics_rounded),
              _heroStat('${data['totalStudents']}', 'Total Students',
                  Icons.groups_rounded),
              _heroStat('${data['classes']}', 'Classes', Icons.class_rounded),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResponsiveFilterBar() {
    return Container(
      height: 52, // Professional slim height
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(4), // Outer spacing for the slider
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9), // Very light slate
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Row(
        children: List.generate(_timeFilters.length, (index) {
          bool sel = _selectedTimeFilter == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => _updateDataForFilter(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  // ✨ ACTIVE STATE: Elevated White Card
                  color: sel ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: sel
                      ? [
                          BoxShadow(
                            color: const Color(0xFF1E293B).withOpacity(0.06),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                          BoxShadow(
                            color: const Color(0xFF1D4ED8).withOpacity(0.04),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: AnimatedDefaultTextStyle(
                  // ✨ Smooth text color transition
                  duration: const Duration(milliseconds: 200),
                  style: TextStyle(
                    color:
                        sel ? const Color(0xFF1D4ED8) : const Color(0xFF64748B),
                    fontWeight: sel ? FontWeight.w900 : FontWeight.w700,
                    fontSize: 11,
                    letterSpacing: 0.3,
                  ),
                  child: Center(
                    child: Text(_timeFilters[index]),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // --- 4. PERFORMANCE LIST ---
  Widget _buildPerformanceSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Class-wise Breakdown',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1E293B))),
              _circleIconBtn(
                  _sortAscending
                      ? Icons.sort_rounded
                      : Icons.filter_list_rounded, () {
                setState(() => _sortAscending = !_sortAscending);
                _applySort();
              }, color: const Color(0xFF1D4ED8)),
            ],
          ),
          const SizedBox(height: 15),
          ..._classPerformance.map((data) => _buildModernClassCard(data)),
        ],
      ),
    );
  }

  Widget _buildModernClassCard(Map<String, dynamic> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data['className'],
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0F172A))),
                Text(data['teacher'],
                    style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 16),
                _gradeIndicator('A', '${data['distribution']['A']}%',
                    const Color(0xFF10B981)),
                _gradeIndicator('B', '${data['distribution']['B']}%',
                    const Color(0xFF3B82F6)),
              ],
            ),
          ),
          _buildPieChart(data),
        ],
      ),
    );
  }

  // --- HELPERS ---
  Widget _heroStat(String v, String l, IconData i) => Column(children: [
        Icon(i, color: Colors.white70, size: 18),
        const SizedBox(height: 8),
        Text(v,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w900)),
        Text(l,
            style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 10,
                fontWeight: FontWeight.w600)),
      ]);

  Widget _gradeIndicator(String g, String v, Color c) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(children: [
          Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: c, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Text('Grade $g: ',
              style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w700)),
          Text(v,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E293B))),
        ]),
      );

  Widget _buildPieChart(Map<String, dynamic> data) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(PieChartData(
            sectionsSpace: 4,
            centerSpaceRadius: 30,
            sections: [
              PieChartSectionData(
                  value: data['distribution']['A'].toDouble(),
                  color: const Color(0xFF10B981),
                  radius: 10,
                  showTitle: false),
              PieChartSectionData(
                  value: data['distribution']['B'].toDouble(),
                  color: const Color(0xFF3B82F6),
                  radius: 10,
                  showTitle: false),
              PieChartSectionData(
                  value: data['distribution']['C'].toDouble(),
                  color: const Color(0xFFF59E0B),
                  radius: 10,
                  showTitle: false),
              PieChartSectionData(
                  value: data['distribution']['D'].toDouble(),
                  color: const Color(0xFFEF4444),
                  radius: 10,
                  showTitle: false),
            ],
          )),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${data['average']}%',
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1D4ED8))),
              const Text('AVG',
                  style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF94A3B8))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _circleIconBtn(IconData i, VoidCallback onTap,
      {Color color = const Color(0xFF0F172A)}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: color.withOpacity(0.05), shape: BoxShape.circle),
        child: Icon(i, size: 20, color: color),
      ),
    );
  }

  Widget _buildLanguageToggle() {
    return GestureDetector(
      onTap: () => setState(() => _isTelugu = !_isTelugu),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF1D4ED8),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: const Color(0xFF1D4ED8).withOpacity(0.3), blurRadius: 10)
          ],
        ),
        child: Text(_isTelugu ? 'తెలుగు' : 'English',
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 11)),
      ),
    );
  }

  Widget _buildFooterActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
              child:
                  _actionBtn('Export PDF', Icons.picture_as_pdf_rounded, true)),
          const SizedBox(width: 12),
          Expanded(child: _actionBtn('Share', Icons.share_rounded, false)),
        ],
      ),
    );
  }

  Widget _actionBtn(String l, IconData i, bool pri) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(i, size: 18),
      label: Text(l, style: const TextStyle(fontWeight: FontWeight.w800)),
      style: ElevatedButton.styleFrom(
        backgroundColor: pri ? const Color(0xFF0F172A) : Colors.white,
        foregroundColor: pri ? Colors.white : const Color(0xFF0F172A),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: pri
                ? BorderSide.none
                : const BorderSide(color: Color(0xFFE2E8F0))),
        elevation: 0,
      ),
    );
  }

  // Widget _buildBottomNav() {
  //   return Container(
  //     decoration: const BoxDecoration(
  //       border: Border(
  //         top: BorderSide(
  //           color: Color(0xFFF1F5F9),
  //           width: 2,
  //         ),
  //       ),
  //     ),
  //     child: BottomNavigationBar(
  //       currentIndex: _currentIndex,

  //       // ✅ CORRECT onTap (int only)
  //       onTap: (index) {
  //         if (index == _currentIndex) return;
  //         _onBottomNavTap(index);
  //       },

  //       type: BottomNavigationBarType.fixed,
  //       backgroundColor: Colors.white,
  //       selectedItemColor: themeBlue,
  //       unselectedItemColor: const Color(0xFF94A3B8),
  //       elevation: 0,

  //       items: const [
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.home_rounded),
  //           label: "Home",
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.search_rounded),
  //           label: "Search",
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.analytics_rounded),
  //           label: "Activity",
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.grid_view_rounded),
  //           label: "More",
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
