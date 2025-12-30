import 'package:flutter/material.dart';
import 'package:toki/routes/parents_routes.dart';

final Color _accentOrange = const Color(0xFFFF5722);
final Color _primaryOrange = const Color(0xFFFF5722);

class TicketsPage extends StatefulWidget {
  const TicketsPage({Key? key}) : super(key: key);

  @override
  _TicketsPageState createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  String _selectedLanguage = 'తెలుగు';
  String _selectedFilter = 'All';

  final Color _headerGreen = const Color(0xFF34D399);
  final Color _primaryBlue = const Color(0xFF2563EB);
  final Color _scaffoldBg = const Color(0xFFF8FAFC);
  final Color _textPrimary = const Color(0xFF1E293B);
  final Color _textSecondary = const Color(0xFF64748B);
  final Color _borderGrey = const Color(0xFFE2E8F0);

  final List<Map<String, dynamic>> _tickets = [
    {
      "id": "T001",
      "category": "Leave Request",
      "status": "In Progress",
      "title": "Request for Leave",
      "desc":
          "My daughter will be on leave from Nov 12-14 due to family function. Please appro...",
      "date": "Nov 8, 2025"
    },
    {
      "id": "T002",
      "category": "Transport",
      "status": "Resolved",
      "title": "Bus Timing Issue",
      "desc":
          "Bus is consistently late by 15-20 minutes for pickup. Can this be looked into?...",
      "date": "Nov 5, 2025"
    },
    {
      "id": "T003",
      "category": "Academic",
      "status": "Resolved",
      "title": "Homework Doubts",
      "desc":
          "Need clarification on Mathematics homework Exercise 5.2, Question 7....",
      "date": "Nov 3, 2025"
    },
  ];

  void _showTicketOptions(Map<String, dynamic> ticket) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF8F9FB), // Subtle contrast background
          borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
        ),
        padding: EdgeInsets.fromLTRB(
            20, 12, 20, MediaQuery.of(context).padding.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 1. Top Handle
            Center(
              child: Container(
                width: 45,
                height: 5,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),

            /// 2. Ticket Preview (Contextual Card)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade100),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF8B5CF6).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.confirmation_num_rounded,
                        color: Color(0xFF8B5CF6), size: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ticket['id'] ?? "#TK-8821",
                          style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5),
                        ),
                        Text(
                          ticket['subject'] ?? "Fee Payment Issue",
                          style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: Color(0xFF1E293B)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  _buildStatusChip("Active", Colors.orange),
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.only(left: 8, bottom: 12),
              child: Text("AVAILABLE ACTIONS",
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF64748B),
                      letterSpacing: 1.2)),
            ),

            /// 3. Action Grid
            Row(
              children: [
                _buildActionBox(
                  icon: Icons.edit_note_rounded,
                  label: "Edit Ticket",
                  color: Colors.blue,
                  onTap: () => Navigator.pop(context),
                ),
                const SizedBox(width: 12),
                _buildActionBox(
                  icon: Icons.chat_bubble_outline_rounded,
                  label: "Add Comment",
                  color: const Color(0xFF10B981),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildActionBox(
              icon: Icons.delete_outline_rounded,
              label: "Delete Ticket Permanently",
              color: Colors.red,
              isFullWidth: true,
              onTap: () => Navigator.pop(context),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageToggle() {
    return GestureDetector(
      onTap: _toggleLanguage,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade200)),
        child: Row(
          children: [
            Icon(Icons.translate, size: 14, color: _primaryOrange),
            const SizedBox(width: 4),
            Text(_selectedLanguage,
                style: TextStyle(
                    color: _primaryOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 12)),
          ],
        ),
      ),
    );
  }

  void _toggleLanguage() {
    setState(() {
      _selectedLanguage = _selectedLanguage == 'తెలుగు' ? 'English' : 'తెలుగు';
    });
  }

  /// Helper: Action Box Widget
  Widget _buildActionBox({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    bool isFullWidth = false,
  }) {
    return Expanded(
      flex: isFullWidth ? 0 : 1,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: isFullWidth ? double.infinity : null,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withOpacity(0.1)),
          ),
          child: Row(
            mainAxisAlignment: isFullWidth
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: color.withOpacity(0.1), shape: BoxShape.circle),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 14),
              Text(
                label,
                style: TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 14, color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w800,
          fontSize: 11,
        ),
      ),
    );
  }

  void _navigateToMoreOptions() =>
      Navigator.pushNamed(context, ParentsRoutes.moreOptions);

  // ✅ RAISE TICKET PAGE: HEADER COMPLETELY REPLACED
  void _navigateToRaiseTicket() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Column(
                  children: [
                    // 1. REPLACED HEADER (No School Name, No Language Switcher)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 15),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF1F5F9),
                                  shape: BoxShape.circle),
                              child: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  size: 18,
                                  color: Color(0xFF1E293B)),
                            ),
                          ),
                          const SizedBox(width: 15),
                          const Text("Raise New Ticket",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -0.5)),
                        ],
                      ),
                    ),
                    const Divider(height: 1),

                    // 2. FORM CONTENT
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: _borderGrey),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10))
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFormLabel("Category"),
                              _buildSimpleInput("Select Category"),
                              const SizedBox(height: 20),
                              _buildFormLabel("Subject"),
                              _buildSimpleInput("Brief title of your concern"),
                              const SizedBox(height: 20),
                              _buildFormLabel("Description"),
                              _buildSimpleInput(
                                  "Describe your concern in detail...",
                                  maxLines: 5),
                              const SizedBox(height: 20),
                              _buildFormLabel("Voice Note (Optional)"),

                              // Voice Recording UI
                              Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 30),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  children: [
                                    const CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Color(0xFFEFF6FF),
                                      child: Icon(Icons.mic_none_rounded,
                                          color: Colors.blue, size: 30),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text("Tap to Record",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text("You can add a voice message",
                                        style: TextStyle(
                                            color: _textSecondary,
                                            fontSize: 12)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // 3. SUBMIT BUTTON
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _primaryBlue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                          ),
                          child: const Text("SUBMIT TICKET",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                  letterSpacing: 1)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final filteredTickets = _selectedFilter == 'All'
        ? _tickets
        : _tickets.where((t) => t['status'] == _selectedFilter).toList();

    return Scaffold(
      backgroundColor: _scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppHeader(),
            Expanded(
              child: Stack(
                children: [
                  ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      _buildStatsHeader(screenWidth),
                      const SizedBox(height: 20),
                      _buildFilterTabs(),
                      const SizedBox(height: 10),
                      ...filteredTickets
                          .map((t) => _buildTicketCard(t))
                          .toList(),
                      const SizedBox(height: 100),
                    ],
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _navigateToRaiseTicket,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryBlue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          elevation: 8,
                          shadowColor: _primaryBlue.withOpacity(0.4),
                        ),
                        child: const Text("+ Raise New Ticket",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- UI BLOCKS ---

  Widget _buildAppHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border:
            Border(bottom: BorderSide(color: Colors.grey.shade100, width: 1)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [_primaryOrange, _primaryOrange.withOpacity(0.8)]),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                    color: _primaryOrange.withOpacity(0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 6))
              ],
            ),
            alignment: Alignment.center,
            child: const Text("A",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 22)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Aditya International",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                        letterSpacing: -0.6,
                        color: Color(0xFF1A1A1A))),
                Row(
                  children: [
                    Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                            color: Color(0xFF10B981), shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    Text("Support Portal Active",
                        style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 11,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
          _buildLanguageToggle(),
        ],
      ),
    );
  }

  Widget _buildStatsHeader(double screenWidth) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _headerGreen,
            _headerGreen.withBlue(60).withGreen(180), // Dynamic Gradient
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: _headerGreen.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 1. Top Navigation Row
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white24),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.white, size: 16),
                ),
              ),
              const SizedBox(width: 16),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Support Portal",
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1),
                  ),
                  Text(
                    "My Tickets",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5),
                  ),
                ],
              ),
              const Spacer(),
              // Optional: Header Icon
              Icon(Icons.confirmation_number_outlined,
                  color: Colors.white.withOpacity(0.2), size: 40),
            ],
          ),

          const SizedBox(height: 35),

          /// 2. Stats Grid
          Row(
            children: [
              _statBox("01", "Active", Icons.pending_actions_rounded),
              const SizedBox(width: 12),
              _statBox("02", "Resolved", Icons.check_circle_outline_rounded),
              const SizedBox(width: 12),
              _statBox("03", "Total", Icons.assessment_outlined),
            ],
          )
        ],
      ),
    );
  }

  /// Helper: Upgraded Premium Stat Box
  Widget _statBox(String value, String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white70, size: 18),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label.toUpperCase(),
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 9,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    final tabs = ["All", "Open", "In Progress", "Resolved"];
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          bool isSelected = _selectedFilter == tabs[index];
          return GestureDetector(
            onTap: () => setState(() => _selectedFilter = tabs[index]),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: isSelected ? _headerGreen : Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                      color: isSelected ? Colors.transparent : _borderGrey)),
              child: Text(tabs[index],
                  style: TextStyle(
                      color: isSelected ? Colors.white : _textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTicketCard(Map<String, dynamic> t) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: _borderGrey),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 15,
                offset: const Offset(0, 5))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _badge(t['category'], _primaryBlue),
              const SizedBox(width: 8),
              _badge(t['status'],
                  t['status'] == 'Resolved' ? Colors.green : Colors.orange),
              const Spacer(),
              GestureDetector(
                onTap: () => _showTicketOptions(t),
                child: Icon(Icons.more_vert_rounded,
                    color: _textSecondary, size: 22),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(t['title'],
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E293B))),
          const SizedBox(height: 6),
          Text(t['desc'],
              style:
                  TextStyle(color: _textSecondary, fontSize: 13, height: 1.4)),
          const SizedBox(height: 15),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Ticket #${t['id']}",
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
            Text(t['date'],
                style: const TextStyle(color: Colors.grey, fontSize: 12))
          ]),
        ],
      ),
    );
  }

  Widget _badge(String txt, Color color) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8)),
      child: Text(txt,
          style: TextStyle(
              color: color, fontSize: 10, fontWeight: FontWeight.bold)));

  // --- HELPERS FOR FORM ---

  Widget _buildFormLabel(String label) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      );

  Widget _buildSimpleInput(String hint, {int maxLines = 1}) => TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200)),
        ),
      );
}
