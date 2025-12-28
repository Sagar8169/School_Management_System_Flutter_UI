import 'package:flutter/material.dart';
import 'fleet_mock_data.dart';

class FleetDriverProfile extends StatelessWidget {
  final String driverId;

  const FleetDriverProfile({Key? key, required this.driverId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const primaryPurple = Color(0xFF7C4DFF);
    const primaryTeal = Color(0xFF009A86);
    const background = Color(0xFFF9FAFB);

    final driver = FleetMockData.driverById(driverId);

    if (driver == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Driver Profile'),
          backgroundColor: primaryPurple,
        ),
        body: const Center(child: Text('Driver not found')),
      );
    }

    final route = FleetMockData.routeById(driver.routeId);

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: primaryPurple,
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 24),
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
                        'Driver Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 38,
                          color: primaryPurple,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              driver.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Driver ID: ${driver.id}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'On Duty',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                children: [
                  _infoCard(
                    title: 'Basic Information',
                    children: [
                      _infoRow(
                        icon: Icons.phone,
                        iconColor: Colors.blue,
                        label: 'Phone Number',
                        value: driver.phone,
                      ),
                      const SizedBox(height: 10),
                      _infoRow(
                        icon: Icons.map_outlined,
                        iconColor: primaryTeal,
                        label: 'Assigned Route',
                        value: route?.name ?? 'N/A',
                      ),
                      const SizedBox(height: 10),
                      _infoRow(
                        icon: Icons.directions_bus,
                        iconColor: Colors.orange,
                        label: 'Bus Number',
                        value: driver.busPlate,
                      ),
                      const SizedBox(height: 10),
                      _infoRow(
                        icon: Icons.calendar_month,
                        iconColor: primaryPurple,
                        label: 'Experience',
                        value: '${driver.experienceYears} years',
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Moved Performance Card Here
                  _infoCard(
                    title: "This Month's Performance",
                    children: [
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          _statBox('22', 'Days Worked', Colors.green),
                          _statBox('156', 'Trips Completed', Colors.blue),
                          _statBox('0', 'Delays', Colors.orange),
                          _statBox('850', 'Total KM', primaryPurple),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Moved License Information Below Performance
                  _infoCard(
                    title: 'License Information',
                    children: const [
                      Text(
                        'License Number',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'KA12-20110045678',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'License Type',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Commercial (Heavy Vehicle)',
                        style: TextStyle(fontSize: 13),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Valid Until',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'March 15, 2028',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // hook url_launcher later
                      },
                      icon: const Icon(Icons.call, color: Colors.blue),
                      label: const Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        child: Text(
                          'Call Driver',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.blue),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
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

  Widget _infoCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
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
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _statBox(String value, String label, Color color) {
    return SizedBox(
      width: 140,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.06),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}