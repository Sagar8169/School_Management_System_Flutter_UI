import 'package:flutter/material.dart';

import '../screens/principal/home_principal.dart';
import '../screens/principal/attendance_analytics_page.dart';
import '../screens/principal/grades_analytics_page.dart';
import '../screens/principal/fleet_management_page.dart' as fleet_screen;
import '../screens/principal/more_page.dart';
import '../screens/principal/search_page.dart';
import '../screens/principal/class_search_page.dart';
import '../screens/principal/class_details_page.dart';
import '../screens/principal/teacher_search_page.dart';
import '../screens/principal/teacher_profile_page.dart';
import '../screens/principal/student_search_page.dart';
import '../screens/principal/student_profile_page.dart';
import '../screens/principal/staff_search_page.dart';
import '../screens/principal/staff_profile_page.dart';
import '../screens/principal/pending_approvals_page.dart';
import '../screens/principal/take_attendance_page.dart';
import '../screens/principal/upload_grades_page.dart';
import '../screens/principal/announcements_page.dart';
import '../screens/principal/fleet_details_page.dart';
import '../screens/principal/activity_page.dart';
import '../screens/principal/timetable_page.dart'; // ADDED
import '../screens/principal/class_timetable_page.dart'; // ADDED

class PrincipalRoutes {
  // ROUTE NAMES
  static const String home = '/principal/home';
  static const String activity = '/principal/activity';

  static const String attendanceAnalytics = '/principal/attendance-analytics';
  static const String gradesAnalytics = '/principal/grades-analytics';
  static const String fleetManagement = '/principal/fleet-management';
  static const String fleetDetails = '/principal/fleet-details';

  // NEW ROUTES
  static const String takeAttendance = '/principal/take-attendance';
  static const String uploadGrades = '/principal/upload-grades';
  static const String pendingApprovals = '/principal/pending-approvals';

  static const String morePage = '/principal/more';
  static const String search = '/principal/search';

  static const String classSearch = '/principal/class-search';
  static const String classDetails = '/principal/class-details';

  static const String teacherSearch = '/principal/teacher-search';
  static const String teacherProfile = '/principal/teacher-profile';

  static const String studentSearch = '/principal/student-search';
  static const String studentProfile = '/principal/student-profile';

  static const String staffSearch = '/principal/staff-search';
  static const String staffProfile = '/principal/staff-profile';

  static const String announcements = '/principal/announcements';

  // TIMETABLE ROUTES - ADDED
  static const String timetable = '/principal/timetable';
  static const String classTimetable = '/principal/class-timetable';

  // ROUTE GENERATOR
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
    // HOME
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomePrincipal(),
        );

    // NEW ACTIVITY PAGE
      case activity:
        return MaterialPageRoute(
          builder: (_) => const ActivityPage(),
        );

    // ANALYTICS
      case attendanceAnalytics:
        return MaterialPageRoute(
          builder: (_) => const AttendanceAnalyticsPage(),
        );

      case gradesAnalytics:
        return MaterialPageRoute(
          builder: (_) => const GradesAnalyticsPage(),
        );

      case fleetManagement:
        return MaterialPageRoute(
          builder: (_) => const fleet_screen.FleetManagementPage(),
        );

    // FLEET DETAILS ROUTE
      case fleetDetails:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => FleetDetailsPage(bus: args ?? {}),
        );

    // NEW ROUTES
      case takeAttendance:
        return MaterialPageRoute(
          builder: (_) => const TakeAttendancePage(),
        );
      case pendingApprovals:
        return MaterialPageRoute(
          builder: (_) => const PendingApprovalsPage(),
        );

      case uploadGrades:
        return MaterialPageRoute(
          builder: (_) => const UploadGradesPage(),
        );

    // MORE PAGE
      case morePage:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => MorePage(
            initialSection: args?['section'],
          ),
        );

    // SEARCH
      case search:
        return MaterialPageRoute(
          builder: (_) => const SearchPage(),
        );

      case classSearch:
        return MaterialPageRoute(
          builder: (_) => const ClassSearchPage(),
        );

      case teacherSearch:
        return MaterialPageRoute(
          builder: (_) => const TeacherSearchPage(),
        );

      case studentSearch:
        return MaterialPageRoute(
          builder: (_) => const StudentSearchPage(),
        );

      case staffSearch:
        return MaterialPageRoute(
          builder: (_) => const StaffSearchPage(),
        );

    // DETAILS / PROFILES
      case classDetails:
        final classArgs = settings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(
          builder: (_) => ClassDetailsPage(classData: classArgs),
        );

      case teacherProfile:
        final teacherArgs = settings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(
          builder: (_) => TeacherProfilePage(teacherData: teacherArgs),
        );

      case studentProfile:
        final studentArgs = settings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(
          builder: (_) => StudentProfilePage(studentData: studentArgs),
        );

      case announcements:
        return MaterialPageRoute(
          builder: (_) => const AnnouncementsPage(),
        );

      case staffProfile:
        final staffArgs = settings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(
          builder: (_) => StaffProfilePage(staffData: staffArgs),
        );

    // TIMETABLE ROUTES - ADDED
      case timetable:
        return MaterialPageRoute(
          builder: (_) => const TimetablePage(),
        );

      case classTimetable:
        final classArgs = settings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(
          builder: (_) => ClassTimetablePage(classData: classArgs),
        );

    // IMPORTANT: DO NOT RETURN A SCREEN HERE
    // let main router handle fallback
      default:
        return null;
    }
  }
}