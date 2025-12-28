// lib/screens/driver/tickets_page.dart
import 'package:flutter/material.dart';
import '../../routes/driver_routes.dart';
import '../../widgets/driver_widgets.dart';

class TicketsPage extends StatefulWidget {
  const TicketsPage({Key? key}) : super(key: key);

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class TicketDummy {
  final String id;
  final String title;
  final String date;
  final String status;
  final String priority;
  final String desc;

  TicketDummy({
    required this.id,
    required this.title,
    required this.date,
    required this.status,
    required this.priority,
    required this.desc,
  });
}

final List<TicketDummy> _allTickets = [
  TicketDummy(
    id: 'TKT-001',
    title: 'Bus Maintenance',
    date: 'Oct 30, 2024',
    status: 'Pending',
    priority: 'High',
    desc: 'Engine overheating issue.',
  ),
  TicketDummy(
    id: 'TKT-002',
    title: 'Route Change',
    date: 'Oct 28, 2024',
    status: 'In Progress',
    priority: 'Medium',
    desc: 'Request to add Jubilee Hills stop.',
  ),
  TicketDummy(
    id: 'TKT-003',
    title: 'AC Repair',
    date: 'Oct 25, 2024',
    status: 'Resolved',
    priority: 'High',
    desc: 'AC cooling was very low.',
  ),
];


class _TicketsPageState extends State<TicketsPage> {

  List<TicketDummy> get _filteredTickets {
    if (_filterType == 'All') return _allTickets;

    return _allTickets
        .where((t) => t.status == _filterType)
        .toList();
  }

  int _currentIndex = 2;
  String _filterType = 'All';
  bool _isTelugu = true;

  // --- ORIGINAL NAVIGATION LOGIC ---
  void _navigateToPage(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
    switch (index) {
      case 0: Navigator.pushNamedAndRemoveUntil(context, DriverRoutes.home, (route) => false); break;
      case 1: Navigator.pushNamed(context, DriverRoutes.tripHistory); break;
      case 3: Navigator.pushNamed(context, DriverRoutes.profile); break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double px = MediaQuery.of(context).size.width > 600 ? 40.0 : 18.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            /// ✅ SAME HEADER AS HOME DRIVER
            DriverWidgets.appHeader(
              schoolName: 'Aditya International School',
              schoolInitial: 'A',
              selectedLanguage: _isTelugu ? 'తెలుగు' : 'English',
              onLanguageToggle: () =>
                  setState(() => _isTelugu = !_isTelugu),
            ),

            /// ✨ Body
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async =>
                await Future.delayed(const Duration(seconds: 1)),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: px),
                  children: [
                    const SizedBox(height: 20),

                    _buildStatsBanner(),

                    const SizedBox(height: 25),
                    _buildSectionTitle("FILTER STATUS"),
                    const SizedBox(height: 12),
                    _buildFilterChips(),

                    const SizedBox(height: 25),
                    _buildSectionTitle("MY TICKETS"),
                    const SizedBox(height: 12),

                    /// 🎫 Ticket Cards (FILTERED)
                    ..._filteredTickets.map(
                          (t) => _buildTicketCard(
                        t.id,
                        t.title,
                        t.date,
                        t.status,
                        t.priority,
                        t.desc,
                      ),
                    ),

                    const SizedBox(height: 20), // FAB safe space
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      /// ➕ New Ticket FAB
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _createNewTicket(context),
        backgroundColor: const Color(0xFFE65100),
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text(
          "NEW TICKET",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),

      /// 🔽 Bottom Navigation
      bottomNavigationBar: _buildModernNav(),
    );
  }

  // --- ✨ UI BUILDERS ---

  Widget _buildCustomAppBar(double px) => Container(
    padding: EdgeInsets.symmetric(horizontal: px, vertical: 15),
    color: Colors.white,
    child: Row(children: [
      IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20)),
      const Expanded(child: Text('My Tickets', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900))),
      Text(_isTelugu ? "తెలుగు" : "English", style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFFE65100))),
    ]),
  );

  Widget _buildStatsBanner() => Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(colors: [Color(0xFFE65100), Color(0xFFFB8C00)]),
      borderRadius: BorderRadius.circular(24),
      boxShadow: [BoxShadow(color: Colors.orange.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))],
    ),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      _statItem('Total', '12', Icons.receipt_long),
      _statItem('Pending', '3', Icons.pending_actions),
      _statItem('Active', '1', Icons.bolt),
    ]),
  );

  Widget _buildFilterChips() => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: ['All', 'Pending', 'Resolved', 'Closed']
          .map(
            (t) => Padding(
          padding: const EdgeInsets.only(right: 10),
          child: ChoiceChip(
            label: Text(t),
            selected: _filterType == t,
            onSelected: (_) => setState(() => _filterType = t),

            /// 🎨 Background
            selectedColor: const Color(0xFF1E293B),
            backgroundColor: const Color(0xFFF8FAFC),

            /// ✅ DEFAULT TICK → WHITE
            checkmarkColor: Colors.white,

            /// 🧱 Border
            side: BorderSide(
              color: _filterType == t
                  ? const Color(0xFF1E293B)
                  : const Color(0xFFE5E7EB),
            ),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),

            labelStyle: TextStyle(
              color: _filterType == t
                  ? Colors.white
                  : const Color(0xFF1E293B),
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),

            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
          ),
        ),
      )
          .toList(),
    ),
  );

  Widget _statItem(String label, String value, IconData icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Colors.white70,
          size: 20,
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildTicketCard(
      String id,
      String title,
      String date,
      String status,
      String priority,
      String desc,
      ) {
    return InkWell(
      onTap: () => _showTicketDetails(context, id, title, desc),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔹 Top Row (ID + Status)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  id,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF64748B),
                  ),
                ),
                _statusBadge(status),
              ],
            ),

            const SizedBox(height: 10),

            /// 🔹 Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 12),

            /// 🔹 Bottom Row (Date + Priority)
            Row(
              children: [
                const Icon(
                  Icons.calendar_month_rounded,
                  size: 14,
                  color: Color(0xFF94A3B8),
                ),
                const SizedBox(width: 6),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF475569),
                  ),
                ),
                const Spacer(),
                _priorityChip(priority),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _statusBadge(String status) {
    final Color color = status == 'Resolved'
        ? const Color(0xFF16A34A)
        : status == 'Pending'
        ? const Color(0xFFF59E0B)
        : const Color(0xFF2563EB);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
  Widget _priorityChip(String priority) {
    final Color color =
    priority == 'High' ? Colors.red : Colors.orange;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Text(
        priority,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }

  Widget _badge(String t) => Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Text(t, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 10)));

  // --- ✨ FIXED: TICKET DETAILS (SAFE AREA & NO OVERFLOW) ---

  void _showTicketDetails(
      BuildContext context,
      String id,
      String title,
      String description,
      ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.50,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🌿 Drag Handle
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.green.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                /// 🌿 Header
                Row(
                  children: const [
                    Icon(Icons.confirmation_number_rounded,
                        color: Color(0xFF16A34A)),
                    SizedBox(width: 8),
                    Text(
                      'Ticket Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF14532D),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                /// 🌿 Info Rows
                _detailRow('ID', id),
                _detailRow('Status', 'Pending'),
                _detailRow('Priority', 'High'),

                const SizedBox(height: 10),
                Divider(color: Colors.green.shade100),
                const SizedBox(height: 8),

                /// 🌿 Description Title
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF166534),
                  ),
                ),

                const SizedBox(height: 6),

                /// 🌿 Description Body
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Text(
                      description +
                          "\n\nOriginal issue description will appear here for the driver to review properly.",
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF475569),
                        height: 1.45,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                /// 🌿 Close Button (Green)
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF16A34A),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'CLOSE',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- ✨ 100% ORIGINAL LOGIC FOR CREATE TICKET ---
  void _createNewTicket(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24), // ✅ WIDTH INCREASE
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26),
        ),
        backgroundColor: Colors.white, // 🌿 light green bg
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🌿 Header
                Row(
                  children: const [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Color(0xFFDCFCE7),
                      child: Icon(
                        Icons.support_agent_rounded,
                        color: Color(0xFF15803D),
                        size: 22,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'New Support Ticket',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF14532D),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),
                const Text(
                  'Raise an issue and our team will assist you',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF166534),
                  ),
                ),

                const SizedBox(height: 20),

                /// 📝 Issue Title
                _modernInput(
                  label: 'Issue Title',
                  icon: Icons.title_rounded,
                ),

                const SizedBox(height: 14),

                /// 📂 Category
                DropdownButtonFormField<String>(
                  decoration: _modernDecoration(
                    label: 'Category',
                    icon: Icons.category_outlined,
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  items: const [
                    DropdownMenuItem(value: 'maint', child: Text('Maintenance')),
                    DropdownMenuItem(value: 'route', child: Text('Route Change')),
                    DropdownMenuItem(value: 'student', child: Text('Student Issue')),
                  ],
                  onChanged: (v) {},
                ),

                const SizedBox(height: 14),

                /// 🧾 Description
                _modernInput(
                  label: 'Description',
                  icon: Icons.description_outlined,
                  maxLines: 4,
                ),

                const SizedBox(height: 22),

                /// 🔘 Buttons
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF166534),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF16A34A),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _modernInput({
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextField(
      maxLines: maxLines,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      decoration: _modernDecoration(
        label: label,
        icon: icon,
      ),
    );
  }

  InputDecoration _modernDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        color: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      floatingLabelStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      prefixIcon: Icon(icon, color: Colors.black, size: 20),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE65100), width: 1.5),
      ),
    );
  }

  Widget _detailRow(String l, String v) => Padding(padding: const EdgeInsets.only(bottom: 12), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(l, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)), Text(v, style: const TextStyle(fontWeight: FontWeight.bold))]));

  Widget _buildSectionTitle(String t) => Text(t, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Color(0xFF94A3B8), letterSpacing: 1.2));

  Widget _buildModernNav() => BottomNavigationBar(
    backgroundColor: Colors.white,
    currentIndex: _currentIndex, onTap: _navigateToPage, type: BottomNavigationBarType.fixed, selectedItemColor: const Color(0xFFE65100), elevation: 0,
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.alt_route_rounded), label: 'Trip'),
      BottomNavigationBarItem(icon: Icon(Icons.confirmation_number), label: 'Tickets'),
      BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
    ],
  );
}