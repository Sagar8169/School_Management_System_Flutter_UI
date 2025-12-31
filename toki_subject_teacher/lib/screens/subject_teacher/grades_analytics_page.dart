import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:toki/routes/subject_teacher_routes.dart';
import '../../widgets/common_widgets.dart';

class GradesAnalyticsPage extends StatefulWidget {
  final Map<String, dynamic>? studentData;

  const GradesAnalyticsPage({
    super.key,
    this.studentData, // ❌ required hata diya
  });

  @override
  State<GradesAnalyticsPage> createState() => _GradesAnalyticsPageState();
}

class _GradesAnalyticsPageState extends State<GradesAnalyticsPage> {
  int _selectedTimeFilter = 0;
  bool _isTelugu = true;

  bool _sortAscending = false;
  final List<String> _timeFilters = [
    'This Month',
    'Last 3 Months',
    'Term 1',
    'Term 2'
  ];

  // Mock data for class performance with grade distribution
  List<Map<String, dynamic>> _classPerformance = [
    {
      'className': 'Class 10-A',
      'section': 'Section A',
      'teacher': 'Mr. Rajesh Sharma',
      'average': 76.5,
      'totalStudents': 45,
      'excellentStudents': 18,
      'distribution': {
        'A': 40,
        'B': 30,
        'C': 20,
        'D': 10,
      },
      'distributionColors': [
        const Color(0xFF10B981), // Green for A
        const Color(0xFF2563EB), // Blue for B
        const Color(0xFFF59E0B), // Yellow for C
        const Color(0xFFEF4444), // Red for D
      ],
    },
    {
      'className': 'Class 10-B',
      'section': 'Section B',
      'teacher': 'Ms. Priya Patel',
      'average': 79.2,
      'totalStudents': 44,
      'excellentStudents': 20,
      'distribution': {
        'A': 45,
        'B': 28,
        'C': 18,
        'D': 9,
      },
      'distributionColors': [
        const Color(0xFF10B981),
        const Color(0xFF2563EB),
        const Color(0xFFF59E0B),
        const Color(0xFFEF4444),
      ],
    },
    {
      'className': 'Class 9-A',
      'section': 'Section A',
      'teacher': 'Mr. Suresh Kumar',
      'average': 82.4,
      'totalStudents': 39,
      'excellentStudents': 22,
      'distribution': {
        'A': 50,
        'B': 25,
        'C': 15,
        'D': 10,
      },
      'distributionColors': [
        const Color(0xFF10B981),
        const Color(0xFF2563EB),
        const Color(0xFFF59E0B),
        const Color(0xFFEF4444),
      ],
    },
    {
      'className': 'Class 9-B',
      'section': 'Section B',
      'teacher': 'Ms. Anjali Singh',
      'average': 74.8,
      'totalStudents': 41,
      'excellentStudents': 15,
      'distribution': {
        'A': 35,
        'B': 32,
        'C': 20,
        'D': 13,
      },
      'distributionColors': [
        const Color(0xFF10B981),
        const Color(0xFF2563EB),
        const Color(0xFFF59E0B),
        const Color(0xFFEF4444),
      ],
    },
  ];

  // Data for different time filters
  final Map<int, List<Map<String, dynamic>>> _timeFilterData = {
    0: [
      {
        'className': 'Class 10-A',
        'section': 'Section A',
        'teacher': 'Mr. Rajesh Sharma',
        'average': 76.5,
        'totalStudents': 45,
        'excellentStudents': 18,
        'distribution': {
          'A': 40,
          'B': 30,
          'C': 20,
          'D': 10,
        },
        'distributionColors': [
          const Color(0xFF10B981),
          const Color(0xFF2563EB),
          const Color(0xFFF59E0B),
          const Color(0xFFEF4444),
        ],
      },
      {
        'className': 'Class 9-A',
        'section': 'Section A',
        'teacher': 'Mr. Suresh Kumar',
        'average': 82.4,
        'totalStudents': 39,
        'excellentStudents': 22,
        'distribution': {
          'A': 50,
          'B': 25,
          'C': 15,
          'D': 10,
        },
        'distributionColors': [
          const Color(0xFF10B981),
          const Color(0xFF2563EB),
          const Color(0xFFF59E0B),
          const Color(0xFFEF4444),
        ],
      },
    ],
    1: [
      {
        'className': 'Class 10-A',
        'section': 'Section A',
        'teacher': 'Mr. Rajesh Sharma',
        'average': 78.2,
        'totalStudents': 45,
        'excellentStudents': 20,
        'distribution': {
          'A': 42,
          'B': 31,
          'C': 18,
          'D': 9,
        },
        'distributionColors': [
          const Color(0xFF10B981),
          const Color(0xFF2563EB),
          const Color(0xFFF59E0B),
          const Color(0xFFEF4444),
        ],
      },
      {
        'className': 'Class 9-A',
        'section': 'Section A',
        'teacher': 'Mr. Suresh Kumar',
        'average': 80.5,
        'totalStudents': 39,
        'excellentStudents': 21,
        'distribution': {
          'A': 48,
          'B': 26,
          'C': 16,
          'D': 10,
        },
        'distributionColors': [
          const Color(0xFF10B981),
          const Color(0xFF2563EB),
          const Color(0xFFF59E0B),
          const Color(0xFFEF4444),
        ],
      },
    ],
    2: [
      {
        'className': 'Class 10-A',
        'section': 'Section A',
        'teacher': 'Mr. Rajesh Sharma',
        'average': 75.0,
        'totalStudents': 45,
        'excellentStudents': 17,
        'distribution': {
          'A': 38,
          'B': 29,
          'C': 21,
          'D': 12,
        },
        'distributionColors': [
          const Color(0xFF10B981),
          const Color(0xFF2563EB),
          const Color(0xFFF59E0B),
          const Color(0xFFEF4444),
        ],
      },
    ],
    3: [
      {
        'className': 'Class 10-A',
        'section': 'Section A',
        'teacher': 'Mr. Rajesh Sharma',
        'average': 78.5,
        'totalStudents': 45,
        'excellentStudents': 19,
        'distribution': {
          'A': 41,
          'B': 30,
          'C': 19,
          'D': 10,
        },
        'distributionColors': [
          const Color(0xFF10B981),
          const Color(0xFF2563EB),
          const Color(0xFFF59E0B),
          const Color(0xFFEF4444),
        ],
      },
    ],
  };

  // Overall grade data for different time filters
  final Map<int, Map<String, dynamic>> _overallGradeData = {
    0: {'average': 78.5, 'totalStudents': 850, 'classes': 20},
    1: {'average': 77.8, 'totalStudents': 850, 'classes': 20},
    2: {'average': 76.2, 'totalStudents': 850, 'classes': 20},
    3: {'average': 79.1, 'totalStudents': 850, 'classes': 20},
  };

  void _toggleLanguage() {
    setState(() {
      _isTelugu = !_isTelugu;
    });
  }

  void _toggleSortOrder() {
    setState(() {
      _sortAscending = !_sortAscending;
      _sortClassPerformance();
    });
  }

  void _sortClassPerformance() {
    _classPerformance.sort((a, b) {
      final double averageA = a['average'] as double;
      final double averageB = b['average'] as double;
      return _sortAscending
          ? averageA.compareTo(averageB)
          : averageB.compareTo(averageA);
    });
  }

  void _updateDataForFilter(int index) {
    setState(() {
      _selectedTimeFilter = index;
      _classPerformance = List.from(_timeFilterData[index] ?? []);
      _sortClassPerformance();
    });
  }

  void _navigateTo(String routeName, {Map<String, dynamic>? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  @override
  void initState() {
    super.initState();
    _sortClassPerformance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(),
              const SizedBox(height: 16),

              // Grades Overview Card
              _buildGradesOverviewCard(),
              const SizedBox(height: 16),

              // Time Filter Tabs
              _buildTimeFilterTabs(),
              const SizedBox(height: 24),

              // Class Performance with Sort Button
              _buildClassPerformanceSection(),
              const SizedBox(height: 24),

              // Footer Action Buttons
              _buildFooterActions(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

// --- HEADER: UPDATED TO MATCH PREVIOUS PAGES ---
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
                color:
                    const Color(0xFF7C3AED).withOpacity(0.1), // Purple Accent
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Color(0xFF7C3AED), size: 20),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              "Grades Analytics", // Page Title
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

  Widget _buildGradesOverviewCard() {
    final data = _overallGradeData[_selectedTimeFilter]!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF59E0B),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.show_chart_rounded,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Grades Overview',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    _timeFilters[_selectedTimeFilter],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _GradeStat(
                  label: 'School Average',
                  value: '${data['average']}%',
                  color: Colors.white,
                ),
                _GradeStat(
                  label: 'Total Students',
                  value: '${data['totalStudents']}',
                  color: Colors.white,
                ),
                _GradeStat(
                  label: 'Classes',
                  value: '${data['classes']}',
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

// --- UPDATED MODERN FILTER TABS ---
  Widget _buildTimeFilterTabs() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _timeFilters.length,
        itemBuilder: (context, index) {
          final bool isSelected = index == _selectedTimeFilter;
          return GestureDetector(
            onTap: () => _updateDataForFilter(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                // ✅ Selected hone par Purple, nahi toh White background
                color: isSelected ? const Color(0xFF7C3AED) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF7C3AED)
                      : Colors.grey.shade300,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                            color: const Color(0xFF7C3AED).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4))
                      ]
                    : null,
              ),
              alignment: Alignment.center,
              child: Text(
                _timeFilters[index],
                style: TextStyle(
                  // ✅ Selected hone par White text
                  color: isSelected ? Colors.white : Colors.grey.shade700,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildClassPerformanceSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header with Sort Button
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Class-wise Performance',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              // Sort Button
              GestureDetector(
                onTap: _toggleSortOrder,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _sortAscending
                            ? Icons.arrow_upward
                            : Icons.arrow_downward,
                        size: 16,
                        color: const Color(0xFF1D4ED8),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _sortAscending ? 'Low to High' : 'High to Low',
                        style: const TextStyle(
                          color: Color(0xFF1D4ED8),
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
          const SizedBox(height: 16),

          // Class List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _classPerformance.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final classData = _classPerformance[index];
              return _buildClassPerformanceCard(classData);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildClassPerformanceCard(Map<String, dynamic> classData) {
    final double average = (classData['average'] as num).toDouble();
    final Map<String, int> distribution =
        Map<String, int>.from(classData['distribution'] as Map);
    final List<Color> colors =
        List<Color>.from(classData['distributionColors'] as List);

    return GestureDetector(
      onTap: () {
        _navigateTo(SubjectTeacherRoutes.classDetails, arguments: classData);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: -4,
              offset: const Offset(0, 6),
              color: Colors.black.withOpacity(0.05),
            ),
          ],
        ),
        child: Row(
          children: [
            // Class Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    classData['className'].toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Class Teacher: ${classData['teacher']}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Average Score
                  Text(
                    'Average Score: ${average.toStringAsFixed(1)}%',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _getGradeColor(average),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Grade Distribution Legend
                  _buildGradeDistributionLegend(distribution, colors),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Pie Chart for Grade Distribution
            _buildGradeDistributionPieChart(distribution, colors),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeDistributionPieChart(
      Map<String, int> distribution, List<Color> colors) {
    final List<double> values =
        distribution.values.map((v) => v.toDouble()).toList();

    return SizedBox(
      width: 70,
      height: 70,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 20,
              sections: List.generate(values.length, (index) {
                return PieChartSectionData(
                  color: colors[index],
                  value: values[index],
                  title: '',
                  radius: 15,
                  showTitle: false,
                );
              }),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Grade',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  'Dist',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradeDistributionLegend(
      Map<String, int> distribution, List<Color> colors) {
    final List<String> labels = distribution.keys.toList();
    final List<int> values = distribution.values.toList();

    return Column(
      children: List.generate(labels.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: colors[index],
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${labels[index]}: ${values[index]}%',
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Color _getGradeColor(double average) {
    if (average >= 80) return const Color(0xFF10B981);
    if (average >= 60) return const Color(0xFFF59E0B);
    return const Color(0xFFEF4444);
  }

  Widget _buildFooterActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Download Report Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                _showDownloadConfirmation();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF59E0B),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.download, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Download Report (PDF)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Share Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton(
              onPressed: () {
                _showShareOptions();
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFF59E0B),
                side: const BorderSide(color: Color(0xFFF59E0B)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Colors.white,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.share, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Share',
                    style: TextStyle(
                      color: Color(0xFFF59E0B),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDownloadConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Download Report'),
        content:
            const Text('The grades report will be downloaded in PDF format.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel',
                style: TextStyle(color: Color(0xFF6B7280))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Report download started'),
                  backgroundColor: Color(0xFFF59E0B),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF59E0B)),
            child:
                const Text('Download', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showShareOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
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
            color: const Color(0xFFF59E0B).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFFF59E0B), size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

// Helper Widgets
class _GradeStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _GradeStat({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
