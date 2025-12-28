import 'package:flutter/material.dart';
import '../../routes/fleet_manager_routes.dart';
import 'fleet_mock_data.dart';

class FleetRouteDrivers extends StatelessWidget {
  final String routeId;

  const FleetRouteDrivers({Key? key, required this.routeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const primaryPurple = Color(0xFF7C4DFF);
    const background = Color(0xFFF9FAFB);

    final route = FleetMockData.routeById(routeId);
    final drivers = FleetMockData.driversForRoute(routeId);

    final routeName = route?.name ?? 'Route';
    final countLabel = '${drivers.length} drivers assigned';

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: primaryPurple,
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Drivers on Route',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          routeName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          countLabel,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                itemCount: drivers.length,
                itemBuilder: (context, index) {
                  final d = drivers[index];
                  return _driverCard(context, d);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _driverCard(BuildContext context, FleetDriver d) {
    const primaryPurple = Color(0xFF7C4DFF);
    const primaryTeal = Color(0xFF009A86);

    final statusLabel = d.onDuty ? 'On Duty' : 'Off Duty';
    final statusColor = d.onDuty ? Colors.green : Colors.grey;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          FleetManagerRoutes.driverProfile,
          arguments: {'driverId': d.id},
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
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
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: primaryPurple.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, color: primaryPurple),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    d.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          statusLabel,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${d.busPlate} • ${d.experienceYears} years exp.',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    d.phone,
                    style: const TextStyle(
                      color: primaryTeal,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
