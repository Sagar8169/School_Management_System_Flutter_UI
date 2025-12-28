// lib/screens/driver/trip_detail_page.dart
import 'package:flutter/material.dart';
import '../../widgets/driver_widgets.dart';
import '../../routes/driver_routes.dart';

class TripDetailPage extends StatelessWidget {
  final String tripId;

  const TripDetailPage({Key? key, required this.tripId}) : super(key: key);

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
                        text: 'Active',
                        backgroundColor: const Color(0xFF10B981),
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Live Status Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFECFDF5),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFA7F3D0)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            DriverWidgets.iconCircle(
                              icon: Icons.directions_bus,
                              backgroundColor: const Color(0xFF10B981),
                              iconColor: Colors.white,
                              size: 40,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Morning Trip', style: DriverWidgets.titleMedium()),
                                  Text('Started at: 06:19 PM', style: DriverWidgets.caption()),
                                ],
                              ),
                            ),
                            DriverWidgets.badge(
                              text: 'Live',
                              backgroundColor: const Color(0xFF10B981),
                              textColor: Colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _buildStatBox('Route KM', '9.8'),
                            const SizedBox(width: 8),
                            _buildStatBox('Completed', '2/4'),
                            const SizedBox(width: 8),
                            _buildStatBox('Remaining', '2'),
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
                              Text('GPS Tracking Active', style: DriverWidgets.bodyMedium().copyWith(fontWeight: FontWeight.w600)),
                              Text('Auto-detecting stops', style: DriverWidgets.caption()),
                            ],
                          ),
                        ),
                        DriverWidgets.badge(
                          text: 'Active',
                          backgroundColor: const Color(0xFF2563EB),
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Simulate Button (Demo) - THIS TAKES YOU TO TRIP COMPLETED PAGE
                  GestureDetector(
                    onTap: () {
                      // Clicking this will navigate to Trip Completed Page
                      Navigator.pushNamed(
                        context,
                        DriverRoutes.tripCompleted,
                        arguments: {'tripId': tripId},
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2563EB),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF2563EB).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.play_arrow_outlined, color: Colors.white, size: 20),
                          const SizedBox(width: 8),
                          Text('Simulate GPS Progress (Demo)', style: DriverWidgets.bodyMedium(color: Colors.white).copyWith(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Toast Message
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2)),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, size: 16, color: Colors.green[700]),
                        const SizedBox(width: 8),
                        Text('Arrived at Jubilee Hills', style: DriverWidgets.bodySmall()),
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
                          Icon(Icons.location_on_outlined, color: Colors.orange[700], size: 20),
                          const SizedBox(width: 8),
                          Text('Route Stops', style: DriverWidgets.titleLarge()),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text('50%', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Timeline
                  _buildTimelineStop(
                    title: 'Banjara Hills Circle',
                    time: '07:30',
                    status: _StopStatus.crossed,
                    isFirst: true,
                  ),
                  _buildTimelineStop(
                    title: 'Jubilee Hills',
                    time: '07:45',
                    status: _StopStatus.crossed,
                  ),
                  _buildTimelineStop(
                    title: 'Road No 10',
                    time: '08:00',
                    status: _StopStatus.current,
                    gpsCoords: 'GPS: 17.4359, 78.4015',
                  ),
                  _buildTimelineStop(
                    title: 'DPS School',
                    time: '08:15',
                    status: _StopStatus.upcoming,
                    tag: 'School',
                    isLast: true,
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
          colors: [Color(0xFFE65100), Color(0xFFEF6C00)],
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
                  // Back Button - CLICK TO GO BACK TO PREVIOUS PAGE
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
                    child: const Text('తెలుగు', style: TextStyle(color: Color(0xFFE65100), fontSize: 12, fontWeight: FontWeight.bold)),
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
                  const Text('Trip Management', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('AP09T1234 - Route 1 - Banjara Hills', style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14)),
                  const SizedBox(height: 24),

                  // Progress Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Trip Progress', style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12)),
                      const Text('2/4', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: 0.5, // 50%
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF111827), Color(0xFF374151)],
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
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

  Widget _buildTimelineStop({
    required String title,
    required String time,
    required _StopStatus status,
    String? gpsCoords,
    String? tag,
    bool isFirst = false,
    bool isLast = false,
  }) {
    Color getBorderColor() {
      if (status == _StopStatus.crossed) return const Color(0xFF10B981);
      if (status == _StopStatus.current) return const Color(0xFF2563EB);
      return Colors.transparent;
    }

    Color getBackgroundColor() {
      if (status == _StopStatus.crossed) return const Color(0xFFF0FDF4);
      if (status == _StopStatus.current) return const Color(0xFFEFF6FF);
      return Colors.white;
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline Line & Icon
          SizedBox(
            width: 40,
            child: Column(
              children: [
                if (!isFirst)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: status == _StopStatus.crossed ? const Color(0xFF10B981) : const Color(0xFFE5E7EB),
                    ),
                  ),

                // Icon
                if (status == _StopStatus.crossed)
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Color(0xFF10B981),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check, color: Colors.white, size: 16),
                  )
                else if (status == _StopStatus.current)
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2563EB),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.navigation, color: Colors.white, size: 14),
                  )
                else
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE5E7EB),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.directions_bus, color: Colors.grey, size: 14),
                  ),

                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: status == _StopStatus.current || status == _StopStatus.crossed
                          ? const Color(0xFF10B981)
                          : const Color(0xFFE5E7EB),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Content Card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: getBackgroundColor(),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: getBorderColor(), width: 1.5),
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
                    Padding(
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
                          if (status == _StopStatus.crossed)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF10B981),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: const [
                                  Icon(Icons.check, size: 12, color: Colors.white),
                                  SizedBox(width: 4),
                                  Text('Crossed', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            )
                          else if (status == _StopStatus.current)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2563EB),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: const [
                                  Icon(Icons.arrow_forward, size: 12, color: Colors.white),
                                  SizedBox(width: 4),
                                  Text('Current', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            )
                          else
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Text(
                                'Upcoming',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                        ],
                      ),
                    ),

                    // GPS Details for Current Stop
                    if (status == _StopStatus.current && gpsCoords != null)
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDBEAFE),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.pin_drop, size: 14, color: Color(0xFFDC2626)),
                                const SizedBox(width: 8),
                                Text(
                                  gpsCoords,
                                  style: TextStyle(
                                    color: DriverWidgets.textPrimary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Will auto-complete when near this stop',
                              style: TextStyle(color: Color(0xFF2563EB), fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum _StopStatus { crossed, current, upcoming }