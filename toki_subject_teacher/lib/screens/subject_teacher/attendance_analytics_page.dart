import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:toki/routes/subject_teacher_routes.dart';

class AttendanceAnalyticsPage extends StatefulWidget {
  final Map<String, dynamic>? studentData;
  const AttendanceAnalyticsPage({super.key, this.studentData});

  @override
  State<AttendanceAnalyticsPage> createState() =>
      _AttendanceAnalyticsPageState();
}

class _AttendanceAnalyticsPageState extends State<AttendanceAnalyticsPage> {
  int _selectedTimeFilter = 0;
  bool _isTelugu = true;
  bool _sortAscending = false;
  final List<String> _timeFilters = [
    'Today',
    'This Week',
    'This Month',
    '6 Month'
  ];

  final Color _primaryPurple = const Color(0xFF7C3AED);
  final Color _scaffoldBg = const Color(0xFFF1F5F9);

  // --- ORIGINAL MOCK DATA ---
  late List<Map<String, dynamic>> _classBreakdown;

  final Map<int, List<Map<String, dynamic>>> _timeFilterData = {
    0: [
      {
        'className': 'Class 10-A',
        'teacher': 'Mr. Rajesh Kumar',
        'percentage': 93.3,
        'present': 42,
        'absent': 3,
        'total': 45
      },
      {
        'className': 'Class 9-A',
        'teacher': 'Mr. Suresh Patel',
        'percentage': 97.4,
        'present': 38,
        'absent': 1,
        'total': 39
      },
    ],
    1: [
      {
        'className': 'Class 10-A',
        'teacher': 'Mr. Rajesh Kumar',
        'percentage': 91.5,
        'present': 215,
        'absent': 20,
        'total': 235
      }
    ],
    2: [
      {
        'className': 'Class 10-A',
        'teacher': 'Mr. Rajesh Kumar',
        'percentage': 92.8,
        'present': 890,
        'absent': 69,
        'total': 959
      }
    ],
    3: [
      {
        'className': 'Class 10-A',
        'teacher': 'Mr. Rajesh Kumar',
        'percentage': 94.1,
        'present': 2540,
        'absent': 159,
        'total': 2699
      }
    ],
  };

  final Map<int, Map<String, dynamic>> _overallAttendanceData = {
    0: {'present': 398, 'absent': 31, 'rate': 92.8},
    1: {'present': 2350, 'absent': 210, 'rate': 91.8},
    2: {'present': 8960, 'absent': 850, 'rate': 91.3},
    3: {'present': 25400, 'absent': 2380, 'rate': 91.4},
  };

  @override
  void initState() {
    super.initState();
    _classBreakdown = List.from(_timeFilterData[0]!);
    _sortClassBreakdown();
  }

  void _toggleLanguage() => setState(() => _isTelugu = !_isTelugu);

  void _sortClassBreakdown() {
    _classBreakdown.sort((a, b) {
      final double pA = (a['percentage'] as num).toDouble();
      final double pB = (b['percentage'] as num).toDouble();
      return _sortAscending ? pA.compareTo(pB) : pB.compareTo(pA);
    });
  }

  void _updateDataForFilter(int index) {
    setState(() {
      _selectedTimeFilter = index;
      _classBreakdown =
          List.from(_timeFilterData[index] ?? _timeFilterData[0]!);
      _sortClassBreakdown();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildExactHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      _buildOriginalHeroCard(), // ✅ Hero Header back to original style
                      const SizedBox(height: 20),
                      _buildFilterTabs(),
                      const SizedBox(height: 24),
                      _buildListHeader(),
                      const SizedBox(height: 12),
                      _buildClassCardsList(),
                      const SizedBox(height: 24),
                      _buildFooterActions(),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- HEADER: PURPLE BACK BUTTON ---
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
          const Expanded(
              child: Text("Attendance Analytics",
                  style: TextStyle(
                      color: Color(0xFF1E293B),
                      fontSize: 18,
                      fontWeight: FontWeight.bold))),
          InkWell(
            onTap: _toggleLanguage,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                  border: Border.all(color: _primaryPurple.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(_isTelugu ? 'తెలుగు' : 'English',
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

  // --- HERO CARD: ORIGINAL STYLE ---
  Widget _buildOriginalHeroCard() {
    final data = _overallAttendanceData[_selectedTimeFilter]!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6CCF8E), Color(0xFF4CAF50)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_month_rounded,
                  color: Colors.white, size: 22),
              const SizedBox(width: 8),
              const Text("Overall Attendance",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              const Spacer(),
              Text(_timeFilters[_selectedTimeFilter],
                  style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _summaryItem("${data['present']}", "Present"),
              _summaryItem("${data['absent']}", "Absent"),
              _summaryItem("${data['rate']}%", "Rate"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryItem(String v, String l) => Column(
        children: [
          Text(v,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          Text(l,
              style: TextStyle(
                  color: Colors.white.withOpacity(0.8), fontSize: 11)),
        ],
      );

  // --- FILTERS ---
  Widget _buildFilterTabs() {
    return SizedBox(
      height: 38,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _timeFilters.length,
        itemBuilder: (context, index) {
          final bool isSelected = index == _selectedTimeFilter;
          return GestureDetector(
            onTap: () => _updateDataForFilter(index),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: isSelected ? _primaryPurple : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: isSelected ? _primaryPurple : Colors.grey.shade300),
              ),
              alignment: Alignment.center,
              child: Text(_timeFilters[index],
                  style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 13)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildListHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Class Performance",
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B))),
        InkWell(
          onTap: () {
            setState(() {
              _sortAscending = !_sortAscending;
              _sortClassBreakdown();
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
                color: _primaryPurple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)),
            child: Row(children: [
              Icon(_sortAscending ? Icons.arrow_upward : Icons.arrow_downward,
                  size: 14, color: _primaryPurple),
              const SizedBox(width: 4),
              Text(_sortAscending ? 'Low-High' : 'High-Low',
                  style: TextStyle(
                      color: _primaryPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 11)),
            ]),
          ),
        ),
      ],
    );
  }

  // --- CLASS LIST CARDS ---
  Widget _buildClassCardsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _classBreakdown.length,
      itemBuilder: (context, index) {
        final item = _classBreakdown[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4))
            ],
          ),
          child: InkWell(
            onTap: () => Navigator.pushNamed(
                context, SubjectTeacherRoutes.classDetails,
                arguments: item),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item['className'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Color(0xFF1E293B))),
                          Text("Teacher: ${item['teacher']}",
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 12)),
                        ]),
                    _buildCompactDonut(item['percentage']),
                  ],
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(height: 1)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _miniDetail("Present", "${item['present']}", Colors.green),
                    _miniDetail("Absent", "${item['absent']}", Colors.red),
                    _miniDetail("Total", "${item['total']}", Colors.blueGrey),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCompactDonut(double percent) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 18,
              sections: [
                PieChartSectionData(
                    color: _primaryPurple,
                    value: percent,
                    radius: 7,
                    showTitle: false),
                PieChartSectionData(
                    color: _primaryPurple.withOpacity(0.1),
                    value: 100 - percent,
                    radius: 7,
                    showTitle: false),
              ],
            ),
          ),
          Text("${percent.toInt()}%",
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: _primaryPurple)),
        ],
      ),
    );
  }

  Widget _miniDetail(String l, String v, Color c) => Column(children: [
        Text(v,
            style:
                TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: c)),
        Text(l, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ]);

  // --- FOOTER BUTTONS ---
  Widget _buildFooterActions() {
    return Column(
      children: [
        _fullBtn("Download PDF Report", Icons.file_download_outlined,
            _primaryPurple, true),
        const SizedBox(height: 12),
        _fullBtn("Share Analysis", Icons.share_outlined, _primaryPurple, false),
      ],
    );
  }

  Widget _fullBtn(String t, IconData i, Color c, bool fill) => SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: Icon(i, size: 20),
          label: Text(t, style: const TextStyle(fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            backgroundColor: fill ? c : Colors.white,
            foregroundColor: fill ? Colors.white : c,
            elevation: 0,
            side: BorderSide(color: c),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
      );
}
