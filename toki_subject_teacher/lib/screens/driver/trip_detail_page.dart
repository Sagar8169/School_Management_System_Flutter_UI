// lib/screens/driver/trip_detail_page.dart
import 'package:flutter/material.dart';
import '../../routes/driver_routes.dart';

// ✨ Stop Status Enum (Original Logic)
enum StopStatus { crossed, current, upcoming }

class TripDetailPage extends StatelessWidget {
  final String tripId;

  const TripDetailPage({Key? key, required this.tripId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dynamic padding for responsiveness
    final double px = MediaQuery.of(context).size.width > 600 ? 40.0 : 20.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          // 1. Fixed Premium Header
          _buildHeroHeader(context, px),

          // 2. Scrollable Content Area
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(px, 24, px, 120), // Bottom padding for safety
              children: [
                _buildSectionTitle('TRIP STATUS', Icons.sensors),
                const SizedBox(height: 16),

                // Live Tracking Card
                _buildLiveStatusCard(),

                const SizedBox(height: 12),

                // GPS Tracking Status
                _buildGpsStatusCard(),

                const SizedBox(height: 24),

                // Simulation Button (Demo Logic)
                _buildSimulateButton(context),

                const SizedBox(height: 32),

                _buildSectionTitle('ROUTE STOPS PROGRESS', Icons.alt_route),
                const SizedBox(height: 20),

                // Timeline List
                _buildTimelineList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- 🛠️ UI BUILDER FUNCTIONS ---

  Widget _buildHeroHeader(BuildContext context, double px) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE65100), Color(0xFFFB8C00)],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                      child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Text('Trip Detail', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
                  ),
                  _langBadge(),
                ],
              ),
              const SizedBox(height: 25),
              const Text('AP09T1234 • Route 1', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Trip Progress', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800)),
                  Text('2 / 4 Stops', style: TextStyle(color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: const LinearProgressIndicator(
                  value: 0.5,
                  minHeight: 8,
                  backgroundColor: Colors.white12,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLiveStatusCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 15, offset: const Offset(0, 8))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(backgroundColor: Colors.white24, child: Icon(Icons.directions_bus, color: Colors.white)),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Morning Trip', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18)),
                    Text('Active since 07:15 AM', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              _statusBadge('LIVE', Colors.white, Colors.green.shade800),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoRow(Icons.speed, '12.5 KM'),
              _infoRow(Icons.timer_outlined, '45 MIN'),
              _infoRow(Icons.sync_rounded, 'SYNCED'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGpsStatusCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFBFDBFE)),
      ),
      child: const Row(
        children: [
          Icon(Icons.gps_fixed, color: Color(0xFF2563EB), size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'GPS Tracking active. Auto-detecting stops.',
              style: TextStyle(color: Color(0xFF1E40AF), fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineList() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28)),
      child: Column(
        children: [
          _buildTimelineItem('Banjara Hills Circle', '07:30 AM', StopStatus.crossed, isFirst: true),
          _buildTimelineItem('Jubilee Hills', '07:45 AM', StopStatus.crossed),
          _buildTimelineItem('Road No 10', '08:00 AM', StopStatus.current, gps: '17.43, 78.40'),
          _buildTimelineItem('DPS School', '08:15 AM', StopStatus.upcoming, isLast: true),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(String title, String time, StopStatus status, {bool isFirst = false, bool isLast = false, String? gps}) {
    Color color = status == StopStatus.crossed ? Colors.green : (status == StopStatus.current ? Colors.blue : Colors.grey.shade300);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 22, height: 22,
              decoration: BoxDecoration(
                color: status == StopStatus.current ? Colors.white : color,
                border: Border.all(color: color, width: 2),
                shape: BoxShape.circle,
              ),
              child: status == StopStatus.crossed ? const Icon(Icons.check, color: Colors.white, size: 12) : null,
            ),
            if (!isLast) Container(width: 2, height: 45, color: color.withOpacity(0.3)),
          ],
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.w800, color: status == StopStatus.upcoming ? Colors.grey : Colors.black87)),
              Text(time, style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
              if (gps != null)
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
                  child: Text('GPS: $gps', style: const TextStyle(color: Colors.blue, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSimulateButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(
              context,
              DriverRoutes.tripCompleted,
              arguments: {'tripId': tripId}
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2563EB),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: const Text('SIMULATE GPS ARRIVAL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: 1)),
      ),
    );
  }

  // --- 🎨 HELPER WIDGETS ---

  Widget _langBadge() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
    child: const Text('తెలుగు', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
  );

  Widget _statusBadge(String t, Color txt, Color bg) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
    child: Text(t, style: TextStyle(color: txt, fontSize: 10, fontWeight: FontWeight.w900)),
  );

  Widget _infoRow(IconData i, String t) => Row(
    children: [
      Icon(i, color: Colors.white70, size: 16),
      const SizedBox(width: 6),
      Text(t, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
    ],
  );

  Widget _buildSectionTitle(String t, IconData i) => Row(
    children: [
      Icon(i, size: 16, color: Colors.blueGrey),
      const SizedBox(width: 8),
      Text(t, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Colors.blueGrey, letterSpacing: 1)),
    ],
  );
}