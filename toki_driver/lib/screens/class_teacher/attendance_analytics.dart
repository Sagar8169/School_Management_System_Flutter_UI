import 'package:flutter/material.dart';
import '../../routes/class_teacher_routes.dart';

class AttendanceAnalyticsPage extends StatefulWidget {
  const AttendanceAnalyticsPage({Key? key}) : super(key: key);

  @override
  State<AttendanceAnalyticsPage> createState() => _AttendanceAnalyticsPageState();
}

class _AttendanceAnalyticsPageState extends State<AttendanceAnalyticsPage> {
  int _currentIndex = 0;
  int _selectedTabIndex = 0;
  bool _isComparisonOn = false;
  bool _isTelugu = true;

  final Color _primaryGreen = const Color(0xFF26A675);
  final Color _primaryBlue = const Color(0xFF2979FF);
  final Color _bgGrey = const Color(0xFFF5F6F8);
  final Color _textDark = const Color(0xFF1A1A1A);
  final Color _textGrey = const Color(0xFF757575);
  final Color _successGreen = const Color(0xFF00C853);
  final Color _errorRed = const Color(0xFFD32F2F);
  final Color _warningOrange = const Color(0xFFFF9800);
  final Color _selectedPurple = const Color(0xFFEADDFF);

  final List<String> _tabs = ['Daily', 'Weekly', 'Monthly', 'Yearly'];

  final List<Map<String, dynamic>> _dailyData = [
    {'date': 'Nov 9', 'percentage': 93.2, 'present': 41, 'absent': 3, 'total': 44, 'atRisk': 2},
    {'date': 'Nov 8', 'percentage': 95.5, 'present': 42, 'absent': 2, 'total': 44, 'atRisk': 1},
    {'date': 'Nov 7', 'percentage': 90.9, 'present': 40, 'absent': 4, 'total': 44, 'atRisk': 3},
    {'date': 'Nov 6', 'percentage': 97.7, 'present': 43, 'absent': 1, 'total': 44, 'atRisk': 0},
    {'date': 'Nov 5', 'percentage': 93.2, 'present': 41, 'absent': 3, 'total': 44, 'atRisk': 2},
  ];

  final List<Map<String, dynamic>> _weeklyData = [
    {'week': 'Week 45 (Nov 4-9)', 'percentage': 94.1, 'present': 207, 'absent': 13, 'total': 220, 'atRisk': 5},
    {'week': 'Week 44 (Oct 28-Nov 2)', 'percentage': 92.7, 'present': 204, 'absent': 16, 'total': 220, 'atRisk': 6},
    {'week': 'Week 43 (Oct 21-26)', 'percentage': 91.4, 'present': 201, 'absent': 19, 'total': 220, 'atRisk': 7},
    {'week': 'Week 42 (Oct 14-19)', 'percentage': 95.0, 'present': 209, 'absent': 11, 'total': 220, 'atRisk': 4},
  ];

  final List<Map<String, dynamic>> _monthlyData = [
    {'month': 'October 2025', 'percentage': 93.5, 'present': 412, 'absent': 29, 'total': 441, 'atRisk': 8},
    {'month': 'September 2025', 'percentage': 94.2, 'present': 415, 'absent': 26, 'total': 441, 'atRisk': 6},
    {'month': 'August 2025', 'percentage': 92.8, 'present': 409, 'absent': 32, 'total': 441, 'atRisk': 9},
  ];

  final List<Map<String, dynamic>> _yearlyData = [
    {'year': '2025 (YTD)', 'percentage': 93.8, 'present': 1236, 'absent': 87, 'total': 1323, 'atRisk': 12},
    {'year': '2024', 'percentage': 94.5, 'present': 1247, 'absent': 73, 'total': 1320, 'atRisk': 9},
    {'year': '2023', 'percentage': 92.9, 'present': 1226, 'absent': 94, 'total': 1320, 'atRisk': 15},
  ];

  final Map<String, dynamic> _comparisonData = {
    'week': {'prev': 90.9, 'current': 93.5, 'change': '+2.6%'},
    'month': {'prev': 90.9, 'current': 93.5, 'change': '+2.6%'},
    'year': {'prev': 90.9, 'current': 93.5, 'change': '+2.6%'},
  };

  final List<Map<String, dynamic>> _atRiskStudents = [
    {'name': 'Rahul Sharma', 'attendance': 68.5, 'daysAbsent': 12},
    {'name': 'Priya Patel', 'attendance': 72.3, 'daysAbsent': 10},
    {'name': 'Arjun Kumar', 'attendance': 65.8, 'daysAbsent': 14},
    {'name': 'Sneha Reddy', 'attendance': 69.2, 'daysAbsent': 13},
  ];

  List<Map<String, dynamic>> get _currentData {
    switch (_selectedTabIndex) {
      case 0: return _dailyData;
      case 1: return _weeklyData;
      case 2: return _monthlyData;
      case 3: return _yearlyData;
      default: return _dailyData;
    }
  }

  String get _dateLabel {
    switch (_selectedTabIndex) {
      case 0: return 'date';
      case 1: return 'week';
      case 2: return 'month';
      case 3: return 'year';
      default: return 'date';
    }
  }

  void _toggleLanguage() {
    setState(() {
      _isTelugu = !_isTelugu;
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    ClassTeacherRoutes.handleBottomNavTap(context, index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgGrey,
      appBar: _buildCustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildSegmentedTabs(),
                  const SizedBox(height: 16),
                  _buildToggleCard(),
                  const SizedBox(height: 16),
                  ..._currentData.map((data) => Padding(padding: const EdgeInsets.only(bottom: 12), child: _buildAttendanceCard(data))),
                  if (_isComparisonOn) ...[
                    const SizedBox(height: 8),
                    _buildPeriodComparisonSection(),
                    const SizedBox(height: 16),
                    _buildAtRiskStudentsSection(),
                    const SizedBox(height: 20),
                  ],
                  const SizedBox(height: 10),
                  _buildActionButtons(),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  PreferredSizeWidget _buildCustomAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 70,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: _primaryBlue, borderRadius: BorderRadius.circular(8)),
            child: const Center(child: Text('A', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20))),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Aditya International School', style: TextStyle(color: _textDark, fontSize: 16, fontWeight: FontWeight.bold)),
              Text('Powered by Toki Tech', style: TextStyle(color: Colors.grey[400], fontSize: 11)),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: _toggleLanguage,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(20)),
              child: Text(_isTelugu ? 'తెలుగు' : 'English', style: TextStyle(color: _primaryBlue, fontSize: 13, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      decoration: BoxDecoration(color: _primaryGreen, borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                  child: const Icon(Icons.chevron_left, color: Colors.white, size: 20),
                ),
              ),
              const SizedBox(width: 12),
              const Text('Attendance Analytics', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Class 8B', style: TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHeroStat('93.5%', 'Avg Rate'),
              _buildHeroStat('41', 'Avg Present'),
              _buildHeroStat('44', 'Total Students'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroStat(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  Widget _buildSegmentedTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(_tabs.length, (index) {
        final isSelected = _selectedTabIndex == index;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedTabIndex = index),
            child: Container(
              margin: EdgeInsets.only(right: index == _tabs.length - 1 ? 0 : 8),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(color: isSelected ? _primaryBlue : Colors.white, borderRadius: BorderRadius.circular(20), border: isSelected ? null : Border.all(color: Colors.grey.shade300)),
              alignment: Alignment.center,
              child: Text(_tabs[index], style: TextStyle(color: isSelected ? Colors.white : _textDark, fontSize: 12, fontWeight: FontWeight.w600)),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildToggleCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _isComparisonOn ? _primaryBlue : Colors.grey.shade200),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          const Icon(Icons.show_chart, color: Color(0xFF2979FF)),
          const SizedBox(width: 12),
          const Expanded(child: Text('Comparison Analytics', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14))),
          Switch(
            value: _isComparisonOn,
            activeColor: Colors.white,
            activeTrackColor: _primaryBlue,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey.shade300,
            onChanged: (val) => setState(() => _isComparisonOn = val),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceCard(Map<String, dynamic> data) {
    Color badgeBg = const Color(0xFFE3F2FD);
    Color badgeText = _primaryBlue;

    if (data['percentage'] >= 95) {
      badgeBg = const Color(0xFFE8F5E9);
      badgeText = _successGreen;
    } else if (data['percentage'] < 85) {
      badgeBg = const Color(0xFFFFF3E0);
      badgeText = _warningOrange;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2))]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(data[_dateLabel], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), overflow: TextOverflow.ellipsis)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: badgeBg, borderRadius: BorderRadius.circular(4)),
                child: Text('${data['percentage']}%', style: TextStyle(color: badgeText, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDetailStat(data['present'].toString(), 'Present', _successGreen),
              _buildDetailStat(data['absent'].toString(), 'Absent', _errorRed),
              _buildDetailStat(data['atRisk'].toString(), 'At Risk', _warningOrange),
              _buildDetailStat(data['total'].toString(), 'Total', _primaryBlue),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailStat(String val, String label, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(val, style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.w500)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 10)),
      ],
    );
  }

  Widget _buildPeriodComparisonSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Period Comparison', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2))]),
          child: Column(
            children: [
              _buildComparisonRow('This Week vs Last Week', _comparisonData['week']['prev'], _comparisonData['week']['current'], _comparisonData['week']['change']),
              const Divider(height: 24),
              _buildComparisonRow('This Month vs Last Month', _comparisonData['month']['prev'], _comparisonData['month']['current'], _comparisonData['month']['change']),
              const Divider(height: 24),
              _buildComparisonRow('This Year vs Last Year', _comparisonData['year']['prev'], _comparisonData['year']['current'], _comparisonData['year']['change']),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildComparisonRow(String title, double prevVal, double currVal, String change) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            Text(change, style: TextStyle(color: change.startsWith('+') ? _successGreen : _errorRed, fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: prevVal / 100, minHeight: 6, backgroundColor: Colors.grey[200], valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2979FF)))),
                  const SizedBox(height: 6),
                  const Text('Last: 90.9%', style: TextStyle(color: Colors.grey, fontSize: 10)),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: currVal / 100, minHeight: 6, backgroundColor: Colors.grey[200], valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00C853)))),
                  const SizedBox(height: 6),
                  const Text('This: 93.5%', style: TextStyle(color: Colors.grey, fontSize: 10)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAtRiskStudentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('At Risk Students', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2))]),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text('Student Name', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Colors.grey))),
                  Expanded(child: Text('Attendance', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Colors.grey), textAlign: TextAlign.center)),
                  Expanded(child: Text('Days Absent', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Colors.grey), textAlign: TextAlign.end)),
                ],
              ),
              const SizedBox(height: 12),
              ..._atRiskStudents.map((student) => Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: _buildAtRiskStudentRow(student))),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAtRiskStudentRow(Map<String, dynamic> student) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(student['name'], style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13), overflow: TextOverflow.ellipsis)),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: student['attendance'] < 70 ? const Color(0xFFFFF2F2) : const Color(0xFFFFF7E0), borderRadius: BorderRadius.circular(4)),
            child: Text('${student['attendance']}%', style: TextStyle(color: student['attendance'] < 70 ? _errorRed : _warningOrange, fontSize: 12, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
          ),
        ),
        Expanded(
          child: Text(student['daysAbsent'].toString(), style: TextStyle(color: _textDark, fontSize: 13, fontWeight: FontWeight.w600), textAlign: TextAlign.end),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Downloading report...'), duration: Duration(seconds: 2))),
            style: ElevatedButton.styleFrom(backgroundColor: _primaryBlue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), elevation: 0),
            child: const Text('Download Report (PDF)', style: TextStyle(fontWeight: FontWeight.w600)),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Shared'), duration: Duration(seconds: 2))),
            style: OutlinedButton.styleFrom(foregroundColor: _primaryBlue, side: BorderSide(color: _primaryBlue), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            child: const Text('Share', style: TextStyle(fontWeight: FontWeight.w600)),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey.shade200))),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: _primaryBlue,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        elevation: 0,
        items: [
          BottomNavigationBarItem(icon: Icon(_currentIndex == 0 ? Icons.home_filled : Icons.home_outlined), label: 'Home'),
          const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: _currentIndex == 2 ? _selectedPurple : Colors.transparent, borderRadius: BorderRadius.circular(20)),
              child: const Icon(Icons.show_chart, size: 22),
            ),
            label: 'Activity',
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.more_vert), label: 'More'),
        ],
      ),
    );
  }
}