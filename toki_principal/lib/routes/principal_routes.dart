import 'package:flutter/material.dart';

// --- Imports ---
import '../screens/principal/add_event_page.dart';
import '../screens/principal/add_homework_page.dart';
import '../screens/principal/collect_fee_page.dart';
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
import '../screens/principal/timetable_page.dart';
import '../screens/principal/class_timetable_page.dart';

class PrincipalRoutes {
  static const String collectFee = '/collect-fee';

  // ROUTE NAMES Constants
  static const String home = '/principal/home';
  static const String activity = '/principal/activity';
  static const String attendanceAnalytics = '/principal/attendance-analytics';
  static const String gradesAnalytics = '/principal/grades-analytics';
  static const String fleetManagement = '/principal/fleet-management';
  static const String fleetDetails = '/principal/fleet-details';
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
  static const String timetable = '/principal/timetable';
  static const String classTimetable = '/principal/class-timetable';

  // New Functional Routes
  static const String addHomework = '/add-homework';
  static const String addEvent = '/add-event';
  static const String assignTask = '/assign-task'; // ✅ Naya Route Constant

  // ROUTE GENERATOR
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>? ?? {};

    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePrincipal());

      case activity:
        return MaterialPageRoute(builder: (_) => const ActivityPage());

      case attendanceAnalytics:
        return MaterialPageRoute(builder: (_) => const AttendanceAnalyticsPage());

      case gradesAnalytics:
        return MaterialPageRoute(builder: (_) => const GradesAnalyticsPage());

      case fleetManagement:
        return MaterialPageRoute(builder: (_) => const fleet_screen.FleetManagementPage());

      case addHomework:
        return MaterialPageRoute(builder: (_) => const AddHomeworkPage());

      case fleetDetails:
        return MaterialPageRoute(builder: (_) => FleetDetailsPage(bus: args));

      case takeAttendance:
        return MaterialPageRoute(builder: (_) => const TakeAttendancePage());

      case pendingApprovals:
      // Note: Agar constructor error aaye toh yahan se 'const' hata dein
        return MaterialPageRoute(builder: (_) => const AssignTaskPage());

      case uploadGrades:
        return MaterialPageRoute(builder: (_) => const UploadGradesPage());

      case morePage:
        return MaterialPageRoute(
          builder: (_) => MorePage(initialSection: args['section']),
        );

      case search:
        return MaterialPageRoute(builder: (_) => const SearchPage());

      case classSearch:
        return MaterialPageRoute(builder: (_) => const ClassSearchPage());

      case teacherSearch:
        return MaterialPageRoute(builder: (_) => const TeacherSearchPage());

      case studentSearch:
        return MaterialPageRoute(builder: (_) => const StudentSearchPage());

      case staffSearch:
        return MaterialPageRoute(builder: (_) => const StaffSearchPage());

      case classDetails:
        return MaterialPageRoute(builder: (_) => ClassDetailsPage(classData: args));

      case teacherProfile:
        return MaterialPageRoute(builder: (_) => TeacherProfilePage(teacherData: args));

      case studentProfile:
        return MaterialPageRoute(builder: (_) => StudentProfilePage(studentData: args));

      case announcements:
        return MaterialPageRoute(builder: (_) => const AnnouncementsPage());

      case staffProfile:
        return MaterialPageRoute(builder: (_) => StaffProfilePage(staffData: args));

      case addEvent:
        return MaterialPageRoute(builder: (_) => const AddEventPage());

      case assignTask: // ✅ Assign Task Case add kiya
        return MaterialPageRoute(builder: (_) => const AssignTaskPage());

      case collectFee: // ✅ Assign Task Case add kiya
        return MaterialPageRoute(builder: (_) => const CollectFeePage());

      case timetable:
        return MaterialPageRoute(builder: (_) => const TimetablePage());

      case classTimetable:
        return MaterialPageRoute(builder: (_) => ClassTimetablePage(classData: args));

      default:
        return null;
    }
  }
}