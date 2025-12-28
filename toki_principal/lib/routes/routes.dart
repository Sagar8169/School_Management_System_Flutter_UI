import 'package:flutter/cupertino.dart'; // Modern transitions ke liye
import 'package:flutter/material.dart';
import '../screens/mobile_login_page.dart';
import '../screens/otp_verification_page.dart';
import 'package:toki_principal/routes/principal_routes.dart';

class Routes {
  // Named Routes Constants
  static const String login = '/login';
  static const String otpVerification = '/otp-verification';
  static const String splash = '/'; // Splash route agar main.dart me zarurat ho

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    // Debugging ke liye (Optional)
    debugPrint('Navigating to: ${settings.name}');

    switch (settings.name) {

    // 🔐 AUTH ROUTES
      case login:
        return CupertinoPageRoute(
          builder: (_) => const MobileLoginPage(),
          settings: settings,
        );

      case otpVerification:
      // Argument check with safety logic
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        return CupertinoPageRoute(
          builder: (_) => OtpVerificationPage(
            mobileNumber: args['mobileNumber'] ?? '',
          ),
          settings: settings,
        );

      default:
      // 🔹 PRINCIPAL ROUTES (Dashboard, Home, Analytics etc.)
      // Pehle Principal routes me check karega
        final principalRoute = PrincipalRoutes.generateRoute(settings);
        if (principalRoute != null) return principalRoute;

        // 🔹 FALLBACK (Route not found screen ko modern banaya)
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Navigation Error')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.redAccent),
                  const SizedBox(height: 16),
                  Text('No route defined for ${settings.name}'),
                ],
              ),
            ),
          ),
        );
    }
  }
}