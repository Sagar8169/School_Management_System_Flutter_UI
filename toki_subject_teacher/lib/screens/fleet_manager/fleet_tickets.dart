import 'package:flutter/material.dart';
import '../../routes/fleet_manager_routes.dart';
import 'fleet_ticket_data.dart';

class FleetTickets extends StatefulWidget {
  const FleetTickets({Key? key}) : super(key: key);

  @override
  State<FleetTickets> createState() => _FleetTicketsState();
}

class _FleetTicketsState extends State<FleetTickets> {
  static const Color primaryTeal = Color(0xFF00BFA5);
  static const Color background = Color(0xFFF9FAFB);
  static const Color redHeader = Color(0xFFE75B4E);

  String _selectedFilter = 'All';
  int _bottomIndex = 2; // Tickets active

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
      case 2:
      // already here
        break;
      case 3:
        Navigator.pushNamed(context, FleetManagerRoutes.moreOptions);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tickets = FleetTicketData.tickets.where((t) {
      if (_selectedFilter == 'All') return true;
      return t.status.toLowerCase() == _selectedFilter.toLowerCase();
    }).toList();

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _globalHeader(),
            _ticketsHeader(),
            _filterRow(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
                itemCount: tickets.length,
                itemBuilder: (context, index) {
                  final ticket = tickets[index];
                  return _ticketCard(ticket);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomIndex,
        onTap: _onBottomTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: primaryTeal,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Tickets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_vert),
            label: 'More',
          ),
        ],
      ),
    );
  }

  Widget _globalHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: primaryTeal,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'A',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Aditya International School',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 2),
                Text(
                  'Powered by Toki Tech',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: primaryTeal),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('తెలుగు'),
          ),
        ],
      ),
    );
  }

  Widget _ticketsHeader() {
    return Container(
      color: redHeader,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fleet Tickets',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _summaryCard('1', 'Open'),
              const SizedBox(width: 8),
              _summaryCard('1', 'In Progress'),
              const SizedBox(width: 8),
              _summaryCard('1', 'Resolved'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryCard(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterRow() {
    final filters = ['All', 'Open', 'In Progress', 'Resolved'];

    return Container(
      color: background,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filters
              .map((f) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: _filterChip(f),
          ))
              .toList(),
        ),
      ),
    );
  }

  Widget _filterChip(String label) {
    final bool active = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedFilter = label);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: active ? const Color(0xFFE75B4E) : const Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.white : Colors.black87,
            fontSize: 12,
            fontWeight: active ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _ticketCard(FleetTicket ticket) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          FleetManagerRoutes.ticketDetail,
          arguments: {'ticketId': ticket.id},
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x11000000),
              blurRadius: 6,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _tagChip(
                  ticket.type,
                  Colors.lightBlue.shade50,
                  Colors.blue.shade700,
                ),
                const SizedBox(width: 8),
                _tagChip(
                  '${ticket.priority} Priority',
                  Colors.red.shade50,
                  Colors.red.shade700,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              ticket.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              ticket.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${ticket.busNumber} • ${ticket.routeName}',
              style: const TextStyle(
                color: primaryTeal,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Ticket #${ticket.id} • ${ticket.footerDate}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _tagChip(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: fg,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
