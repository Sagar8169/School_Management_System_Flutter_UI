// lib/routes/driver_routes.dart
import 'package:flutter/material.dart';
import '../screens/driver/home_driver.dart';
import '../screens/driver/trip_detail_page.dart';
import '../screens/driver/trip_completed_page.dart';
import '../screens/driver/trip_history_page.dart';
import '../screens/driver/tickets_page.dart';
import '../screens/driver/profile_page.dart';

class DriverRoutes {
  static const String home = '/driver/home';
  static const String tripDetail = '/driver/trip/detail';
  static const String tripCompleted = '/driver/trip/completed';
  static const String tripHistory = '/driver/trip/history';
  static const String tickets = '/driver/tickets';
  static const String profile = '/driver/profile';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeDriver(),
        );
      case tripDetail:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => TripDetailPage(
            tripId: args?['tripId'] ?? 'TRIP-123',
          ),
        );
      case tripCompleted:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => TripCompletedPage(
            tripId: args?['tripId'] ?? 'TRIP-123',
          ),
        );
      case tripHistory:
        return MaterialPageRoute(
          builder: (_) => const TripHistoryPage(),
        );
      case tickets:
        return MaterialPageRoute(
          builder: (_) => const TicketsPage(),
        );
      case profile:
        return MaterialPageRoute(
          builder: (_) => const ProfilePage(),
        );
      default:
      // Return null for any non-driver routes so they can be handled by other route generators
        return null;
    }
  }
}