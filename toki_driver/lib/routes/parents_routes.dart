// lib/routes/parents_routes.dart
import 'package:flutter/material.dart';

// REAL screens you already have
import '../screens/parents/home_parents.dart';
import '../screens/parents/attendance_record_page.dart';
import '../screens/parents/grades_page.dart';
import '../screens/parents/homework_page.dart';
import '../screens/parents/announcements_page.dart';
import '../screens/parents/events_page.dart';
import '../screens/parents/bus_tracking_page.dart';
import '../screens/parents/tickets_page.dart';
import '../screens/parents/raise_ticket_page.dart';
import '../screens/parents/more_options_page.dart';
import '../screens/parents/reports_page.dart';
import '../screens/parents/today_full_details_page.dart'; // NEW IMPORT

class ParentsRoutes {
  // Parent-specific routes
  static const String home = '/parents/home';
  static const String attendance = '/parents/attendance';
  static const String grades = '/parents/grades';
  static const String homework = '/parents/homework';
  static const String announcements = '/parents/announcements';
  static const String events = '/parents/events';
  static const String busTracking = '/parents/bus-tracking';
  static const String tickets = '/parents/tickets';
  static const String raiseTicket = '/parents/raise-ticket';
  static const String moreOptions = '/parents/more-options';
  static const String reports = '/parents/reports';
  static const String todayFullDetails = '/parents/today-full-details'; // NEW ROUTE

  // Extra destinations (placeholders)
  static const String profile = '/parents/profile';
  static const String settings = '/parents/settings';
  static const String academicCalendar = '/parents/academic-calendar';
  static const String support = '/parents/support';
  static const String contactSchool = '/parents/contact-school';

  /// Returns a [Route] for the given [routeSettings], or null if this module
  /// doesn't handle the route (let the main router fallback).
  static Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
    // MAIN
      case home:
        return MaterialPageRoute(builder: (_) => HomeParents());

      case attendance:
        return MaterialPageRoute(builder: (_) => AttendanceRecordPage());

      case grades:
        return MaterialPageRoute(builder: (_) => GradesPage());

      case homework:
        return MaterialPageRoute(builder: (_) => HomeworkPage());

      case announcements:
        return MaterialPageRoute(builder: (_) => AnnouncementsPage());

      case events:
        return MaterialPageRoute(builder: (_) => EventsPage());

      case reports:
        return MaterialPageRoute(builder: (_) => ReportsPage());

      case busTracking:
        return MaterialPageRoute(builder: (_) => BusTrackingPage());

      case tickets:
        return MaterialPageRoute(builder: (_) => TicketsPage());

      case raiseTicket:
        return MaterialPageRoute(builder: (_) => RaiseTicketPage());

      case moreOptions:
        return MaterialPageRoute(builder: (_) => MoreOptionsPage());

    // NEW ROUTE
      case todayFullDetails:
        return MaterialPageRoute(builder: (_) => TodayFullDetailsPage());

    // EXTRA / PLACEHOLDER ROUTES
      case profile:
        return MaterialPageRoute(
          builder: (_) => _ParentsPlaceholderScreen(
            title: 'My Profile',
            message:
            'Profile screen not implemented yet.\nAdd it under lib/screens/parents/ and update ParentsRoutes.',
          ),
        );

      case settings:
        return MaterialPageRoute(
          builder: (_) => _ParentsPlaceholderScreen(
            title: 'Settings',
            message:
            'Settings screen not implemented yet.\nAdd it under lib/screens/parents/ and update ParentsRoutes.',
          ),
        );

      case academicCalendar:
        return MaterialPageRoute(
          builder: (_) => _ParentsPlaceholderScreen(
            title: 'Academic Calendar',
            message:
            'Academic calendar screen not implemented yet.\nAdd it under lib/screens/parents/ and update ParentsRoutes.',
          ),
        );

      case support:
        return MaterialPageRoute(
          builder: (_) => _ParentsPlaceholderScreen(
            title: 'Support',
            message:
            'Support screen not implemented yet.\nAdd it under lib/screens/parents/ and update ParentsRoutes.',
          ),
        );

      case contactSchool:
        return MaterialPageRoute(
          builder: (_) => _ParentsPlaceholderScreen(
            title: 'Contact School',
            message:
            'Contact school screen not implemented yet.\nAdd it under lib/screens/parents/ and update ParentsRoutes.',
          ),
        );

      default:
        return null; // let the main router handle fallback
    }
  }
}

/// Simple fallback screen so navigation doesn't crash
class _ParentsPlaceholderScreen extends StatelessWidget {
  final String title;
  final String message;

  const _ParentsPlaceholderScreen({
    Key? key,
    required this.title,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            message,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}