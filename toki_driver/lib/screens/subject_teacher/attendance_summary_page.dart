import 'package:flutter/material.dart';
import '../../routes/subject_teacher_routes.dart';
import '../../routes/principal_routes.dart';

class AttendanceSummaryPage extends StatefulWidget {
  const AttendanceSummaryPage({Key? key}) : super(key: key);

  @override
  State<AttendanceSummaryPage> createState() => _AttendanceSummaryPageState();
}

class _AttendanceSummaryPageState extends State<AttendanceSummaryPage> {
  int _currentIndex = 2;
  bool _isTelugu = true;
  int _selectedToggleIndex = 0;

  final List<Map<String, dynamic>> _todayClasses = [
    {
      "className": "Class 8B",
      "percent": "95.5%",
      "present": "42",
      "absent": "2",
      "total": "44",
      "color": "green"
    },
    {
      "className": "Class 9A",
      "percent": "90.5%",
      "present": "38",
      "absent": "4",
      "total": "42",
      "color": "blue"
    },
    {
      "className": "Class 10C",
      "percent": "95.7%",
      "present": "44",
      "absent": "2",
      "total": "46",
      "color": "green"
    },
  ];

  final List<Map<String, dynamic>> _weekClasses = [
    {
      "className": "Class 8B",
      "percent": "94.2%",
      "present": "208",
      "absent": "12",
      "total": "220",
      "color": "green"
    },
    {
      "className": "Class 9A",
      "percent": "91.0%",
      "present": "190",
      "absent": "20",
      "total": "210",
      "color": "blue"
    },
    {
      "className": "Class 10C",
      "percent": "96.5%",
      "present": "222",
      "absent": "8",
      "total": "230",
      "color": "green"
    },
  ];

  final Color _primaryPurple = const Color(0xFF9570FF);
  final Color _greenHeader = const Color(0xFF2DC58C);
  final Color _darkGreen = const Color(0xFF1E8F65);

  void _toggleLanguage() {
    setState(() {
      _isTelugu = !_isTelugu;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isTelugu ? 'తెలుగు భాషలో మార్చబడింది' : 'Switched to English'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _onTabTapped(int index) {
    if (_currentIndex == index) return;

    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(
            context,
            SubjectTeacherRoutes.home,
                (route) => false
        );
        break;
      case 1:
        Navigator.pushNamedAndRemoveUntil(
            context,
            PrincipalRoutes.search,
                (route) => false
        );
        break;
      case 2:
        Navigator.pushNamedAndRemoveUntil(
            context,
            SubjectTeacherRoutes.activity,
                (route) => false
        );
        break;
      case 3:
        Navigator.pushNamedAndRemoveUntil(
            context,
            SubjectTeacherRoutes.settings,
                (route) => false
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentList = _selectedToggleIndex == 0 ? _todayClasses : _weekClasses;
    final averageStr = _selectedToggleIndex == 0 ? "93.9%" : "94.5%";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Attendance Summary',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: _toggleLanguage,
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _isTelugu ? 'తెలుగు' : 'English',
                style: const TextStyle(color: Colors.blue, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: _greenHeader,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      SizedBox(width: 4),
                      Text("Attendance Summary", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: _darkGreen,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Overall Average", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        const SizedBox(height: 8),
                        Text(averageStr, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(
                            "Across 3 classes • ${_selectedToggleIndex == 0 ? '132' : '660'} total students",
                            style: const TextStyle(color: Colors.white70, fontSize: 12)
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _selectedToggleIndex = 0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: _selectedToggleIndex == 0 ? _greenHeader : Colors.transparent,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child: Text(
                                    "Today",
                                    style: TextStyle(
                                        color: _selectedToggleIndex == 0 ? Colors.white : Colors.black54,
                                        fontWeight: FontWeight.bold
                                    )
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _selectedToggleIndex = 1),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: _selectedToggleIndex == 1 ? _greenHeader : Colors.transparent,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child: Text(
                                    "This Week",
                                    style: TextStyle(
                                        color: _selectedToggleIndex == 1 ? Colors.white : Colors.black54,
                                        fontWeight: FontWeight.bold
                                    )
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: currentList.length,
                    itemBuilder: (context, index) {
                      return _buildClassItem(currentList[index]);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildClassItem(Map<String, dynamic> data) {
    Color badgeColor = data['color'] == 'green' ? Colors.green.shade50 : Colors.blue.shade50;
    Color badgeText = data['color'] == 'green' ? Colors.green : Colors.blue;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
            context,
            SubjectTeacherRoutes.classAttendance,
            arguments: data
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
            ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(data['className'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(data['percent'], style: TextStyle(color: badgeText, fontWeight: FontWeight.bold, fontSize: 12)),
            ),
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatColumn(data['present'], "Present", const Color(0xFF2DC58C)),
                _buildStatColumn(data['absent'], "Absent", Colors.red),
                _buildStatColumn(data['total'], "Total", Colors.black),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String val, String label, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(val, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: _primaryPurple,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_vert),
            label: 'More',
          ),
        ],
      ),
    );
  }
}