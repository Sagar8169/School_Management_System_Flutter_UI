import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../widgets/common_widgets.dart';
import '../../routes/principal_routes.dart';

class AttendanceAnalyticsPage extends StatefulWidget {
  const AttendanceAnalyticsPage({super.key});

  @override
  State<AttendanceAnalyticsPage> createState() => _AttendanceAnalyticsPageState();
}

class _AttendanceAnalyticsPageState extends State<AttendanceAnalyticsPage> {
  int _currentIndex = 0;
  int _selectedTimeFilter = 0;
  bool _isTelugu = true;
  bool _sortAscending = false;
  final List<String> _timeFilters = ['Today', 'This Week', 'This Month', '6 Month'];

  // Original mock data
  List<Map<String, dynamic>> _classBreakdown = [
    {
      'className': 'Class 10-A',
      'section': 'Section A',
      'teacher': 'Mr. Rajesh Kumar',
      'percentage': 93.3,
      'present': 42,
      'absent': 3,
      'total': 45,
      'isHigh': false,
    },
    {
      'className': 'Class 10-B',
      'section': 'Section B',
      'teacher': 'Ms. Priya Sharma',
      'percentage': 90.9,
      'present': 40,
      'absent': 4,
      'total': 44,
      'isHigh': false,
    },
    {
      'className': 'Class 9-A',
      'section': 'Section A',
      'teacher': 'Mr. Suresh Patel',
      'percentage': 97.4,
      'present': 38,
      'absent': 1,
      'total': 39,
      'isHigh': true,
    },
    {
      'className': 'Class 9-B',
      'section': 'Section B',
      'teacher': 'Ms. Anjali Singh',
      'percentage': 95.0,
      'present': 38,
      'absent': 2,
      'total': 40,
      'isHigh': true,
    },
    {
      'className': 'Class 8-A',
      'section': 'Section A',
      'teacher': 'Mr. Vikram Reddy',
      'percentage': 92.1,
      'present': 35,
      'absent': 3,
      'total': 38,
      'isHigh': false,
    },
    {
      'className': 'Class 8-B',
      'section': 'Section B',
      'teacher': 'Ms. Kavita Joshi',
      'percentage': 96.2,
      'present': 38,
      'absent': 1,
      'total': 39,
      'isHigh': true,
    },
  ];

  // Data for different time filters
  final Map<int, List<Map<String, dynamic>>> _timeFilterData = {
    0: [
      {
        'className': 'Class 10-A',
        'section': 'Section A',
        'teacher': 'Mr. Rajesh Kumar',
        'percentage': 93.3,
        'present': 42,
        'absent': 3,
        'total': 45,
        'isHigh': false,
      },
      {
        'className': 'Class 10-B',
        'section': 'Section B',
        'teacher': 'Ms. Priya Sharma',
        'percentage': 90.9,
        'present': 40,
        'absent': 4,
        'total': 44,
        'isHigh': false,
      },
      {
        'className': 'Class 9-A',
        'section': 'Section A',
        'teacher': 'Mr. Suresh Patel',
        'percentage': 97.4,
        'present': 38,
        'absent': 1,
        'total': 39,
        'isHigh': true,
      },
    ],
    1: [
      {
        'className': 'Class 10-A',
        'section': 'Section A',
        'teacher': 'Mr. Rajesh Kumar',
        'percentage': 91.5,
        'present': 215,
        'absent': 20,
        'total': 235,
        'isHigh': false,
      },
      {
        'className': 'Class 10-B',
        'section': 'Section B',
        'teacher': 'Ms. Priya Sharma',
        'percentage': 94.2,
        'present': 228,
        'absent': 14,
        'total': 242,
        'isHigh': true,
      },
      {
        'className': 'Class 9-A',
        'section': 'Section A',
        'teacher': 'Mr. Suresh Patel',
        'percentage': 96.8,
        'present': 210,
        'absent': 7,
        'total': 217,
        'isHigh': true,
      },
      {
        'className': 'Class 8-B',
        'section': 'Section B',
        'teacher': 'Ms. Kavita Joshi',
        'percentage': 89.3,
        'present': 192,
        'absent': 23,
        'total': 215,
        'isHigh': false,
      },
    ],
    2: [
      {
        'className': 'Class 10-A',
        'section': 'Section A',
        'teacher': 'Mr. Rajesh Kumar',
        'percentage': 92.8,
        'present': 890,
        'absent': 69,
        'total': 959,
        'isHigh': true,
      },
      {
        'className': 'Class 9-A',
        'section': 'Section A',
        'teacher': 'Mr. Suresh Patel',
        'percentage': 96.5,
        'present': 845,
        'absent': 31,
        'total': 876,
        'isHigh': true,
      },
      {
        'className': 'Class 8-B',
        'section': 'Section B',
        'teacher': 'Ms. Kavita Joshi',
        'percentage': 90.2,
        'present': 760,
        'absent': 83,
        'total': 843,
        'isHigh': false,
      },
      {
        'className': 'Class 7-A',
        'section': 'Section A',
        'teacher': 'Mr. Ramesh Iyer',
        'percentage': 88.7,
        'present': 720,
        'absent': 91,
        'total': 811,
        'isHigh': false,
      },
    ],
    3: [
      {
        'className': 'Class 10-A',
        'section': 'Section A',
        'teacher': 'Mr. Rajesh Kumar',
        'percentage': 94.1,
        'present': 2540,
        'absent': 159,
        'total': 2699,
        'isHigh': true,
      },
      {
        'className': 'Class 9-A',
        'section': 'Section A',
        'teacher': 'Mr. Suresh Patel',
        'percentage': 97.2,
        'present': 2480,
        'absent': 71,
        'total': 2551,
        'isHigh': true,
      },
      {
        'className': 'Class 8-B',
        'section': 'Section B',
        'teacher': 'Ms. Kavita Joshi',
        'percentage': 91.8,
        'present': 2180,
        'absent': 195,
        'total': 2375,
        'isHigh': true,
      },
      {
        'className': 'Class 7-A',
        'section': 'Section A',
        'teacher': 'Mr. Ramesh Iyer',
        'percentage': 89.5,
        'present': 2080,
        'absent': 245,
        'total': 2325,
        'isHigh': false,
      },
      {
        'className': 'Class 6-B',
        'section': 'Section B',
        'teacher': 'Ms. Sunita Rao',
        'percentage': 85.3,
        'present': 1850,
        'absent': 320,
        'total': 2170,
        'isHigh': false,
      },
    ],
  };

  // Overall attendance data for different time filters
  final Map<int, Map<String, dynamic>> _overallAttendanceData = {
    0: {'present': 398, 'absent': 31, 'rate': 92.8, 'totalStudents': 850},
    1: {'present': 2350, 'absent': 210, 'rate': 91.8, 'totalStudents': 2560},
    2: {'present': 8960, 'absent': 850, 'rate': 91.3, 'totalStudents': 9810},
    3: {'present': 25400, 'absent': 2380, 'rate': 91.4, 'totalStudents': 27780},
  };

  void _toggleLanguage() {
    setState(() {
      _isTelugu = !_isTelugu;
    });
  }

  void _toggleSortOrder() {
    setState(() {
      _sortAscending = !_sortAscending;
      _sortClassBreakdown();
    });
  }

  void _sortClassBreakdown() {
    _classBreakdown.sort((a, b) {
      final double percentageA = a['percentage'] as double;
      final double percentageB = b['percentage'] as double;
      return _sortAscending
          ? percentageA.compareTo(percentageB)
          : percentageB.compareTo(percentageA);
    });
  }

  void _updateDataForFilter(int index) {
    setState(() {
      _selectedTimeFilter = index;
      _classBreakdown = List.from(_timeFilterData[index] ?? []);
      _sortClassBreakdown();
    });
  }

  void _navigateTo(String routeName, {Map<String, dynamic>? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.of(context).pushNamedAndRemoveUntil(
          PrincipalRoutes.home,
              (route) => false,
        );
        break;
      case 1:
        _navigateTo(PrincipalRoutes.search);
        break;
      case 2:
        break;
      case 3:
        _navigateTo(PrincipalRoutes.morePage);
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _sortClassBreakdown();
  }

  @override
  Widget build(BuildContext context) {
    final data = _overallAttendanceData[_selectedTimeFilter]!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            /// -------- ATTENDANCE ANALYTICS CARD --------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF6CCF8E), // lighter top green
                    Color(0xFF4CAF50), // bottom green
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(26),
                  bottomRight: Radius.circular(26),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_back,
                              color: Colors.white, size: 18),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        "Attendance Analytics",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      // Language Toggle (kept from first page)
                      GestureDetector(
                        onTap: _toggleLanguage,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            _isTelugu ? 'తెలుగు' : 'English',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// -------- INNER DARK GREEN CARD (EXACT MATCH) --------
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3E8F63), // dark green EXACT screenshot color
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.10),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Overall Attendance (${_timeFilters[_selectedTimeFilter]})",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 18),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _StatBox(value: "${data['present']}", label: "Present"),
                            _StatBox(value: "${data['absent']}", label: "Absent"),
                            _StatBox(value: "${data['rate']}%", label: "Rate"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    /// -------- FILTER BUTTONS --------
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(_timeFilters.length, (index) {
                          return GestureDetector(
                            onTap: () => _updateDataForFilter(index),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                color: _selectedTimeFilter == index
                                    ? const Color(0xFF2962FF)
                                    : const Color(0xFFF2F4FF),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Text(
                                _timeFilters[index],
                                style: TextStyle(
                                  color: _selectedTimeFilter == index
                                      ? Colors.white
                                      : Colors.black87,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Class-wise Breakdown",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          // Sort Button
                          GestureDetector(
                            onTap: _toggleSortOrder,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF2F4FF),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    _sortAscending ? Icons.arrow_upward : Icons.arrow_downward,
                                    size: 16,
                                    color: const Color(0xFF2962FF),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    _sortAscending ? 'Low to High' : 'High to Low',
                                    style: const TextStyle(
                                      color: Color(0xFF2962FF),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// -------- CLASS CARDS --------
                    ..._classBreakdown.map((classData) => _buildClassCard(classData)),

                    const SizedBox(height: 20),

                    /// -------- DOWNLOAD BUTTON --------
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          _showDownloadConfirmation();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2962FF),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.download, size: 20, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              "Download Report (PDF)",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// -------- SHARE BUTTON --------
                    GestureDetector(
                      onTap: () {
                        _showShareOptions();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFF2962FF),
                              width: 2,
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.share, size: 20, color: Color(0xFF2962FF)),
                              SizedBox(width: 8),
                              Text(
                                "Share",
                                style: TextStyle(
                                  color: Color(0xFF2962FF),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

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

  Widget _buildClassCard(Map<String, dynamic> classData) {
    final double percentage = (classData['percentage'] as num).toDouble();
    final int present = classData['present'] as int;
    final int absent = classData['absent'] as int;
    final int total = classData['total'] as int;

    return GestureDetector(
      onTap: () {
        _navigateTo(PrincipalRoutes.classDetails, arguments: classData);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.black12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ---- Title Row ----
              Row(
                children: [
                  Text(
                    classData['className'].toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),

                  /// Percentage Pill
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF1FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      "${percentage.toStringAsFixed(1)}%",
                      style: const TextStyle(
                        color: Color(0xFF2962FF),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 6),

              Text(
                "Class Teacher: ${classData['teacher']}",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 14),

              /// ---- Blue Progress Bar ----
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: percentage / 100,
                  backgroundColor: Colors.grey.shade200,
                  color: const Color(0xFF2962FF),
                  minHeight: 6,
                ),
              ),

              const SizedBox(height: 14),

              /// ---- Stats Row ----
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        "$present",
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        "Present",
                        style: TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "$absent",
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        "Absent",
                        style: TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "$total",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        "Total",
                        style: TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// ---- View Details Button ----
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F7FF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Text(
                    "View Details",
                    style: TextStyle(
                      color: Color(0xFF2962FF),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDownloadConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Download Report'),
        content: const Text('The attendance report will be downloaded in PDF format.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF6B7280))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Report download started'),
                  backgroundColor: Color(0xFF10B981),
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2962FF)),
            child: const Text('Download', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showShareOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Share Report',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildShareOption(Icons.email, 'Email'),
                _buildShareOption(Icons.chat, 'WhatsApp'),
                _buildShareOption(Icons.cloud_upload, 'Drive'),
                _buildShareOption(Icons.copy, 'Copy Link'),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Color(0xFF6B7280)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareOption(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFF2962FF).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFF2962FF), size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onBottomNavTapped,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF1D4ED8),
      unselectedItemColor: const Color(0xFF6B7280),
      selectedFontSize: 12,
      unselectedFontSize: 12,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_rounded),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.show_chart_rounded),
          label: 'Activity',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz_rounded),
          label: 'More',
        ),
      ],
    );
  }
}

/// ---------- SMALL STAT BOX ----------
class _StatBox extends StatelessWidget {
  final String value;
  final String label;

  const _StatBox({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.white70)),
      ],
    );
  }
}