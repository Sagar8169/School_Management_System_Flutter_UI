// lib/screens/parents/homework_page.dart
import 'package:flutter/material.dart';
import '../../routes/parents_routes.dart';

class HomeworkPage extends StatefulWidget {
  const HomeworkPage({Key? key}) : super(key: key);

  @override
  _HomeworkPageState createState() => _HomeworkPageState();
}

class _HomeworkPageState extends State<HomeworkPage> {
  String _selectedLanguage = 'తెలుగు';
  String _selectedFilter = 'All';

  // Colors
  final Color _primaryBlue = const Color(0xFF3B82F6);
  final Color _heroCardBg = const Color(0xFF1D4ED8);
  final Color _scaffoldBg = Colors.white;
  final Color _textPrimary = const Color(0xFF1F2937);
  final Color _textSecondary = const Color(0xFF6B7280);

  // Badge Colors
  final Color _greenBadgeBg = const Color(0xFFECFDF5);
  final Color _greenBadgeText = const Color(0xFF10B981);
  final Color _yellowBadgeBg = const Color(0xFFFFFBEB);
  final Color _yellowBadgeText = const Color(0xFFD97706);
  final Color _redBadgeBg = const Color(0xFFFEF2F2);
  final Color _redBadgeText = const Color(0xFFEF4444);
  final Color _blueBadgeBg = const Color(0xFFEFF6FF);
  final Color _blueBadgeText = const Color(0xFF3B82F6);

  void _toggleLanguage() {
    setState(() {
      _selectedLanguage = _selectedLanguage == 'తెలుగు' ? 'English' : 'తెలుగు';
    });
  }

  void _onBottomNavTap(int index) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, ParentsRoutes.home);
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, ParentsRoutes.reports);
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, ParentsRoutes.busTracking);
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, ParentsRoutes.moreOptions);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            // 1. App Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF5722),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "A",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Aditya International School",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Powered by Toki Tech",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: _toggleLanguage,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Text(
                        _selectedLanguage,
                        style: const TextStyle(
                          color: Color(0xFFFF5722),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 2. Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero Section (Blue)
                    _buildHeroSection(),

                    const SizedBox(height: 20),

                    // Filter Tabs
                    _buildFilterTabs(),

                    const SizedBox(height: 20),

                    // Homework List
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          _buildHomeworkItem(
                            subject: "Mathematics",
                            title: "Exercise 5.2 - Complete all problems",
                            dueDate: "Due Today",
                            status: "Pending",
                            statusColor: _redBadgeText,
                            statusBg: _redBadgeBg,
                          ),
                          _buildHomeworkItem(
                            subject: "Science",
                            title: "Lab Report - Experiment 3",
                            dueDate: "Due Tomorrow",
                            status: "Pending",
                            statusColor: _yellowBadgeText,
                            statusBg: _yellowBadgeBg,
                          ),
                          _buildHomeworkItem(
                            subject: "English",
                            title: "Essay on 'My Favorite Season'",
                            dueDate: "Due Nov 12",
                            status: "Pending",
                            statusColor: _yellowBadgeText,
                            statusBg: _yellowBadgeBg,
                          ),
                          _buildHomeworkItem(
                            subject: "Hindi",
                            title: "Chapter 3 - Question Answers",
                            dueDate: "Completed",
                            status: "Checked",
                            statusColor: _greenBadgeText,
                            statusBg: _greenBadgeBg,
                          ),
                          _buildHomeworkItem(
                            subject: "Social Studies",
                            title: "Map pointing - Indian States",
                            dueDate: "Completed",
                            status: "Checked",
                            statusColor: _greenBadgeText,
                            statusBg: _greenBadgeBg,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: _onBottomNavTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFFF5722),
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: "Reports",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bus_outlined),
            label: "Bus",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: "More",
          ),
        ],
      ),
    );
  }

  // --- Widgets ---

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: _primaryBlue,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back Button + Title
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                "Homework",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Inner Dark Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _heroCardBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pending Today",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "2",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Total Homework: 5",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    final tabs = ["All", "Pending", "Checked"];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: tabs.map((tab) {
          final isSelected = _selectedFilter == tab;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => setState(() => _selectedFilter = tab),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? _primaryBlue : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tab,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHomeworkItem({
    required String subject,
    required String title,
    required String dueDate,
    required String status,
    required Color statusColor,
    required Color statusBg,
  }) {
    return GestureDetector(
      onTap: () {
        // Navigate to homework detail page
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Homework details for $subject')),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subject Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _blueBadgeBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.assignment_outlined,
                color: _blueBadgeText,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Subject and Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        subject,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: _textPrimary,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusBg,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Homework Title
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      color: _textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Due Date
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 12, color: _textSecondary),
                      const SizedBox(width: 4),
                      Text(
                        dueDate,
                        style: TextStyle(
                          fontSize: 11,
                          color: _textSecondary,
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.chevron_right, size: 16, color: Colors.grey),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}