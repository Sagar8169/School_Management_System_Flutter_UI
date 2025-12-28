// lib/screens/driver/trip_completed_page.dart
import 'package:flutter/material.dart';
import '../../widgets/driver_widgets.dart';
import '../../routes/driver_routes.dart';

class TripCompletedPage extends StatelessWidget {
  final String tripId;

  const TripCompletedPage({Key? key, required this.tripId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          // 1. Hero Celebration Header
          _buildCelebrationHeader(context),

          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              children: [
                // 2. Performance Dashboard
                _buildSectionHeader('TRIP PERFORMANCE', Icons.analytics_outlined),
                const SizedBox(height: 16),
                _buildPerformanceGrid(),

                const SizedBox(height: 28),

                // 3. Timeline Overview (Green Flow)
                _buildSectionHeader('ROUTE RECAP', Icons.route_outlined),
                const SizedBox(height: 16),
                _buildTimelineList(),

                const SizedBox(height: 28),

                // 4. Trip Stats Summary Card
                _buildSectionHeader('JOURNEY SUMMARY', Icons.summarize_outlined),
                const SizedBox(height: 16),
                _buildTripSummaryCard(),

                const SizedBox(height: 32),

                // 5. Final Actions (Buttons)
                _buildActionCenter(context),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCelebrationHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF059669), Color(0xFF10B981)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  _circleIconBtn(Icons.arrow_back_ios_new, () => Navigator.pop(context)),
                  const Spacer(),
                  _langPill(),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Icon(Icons.check_circle_rounded, color: Colors.white, size: 80),
            const SizedBox(height: 16),
            const Text('Trip Successfully Ended', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            Text('Route 1 • Banjara Hills • $tripId', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceGrid() {
    return Row(
      children: [
        _statCard('Total Distance', '25.4 km', Icons.speed, Colors.blue),
        const SizedBox(width: 12),
        _statCard('Total Duration', '65 mins', Icons.timer, Colors.orange),
        const SizedBox(width: 12),
        _statCard('Stops Made', '4/4', Icons.pin_drop, Colors.purple),
      ],
    );
  }

  Widget _statCard(String label, String val, IconData icon, Color col) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)]),
      child: Column(children: [
        Icon(icon, color: col, size: 24),
        const SizedBox(height: 10),
        Text(val, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
        const SizedBox(height: 4),
        Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8), fontWeight: FontWeight.bold)),
      ]),
    ),
  );

  Widget _buildTimelineList() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28)),
      child: Column(
        children: [
          _timelineItem('Banjara Hills Circle', '07:30 AM', true, false),
          _timelineItem('Jubilee Hills', '07:45 AM', false, false),
          _timelineItem('Road No 10', '08:00 AM', false, false),
          _timelineItem('DPS School', '08:15 AM', false, true),
        ],
      ),
    );
  }

  Widget _timelineItem(String loc, String time, bool isFirst, bool isLast) => Row(
    children: [
      Column(children: [
        Container(width: 24, height: 24, decoration: const BoxDecoration(color: Color(0xFF10B981), shape: BoxShape.circle), child: const Icon(Icons.check, color: Colors.white, size: 14)),
        if (!isLast) Container(width: 2, height: 30, color: const Color(0xFFD1FAE5)),
      ]),
      const SizedBox(width: 15),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(loc, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF1E293B))),
        Text('Reached at $time', style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
      ])),
    ],
  );

  Widget _buildTripSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B), // Dark Navy
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _summaryItem('Avg Speed', '24 km/h', Icons.bolt),
            _summaryItem('Fuel Est.', '4.2 L', Icons.local_gas_station),
            _summaryItem('Score', '98%', Icons.star_rounded),
          ]),
          const Divider(color: Colors.white12, height: 40),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _summaryItem('Start', '07:25 AM', Icons.play_arrow_rounded),
            _summaryItem('End', '08:30 AM', Icons.stop_rounded),
          ]),
        ],
      ),
    );
  }

  Widget _summaryItem(String l, String v, IconData i) => Column(children: [
    Icon(i, color: Colors.white38, size: 20),
    const SizedBox(height: 8),
    Text(v, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900)),
    Text(l, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
  ]);

  Widget _buildActionCenter(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, DriverRoutes.home, (route) => false),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF97316),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 0,
            ),
            child: const Text('FINISH & GO HOME', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16, letterSpacing: 1)),
          ),
        ),
        const SizedBox(height: 12),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.description_outlined, color: Color(0xFF94A3B8)),
          label: const Text('VIEW DETAILED REPORT', style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  // Helper Widgets
  Widget _circleIconBtn(IconData i, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), shape: BoxShape.circle), child: Icon(i, color: Colors.white, size: 18)),
  );

  Widget _langPill() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
    child: const Text('తెలుగు', style: TextStyle(color: Color(0xFF059669), fontWeight: FontWeight.w900, fontSize: 12)),
  );

  Widget _buildSectionHeader(String t, IconData i) => Row(children: [
    Icon(i, size: 16, color: const Color(0xFF64748B)),
    const SizedBox(width: 8),
    Text(t, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Color(0xFF64748B), letterSpacing: 1)),
  ]);
}