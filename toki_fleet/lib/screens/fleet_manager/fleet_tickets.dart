import 'package:flutter/material.dart';
import '../../routes/fleet_manager_routes.dart';
import 'fleet_ticket_data.dart';

class FleetTickets extends StatefulWidget {
  const FleetTickets({Key? key}) : super(key: key);

  @override
  State<FleetTickets> createState() => _FleetTicketsState();
}

class _FleetTicketsState extends State<FleetTickets> {
  static const Color primaryTeal = Color(0xFF0D9488);
  static const Color scaffoldBg = Color(0xFFF8FAFC);
  static const Color redHeader = Color(0xFFE11D48);

  String _selectedFilter = 'All';
  int _bottomIndex = 2;

  void _onBottomTap(int index) {
    if (index == _bottomIndex) return;
    setState(() => _bottomIndex = index);
    switch (index) {
      case 0:
        Navigator.pushNamed(context, FleetManagerRoutes.dashboard);
        break;
      case 1:
        Navigator.pushNamed(context, FleetManagerRoutes.search);
        break;
      case 3:
        Navigator.pushNamed(context, FleetManagerRoutes.moreOptions);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Screen width for responsiveness
    final double screenWidth = MediaQuery.of(context).size.width;

    final tickets = FleetTicketData.tickets.where((t) {
      if (_selectedFilter == 'All') return true;
      return t.status.toLowerCase() == _selectedFilter.toLowerCase();
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      // Wrap with SafeArea to avoid notch issues
      body: SafeArea(
        child: Column(
          children: [
            _buildWhiteTopBar(),
            // Use CustomScrollView for better control over overlapping headers
            Expanded(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(child: _buildCurvySummaryHeader()),
                  // Responsive spacing based on card height
                  const SliverToBoxAdapter(child: SizedBox(height: 70)),
                  SliverToBoxAdapter(child: _buildHorizontalFilters()),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) =>
                            _buildModernTicketCard(tickets[index]),
                        childCount: tickets.length,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildWhiteTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: primaryTeal.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(Icons.school_rounded, color: primaryTeal, size: 22),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Aditya International',
                    style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                Text('Fleet Management System',
                    style: TextStyle(color: Colors.grey, fontSize: 10)),
              ],
            ),
          ),
          Text("తెలుగు",
              style: TextStyle(
                  color: primaryTeal,
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildTopGlobalHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: primaryTeal, borderRadius: BorderRadius.circular(10)),
            child:
                const Icon(Icons.school_rounded, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Aditya International',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                    overflow: TextOverflow.ellipsis),
                Text('Fleet Management System',
                    style: TextStyle(color: Colors.grey, fontSize: 10)),
              ],
            ),
          ),
          // Language Button - Responsive size
          SizedBox(
            height: 32,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  backgroundColor: primaryTeal.withOpacity(0.1),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  shape: const StadiumBorder()),
              child: const Text('తెలుగు',
                  style: TextStyle(
                      color: primaryTeal,
                      fontWeight: FontWeight.bold,
                      fontSize: 11)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurvySummaryHeader() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          height: 110,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0F766E), // dark teal
                Color(0xFF14B8A6), // light teal
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(32),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: const Text(
            'TICKET ANALYTICS',
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w800,
              fontSize: 12,
              letterSpacing: 1.6,
            ),
          ),
        ),

        // --- FLOATING STATS CARD ---
        Positioned(
          top: 55,
          left: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildModernStat(
                  Icons.new_releases_rounded,
                  '12',
                  'Open',
                  Colors.orange,
                ),
                _buildVerticalDivider(),
                _buildModernStat(
                  Icons.pending_actions_rounded,
                  '05',
                  'Pending',
                  Colors.blue,
                ),
                _buildVerticalDivider(),
                _buildModernStat(
                  Icons.task_alt_rounded,
                  '84',
                  'Solved',
                  Colors.green,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModernStat(
      IconData icon, String count, String label, Color color) {
    return Flexible(
      // Make stats flexible for smaller screens
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 6),
          Text(count,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(label,
              style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 10,
                  fontWeight: FontWeight.w600),
              maxLines: 1),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(height: 30, width: 1, color: Colors.grey.shade200);
  }

  Widget _buildHorizontalFilters() {
    final filters = ['All', 'Open', 'In Progress', 'Resolved'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: filters.map((f) {
          bool isSelected = _selectedFilter == f;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(f),
              checkmarkColor: Colors.white,
              selected: isSelected,
              onSelected: (val) => setState(() => _selectedFilter = f),
              selectedColor: redHeader,
              labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontSize: 12),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          );
        }).toList(),
      ),
    );
  }

  // --- 4. Ticket Card ---
  Widget _buildModernTicketCard(FleetTicket ticket) {
    Color statusColor = ticket.status.toLowerCase() == 'open'
        ? Colors.orange
        : (ticket.status.toLowerCase() == 'resolved'
            ? Colors.green
            : Colors.blue);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        // ✅ SLIGHT BLACK BORDER ADDED
        border: Border.all(
          color: Colors.black.withOpacity(0.08),
          width: 1,
        ),
        // ✅ SOFT SHADOW TO MAINTAIN DEPTH
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(
            context, FleetManagerRoutes.ticketDetail,
            arguments: {'ticketId': ticket.id}),
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _statusBadge(ticket.status, statusColor),
                      Text('#${ticket.id}',
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(ticket.title,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B))),
                  const SizedBox(height: 6),
                  Text(ticket.description,
                      maxLines: 2,
                      style: const TextStyle(
                          color: Colors.blueGrey, fontSize: 12, height: 1.3)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    children: [
                      _iconLabel(Icons.directions_bus_filled_rounded,
                          ticket.busNumber),
                      _iconLabel(Icons.map_rounded, ticket.routeName),
                    ],
                  ),
                ],
              ),
            ),
            // ✅ FOOTER WITH LIGHT BORDER TOP
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                border: Border(
                    top: BorderSide(color: Colors.black.withOpacity(0.05))),
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.access_time_rounded,
                      size: 14, color: Colors.grey),
                  const SizedBox(width: 6),
                  Text(ticket.footerDate,
                      style: const TextStyle(fontSize: 10, color: Colors.grey)),
                  const Spacer(),
                  const Text('Details',
                      style: TextStyle(
                          color: primaryTeal,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                  const Icon(Icons.arrow_forward_ios_rounded,
                      size: 10, color: primaryTeal),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconLabel(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: primaryTeal),
        const SizedBox(width: 4),
        Text(text,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _statusBadge(String status, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6)),
      child: Text(status.toUpperCase(),
          style: TextStyle(
              color: color, fontSize: 9, fontWeight: FontWeight.w800)),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _bottomIndex,
      onTap: _onBottomTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primaryTeal,
      unselectedItemColor: Colors.grey.shade400,
      backgroundColor: Colors.white,
      selectedFontSize: 11,
      unselectedFontSize: 11,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded), label: 'Search'),
        BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_num_rounded), label: 'Tickets'),
        BottomNavigationBarItem(icon: Icon(Icons.menu_rounded), label: 'More'),
      ],
    );
  }
}
