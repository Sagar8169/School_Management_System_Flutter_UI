// lib/routes.dart
import 'package:flutter/material.dart';

// MAIN SCREENS
import 'screens/splash/splash_screen.dart';
import 'screens/mobile_login_page.dart';
import 'screens/otp_verification_page.dart';
import 'screens/parents/home_parents.dart';
import 'screens/class_teacher/home_class_teacher.dart';
import 'screens/subject_teacher/home_subject_teacher.dart';
import 'screens/fleet_manager/home_fleet_manager.dart';
import 'screens/driver/home_driver.dart';
import 'screens/principal/home_principal.dart';

// ROUTE GROUPS
import 'routes/parents_routes.dart';
import 'routes/class_teacher_routes.dart';
import 'routes/subject_teacher_routes.dart';
import 'routes/fleet_manager_routes.dart';
import 'routes/driver_routes.dart';
import 'routes/principal_routes.dart';

class Routes {
  static const String splash = '/';
  static const String mobileLogin = '/mobile-login';
  static const String otpVerification = '/otp-verification';

  // top-level "home" entries for each role
  static const String parentsHome = '/parents/home';
  static const String classTeacherHome = '/class-teacher/home';
  static const String subjectTeacherHome = '/subject-teacher/home';
  static const String fleetManagerHome = '/fleet-manager/home';
  static const String driverHome = '/driver/home';
  static const String principalHome = '/principal/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Check Driver Routes FIRST - Fix for driver routes not working
    if (settings.name?.startsWith('/driver') == true) {
      final driverRoute = DriverRoutes.generateRoute(settings);
      if (driverRoute != null) return driverRoute;
    }

    // FIRST: Try to delegate to role-specific route generators
    // Try Class Teacher Routes first for any /class-teacher route
    if (settings.name?.startsWith('/class-teacher') == true) {
      final route = ClassTeacherRoutes.generateRoute(settings);
      if (route != null) return route;
    }

    // 0️⃣ FIRST: let FleetManagerRoutes handle ANY /fleet/... route
    // This fixes "No route defined for /fleet/tickets" and friends.
    final fleetRoute = FleetManagerRoutes.generateRoute(settings);
    if (fleetRoute != null) {
      return fleetRoute;
    }

    // 1️⃣ ALSO FIRST: Check if it's a parent route (since /parents/home is in the switch below)
    final parentsRoute = ParentsRoutes.generateRoute(settings);
    if (parentsRoute != null) {
      return parentsRoute;
    }

    // 2️⃣ Normal top-level routing
    switch (settings.name) {
    // ───────── AUTH / COMMON ─────────
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case mobileLogin:
        return MaterialPageRoute(
          builder: (_) => const MobileLoginPage(),
        );

      case otpVerification:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => OtpVerificationPage(
            mobileNumber: args?['mobileNumber'] ?? '',
          ),
        );

    // ───────── TOP-LEVEL HOME SCREENS ─────────
      case parentsHome:
        return MaterialPageRoute(
          builder: (_) => const HomeParents(),
        );

      case classTeacherHome:
        return MaterialPageRoute(
          builder: (_) => const HomeClassTeacher(),
        );

      case subjectTeacherHome:
        return MaterialPageRoute(
          builder: (_) => const HomeSubjectTeacher(),
        );

      case fleetManagerHome:
        return MaterialPageRoute(
          builder: (_) => const HomeFleetManager(),
        );

      case driverHome:
        return MaterialPageRoute(
          builder: (_) => const HomeDriver(),
        );

      case principalHome:
        return MaterialPageRoute(
          builder: (_) => const HomePrincipal(),
        );

    // ───────── EVERYTHING ELSE: DELEGATE TO OTHER FEATURE ROUTERS ─────────
      default:
      // 1. Principal routes
        final principalRoute = PrincipalRoutes.generateRoute(settings);
        if (principalRoute != null) return principalRoute;

        // 2. Subject Teacher routes
        final subjectTeacherRoute = SubjectTeacherRoutes.generateRoute(settings);
        if (subjectTeacherRoute != null) return subjectTeacherRoute;

        // Note: Class Teacher routes already handled at the top
        // Note: Driver routes already handled at the VERY TOP

        // ❌ FINAL fallback: nothing handled it
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}