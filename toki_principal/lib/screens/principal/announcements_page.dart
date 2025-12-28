import 'package:flutter/material.dart';
import '../../routes/principal_routes.dart';

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({super.key});

  @override
  State<AnnouncementsPage> createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  int _currentIndex = 3;
  bool _isTelugu = true;
  int _selectedTab = 0;
  final TextEditingController _searchController = TextEditingController();

  // Audience selection state for new announcement
  final List<String> _audienceOptions = ['All', 'Teachers', 'Students', 'Parents'];
  final List<String> _selectedAudience = ['All'];

  final List<Map<String, dynamic>> _announcements = [
    {
      'id': '1',
      'title': 'Winter Vacation Notice',
      'description':
      'School will remain closed for winter break from Dec 25 to Jan 5.',
      'target': 'All',
      'time': '10m ago',
      'isUrgent': true,
      'category': 'Holiday',
      'author': 'Admin Office',
      'date': 'Dec 24, 2025',
    },
    {
      'id': '2',
      'title': 'Teacher Training Workshop',
      'description':
      'A mandatory workshop for all faculty members on new pedagogical tools.',
      'target': 'Teachers',
      'time': '3h ago',
      'isUrgent': false,
      'category': 'Event',
      'author': 'Principal',
      'date': 'Dec 24, 2025',
    },
    {
      'id': '3',
      'title': 'Mid-Term Examination Schedule',
      'description':
      'Mid-term examinations will begin from January 10. Timetable will be shared soon.',
      'target': 'Students',
      'time': '6h ago',
      'isUrgent': false,
      'category': 'Exams',
      'author': 'Examination Cell',
      'date': 'Dec 23, 2025',
    },
    {
      'id': '4',
      'title': 'Cyclone Warning – School Closed',
      'description':
      'Due to cyclone warning issued by authorities, school will remain closed tomorrow.',
      'target': 'All',
      'time': '1d ago',
      'isUrgent': true,
      'category': 'Emergency',
      'author': 'District Administration',
      'date': 'Dec 23, 2025',
    },
    {
      'id': '5',
      'title': 'Parent–Teacher Meeting',
      'description':
      'PTM is scheduled on Dec 28 from 10:00 AM to 1:00 PM. Parents are requested to attend.',
      'target': 'Parents',
      'time': '2d ago',
      'isUrgent': false,
      'category': 'Meeting',
      'author': 'School Office',
      'date': 'Dec 22, 2025',
    },
    {
      'id': '6',
      'title': 'Fee Payment Reminder',
      'description':
      'Last date for paying the current term fees is Dec 30. Please avoid late charges.',
      'target': 'Parents',
      'time': '3d ago',
      'isUrgent': true,
      'category': 'Finance',
      'author': 'Accounts Department',
      'date': 'Dec 21, 2025',
    },
  ];


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

  Widget _buildCleanBottomNav() {
    return Container(
      decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade100, width: 1))),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
        selectedItemColor: const Color(0xFF1D4ED8),
        unselectedItemColor: Colors.grey.shade400,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 0,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded, size: 24), activeIcon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search_rounded, size: 24), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics_rounded, size: 24), label: 'Activity'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded, size: 24), label: 'More'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            _buildSimpleHeader(),
            _buildHorizontalFilter(),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                children: [
                  _buildAdvancedSearch(),
                  const SizedBox(height: 25),
                  const Text("LATEST BROADCASTS",
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Color(0xFF94A3B8), letterSpacing: 2)),
                  const SizedBox(height: 15),
                  ..._announcements.map((a) => _buildModernCard(a)),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateModal,
        backgroundColor: const Color(0xFF1D4ED8),
        icon: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
        label: const Text("Create New", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  PreferredSizeWidget _buildSimpleHeader() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(110),
      child: Container(
        padding: EdgeInsets.fromLTRB(
          20,
          MediaQuery.of(context).padding.top + 0,
          20,
          16,
        ),
        decoration: BoxDecoration(
          color: Colors.white,

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 6), // 👈 bottom-only shadow
            ),
          ],
        ),
        child: Row(
          children: [
            // 🔙 Back Button
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 18,
                  color: Color(0xFF1E293B),
                ),
              ),
            ),

            const SizedBox(width: 16),

            // 📰 Title + Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Announcements',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Powered by Toki Tech',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),

            // 🌐 Language Toggle
            GestureDetector(
              onTap: _toggleLanguage,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF1D4ED8).withOpacity(0.15),
                  ),
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
      ),
    );
  }

  void _toggleLanguage() {
    setState(() {
      _isTelugu = !_isTelugu;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isTelugu ? "తెలుగు భాషలోకి మార్చబడింది" : "Switched to English"),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }


  Widget _buildCustomHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18)),
          const Expanded(child: Text("Announcements", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)))),
          _buildLanguageChip(),
        ],
      ),
    );
  }

  Widget _buildLanguageChip() {
    return InkWell(
      onTap: () => setState(() => _isTelugu = !_isTelugu),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(12)),
        child: Text(_isTelugu ? "తెలుగు" : "English", style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Color(0xFF1D4ED8))),
      ),
    );
  }

  Widget _buildHorizontalFilter() {
    return Container(
      height: 60, // Thodi height badhai hai for breathing space
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1),
        ),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _audienceOptions.length,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        physics: const BouncingScrollPhysics(), // iOS style smooth scroll
        itemBuilder: (context, index) {
          bool sel = _selectedTab == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedTab = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 22),
              decoration: BoxDecoration(
                // Selected: Solid color with Shadow | Unselected: Transparent with subtle border
                color: sel ? const Color(0xFF1D4ED8) : Colors.transparent,
                borderRadius: BorderRadius.circular(30), // Oval/Pill shape
                border: Border.all(
                  color: sel ? Colors.transparent : const Color(0xFFE2E8F0),
                  width: 1.2,
                ),
                boxShadow: sel ? [
                  BoxShadow(
                    color: const Color(0xFF1D4ED8).withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ] : [],
              ),
              child: Center(
                child: Text(
                  _audienceOptions[index],
                  style: TextStyle(
                    color: sel ? Colors.white : const Color(0xFF64748B),
                    fontWeight: sel ? FontWeight.w900 : FontWeight.w700,
                    fontSize: 13,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget _buildAdvancedSearch() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(hintText: "Search updates...", prefixIcon: Icon(Icons.search, size: 20), border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }

  Widget _buildModernCard(Map<String, dynamic> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, left: 6, right: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        // --- MAIN EXTERNAL BORDER ---
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E293B).withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          onTap: () => _showDetailModal(data),
          child: Stack(
            children: [
              // --- LEFT ACCENT BORDER (Visual Hint) ---
              Positioned(
                left: 0, top: 0, bottom: 0,
                child: Container(
                  width: 5,
                  color: const Color(0xFF1D4ED8), // Theme Color
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Modern Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1D4ED8).withOpacity(0.08),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            data['category'].toString().toUpperCase(),
                            style: const TextStyle(
                              color: Color(0xFF1D4ED8),
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const Spacer(),
                        // Time with Icon
                        Row(
                          children: [
                            Icon(Icons.access_time_rounded, size: 12, color: Colors.grey.shade400),
                            const SizedBox(width: 4),
                            Text(
                              data['time'],
                              style: TextStyle(fontSize: 11, color: Colors.grey.shade500, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Title
                    Text(
                      data['title'],
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0F172A),
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Description
                    Text(
                      data['description'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Footer: "Read More" Hint
                    Row(
                      children: [
                        const Text(
                          "Tap to view details",
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF1D4ED8)),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.arrow_forward_ios_rounded, size: 10, color: const Color(0xFF1D4ED8).withOpacity(0.7)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _miniBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
      child: Text(label.toUpperCase(), style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.w900)),
    );
  }

  // --- MODALS WITH AUDIENCE SELECT ---

  void _showDetailModal(Map<String, dynamic> a) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.55,
        minChildSize: 0.4,
        maxChildSize: 0.9, // Thoda extra space scroll ke liye
        builder: (_, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2),
            ],
          ),
          // MediaQuery ka use karke bottom safe area padding di hai
          padding: EdgeInsets.fromLTRB(24, 12, 24, MediaQuery.of(context).padding.bottom + 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // --- MODERN DRAG HANDLE ---
              Container(
                width: 45,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 24),

              // --- SCROLLABLE CONTENT ---
              Expanded(
                child: ListView( // SingleChildScrollView se behtar hai listview draggable ke sath
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    // Icon + Category Tag
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1D4ED8).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.campaign_rounded, size: 20, color: Color(0xFF1D4ED8)),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          "ANNOUNCEMENT",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF64748B),
                            letterSpacing: 1.1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Title
                    Text(
                      a['title'],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0F172A),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Description Box
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFF1F5F9)),
                      ),
                      child: Text(
                        a['description'],
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF334155),
                          height: 1.6,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Audience Info Tile
                    _buildInfoTile("Target Audience", a['target'], Icons.groups_rounded),
                    const SizedBox(height: 20),
                  ],
                ),
              ),

              // --- ACTION BUTTON (Fixed at Bottom) ---
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D4ED8),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    "Understood, Acknowledge",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Helper: Safed aur clean info tile
  Widget _buildInfoTile(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF64748B)),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF64748B)),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Color(0xFF1D4ED8)),
          ),
        ],
      ),
    );
  }
  void _showCreateModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          // Height handling for keyboard
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Column(
            children: [
              // --- TOP HEADER AREA ---
              const SizedBox(height: 12),
              Container(
                width: 45,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "New Broadcast",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Send an announcement to your school",
                style: TextStyle(color: Colors.grey.shade500, fontSize: 13, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),

              // --- SCROLLABLE FORM ---
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildModernInput("Broadcast Title", "e.g. Annual Sports Meet", Icons.title_rounded),
                      const SizedBox(height: 20),

                      _buildModernInput("Message Description", "Write your announcement here...", Icons.short_text_rounded, maxLines: 5),
                      const SizedBox(height: 24),

                      // Section Title
                      const Row(
                        children: [
                          Icon(Icons.person_search_rounded, size: 18, color: Color(0xFF1D4ED8)),
                          const SizedBox(width: 8),
                          Text(
                            "Target Audience",
                            style: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF1E293B), fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Choice Chips with Premium Style
                      Wrap(
                        spacing: 8,
                        runSpacing: 10,
                        children: _audienceOptions.map((option) {
                          final isSelected = _selectedAudience.contains(option);
                          return ChoiceChip(
                            label: Text(option),
                            selected: isSelected,
                            onSelected: (selected) {
                              setModalState(() {
                                selected ? _selectedAudience.add(option) : _selectedAudience.remove(option);
                              });
                            },
                            selectedColor: const Color(0xFF1D4ED8),
                            backgroundColor: const Color(0xFFF1F5F9),
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : const Color(0xFF64748B),
                              fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
                              fontSize: 12,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide.none),
                            showCheckmark: false,
                          );
                        }).toList(),
                      ),

                      // Keyboard space buffer
                      SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 20),
                    ],
                  ),
                ),
              ),

              // --- BOTTOM ACTION AREA (SAFE AREA MAINTAINED) ---
              Container(
                padding: EdgeInsets.fromLTRB(24, 16, 24, MediaQuery.of(context).padding.bottom + 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, -5))
                  ],
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1D4ED8),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    ),
                    child: const Text(
                      "Publish Broadcast",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white),
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

// Helper: Modern Input Field
  Widget _buildModernInput(String label, String hint, IconData icon, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF475569))),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 20, color: const Color(0xFF1D4ED8).withOpacity(0.5)),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFF1D4ED8), width: 1.5)),
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _inputField(String label, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.blueGrey),
        filled: true, fillColor: const Color(0xFFF8FAFC),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildElevatedButton(String text, VoidCallback onTap) {
    return Container(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1D4ED8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          elevation: 0,
        ),
        child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16)),
      ),
    );
  }

  Widget _rowInfo(String l, String v) => Padding(padding: const EdgeInsets.only(bottom: 10), child: Row(children: [Text("$l: ", style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w900, fontSize: 10)), Text(v, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))]));

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xFFF1F5F9), width: 2))),
      child: BottomNavigationBar(
        currentIndex: _currentIndex, onTap: _onBottomNavTap,
        type: BottomNavigationBarType.fixed, backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF1D4ED8), unselectedItemColor: const Color(0xFF94A3B8),
        elevation: 0, items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded, size: 24), activeIcon: Icon(Icons.home_filled), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search_rounded, size: 24), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.analytics_rounded, size: 24), label: 'Activity'),
        BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded, size: 24), label: 'More'),
      ],
      ),
    );
  }
}