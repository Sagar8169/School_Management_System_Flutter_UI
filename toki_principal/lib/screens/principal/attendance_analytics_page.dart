import 'package:flutter/material.dart';
import '../../routes/principal_routes.dart';

const Color themeBlue = Color(0xFF1E3A8A);
const Color themeLightBlue = Color(0xFF3B82F6);
const Color themeGreen = Color(0xFF059669);
const Color backgroundSlate = Color(0xFFF8FAFC);

class AttendanceAnalyticsPage extends StatefulWidget {
  const AttendanceAnalyticsPage({super.key});

  @override
  State<AttendanceAnalyticsPage> createState() =>
      _AttendanceAnalyticsPageState();
}

class _AttendanceAnalyticsPageState extends State<AttendanceAnalyticsPage> {
  bool _isDownloading = false; // State variable for loading

  DateTime? _selectedSingleDate; // Range ki jagah single date
  String _formattedCustomDate = "";
  // --- ORIGINAL STATE VARIABLES ---
  // int _currentIndex = 0;
  int _selectedTimeFilter = 0;
  bool _isTelugu = true;
  bool _sortAscending = false;
  final List<String> _timeFilters = [
    'Today',
    'This Week',
    'This Month',
    '6 Month'
  ];

  // --- ORIGINAL DATA STRUCTURES ---
  late List<Map<String, dynamic>> _classBreakdown;

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
        'isHigh': false
      },
      {
        'className': 'Class 10-B',
        'section': 'Section B',
        'teacher': 'Ms. Priya Sharma',
        'percentage': 90.9,
        'present': 40,
        'absent': 4,
        'total': 44,
        'isHigh': false
      },
      {
        'className': 'Class 9-A',
        'section': 'Section A',
        'teacher': 'Mr. Suresh Patel',
        'percentage': 97.4,
        'present': 38,
        'absent': 1,
        'total': 39,
        'isHigh': true
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
        'isHigh': false
      },
      {
        'className': 'Class 10-B',
        'section': 'Section B',
        'teacher': 'Ms. Priya Sharma',
        'percentage': 94.2,
        'present': 228,
        'absent': 14,
        'total': 242,
        'isHigh': true
      },
      {
        'className': 'Class 9-A',
        'section': 'Section A',
        'teacher': 'Mr. Suresh Patel',
        'percentage': 96.8,
        'present': 210,
        'absent': 7,
        'total': 217,
        'isHigh': true
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
        'isHigh': true
      },
      {
        'className': 'Class 9-A',
        'section': 'Section A',
        'teacher': 'Mr. Suresh Patel',
        'percentage': 96.5,
        'present': 845,
        'absent': 31,
        'total': 876,
        'isHigh': true
      },
      {
        'className': 'Class 8-B',
        'section': 'Section B',
        'teacher': 'Ms. Kavita Joshi',
        'percentage': 90.2,
        'present': 760,
        'absent': 83,
        'total': 843,
        'isHigh': false
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
        'isHigh': true
      },
      {
        'className': 'Class 9-A',
        'section': 'Section A',
        'teacher': 'Mr. Suresh Patel',
        'percentage': 97.2,
        'present': 2480,
        'absent': 71,
        'total': 2551,
        'isHigh': true
      },
      {
        'className': 'Class 6-B',
        'section': 'Section B',
        'teacher': 'Ms. Sunita Rao',
        'percentage': 85.3,
        'present': 1850,
        'absent': 320,
        'total': 2170,
        'isHigh': false
      },
    ],
  };

  final Map<int, Map<String, dynamic>> _overallAttendanceData = {
    0: {'present': 398, 'absent': 31, 'rate': 92.8, 'totalStudents': 850},
    1: {'present': 2350, 'absent': 210, 'rate': 91.8, 'totalStudents': 2560},
    2: {'present': 8960, 'absent': 850, 'rate': 91.3, 'totalStudents': 9810},
    3: {'present': 25400, 'absent': 2380, 'rate': 91.4, 'totalStudents': 27780},
  };

  @override
  void initState() {
    super.initState();
    _updateDataForFilter(0);
  }

  // --- LOGIC FUNCTIONS (Fixed & Analyzed) ---
  void _updateDataForFilter(int index) {
    setState(() {
      _selectedTimeFilter = index;
      _classBreakdown = List.from(_timeFilterData[index] ?? []);
      _sortClassBreakdown();
    });
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

  void _sortClassBreakdown() {
    setState(() {
      _classBreakdown.sort((a, b) {
        final double percentageA = a['percentage'] as double;
        final double percentageB = b['percentage'] as double;
        return _sortAscending
            ? percentageA.compareTo(percentageB)
            : percentageB.compareTo(percentageA);
      });
    });
  }

  void _navigateTo(String routeName, {Map<String, dynamic>? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  // void _onBottomNavTapped(int index) {
  //   if (index == _currentIndex) return;
  //   setState(() => _currentIndex = index);
  //   switch (index) {
  //     case 0: Navigator.pushReplacementNamed(context, PrincipalRoutes.home); break;
  //     case 1: Navigator.pushNamed(context, PrincipalRoutes.search); break;
  //     case 2: break;
  //     case 3: Navigator.pushNamed(context, PrincipalRoutes.morePage); break;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final summary = _overallAttendanceData[_selectedTimeFilter] ??
        {
          'present': 0,
          'absent': 0,
          'rate': 0,
          'totalStudents': 0,
        };

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildPremiumHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _buildSummaryCard(summary),
                    const SizedBox(height: 25),
                    _buildTimeFilters(),
                    const SizedBox(height: 25),
                    _buildClassListHeader(),
                    const SizedBox(height: 12),
                    // Class Cards List
                    ..._classBreakdown.map((data) => _buildClassCard(data)),
                    const SizedBox(height: 25),
                    _buildFooterActions(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildPremiumHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        MediaQuery.of(context).padding.top + 0,
        20,
        10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6), // 👈 shadow only at bottom
          ),
        ],
      ),
      child: Row(
        children: [
          // 🔙 Circular Back Button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 42,
              width: 42,
              decoration: const BoxDecoration(
                color: Color(0xFFF1F5F9),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: Color(0xFF1E293B),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // 🏫 Title + Subtitle
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Attendance Analytics',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'School Statistics Insights',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),

          // 🌐 Language Toggle
          GestureDetector(
            onTap: () => setState(() => _isTelugu = !_isTelugu),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _isTelugu ? 'తెలుగు' : 'English',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1D4ED8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(Map<String, dynamic> summary) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF064E3B),
            Color(0xFF059669)
          ], // Darker to light emerald
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        // --- LIGHT BORDER ON GRADIENT ---
        border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF059669).withOpacity(0.4),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        // Background design elements ke liye
        children: [
          // Background decorative circles (Optional for extra "Acha UI")
          Positioned(
            right: -20,
            top: -20,
            child: CircleAvatar(
                radius: 50, backgroundColor: Colors.white.withOpacity(0.05)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Icon(Icons.analytics_rounded,
                            color: Colors.white, size: 16),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'School Overview',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            letterSpacing: 0.5),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      _currentFilterLabel.toUpperCase(),
                      style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ovStatStat('${summary['present']}', 'PRESENT',
                      Icons.people_alt_rounded),
                  _buildSummaryDivider(),
                  _ovStatStat('${summary['absent']}', 'ABSENT',
                      Icons.person_off_rounded),
                  _buildSummaryDivider(),
                  _ovStatStat(
                      '${summary['rate']}%', 'RATE', Icons.trending_up_rounded),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  String get _currentFilterLabel {
    if (_selectedTimeFilter == -1) {
      return _formattedCustomDate.isNotEmpty ? _formattedCustomDate : "Custom";
    }
    return _timeFilters[_selectedTimeFilter];
  }

// Helper: Stats with Icons
  Widget _ovStatStat(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white.withOpacity(0.6), size: 16),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5),
        ),
      ],
    );
  }

// Helper: Vertical Divider for Card
  Widget _buildSummaryDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.white.withOpacity(0.1),
    );
  }

  Widget _buildTimeFilters() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 50, // Height thodi badhai hai taaki comfortable lage
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding:
            const EdgeInsets.symmetric(horizontal: 16), // Kinaro se thodi jagah
        physics: const BouncingScrollPhysics(), // iOS style smooth scrolling
        child: Row(
          children: [
            // --- REGULAR FILTERS ---
            ...List.generate(_timeFilters.length, (index) {
              bool isSelected = _selectedTimeFilter == index;
              return Padding(
                padding: const EdgeInsets.only(right: 12), // Items ke beech gap
                child: _buildFilterItem(_timeFilters[index], isSelected,
                    () => _updateDataForFilter(index)),
              );
            }),

            // --- CUSTOM DATE PICKER BUTTON ---
            _buildCustomDateButton(),
          ],
        ),
      ),
    );
  }

// Helper: Standard Filter Item (Pill Style)
  Widget _buildFilterItem(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          // Selected hone par teal background, warna halka grey
          color: isSelected ? const Color(0xFF0D9488) : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(25), // Full round pill shape
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF0D9488).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
              color: isSelected ? Colors.white : const Color(0xFF64748B),
            ),
          ),
        ),
      ),
    );
  }

// Helper: Custom Date Button (Match with scrollable style)
  Widget _buildCustomDateButton() {
    bool isCustomSelected = _selectedTimeFilter == -1;

    return GestureDetector(
      onTap: () => _showCustomDatePicker(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isCustomSelected
              ? const Color(0xFF0D9488)
              : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color:
                isCustomSelected ? Colors.transparent : const Color(0xFFE2E8F0),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.calendar_month_rounded,
              size: 18,
              color: isCustomSelected ? Colors.white : const Color(0xFF64748B),
            ),
            if (isCustomSelected) ...[
              const SizedBox(width: 8),
              Text(
                _formattedCustomDate,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

// Function to handle Date Picker
// Function to handle Single Date Picker
  void _showCustomDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF0D9488), // Teal Theme
              onPrimary: Colors.white,
              onSurface: Color(0xFF1E293B),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF0D9488)),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedTimeFilter = -1; // Custom mode
        _selectedSingleDate = picked;

        // Format: "15 Nov 2024" ya "15 Nov"
        final months = [
          "Jan",
          "Feb",
          "Mar",
          "Apr",
          "May",
          "Jun",
          "Jul",
          "Aug",
          "Sep",
          "Oct",
          "Nov",
          "Dec"
        ];
        _formattedCustomDate = "${picked.day} ${months[picked.month - 1]}";

        // Yahan apna data fetch call karo single date ke liye
        // _fetchDataForDate(picked);
      });
    }
  }

// Helper: Custom Date Button (Update for Single Date)

  Widget _buildClassListHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 20, vertical: 8), // Adjusted padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // --- TITLE SECTION WITH INDICATOR ---
          Row(
            children: [
              Container(
                width: 4,
                height: 18,
                decoration: BoxDecoration(
                  color: const Color(0xFF1D4ED8),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Class Breakdown',
                style: TextStyle(
                  fontSize: 15, // Slightly refined size
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E293B),
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),

          // --- STYLISH SORT ACTION ---
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                setState(() => _sortAscending = !_sortAscending);
                _sortClassBreakdown();
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1D4ED8).withOpacity(0.06),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF1D4ED8).withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      _sortAscending ? "Lowest First" : "Highest First",
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1D4ED8),
                      ),
                    ),
                    const SizedBox(width: 6),
                    AnimatedRotation(
                      duration: const Duration(milliseconds: 300),
                      turns: _sortAscending ? 0 : 0.5, // Smooth rotation effect
                      child: const Icon(
                        Icons.sort_rounded,
                        size: 16,
                        color: Color(0xFF1D4ED8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassCard(Map<String, dynamic> data) {
    double perc = data['percentage'] as double;
    // ✨ FIXED: Added InkWell for card navigation
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: InkWell(
        onTap: () => _navigateTo(PrincipalRoutes.classDetails, arguments: data),
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFF1F5F9)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4))
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data['className'],
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF1E293B))),
                        Text(data['teacher'],
                            style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF94A3B8),
                                fontWeight: FontWeight.w600)),
                      ]),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: const Color(0xFFF0F9FF),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text('$perc%',
                        style: const TextStyle(
                            color: Color(0xFF1D4ED8),
                            fontWeight: FontWeight.w900,
                            fontSize: 13)),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              LinearProgressIndicator(
                value: perc / 100,
                minHeight: 7,
                backgroundColor: const Color(0xFFF1F5F9),
                color: perc > 95 ? Colors.green : const Color(0xFF1D4ED8),
                borderRadius: BorderRadius.circular(10),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _statText('Present', '${data['present']}', Colors.green),
                  _statText('Absent', '${data['absent']}', Colors.red),
                  _statText('Total', '${data['total']}', Colors.blueGrey),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statText(String l, String v, Color c) => Column(children: [
        Text(l,
            style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF94A3B8),
                fontWeight: FontWeight.bold)),
        Text(v,
            style:
                TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: c)),
      ]);

  Widget _buildFooterActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          // --- DOWNLOAD REPORT BUTTON (PRIMARY) ---
          _buildPrimaryAction(
            label:
                _isDownloading ? "Generating PDF..." : "Download Full Report",
            icon: _isDownloading ? null : Icons.description_rounded,
            isLoading: _isDownloading,
            onTap: _fakeDownloadLogic,
          ),

          const SizedBox(height: 12),

          // --- SHARE STATS BUTTON (SECONDARY) ---
          _buildSecondaryAction(
            label: "Share Analytics",
            icon: Icons.ios_share_rounded,
            onTap: () {
              // Add share logic here
            },
          ),
        ],
      ),
    );
  }

// --- FAKE DOWNLOAD WORKING LOGIC ---
  void _fakeDownloadLogic() async {
    if (_isDownloading) return;

    setState(() => _isDownloading = true);

    // Fake Generation Delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isDownloading = false);

    if (mounted) {
      // PDF khulne ka effect
      _showReportPreview();
    }
  }

  void _showReportPreview() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildPdfModal(),
    );
  }

  Widget _buildPdfModal() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Color(0xFFF1F5F9),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          // Modal Handle
          const SizedBox(height: 12),
          Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10))),

          // PDF Toolbar
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const Text("Report_Nov_2024.pdf",
                    style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                const Spacer(),
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded)),
              ],
            ),
          ),

          // PDF Paper Area
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05), blurRadius: 10)
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // School Header
                    Center(
                      child: Column(
                        children: [
                          const Text("TOKI PUBLIC SCHOOL",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.5)),
                          Text("Attendance & Academic Analytics Report",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold)),
                          const Divider(height: 30, thickness: 1.5),
                        ],
                      ),
                    ),

                    // Report Metadata
                    _pdfRow("Report Date:", "25 Nov 2024"),
                    _pdfRow("Generated By:", "Principal Dashboard"),
                    _pdfRow(
                        "Filter Context:",
                        _selectedTimeFilter == -1
                            ? _formattedCustomDate
                            : _timeFilters[_selectedTimeFilter]),

                    const SizedBox(height: 20),
                    const Text("STATISTICAL SUMMARY",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                            color: Color(0xFF1D4ED8))),
                    const SizedBox(height: 10),

                    // Dummy Data Table
                    Table(
                      border: TableBorder.all(color: Colors.grey.shade300),
                      children: [
                        _tableRow(["Category", "Count", "Percentage"],
                            isHeader: true),
                        _tableRow(["Present", "798", "94%"]),
                        _tableRow(["Absent", "52", "6%"]),
                        _tableRow(["Late", "14", "2%"]),
                      ],
                    ),

                    const SizedBox(height: 40),
                    // Footer Stamp
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Column(
                        children: [
                          Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blue.withOpacity(0.2)),
                                  shape: BoxShape.circle),
                              child: const Center(
                                  child: Text("STAMP",
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.blue)))),
                          const SizedBox(height: 8),
                          const Text("Authorized Signatory",
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

// Helpers for PDF UI
  Widget _pdfRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(label,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(width: 10),
          Text(value, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  TableRow _tableRow(List<String> cells, {bool isHeader = false}) {
    return TableRow(
      children: cells
          .map((cell) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(cell,
                    style: TextStyle(
                        fontWeight:
                            isHeader ? FontWeight.w900 : FontWeight.normal,
                        fontSize: 11)),
              ))
          .toList(),
    );
  }

// Helper: Primary Button UI
  Widget _buildPrimaryAction(
      {required String label,
      IconData? icon,
      required bool isLoading,
      required VoidCallback onTap}) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1D4ED8), Color(0xFF1E40AF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1D4ED8).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: Colors.white, size: 20),
                  const SizedBox(width: 10),
                  Text(label,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 15)),
                ],
              ),
      ),
    );
  }

// Helper: Secondary Button UI
  Widget _buildSecondaryAction(
      {required String label,
      required IconData icon,
      required VoidCallback onTap}) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 18, color: const Color(0xFF1D4ED8)),
        label: Text(label,
            style: const TextStyle(
                color: Color(0xFF1D4ED8),
                fontWeight: FontWeight.w800,
                fontSize: 14)),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
      ),
    );
  }

  Widget _btn(String t, IconData i, Color c, bool pri) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: pri
          ? ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(i, size: 18),
              label:
                  Text(t, style: const TextStyle(fontWeight: FontWeight.w800)),
              style: ElevatedButton.styleFrom(
                  backgroundColor: c,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 0))
          : OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(i, size: 18),
              label:
                  Text(t, style: const TextStyle(fontWeight: FontWeight.w800)),
              style: OutlinedButton.styleFrom(
                  foregroundColor: c,
                  side: BorderSide(color: c, width: 1.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)))),
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
