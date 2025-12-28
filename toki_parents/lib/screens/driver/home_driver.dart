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

  // --- ORIGINAL NAVIGATION LOGIC ---
  void _navigateToPage(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);

    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(context, DriverRoutes.home, (route) => false);
        break;
      case 1:
        Navigator.pushNamed(context, DriverRoutes.tripHistory);
        break;
      case 2:
        Navigator.pushNamed(context, DriverRoutes.tickets);
        break;
      case 3:
        Navigator.pushNamed(context, DriverRoutes.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Dynamic padding for responsiveness
    final double px = MediaQuery.of(context).size.width > 600 ? 40.0 : 18.0;

    return Scaffold(
      backgroundColor: DriverWidgets.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
            // ✨ App Header (Original Logic)
            DriverWidgets.appHeader(
              schoolName: 'Aditya International School',
              schoolInitial: 'A',
              selectedLanguage: _isTelugu ? 'తెలుగు' : 'English',
              onLanguageToggle: () => setState(() => _isTelugu = !_isTelugu),
            ),

            Expanded(
              child: RefreshIndicator(
                color: DriverWidgets.primaryColor,
                onRefresh: () async => await Future.delayed(const Duration(seconds: 1)),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: px),
                  children: [
                    const SizedBox(height: 16),

                    // 1. Driver Profile Hero (Premium Gradient)
                    _buildDriverHero(),

                    const SizedBox(height: 16),

                    // 2. Alert Banner (Logic preserved)
                    if (_showAlert)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: DriverWidgets.alertBanner(
                          title: 'Cyclone Alert - School Closed',
                          message: 'Due to severe cyclone warning, school remains closed. Stay safe!',
                          onDismiss: () => setState(() => _showAlert = false),
                        ),
                      ),

                    // 3. Merged Dashboard (Trips & Stats)
                    _buildCombinedDashboardCard(),

                    const SizedBox(height: 28),

                    // 4. My Route Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('My Route', style: DriverWidgets.titleLarge()),
                        Text('AP09T1234', style: TextStyle(color: DriverWidgets.primaryColor, fontWeight: FontWeight.bold, fontSize: 13)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildRouteCard(),

                    const SizedBox(height: 28),

                    // 5. Recent Trips Section
                    Text('Recent Trips', style: DriverWidgets.titleLarge()),
                    const SizedBox(height: 12),

                    _buildRecentTripCard(
                      date: 'Today - Morning',
                      status: 'Completed',
                      stops: '4/4',
                      distance: '25 km',
                      onTap: () => Navigator.pushNamed(context, DriverRoutes.tripCompleted, arguments: {'tripId': 'TRIP-001'}),
                    ),

                    const SizedBox(height: 12),

                    _buildRecentTripCard(
                      date: 'Yesterday - Evening',
                      status: 'Completed',
                      stops: '4/4',
                      distance: '24 km',
                      onTap: () => Navigator.pushNamed(context, DriverRoutes.tripDetail, arguments: {'tripId': 'TRIP-002'}),
                    ),

                    const SizedBox(height: 40), // Bottom Buffer
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildDriverHero() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE65100), Color(0xFFEF6C00)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [BoxShadow(color: const Color(0xFFE65100).withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('THURSDAY, OCT 30', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1)),
          const SizedBox(height: 12),
          Text('Krishna Murthy', style: DriverWidgets.headlineMedium(color: Colors.white)),
          Text('Senior Fleet Operator', style: DriverWidgets.bodyMedium(color: Colors.white.withOpacity(0.9))),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(Icons.directions_bus_rounded, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text('Route 1 • Banjara Hills', style: DriverWidgets.bodyMedium(color: Colors.white).copyWith(fontWeight: FontWeight.bold)),
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
        color: const Color(0xFF2563EB), // Premium Blue
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.2), blurRadius: 15, offset: const Offset(0, 8))],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Today's Trips", style: DriverWidgets.bodySmall(color: Colors.white70)),
                        const SizedBox(height: 4),
                        Text('2 Total', style: DriverWidgets.headlineLarge(color: Colors.white)),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(15)),
                      child: const Icon(Icons.calendar_today_rounded, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _tripStatusBtn('Morning', 'Live', true),
                    const SizedBox(width: 12),
                    _tripStatusBtn('Evening', 'Pending', false),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 22),
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.1), borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _miniHeroStat(Icons.show_chart, 'Trips', '1'),
                Container(width: 1, height: 30, color: Colors.white10),
                _miniHeroStat(Icons.speed, 'Distance', '25 km'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tripStatusBtn(String time, String status, bool isLive) {
    return Expanded(
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, DriverRoutes.tripDetail, arguments: {'tripId': isLive ? 'TRIP-CURRENT' : 'TRIP-EVENING'}),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isLive ? Colors.white : Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(time, style: TextStyle(color: isLive ? const Color(0xFF2563EB) : Colors.white70, fontSize: 11, fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              Text(status, style: TextStyle(color: isLive ? const Color(0xFF1E293B) : Colors.white, fontSize: 15, fontWeight: FontWeight.w900)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRouteCard() {
    return DriverWidgets.card(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(color: Color(0xFFFFF7ED), borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
            child: Row(
              children: [
                DriverWidgets.iconCircle(icon: Icons.directions_bus, backgroundColor: const Color(0xFFE65100), iconColor: Colors.white, size: 48, iconSize: 24),
                const SizedBox(width: 15),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Route 1', style: DriverWidgets.titleLarge()),
                  Text('Banjara Hills • 4 Stops', style: DriverWidgets.bodySmall()),
                ]),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildTimelineItem(1, 'Banjara Hills Circle', '07:30', isFirst: true),
                _buildTimelineItem(2, 'Jubilee Hills', '07:45'),
                _buildTimelineItem(3, 'Road No 10', '08:00'),
                _buildTimelineItem(4, 'DPS School', '08:15', isLast: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniHeroStat(IconData icon, String label, String val) {
    return Row(children: [
      Icon(icon, color: Colors.white70, size: 18),
      const SizedBox(width: 10),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
        Text(val, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900)),
      ]),
    ]);
  }

  Widget _buildTimelineItem(int index, String location, String time, {bool isFirst = false, bool isLast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(width: 26, height: 26, decoration: BoxDecoration(color: const Color(0xFFFFF7ED), border: Border.all(color: const Color(0xFFE65100), width: 2), shape: BoxShape.circle), child: Center(child: Text('$index', style: const TextStyle(color: Color(0xFFE65100), fontWeight: FontWeight.w900, fontSize: 11)))),
            if (!isLast) Container(width: 2, height: 35, color: const Color(0xFFF1F5F9)),
          ],
        ),
        const SizedBox(width: 15),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(location, style: DriverWidgets.bodyMedium().copyWith(fontWeight: FontWeight.w800)),
          Text(time, style: DriverWidgets.bodySmall()),
          const SizedBox(height: 20),
        ])),
      ],
    );
  }

  Widget _buildRecentTripCard({required String date, required String status, required String stops, required String distance, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: DriverWidgets.card(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(date, style: DriverWidgets.titleMedium()),
                  const SizedBox(height: 4),
                  Row(children: [const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey), const SizedBox(width: 4), Text('Banjara Hills', style: DriverWidgets.bodySmall())]),
                ]),
                Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: const Text('Completed', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w900, fontSize: 11))),
              ],
            ),
            const SizedBox(height: 15),
            Row(children: [
              _tripStat(Icons.stop_circle_outlined, stops),
              const SizedBox(width: 20),
              _tripStat(Icons.speed, distance),
              const Spacer(),
              Text('Details', style: TextStyle(color: DriverWidgets.primaryColor, fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(width: 4),
              Icon(Icons.arrow_forward_ios_rounded, size: 12, color: DriverWidgets.primaryColor),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _tripStat(IconData icon, String val) => Row(children: [Icon(icon, size: 16, color: Colors.grey), const SizedBox(width: 6), Text(val, style: DriverWidgets.bodySmall())]);

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xFFF1F5F9), width: 2))),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _navigateToPage,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFFE65100),
        unselectedItemColor: const Color(0xFF94A3B8),
        elevation: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.alt_route_rounded), label: 'Trip'),
          BottomNavigationBarItem(icon: Icon(Icons.confirmation_number_outlined), label: 'Tickets'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}