import 'package:flutter/material.dart';

// Screens
import '../screens/fleet_manager/home_fleet_manager.dart';
import '../screens/fleet_manager/fleet_overview.dart';
import '../screens/fleet_manager/fleet_driver_profile.dart';
import '../screens/fleet_manager/fleet_more_options.dart';
import '../screens/fleet_manager/fleet_route_drivers.dart';
import '../screens/fleet_manager/fleet_route_students.dart';
import '../screens/fleet_manager/fleet_search_routes.dart';
import '../screens/fleet_manager/fleet_ticket_detail.dart';
import '../screens/fleet_manager/fleet_tickets.dart';

/// Simple Trips page (inline so you don't get missing class errors)
class FleetTrips extends StatelessWidget {
  final String? shift;
  final String? date;

  const FleetTrips({Key? key, this.shift, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fleet Trips'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.directions_bus, size: 64),
            const SizedBox(height: 16),
            const Text(
              'Fleet Trips Management',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            if (shift != null) Text('Shift: $shift'),
            if (date != null) Text('Date: $date'),
            const SizedBox(height: 16),
            const Text(
              'Trip management interface coming soon...',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class FleetManagerRoutes {
  // Main entry points / tabs
  static const String home = '/fleet/home';
  static const String dashboard = '/fleet/dashboard'; // optional alias
  static const String search = '/fleet/search';
  static const String tickets = '/fleet/tickets';
  static const String moreOptions = '/fleet/more';

  // Dashboard-related
  static const String overview = '/fleet/overview';
  static const String trips = '/fleet/trips';
  static const String tripHistory = '/fleet/trip-history';
  static const String busOverview = '/fleet/bus-overview';
  static const String routes = '/fleet/routes';
  static const String drivers = '/fleet/drivers';

  // Detail / deep-link routes
  static const String ticketDetail = '/fleet/tickets/detail';
  static const String routeDrivers = '/fleet/route/drivers';
  static const String routeStudents = '/fleet/route/students';
  static const String driverProfile = '/fleet/driver/profile';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    // Use Uri to safely handle query params like `/fleet/trips?shift=morning`
    final uri = Uri.parse(settings.name ?? '');

    switch (uri.path) {
    // ───────── MAIN TABS ─────────
      case home:
      case dashboard:
        return MaterialPageRoute(
          builder: (_) => const HomeFleetManager(),
        );

      case search:
        return MaterialPageRoute(
          builder: (_) => const FleetSearchRoutes(),
        );

      case tickets:
        return MaterialPageRoute(
          builder: (_) => const FleetTickets(),
        );

      case moreOptions:
        return MaterialPageRoute(
          builder: (_) => const FleetMoreOptions(),
        );

    // ───────── SIMPLE SCREENS ─────────
      case overview:
        return MaterialPageRoute(
          builder: (_) => const FleetOverview(),
        );

      case tripHistory:
      // Placeholder – replace with real screen later
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text(
                'Trip History Page (to be implemented)',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );

      case busOverview:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text(
                'Bus Overview Page (to be implemented)',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );

      case routes:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text(
                'Routes Summary Page (to be implemented)',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );

      case drivers:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text(
                'Drivers List Page (to be implemented)',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );

    // ───────── TRIPS WITH QUERY PARAMS ─────────
      case trips:
        final qp = uri.queryParameters;
        return MaterialPageRoute(
          builder: (_) => FleetTrips(
            shift: qp['shift'],
            date: qp['date'],
          ),
        );

    // ───────── DETAIL ROUTES WITH ARGUMENTS ─────────

      case ticketDetail: {
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        final ticketId = args['ticketId'] as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => FleetTicketDetail(ticketId: ticketId),
        );
      }

      case routeDrivers: {
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        final routeId = args['routeId'] as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => FleetRouteDrivers(routeId: routeId),
        );
      }

      case routeStudents: {
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        final routeId = args['routeId'] as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => FleetRouteStudents(routeId: routeId),
        );
      }

      case driverProfile: {
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        final driverId = args['driverId'] as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => FleetDriverProfile(driverId: driverId),
        );
      }

    // ───────── UNKNOWN → let main router decide ─────────
      default:
        return null;
    }
  }
}
