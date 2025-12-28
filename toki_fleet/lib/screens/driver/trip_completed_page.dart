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
      backgroundColor: DriverWidgets.scaffoldBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderAndHero(context),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Trip Status', style: DriverWidgets.titleLarge()),
                      DriverWidgets.badge(
                        text: 'Completed',
                        backgroundColor: const Color(0xFF059669),
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Completed Status Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD1FAE5),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFA7F3D0)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            DriverWidgets.iconCircle(
                              icon: Icons.directions_bus,
                              backgroundColor: const Color(0xFF059669),
                              iconColor: Colors.white,
                              size: 40,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Morning Trip', style: DriverWidgets.titleMedium()),
                                  Text('Completed at: 08:25 PM', style: DriverWidgets.caption()),
                                ],
                              ),
                            ),
                            DriverWidgets.badge(
                              text: 'Finished',
                              backgroundColor: const Color(0xFF059669),
                              textColor: Colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _buildStatBox('Route KM', '9.8'),
                            const SizedBox(width: 8),
                            _buildStatBox('Total Stops', '4/4'),
                            const SizedBox(width: 8),
                            _buildStatBox('Duration', '65 min'),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // GPS Tracking Card
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFBFDBFE)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.navigation, color: Color(0xFF2563EB), size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('GPS Tracking Completed', style: DriverWidgets.bodyMedium().copyWith(fontWeight: FontWeight.w600)),
                              Text('All stops recorded successfully', style: DriverWidgets.caption()),
                            ],
                          ),
                        ),
                        DriverWidgets.badge(
                          text: 'Completed',
                          backgroundColor: const Color(0xFF2563EB),
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Completion Action Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF7ED),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFFFDDB4)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.check_circle_outline, color: Color(0xFFF97316), size: 24),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('All Stops Completed!', style: DriverWidgets.titleMedium(color: const Color(0xFF4B5563))),
                                Text('Ready to end trip', style: DriverWidgets.caption()),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 16),

                        // MAIN BUTTON - CLICK TO GO BACK TO HOME SCREEN
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // This will clear all routes and go back to Home
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                DriverRoutes.home,
                                    (route) => false,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF98131),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 3,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.done_all, color: Colors.white, size: 22),
                                SizedBox(width: 10),
                                Text(
                                  'End Trip & Go to Home',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Secondary Button - View Report
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              // Show trip report (could be a dialog or new page)
                              _showTripReport(context);
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              side: const BorderSide(color: Color(0xFFF98131)),
                            ),
                            child: const Text(
                              'View Trip Report',
                              style: TextStyle(
                                color: Color(0xFFF98131),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Route Stops Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined, color: Colors.green[700], size: 20),
                          const SizedBox(width: 8),
                          Text('Route Stops', style: DriverWidgets.titleLarge()),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text('100%', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green)),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Timeline - All Crossed
                  _buildTimelineStop(title: 'Banjara Hills Circle', time: '07:30', status: _StopStatus.crossed, isFirst: true),
                  _buildTimelineStop(title: 'Jubilee Hills', time: '07:45', status: _StopStatus.crossed),
                  _buildTimelineStop(title: 'Road No 10', time: '08:00', status: _StopStatus.crossed),
                  _buildTimelineStop(title: 'DPS School', time: '08:15', status: _StopStatus.crossed, tag: 'School', isLast: true),

                  const SizedBox(height: 24),

                  // Trip Summary Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text('Trip Summary', style: DriverWidgets.titleMedium()),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _buildSummaryItem('Distance', '25 km', Icons.speed),
                            const Spacer(),
                            _buildSummaryItem('Duration', '65 min', Icons.timer),
                            const Spacer(),
                            _buildSummaryItem('Avg Speed', '23 km/h', Icons.speed_outlined),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _buildSummaryItem('Start Time', '07:25 AM', Icons.play_arrow),
                            const Spacer(),
                            _buildSummaryItem('End Time', '08:30 AM', Icons.stop),
                            const Spacer(),
                            _buildSummaryItem('Fuel Used', '4.2 L', Icons.local_gas_station),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Success Footer Banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF10B981), Color(0xFF047857)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.emoji_events, color: Colors.white, size: 30),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Excellent Performance!', style: TextStyle(color: Colors.white70, fontSize: 12)),
                              SizedBox(height: 4),
                              Text(
                                'All stops completed successfully\nPerfect on-time performance',
                                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderAndHero(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF059669), Color(0xFF10B981)], // Green gradient for completed
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header with Back Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  // Back Button - CLICK TO GO BACK TO TRIP DETAIL PAGE
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('A', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Aditya International School', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                        Text('Powered by Toki Tech', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 10)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                    child: const Text('తెలుగు', style: TextStyle(color: Color(0xFF059669), fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),

            // Hero Content
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Thursday\nOctober 30', style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12)),
                  const SizedBox(height: 12),
                  const Text('Trip Completed', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('AP09T1234 - Route 1 - Banjara Hills', style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14)),
                  const SizedBox(height: 24),

                  // Progress Bar (Full)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Trip Progress', style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12)),
                      const Text('4/4', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 8,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF111827), Color(0xFF374151)],
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // White curve at bottom
            Container(
              height: 20,
              decoration: const BoxDecoration(
                color: Color(0xFFF6F7FB),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBox(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(label, style: DriverWidgets.caption()),
            const SizedBox(height: 4),
            Text(value, style: DriverWidgets.titleLarge()),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 20, color: DriverWidgets.textSecondary),
        const SizedBox(height: 4),
        Text(title, style: DriverWidgets.caption()),
        const SizedBox(height: 4),
        Text(value, style: DriverWidgets.bodyMedium().copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildTimelineStop({
    required String title,
    required String time,
    required _StopStatus status,
    String? tag,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 40,
            child: Column(
              children: [
                if (!isFirst)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: const Color(0xFF10B981),
                    ),
                  ),
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Color(0xFF10B981),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 16),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: const Color(0xFF10B981),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF0FDF4),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF10B981), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: DriverWidgets.bodyMedium().copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.access_time, size: 14, color: DriverWidgets.textSecondary),
                              const SizedBox(width: 4),
                              Text(time, style: DriverWidgets.bodySmall()),
                              if (tag != null) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    tag,
                                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                  ),
                                )
                              ]
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.check, size: 14, color: Colors.white),
                            SizedBox(width: 4),
                            Text('Completed', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showTripReport(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Trip Report'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Trip ID: $tripId', style: DriverWidgets.bodyMedium()),
            const SizedBox(height: 8),
            Text('Date: October 30, 2024', style: DriverWidgets.bodyMedium()),
            const SizedBox(height: 8),
            Text('Route: Route 1 - Banjara Hills', style: DriverWidgets.bodyMedium()),
            const SizedBox(height: 8),
            Text('Status: Perfectly Completed', style: DriverWidgets.bodyMedium()),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'All stops were completed on time. Excellent performance!',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

enum _StopStatus { crossed, current, upcoming }