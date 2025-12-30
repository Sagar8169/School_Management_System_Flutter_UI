// lib/routes.dart
import 'package:flutter/material.dart';

// MAIN SCREENS
import 'screens/splash/splash_screen.dart';
import 'screens/mobile_login_page.dart';
import 'screens/otp_verification_page.dart';
import 'screens/principal/home_principal.dart';

// ROUTE GROUPS
import 'routes/principal_routes.dart';

class Routes {
  static const String splash = '/';
  static const String mobileLogin = '/mobile-login';
  static const String otpVerification = '/otp-verification';

  // Principal Home Route
  static const String principalHome = '/principal/home';

  static const String login = '/login';
  static Route<dynamic> generateRoute(RouteSettings settings) {
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

      // ───────── PRINCIPAL ─────────
      case principalHome:
        return MaterialPageRoute(
          builder: (_) => HomePrincipal(),
        );

      // ───────── DELEGATE TO PRINCIPAL FEATURE ROUTER ─────────
      default:
        // Check if the route exists within the Principal sub-routes
        final principalRoute = PrincipalRoutes.generateRoute(settings);
        if (principalRoute != null) return principalRoute;

        // ❌ FINAL fallback: Route not found
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
