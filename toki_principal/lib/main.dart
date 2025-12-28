import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));

  // Portrait mode lock
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toki Tech School Management',
      debugShowCheckedModeBanner: false,

      // 🌈 THEME SETUP
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',

        // Colors
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E40AF),
          primary: const Color(0xFF1E40AF),
          secondary: const Color(0xFF0EA5E9),
          surface: const Color(0xFFF8FAFC),
          background: const Color(0xFFF1F5F9),
        ),

        scaffoldBackgroundColor: const Color(0xFFF1F5F9),

        // ❌ Removed 'cardTheme' block to fix the "CardThemeData" error.
        // Material 3 will handle card styling automatically.

        // AppBar Theme
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF1E293B)),
          titleTextStyle: TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E40AF),
            foregroundColor: Colors.white,
            elevation: 0,
            minimumSize: const Size(double.infinity, 54),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),

        // Input Field Theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF1E40AF), width: 1.5),
          ),
        ),
      ),

      initialRoute: Routes.splash,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}