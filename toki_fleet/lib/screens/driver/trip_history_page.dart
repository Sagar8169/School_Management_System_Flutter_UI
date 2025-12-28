// lib/screens/driver/trip_history_page.dart
import 'package:flutter/material.dart';
import '../../widgets/driver_widgets.dart';
import '../../routes/driver_routes.dart';

class TripHistoryPage extends StatefulWidget {
  const TripHistoryPage({Key? key}) : super(key: key);

  @override
  State<TripHistoryPage> createState() => _TripHistoryPageState();
}

class _TripHistoryPageState extends State<TripHistoryPage> {
  int _currentIndex = 1;

  void _navigateToPage(int index) {
    if (index == _currentIndex) return;

    setState(() => _currentIndex = index);

    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(context, DriverRoutes.home, (_) => false);
        break;
      case 1:
        break;
      case 2:
        void switchToTab(int index) {
          setState(() => _currentIndex = index);
        }

        break;
      case 3:
        Navigator.pushNamed(context, DriverRoutes.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DriverWidgets.scaffoldBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: const [
              _TripHeaderCard(),
              SizedBox(height: 16),
              _TripStatusCard(),
              SizedBox(height: 12),
              _GpsStatusCard(),
              SizedBox(height: 12),
              _EndTripCard(),
              SizedBox(height: 20),
              _RouteStopsSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _navigateToPage,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: DriverWidgets.primaryColor,
        unselectedItemColor: DriverWidgets.textSecondary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.directions_bus), label: 'Trip'),
          BottomNavigationBarItem(icon: Icon(Icons.confirmation_number_outlined), label: 'Tickets'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
class _TripHeaderCard extends StatelessWidget {
  const _TripHeaderCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFD44A1C), Color(0xFFE06A2D)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
        Text('Thursday\nOctober 30',
            style: TextStyle(color: Colors.white70, fontSize: 13)),
        SizedBox(height: 6),
        Text('Trip Management',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 6),
        Text('AP09T1234 • Route 1 • Banjara Hills',
            style: TextStyle(color: Colors.white70)),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: LinearProgressIndicator(
                  value: 1,
                  minHeight: 8,
                  backgroundColor: Colors.white24,
                  valueColor: AlwaysStoppedAnimation(Colors.black),
                ),
              ),
            ),
            SizedBox(width: 12),
            Text('4/4', style: TextStyle(color: Colors.white)),
          ],
        )
      ]),
    );
  }
}
class _TripStatusCard extends StatelessWidget {
  const _TripStatusCard();

  @override
  Widget build(BuildContext context) {
    return _whiteCard(
      Column(children: [
        Row(children: const [
          Text('Trip Status', style: TextStyle(fontWeight: FontWeight.bold)),
          Spacer(),
          Chip(label: Text('Active'), backgroundColor: Colors.greenAccent),
        ]),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(children: [
            Row(children: const [
              CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(Icons.directions_bus, color: Colors.white),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Morning Trip',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const Text(
                      'Started at: 06:19 PM',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],

                ),
              ),
              Chip(label: Text('Live'), backgroundColor: Colors.green),
            ]),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _TripMiniStat('Start KM', '9.8'),
                _TripMiniStat('Completed', '4/4'),
                _TripMiniStat('Remaining', '0'),
              ],
            )
          ]),
        )
      ]),
    );
  }
}

class _TripMiniStat extends StatelessWidget {
  final String title, value;
  const _TripMiniStat(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
    ]);
  }
}
class _GpsStatusCard extends StatelessWidget {
  const _GpsStatusCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(children: const [
        Icon(Icons.gps_fixed, color: Colors.blue),
        SizedBox(width: 10),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'GPS Tracking Active',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            Text('Auto-detecting stops', style: TextStyle(fontSize: 12)),
          ]),
        ),
        Chip(label: Text('Active')),
      ]),
    );
  }
}
class _EndTripCard extends StatelessWidget {
  const _EndTripCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.15),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(children: [
        Row(children: const [
          Icon(Icons.check_circle, color: Colors.orange),
          SizedBox(width: 8),
          Expanded(
            child: Text('All Stops Completed!\nReady to end trip',
                style: TextStyle(fontSize: 13)),
          ),
        ]),
        const SizedBox(height: 12),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            minimumSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          onPressed: () {},
          child: const Text('End Trip & Submit'),
        ),
      ]),
    );
  }
}
class _RouteStopsSection extends StatelessWidget {
  const _RouteStopsSection();

  @override
  Widget build(BuildContext context) {
    return _whiteCard(Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Row(children: [
          Icon(Icons.location_on, color: Colors.orange),
          SizedBox(width: 6),
          Text(
            'Route Stops',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),

          Spacer(),
          Chip(label: Text('100%')),
        ]),
        SizedBox(height: 16),
        _RouteStopTile('Banjara Hills Circle', '07:30'),
        _RouteStopTile('Jubilee Hills', '07:45'),
        _RouteStopTile('Road No 10', '08:00'),
        _RouteStopTile('DPS School', '08:15', isSchool: true),
        SizedBox(height: 12),
        _SuccessBanner(),
      ],
    ));
  }
}

class _RouteStopTile extends StatelessWidget {
  final String title, time;
  final bool isSchool;

  const _RouteStopTile(this.title, this.time, {this.isSchool = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green),
      ),
      child: Row(children: [
        const CircleAvatar(
          backgroundColor: Colors.green,
          child: Icon(Icons.check, color: Colors.white),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(time, style: const TextStyle(fontSize: 12)),
          ]),
        ),
        if (isSchool)
          const Chip(label: Text('School')),
        const Chip(label: Text('Crossed'), backgroundColor: Colors.greenAccent),
      ]),
    );
  }
}

class _SuccessBanner extends StatelessWidget {
  const _SuccessBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade700,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(children: const [
        Icon(Icons.trending_up, color: Colors.white),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            'Excellent!\nAll stops completed successfully',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ]),
    );
  }
}
Widget _whiteCard(Widget child) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: child,
  );
}
