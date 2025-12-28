import 'package:flutter/material.dart';
import '../../routes/principal_routes.dart';

// Theme Colors
const Color themeBlue = Color(0xFF1E3A8A);
const Color themeGreen = Color(0xFF059669);
const Color themeRed = Color(0xFFDC2626);
const Color themeOrange = Color(0xFFD97706);

class CollectFeePage extends StatefulWidget {
  const CollectFeePage({super.key});

  @override
  State<CollectFeePage> createState() => _CollectFeePageState();
}

class _CollectFeePageState extends State<CollectFeePage> {
  String _selectedDiv = 'All Div';

  int _currentIndex = 2;
  String _selectedStatus = 'All'; // Filters: All, Paid, Delayed, Not Paid
  String? _selectedClass = 'Class 10';

  // --- Mock Data with Detailed History ---
  final List<Map<String, dynamic>> _students = [
    {
      'id': '1',
      'name': 'Rahul Verma',
      'roll': '101',
      'class': 'Class 10',
      'div': 'A',
      'status': 'Delayed', // Status based on pending amount
      'totalFee': 25000,
      'paid': 15000,
      'pending': 10000,
      'history': [
        {'date': '12 Oct 2023', 'amount': 10000, 'mode': 'UPI'},
        {'date': '05 Sep 2023', 'amount': 5000, 'mode': 'Cash'},
      ],
    },
    {
      'id': '2',
      'name': 'Sneha Reddy',
      'roll': '105',
      'class': 'Class 10',
      'div': 'A',
      'status': 'Paid',
      'totalFee': 25000,
      'paid': 25000,
      'pending': 0,
      'history': [
        {'date': '01 Aug 2023', 'amount': 25000, 'mode': 'Bank'},
      ],
    },
    {
      'id': '3',
      'name': 'Vikram Singh',
      'roll': '102',
      'class': 'Class 10',
      'div': 'A',
      'status': 'Not Paid',
      'totalFee': 25000,
      'paid': 0,
      'pending': 25000,
      'history': [],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            _buildPremiumHeader(),
            _buildFilterChips(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _students.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final student = _students[index];
                  // Simple Filter Logic
                  if (_selectedStatus != 'All' && student['status'] != _selectedStatus) {
                    return const SizedBox.shrink();
                  }
                  return _buildStudentFeeCard(student);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // 🔝 PREMIUM ROUNDED HEADER
  Widget _buildPremiumHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        MediaQuery.of(context).padding.top + 10,
        20,
        25,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // 🔹 TOP ROW
          Row(
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(
                  'https://ui-avatars.com/api/?name=Principal&background=1E3A8A&color=fff',
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Fee Overview",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      "Academic Year 2023-24",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search_rounded, color: themeBlue),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // 🔽 CLASS + DIV FILTER ROW
          Row(
            children: [
              // ✅ CLASS FILTER
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedClass,
                      isExpanded: true,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: themeBlue,
                      ),
                      items: ['Class 8', 'Class 9', 'Class 10']
                          .map(
                            (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      )
                          .toList(),
                      onChanged: (v) {
                        if (v == null) return;
                        setState(() => _selectedClass = v);
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // ✅ DIV / SECTION FILTER
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedDiv,
                      isExpanded: true,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: themeBlue,
                      ),
                      items: ['All Div', 'A', 'B', 'C']
                          .map(
                            (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      )
                          .toList(),
                      onChanged: (v) {
                        if (v == null) return;
                        setState(() => _selectedDiv = v);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 🏷️ STATUS FILTERS (Paid, Delayed, etc.)
  Widget _buildFilterChips() {
    final statuses = ['All', 'Paid', 'Delayed', 'Not Paid'];

    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: statuses.length,
        itemBuilder: (context, index) {
          final status = statuses[index];
          final bool isSel = _selectedStatus == status;

          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ChoiceChip(
              label: Text(status),
              selected: isSel,
              onSelected: (_) {
                setState(() => _selectedStatus = status);
              },

              // ✅ IMPORTANT PART
              showCheckmark: true,
              checkmarkColor: Colors.white, // 🔥 WHITE TICK

              selectedColor: themeBlue,
              backgroundColor: Colors.white,

              labelStyle: TextStyle(
                color: isSel ? Colors.white : const Color(0xFF1E293B),
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(
                  color: isSel ? themeBlue : const Color(0xFFE2E8F0),
                  width: 1.2,
                ),
              ),

              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            ),
          );
        },
      ),
    );
  }

  // 💳 STUDENT FEE CARD — PREMIUM
  Widget _buildStudentFeeCard(Map<String, dynamic> student) {
    final String status = student['status'];
    final Color statusColor =
    status == 'Paid'
        ? themeGreen
        : status == 'Delayed'
        ? themeOrange
        : themeRed;

    final double progress =
        (student['paid'] as num) / (student['totalFee'] as num);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // 🔹 HEADER
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Row(
              children: [
                // Roll Avatar
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    student['roll'],
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Name + Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student['name'],
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Section ${student['div']}",
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),

                // Status Pill
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: statusColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // 🔹 FEE STATS
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _feeStat("TOTAL", "₹${student['totalFee']}",
                        const Color(0xFF475569)),
                    _feeStat("PAID", "₹${student['paid']}", themeGreen),
                    _feeStat("PENDING", "₹${student['pending']}", themeRed),
                  ],
                ),
                const SizedBox(height: 12),

                // Progress Bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress.clamp(0.0, 1.0),
                    minHeight: 7,
                    backgroundColor: const Color(0xFFF1F5F9),
                    valueColor:
                    AlwaysStoppedAnimation<Color>(statusColor),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 6),

          // 🔹 ACTION / HISTORY
          ExpansionTile(
            tilePadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            shape: const Border(),
            iconColor: themeBlue,
            title: const Text(
              "Recent Transactions",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: Color(0xFF334155),
              ),
            ),
            trailing: status != 'Paid'
                ? IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.send_to_mobile_rounded,
                color: themeBlue,
                size: 20,
              ),
              tooltip: "Send Due Reminder",
            )
                : const Icon(
              Icons.verified_rounded,
              color: themeGreen,
              size: 20,
            ),
            children: (student['history'] as List).isEmpty
                ? [
              const Padding(
                padding: EdgeInsets.all(14),
                child: Text(
                  "No payments made yet",
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF94A3B8),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ]
                : (student['history'] as List)
                .map(
                  (h) => ListTile(
                dense: true,
                leading: const Icon(
                  Icons.receipt_long_rounded,
                  size: 16,
                  color: themeBlue,
                ),
                title: Text(
                  "Received ₹${h['amount']}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
                subtitle: Text(
                  "${h['date']} • ${h['mode']}",
                  style: const TextStyle(fontSize: 11),
                ),
              ),
            )
                .toList(),
          ),
        ],
      ),
    );
  }

// 🔹 FEE STAT
  Widget _feeStat(String label, String val, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w800,
            color: Color(0xFF94A3B8),
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          val,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
      ],
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



  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xFFF1F5F9),
            width: 2,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,

        // ✅ CORRECT onTap (int only)
        onTap: (index) {
          if (index == _currentIndex) return;
          _onBottomNavTap(index);
        },

        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: themeBlue,
        unselectedItemColor: const Color(0xFF94A3B8),
        elevation: 0,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_rounded),
            label: "Activity",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: "More",
          ),
        ],
      ),
    );
  }
}