// lib/screens/driver/home_driver.dart
import 'package:flutter/material.dart';
import '../../routes/driver_routes.dart';
import '../../widgets/driver_widgets.dart';

class HomeDriver extends StatefulWidget {
  const HomeDriver({Key? key}) : super(key: key);

  @override
  State<HomeDriver> createState() => _HomeDriverState();
}

class _HomeDriverState extends State<HomeDriver> {
  int _currentIndex = 0;
  bool _showAlert = true;
  bool _isTelugu = true;

  // Navigation method
  void _navigateToPage(int index) {
    if (index == _currentIndex) return;

    setState(() => _currentIndex = index);

    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(
          context,
          DriverRoutes.home,
              (route) => false,
        );
        break;
      case 1:
        Navigator.pushNamed(
          context,
          DriverRoutes.tripHistory,
        );
        break;
      case 2:
        Navigator.pushNamed(
          context,
          DriverRoutes.tickets,
        );
        break;
      case 3:
        Navigator.pushNamed(
          context,
          DriverRoutes.profile,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DriverWidgets.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
            // App Header with Language Toggle
            DriverWidgets.appHeader(
              schoolName: 'Aditya International School',
              schoolInitial: 'A',
              selectedLanguage: _isTelugu ? 'తెలుగు' : 'English',
              onLanguageToggle: () {
                setState(() {
                  _isTelugu = !_isTelugu;
                });
              },
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),

                      // Hero Section
                      _buildDriverHero(),

                      const SizedBox(height: 16),

                      // Alert Banner
                      if (_showAlert)
                        DriverWidgets.alertBanner(
                          title: 'Cyclone Alert - School Closed',
                          message: 'Due to severe cyclone warning, school will remain closed on October 21-22, 2025. Stay safe!',
                          onDismiss: () => setState(() => _showAlert = false),
                        ),

                      if (_showAlert) const SizedBox(height: 16),

                      // MERGED TILE: Today's Trips + Stats
                      _buildCombinedDashboardCard(),

                      const SizedBox(height: 24),

                      Text('My Route', style: DriverWidgets.titleLarge()),
                      const SizedBox(height: 12),

                      // Route Card
                      DriverWidgets.card(
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                color: Color(0xFFFFF7ED),
                                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                              ),
                              child: Row(
                                children: [
                                  DriverWidgets.iconCircle(
                                    icon: Icons.directions_bus,
                                    backgroundColor: const Color(0xFFFF5722),
                                    iconColor: Colors.white,
                                    size: 48,
                                    iconSize: 24,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('AP09T1234', style: DriverWidgets.titleMedium()),
                                        Text('Route 1 - Banjara Hills', style: DriverWidgets.bodySmall()),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              color: const Color(0xFFFFF7ED),
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: Row(
                                children: [
                                  _buildRouteMiniStat('Total Stops', '4'),
                                  const Spacer(),
                                  _buildRouteMiniStat('Students', '3'),
                                  const Spacer(flex: 2),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Stops on Route', style: DriverWidgets.bodyMedium(color: DriverWidgets.textSecondary)),
                                  const SizedBox(height: 16),
                                  _buildTimelineItem(1, 'Banjara Hills Circle', '07:30', isFirst: true),
                                  _buildTimelineItem(2, 'Jubilee Hills', '07:45'),
                                  _buildTimelineItem(3, 'Road No 10', '08:00'),
                                  _buildTimelineItem(4, 'DPS School', '08:15', isLast: true),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Recent Trips Section
                      const SizedBox(height: 24),
                      Text('Recent Trips', style: DriverWidgets.titleLarge()),
                      const SizedBox(height: 12),

                      _buildRecentTripCard(
                        date: 'Today - Morning',
                        status: 'Completed',
                        stops: '4/4',
                        distance: '25 km',
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            DriverRoutes.tripCompleted,
                            arguments: {'tripId': 'TRIP-001'},
                          );
                        },
                      ),

                      const SizedBox(height: 12),

                      _buildRecentTripCard(
                        date: 'Yesterday - Evening',
                        status: 'Completed',
                        stops: '4/4',
                        distance: '24 km',
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            DriverRoutes.tripDetail,
                            arguments: {'tripId': 'TRIP-002'},
                          );
                        },
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _navigateToPage,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: DriverWidgets.primaryColor,
        unselectedItemColor: DriverWidgets.textSecondary,
        selectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bus_outlined),
            activeIcon: Icon(Icons.directions_bus),
            label: 'Trip',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_number_outlined),
            activeIcon: Icon(Icons.confirmation_number),
            label: 'Tickets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildDriverHero() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE65100), Color(0xFFEF6C00)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thursday\nOctober 30',
            style: DriverWidgets.bodySmall(color: Colors.white.withOpacity(0.9)),
          ),
          const SizedBox(height: 12),
          Text(
            'Krishna Murthy',
            style: DriverWidgets.headlineMedium(color: Colors.white),
          ),
          Text(
            'Driver',
            style: DriverWidgets.bodyMedium(color: Colors.white.withOpacity(0.9)),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(Icons.directions_bus, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                'AP09T1234 - Route 1 - Banjara Hills',
                style: DriverWidgets.bodyMedium(color: Colors.white).copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCombinedDashboardCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF2563EB),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Today's Trips",
                          style: DriverWidgets.bodyMedium(color: Colors.white.withOpacity(0.9)),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '2',
                          style: DriverWidgets.headlineLarge(color: Colors.white),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.calendar_today, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            DriverRoutes.tripDetail,
                            arguments: {'tripId': 'TRIP-CURRENT'},
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white.withOpacity(0.3)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Morning',
                                style: DriverWidgets.bodySmall(color: Colors.white.withOpacity(0.8)),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.directions_bus, color: Colors.white, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Live',
                                    style: DriverWidgets.bodyMedium(color: Colors.white).copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            DriverRoutes.tripDetail,
                            arguments: {'tripId': 'TRIP-EVENING'},
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Evening',
                                style: DriverWidgets.bodySmall(color: Colors.white.withOpacity(0.8)),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Pending',
                                style: DriverWidgets.bodyMedium(color: Colors.white).copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Divider(height: 1, color: Colors.white.withOpacity(0.2)),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.show_chart, color: Colors.white, size: 18),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total Trips', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 11)),
                          const SizedBox(height: 2),
                          const Text('1', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(width: 1, height: 40, color: Colors.white.withOpacity(0.2)),
                const SizedBox(width: 16),
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.speed, color: Colors.white, size: 18),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Distance', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 11)),
                          const SizedBox(height: 2),
                          const Text('25 km', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRouteMiniStat(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: DriverWidgets.bodySmall(color: DriverWidgets.textSecondary)),
        const SizedBox(height: 4),
        Text(value, style: DriverWidgets.titleMedium()),
      ],
    );
  }

  Widget _buildTimelineItem(int index, String location, String time, {bool isFirst = false, bool isLast = false}) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 40,
            child: Column(
              children: [
                if (!isFirst)
                  Container(width: 2, height: 10, color: const Color(0xFFFFCC80)),
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFE0B2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$index',
                      style: const TextStyle(color: Color(0xFFE65100), fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(child: Container(width: 2, color: const Color(0xFFFFCC80))),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 4, bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(location, style: DriverWidgets.bodyMedium().copyWith(fontWeight: FontWeight.w500)),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 14, color: Color(0xFF6B7280)),
                      const SizedBox(width: 4),
                      Text(time, style: DriverWidgets.bodySmall()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTripCard({
    required String date,
    required String status,
    required String stops,
    required String distance,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(date, style: DriverWidgets.titleMedium()),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 14, color: DriverWidgets.textSecondary),
                        const SizedBox(width: 4),
                        Text('Route 1 - Banjara Hills', style: DriverWidgets.bodySmall()),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: status == 'Completed'
                        ? Colors.green.withOpacity(0.1)
                        : Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: status == 'Completed' ? Colors.green : Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildTripStat(Icons.stop_circle, 'Stops: $stops'),
                const Spacer(),
                _buildTripStat(Icons.speed, 'Distance: $distance'),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: DriverWidgets.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'View Details',
                    style: TextStyle(
                      color: DriverWidgets.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripStat(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: DriverWidgets.textSecondary),
        const SizedBox(width: 4),
        Text(text, style: DriverWidgets.bodySmall()),
      ],
    );
  }
}