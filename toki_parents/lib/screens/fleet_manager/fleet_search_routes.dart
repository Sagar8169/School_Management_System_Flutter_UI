import 'package:flutter/material.dart';
import '../../routes/fleet_manager_routes.dart';
import 'fleet_mock_data.dart';

class FleetSearchRoutes extends StatefulWidget {
  const FleetSearchRoutes({Key? key}) : super(key: key);

  @override
  State<FleetSearchRoutes> createState() => _FleetSearchRoutesState();
}

class _FleetSearchRoutesState extends State<FleetSearchRoutes> {
  final Color primaryTeal = const Color(0xFF009A86);
  final Color background = const Color(0xFFF9FAFB);

  String _search = '';
  String _filterBy = 'Route'; // Options: 'Route', 'Bus'
  bool _isTelugu = true; // State for language toggle

  @override
  Widget build(BuildContext context) {
    // Filter Logic
    final routes = FleetMockData.routes.where((r) {
      final query = _search.trim().toLowerCase();
      if (query.isEmpty) return true;

      if (_filterBy == 'Bus') {
        // Checks if query matches the bus number
        // NOTE: Ensure your FleetRoute model has a 'busNumber' string field
        return (r.busNumber ?? '').toLowerCase().contains(query);
      } else {
        // Checks if query matches the route name
        return r.name.toLowerCase().contains(query);
      }
    }).toList();

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            _topHeader(), // Fixed Top Header
            _searchHeader(), // Fixed Search Bar with Filter
            Expanded(
              // Properly scrollable list that fills remaining space
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 24),
                // Dismiss keyboard when dragging the list (Better UX)
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: routes.length,
                itemBuilder: (context, index) {
                  final route = routes[index];
                  return _routeCard(route);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topHeader() {
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
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
            onPressed: () {
              setState(() {
                _isTelugu = !_isTelugu;
              });
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: primaryTeal),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              _isTelugu ? 'తెలుగు' : 'English',
              style: TextStyle(color: primaryTeal),
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchHeader() {
    return Container(
      color: primaryTeal,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _filterBy == 'Bus' ? 'Search by Bus' : 'Search by Route',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              onChanged: (val) => setState(() => _search = val),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                hintText: _filterBy == 'Bus'
                    ? 'Enter bus number (e.g. KA01...)'
                    : 'Search route names...',
                hintStyle: const TextStyle(color: Colors.white70),
                border: InputBorder.none,
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Filter Chips
          Row(
            children: [
              _buildFilterChip('Route'),
              const SizedBox(width: 12),
              _buildFilterChip('Bus'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _filterBy == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _filterBy = label;
          // Optional: Clear search when switching to avoid confusion
          // _search = '';
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? primaryTeal : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _routeCard(FleetRoute route) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            blurRadius: 6,
            color: Color(0x11000000),
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                route.name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 15),
              ),
              // Optional: Display bus number on card
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  route.busNumber ?? 'No Bus',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '${route.studentsCount} students • ${route.driversCount} drivers',
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      FleetManagerRoutes.routeStudents,
                      arguments: {'routeId': route.id},
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFE0F2F1),
                    side: BorderSide(color: primaryTeal),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'View Students',
                    style: TextStyle(color: primaryTeal),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      FleetManagerRoutes.routeDrivers,
                      arguments: {'routeId': route.id},
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFEDE7F6),
                    side: const BorderSide(color: Color(0xFF7C4DFF)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'View Drivers',
                    style: TextStyle(color: Color(0xFF7C4DFF)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}