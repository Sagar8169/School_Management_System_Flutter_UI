// lib/routes/class_teacher_routes.dart
import 'package:flutter/material.dart';
import '../screens/class_teacher/home_class_teacher.dart';
import '../screens/class_teacher/attendance_analytics.dart';
import '../screens/class_teacher/parent_tickets_list.dart';
import '../screens/class_teacher/ticket_details.dart';
import '../screens/class_teacher/timetable_screen.dart';
import '../screens/class_teacher/approvals_list_screen.dart';
import '../screens/class_teacher/grade_approval_details_screen.dart';
import '../screens/class_teacher/task_assignment_screen.dart';
import '../screens/class_teacher/create_new_task_screen.dart';
import '../screens/class_teacher/search_screen.dart';
import '../screens/class_teacher/settings_screen.dart';
import '../screens/class_teacher/activity_screen.dart';
import '../screens/class_teacher/add_homework_page.dart';
import '../screens/class_teacher/upload_grades_page.dart';
import '../screens/class_teacher/take_attendance_class_teacher.dart';
import '../screens/class_teacher/class_search_page.dart';
import '../screens/class_teacher/class_details_page.dart';
import '../screens/class_teacher/teacher_search_page.dart';
import '../screens/class_teacher/teacher_profile_page.dart';
import '../screens/class_teacher/student_search_page.dart';
import '../screens/class_teacher/student_profile_page.dart';
import '../screens/class_teacher/staff_search_page.dart';
import '../screens/class_teacher/staff_profile_page.dart';

class ClassTeacherRoutes {
  // ROUTE NAMES
  static const String home = '/class-teacher/home';
  static const String activity = '/class-teacher/activity';
  static const String attendanceAnalytics = '/class-teacher/attendance-analytics';
  static const String parentTickets = '/class-teacher/parent-tickets';
  static const String ticketDetails = '/class-teacher/ticket-details';
  static const String timetable = '/class-teacher/timetable';
  static const String approvalsList = '/class-teacher/approvals-list';
  static const String gradeApprovalDetails = '/class-teacher/grade-approval-details';
  static const String taskAssignment = '/class-teacher/task-assignment';
  static const String createNewTask = '/class-teacher/create-new-task';
  static const String takeAttendance = '/class-teacher/take-attendance';
  static const String uploadGrades = '/class-teacher/upload-grades';
  static const String addHomework = '/class-teacher/add-homework';
  static const String search = '/class-teacher/search';
  static const String settings = '/class-teacher/settings';
  static const String classSearch = '/class-teacher/class-search';
  static const String classDetails = '/class-teacher/class-details';
  static const String teacherSearch = '/class-teacher/teacher-search';
  static const String teacherProfile = '/class-teacher/teacher-profile';
  static const String studentSearch = '/class-teacher/student-search';
  static const String studentProfile = '/class-teacher/student-profile';
  static const String staffSearch = '/class-teacher/staff-search';
  static const String staffProfile = '/class-teacher/staff-profile';

  // ROUTE GENERATOR - FIXED VERSION
  static Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    final routeName = routeSettings.name;

    if (routeName == null) return null;

    switch (routeName) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeClassTeacher());
      case activity:
        return MaterialPageRoute(builder: (_) => const ActivityScreen());
      case attendanceAnalytics:
        return MaterialPageRoute(builder: (_) => const AttendanceAnalyticsPage());
      case takeAttendance:
        return MaterialPageRoute(builder: (_) => const TakeAttendanceClassTeacherPage());
      case parentTickets:
        return MaterialPageRoute(builder: (_) => const ParentTicketsListPage());
      case ticketDetails:
        final args = routeSettings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(builder: (_) => TicketDetailsPage(ticket: args));
      case timetable:
        return MaterialPageRoute(builder: (_) => const TimetableScreen());
      case approvalsList:
        return MaterialPageRoute(builder: (_) => const ApprovalsListScreen());
      case gradeApprovalDetails:
        final args = routeSettings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(builder: (_) => GradeApprovalDetailsScreen(approval: args));
      case taskAssignment:
        return MaterialPageRoute(builder: (_) => const TaskAssignmentScreen());
      case createNewTask:
        return MaterialPageRoute(builder: (_) => const CreateNewTaskScreen());
      case addHomework:
        return MaterialPageRoute(builder: (_) => const AddHomeworkPage());
      case uploadGrades:
        return MaterialPageRoute(builder: (_) => const UploadGradesPage());
      case search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case classSearch:
        return MaterialPageRoute(builder: (_) => const ClassSearchPage());
      case teacherSearch:
        return MaterialPageRoute(builder: (_) => const TeacherSearchPage());
      case studentSearch:
        return MaterialPageRoute(builder: (_) => const StudentSearchPage());
      case staffSearch:
        return MaterialPageRoute(builder: (_) => const StaffSearchPage());
      case classDetails:
        final classArgs = routeSettings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(builder: (_) => ClassDetailsPage(classData: classArgs));
      case teacherProfile:
        final teacherArgs = routeSettings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(builder: (_) => TeacherProfilePage(teacherData: teacherArgs));
      case studentProfile:
        final studentArgs = routeSettings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(builder: (_) => StudentProfilePage(studentData: studentArgs));
      case staffProfile:
        final staffArgs = routeSettings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(builder: (_) => StaffProfilePage(staffData: staffArgs));
      default:
      // Check if it's a route that should be handled here but wasn't caught
        if (routeName.startsWith('/class-teacher')) {
          // Return a proper error page for missing class-teacher routes
          return MaterialPageRoute(
            builder: (_) => Scaffold(
              appBar: AppBar(title: const Text('Route Error')),
              body: Center(
                child: Text('Class Teacher route not found: $routeName'),
              ),
            ),
          );
        }
        return null;
    }
  }

  // Bottom Navigation Helper - FIXED METHOD SIGNATURE
  static void handleBottomNavTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(context, home, (route) => false);
        break;
      case 1:
        Navigator.pushNamedAndRemoveUntil(context, search, (route) => false);
        break;
      case 2:
        Navigator.pushNamedAndRemoveUntil(context, activity, (route) => false);
        break;
      case 3:
        Navigator.pushNamedAndRemoveUntil(context, settings, (route) => false);
        break;
    }
  }
}