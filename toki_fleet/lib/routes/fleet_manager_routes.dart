import 'package:flutter/material.dart';
import 'package:toki/screens/fleet_manager/bottom_navigation.dart';

// Screens Imports

import '../screens/fleet_manager/fleet_overview.dart';
import '../screens/fleet_manager/fleet_driver_profile.dart';
import '../screens/fleet_manager/fleet_more_options.dart';
import '../screens/fleet_manager/fleet_route_drivers.dart';
import '../screens/fleet_manager/fleet_route_students.dart';
import '../screens/fleet_manager/fleet_search_routes.dart';
import '../screens/fleet_manager/fleet_ticket_detail.dart';
import '../screens/fleet_manager/fleet_tickets.dart';

// New Screen Imports
import '../screens/fleet_manager/fleet_profile_edit.dart';
import '../screens/fleet_manager/fleet_trip_history_page.dart';
import '../screens/fleet_manager/fleet_bus_overview.dart';
import '../screens/fleet_manager/fleet_maintenance.dart';
import '../screens/fleet_manager/fleet_driver_directory.dart';
import '../screens/fleet_manager/fleet_leave_mgmt.dart';
import '../screens/fleet_manager/fleet_attendance.dart'; // Isko import zaroor karna

class FleetManagerRoutes {
  // Aliases/Constants
  static const String drivers = '/fleet/drivers';
  static const String tripHistory = '/fleet/trip-history';

  // Main entry points
  static const String home = '/fleet/home';
  static const String dashboard = '/fleet/dashboard';
  static const String search = '/fleet/search';
  static const String tickets = '/fleet/tickets';
  static const String moreOptions = '/fleet/more';

  // Management Screens
  static const String maintenance = '/fleet/maintenance';
  static const String driverDirectory = '/fleet/driver-directory';
  static const String leaveMgmt = '/fleet/leave-management';
  static const String attendance = '/fleet/attendance';
  static const String profileEdit = '/fleet/profile-edit';
  static const String busOverview = '/fleet/bus-overview';
  static const String routes = '/fleet/routes';

  // Detail / deep-link routes
  static const String trips = '/fleet/trips';
  static const String ticketDetail = '/fleet/tickets/detail';
  static const String routeDrivers = '/fleet/route/drivers';
  static const String routeStudents = '/fleet/route/students';
  static const String driverProfile = '/fleet/driver/profile';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final uri = Uri.parse(settings.name ?? '');

    switch (uri.path) {
      // ───────── MAIN TABS ─────────
      case home:
      case dashboard:
        return MaterialPageRoute(builder: (_) => HomeFleetManager());

      case search:
        return MaterialPageRoute(builder: (_) => const FleetSearchRoutes());

      case tickets:
        return MaterialPageRoute(builder: (_) => const FleetTickets());

      case moreOptions:
        return MaterialPageRoute(builder: (_) => const FleetMoreOptions());

      // ───────── MANAGEMENT SCREENS ─────────
      case profileEdit:
        return MaterialPageRoute(builder: (_) => const FleetProfileEdit());

      case busOverview:
        return MaterialPageRoute(builder: (_) => FleetBusOverview());

      case maintenance:
        return MaterialPageRoute(builder: (_) => FleetMaintenance());

      case driverDirectory:
      case drivers: // Handling both aliases
        return MaterialPageRoute(builder: (_) => const FleetDriverDirectory());

      case leaveMgmt:
        return MaterialPageRoute(builder: (_) => const FleetLeaveMgmt());

      case routes:
        return MaterialPageRoute(builder: (_) => const FleetSearchRoutes());

      case attendance:
        return MaterialPageRoute(builder: (_) => const FleetAttendance());

      // lib/routes/fleet_manager_routes.dart (Example file name)

      case tripHistory:
        return MaterialPageRoute(
            builder: (_) =>
                const FleetTripHistoryPage()); // Is page ko yahan bind karein
      // ───────── DETAIL ROUTES ─────────
      case trips:
        final qp = uri.queryParameters;
        return MaterialPageRoute(
          builder: (_) => FleetTrips(shift: qp['shift'], date: qp['date']),
        );

      case ticketDetail:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(
          builder: (_) => FleetTicketDetail(ticketId: args['ticketId'] ?? ''),
        );

      case driverProfile:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(
          builder: (_) => FleetDriverProfile(driverId: args['driverId'] ?? ''),
        );

      default:
        return null;
    }
  }
}

class FleetTrips extends StatelessWidget {
  final String? shift;
  final String? date;
  const FleetTrips({Key? key, this.shift, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fleet Trips')),
      body: Center(child: Text('Trips for $shift on $date')),
    );
  }
}
