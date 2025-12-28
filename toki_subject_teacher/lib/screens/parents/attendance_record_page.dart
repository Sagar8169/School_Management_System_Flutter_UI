// lib/screens/parents/attendance_record_page.dart
import 'package:flutter/material.dart';
import '../../routes/parents_routes.dart';

class AttendanceRecordPage extends StatefulWidget {
  const AttendanceRecordPage({Key? key}) : super(key: key);

  @override
  _AttendanceRecordPageState createState() => _AttendanceRecordPageState();
}

class _AttendanceRecordPageState extends State<AttendanceRecordPage> {
  String _selectedLanguage = 'తెలుగు';
  String _activeFilter = 'Recent';
  DateTimeRange? _selectedDateRange;

  // Color Palette
  final Color _primaryGreen = const Color(0xFF10B981);
  final Color _darkGreenCard = const Color(0xFF065F46);
  final Color _bgGreenLight = const Color(0xFFECFDF5);
  final Color _textGreen = const Color(0xFF059669);
  final Color _bgRedLight = const Color(0xFFFEF2F2);
  final Color _textRed = const Color(0xFFDC2626);
  final Color _scaffoldBg = const Color(0xFFF8FAFC);

  // ✅ Date Picker Logic integrated with Filter Tab
  Future<void> _handleFilterSelection(String filter) async {
    if (filter == 'Custom') {
      final DateTimeRange? picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2024),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(primary: _primaryGreen),
            ),
            child: child!,
          );
        },
      );
      if (picked != null) {
        setState(() {
          _selectedDateRange = picked;
          _activeFilter = 'Custom';
        });
      }
    } else {
      setState(() {
        _activeFilter = filter;
        _selectedDateRange = null;
      });
    }
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
                    _buildGreenSummaryCard(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildOverallTermStats(),
                          const SizedBox(height: 24),
                          const Text("Attendance History", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Color(0xFF1E293B))),
                          const SizedBox(height: 12),
                          _buildFilterTabs(), // ✅ Updated Horizontal Tabs
                          const SizedBox(height: 16),
                          _buildFilteredView(),
                          const SizedBox(height: 30),
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

  // ✅ FULLY INTEGRATED FILTER TABS (Including Custom)
  Widget _buildFilterTabs() {
    final filters = ["Recent", "Today", "Yesterday", "Monthly", "Custom"];
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          String filter = filters[index];
          bool isSelected = _activeFilter == filter;

          return GestureDetector(
            onTap: () => _handleFilterSelection(filter),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 22),
              decoration: BoxDecoration(
                color: isSelected ? _primaryGreen : Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: isSelected ? _primaryGreen : Colors.grey.shade300),
                boxShadow: isSelected ? [BoxShadow(color: _primaryGreen.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 4))] : [],
              ),
              alignment: Alignment.center,
              child: Text(
                filter,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black54,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // --- UI BUILDING BLOCKS ---

  Widget _buildAppHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(width: 40, height: 40, decoration: BoxDecoration(color: const Color(0xFFFF5722), borderRadius: BorderRadius.circular(10)), alignment: Alignment.center, child: const Text("A", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20))),
          const SizedBox(width: 12),
          const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Aditya International", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15)), Text("Attendance Portal", style: TextStyle(color: Colors.grey, fontSize: 11))])),
          Text(_selectedLanguage, style: const TextStyle(color: Color(0xFFFF5722), fontWeight: FontWeight.w800, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildGreenSummaryCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topLeft, colors: [_primaryGreen, const Color(0xFF059669)]),
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(35), bottomRight: Radius.circular(35)),
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            GestureDetector(onTap: () => Navigator.pop(context), child: const CircleAvatar(backgroundColor: Colors.white24, radius: 18, child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 14))),
            const SizedBox(width: 12),
            const Text("Attendance Record", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
          ]),
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(28), border: Border.all(color: Colors.white30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text("ANANYA SHARMA", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 8),
                  Row(children: [_badge("10-A"), const SizedBox(width: 6), _badge("ROLL 24")]),
                ]),
                Container(padding: const EdgeInsets.all(12), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: Text("95%", style: TextStyle(color: _textGreen, fontWeight: FontWeight.w900, fontSize: 20))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _badge(String txt) => Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(8)), child: Text(txt, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900)));

  Widget _buildOverallTermStats() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20)]),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [_bigStat("180", "Working", Colors.blue), _bigStat("172", "Present", _textGreen), _bigStat("08", "Absent", _textRed)]),
    );
  }

  Widget _bigStat(String v, String l, Color c) => Column(children: [Text(v, style: TextStyle(color: c, fontSize: 28, fontWeight: FontWeight.w900)), Text(l, style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w700))]);

  Widget _buildFilteredView() {
    if (_activeFilter == "Monthly") return _buildMonthlyViewList();
    if (_activeFilter == "Today") return _buildDayCard("Wednesday", "Dec 25", true);
    if (_activeFilter == "Yesterday") return _buildDayCard("Tuesday", "Dec 24", true);
    if (_activeFilter == "Custom" && _selectedDateRange != null) {
      return Column(
        children: [
          Text("Range: ${_selectedDateRange!.start.day}/${_selectedDateRange!.start.month} - ${_selectedDateRange!.end.day}/${_selectedDateRange!.end.month}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
          const SizedBox(height: 10),
          _buildDayCard("Range Result", "Showing custom data", true),
        ],
      );
    }
    return _buildRecentDaysList();
  }

  Widget _buildRecentDaysList() {
    return Column(children: [_buildDayCard("Saturday", "Nov 9", true), _buildDayCard("Friday", "Nov 8", true), _buildDayCard("Thursday", "Nov 7", true), _buildDayCard("Wednesday", "Nov 6", false)]);
  }

  Widget _buildDayCard(String day, String date, bool isPresent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 15)]),
      child: Row(children: [
        Container(width: 55, height: 55, decoration: BoxDecoration(color: isPresent ? _bgGreenLight : _bgRedLight, borderRadius: BorderRadius.circular(18)), child: Icon(isPresent ? Icons.verified_user_rounded : Icons.do_not_disturb_on_rounded, color: isPresent ? _textGreen : _textRed, size: 28)),
        const SizedBox(width: 16),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(day, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)), Text(date, style: const TextStyle(color: Colors.grey, fontSize: 12))])),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [Text(isPresent ? "PRESENT" : "ABSENT", style: TextStyle(color: isPresent ? _textGreen : _textRed, fontWeight: FontWeight.w900, fontSize: 13)), const Text("In: 08:30 AM", style: TextStyle(color: Colors.grey, fontSize: 11))]),
      ]),
    );
  }

  Widget _buildMonthlyViewList() {
    return Column(children: [_buildMonthCard("December 2025", "100%", 25, 0, 25, _bgGreenLight, _textGreen), _buildMonthCard("November 2025", "95.5%", 21, 1, 22, _bgGreenLight, _textGreen)]);
  }

  Widget _buildMonthCard(String month, String perc, int p, int a, int t, Color bg, Color txt) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 15)]),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(month, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17)), Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)), child: Text(perc, style: TextStyle(color: txt, fontWeight: FontWeight.w900, fontSize: 14)))]),
        const Divider(height: 40),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [_mStat(p.toString(), "Present", _textGreen), _mStat(a.toString(), "Absent", _textRed), _bigStat(t.toString(), "Working", Colors.blue)])
      ]),
    );
  }

  Widget _mStat(String v, String l, Color c) => Column(children: [Text(v, style: TextStyle(color: c, fontSize: 26, fontWeight: FontWeight.w900)), Text(l, style: const TextStyle(color: Colors.grey, fontSize: 12))]);

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: 1, type: BottomNavigationBarType.fixed, selectedItemColor: const Color(0xFFFF5722),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_max_rounded), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.analytics_rounded), label: "Reports"),
        BottomNavigationBarItem(icon: Icon(Icons.directions_bus_rounded), label: "Bus"),
        BottomNavigationBarItem(icon: Icon(Icons.widgets_rounded), label: "More"),
      ],
    );
  }
}