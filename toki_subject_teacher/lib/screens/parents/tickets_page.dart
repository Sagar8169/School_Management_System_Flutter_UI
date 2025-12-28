import 'package:flutter/material.dart';

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
      "desc": "My daughter will be on leave from Nov 12-14 due to family function. Please appro...",
      "date": "Nov 8, 2025"
    },
    {
      "id": "T002",
      "category": "Transport",
      "status": "Resolved",
      "title": "Bus Timing Issue",
      "desc": "Bus is consistently late by 15-20 minutes for pickup. Can this be looked into?...",
      "date": "Nov 5, 2025"
    },
    {
      "id": "T003",
      "category": "Academic",
      "status": "Resolved",
      "title": "Homework Doubts",
      "desc": "Need clarification on Mathematics homework Exercise 5.2, Question 7....",
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
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        padding: EdgeInsets.fromLTRB(24, 12, 24, MediaQuery.of(context).padding.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40, height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const Text("Ticket Actions", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
            const SizedBox(height: 20),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), shape: BoxShape.circle),
                child: const Icon(Icons.edit_rounded, color: Colors.blue, size: 20),
              ),
              title: const Text("Edit Ticket", style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), shape: BoxShape.circle),
                child: const Icon(Icons.delete_outline_rounded, color: Colors.red, size: 20),
              ),
              title: const Text("Delete Ticket", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ RAISE TICKET PAGE: HEADER COMPLETELY REPLACED
  void _navigateToRaiseTicket() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 1. REPLACED HEADER (No School Name, No Language Switcher)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: const Color(0xFFF1F5F9), shape: BoxShape.circle),
                      child: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: Color(0xFF1E293B)),
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Text(
                      "Raise New Ticket",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: -0.5)
                  ),
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
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 10))],
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
                      _buildSimpleInput("Describe your concern in detail...", maxLines: 5),
                      const SizedBox(height: 20),
                      _buildFormLabel("Voice Note (Optional)"),

                      // Voice Recording UI
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              backgroundColor: Color(0xFFEFF6FF),
                              child: Icon(Icons.mic_none_rounded, color: Colors.blue, size: 30),
                            ),
                            const SizedBox(height: 10),
                            const Text("Tap to Record", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("You can add a voice message", style: TextStyle(color: _textSecondary, fontSize: 12)),
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text("SUBMIT TICKET", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16, letterSpacing: 1)),
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
                      ...filteredTickets.map((t) => _buildTicketCard(t)).toList(),
                      const SizedBox(height: 100),
                    ],
                  ),
                  Positioned(
                    bottom: 20, left: 20, right: 20,
                    child: SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _navigateToRaiseTicket,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryBlue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 8,
                          shadowColor: _primaryBlue.withOpacity(0.4),
                        ),
                        child: const Text("+ Raise New Ticket", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // --- UI BLOCKS ---

  Widget _buildAppHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          Container(width: 38, height: 38, decoration: BoxDecoration(color: const Color(0xFFFF5722), borderRadius: BorderRadius.circular(8)), alignment: Alignment.center, child: const Text("A", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18))),
          const SizedBox(width: 12),
          const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Aditya International", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), Text("Helpdesk Portal", style: TextStyle(color: Colors.grey, fontSize: 11))])),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Text(_selectedLanguage, style: const TextStyle(color: Color(0xFFFF5722), fontWeight: FontWeight.w600, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsHeader(double screenWidth) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 35),
      decoration: BoxDecoration(color: _headerGreen, borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(35), bottomRight: Radius.circular(35))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            GestureDetector(onTap: () => Navigator.pop(context), child: const CircleAvatar(backgroundColor: Colors.white24, radius: 18, child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 14))),
            const SizedBox(width: 12),
            const Text("My Tickets", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          ]),
          const SizedBox(height: 25),
          Row(children: [_statBox("1", "Active"), const SizedBox(width: 12), _statBox("2", "Resolved"), const SizedBox(width: 12), _statBox("3", "Total")])
        ],
      ),
    );
  }

  Widget _statBox(String val, String label) => Expanded(child: Container(padding: const EdgeInsets.symmetric(vertical: 18), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)), child: Column(children: [Text(val, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11))])));

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
              decoration: BoxDecoration(color: isSelected ? _headerGreen : Colors.white, borderRadius: BorderRadius.circular(25), border: Border.all(color: isSelected ? Colors.transparent : _borderGrey)),
              child: Text(tabs[index], style: TextStyle(color: isSelected ? Colors.white : _textPrimary, fontSize: 13, fontWeight: FontWeight.w600)),
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
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: _borderGrey), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 15, offset: const Offset(0, 5))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _badge(t['category'], _primaryBlue),
              const SizedBox(width: 8),
              _badge(t['status'], t['status'] == 'Resolved' ? Colors.green : Colors.orange),
              const Spacer(),
              GestureDetector(
                onTap: () => _showTicketOptions(t),
                child: Icon(Icons.more_vert_rounded, color: _textSecondary, size: 22),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(t['title'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
          const SizedBox(height: 6),
          Text(t['desc'], style: TextStyle(color: _textSecondary, fontSize: 13, height: 1.4)),
          const SizedBox(height: 15),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Ticket #${t['id']}", style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)), Text(t['date'], style: const TextStyle(color: Colors.grey, fontSize: 12))]),
        ],
      ),
    );
  }

  Widget _badge(String txt, Color color) => Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Text(txt, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)));

  // --- HELPERS FOR FORM ---

  Widget _buildFormLabel(String label) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
  );

  Widget _buildSimpleInput(String hint, {int maxLines = 1}) => TextField(
    maxLines: maxLines,
    decoration: InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.all(15),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
    ),
  );

  Widget _buildBottomNav() => BottomNavigationBar(currentIndex: 2, type: BottomNavigationBarType.fixed, selectedItemColor: const Color(0xFFFF5722), items: const [BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"), BottomNavigationBarItem(icon: Icon(Icons.directions_bus_outlined), label: "Bus"), BottomNavigationBarItem(icon: Icon(Icons.confirmation_number_rounded), label: "Tickets"), BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "More")]);
}