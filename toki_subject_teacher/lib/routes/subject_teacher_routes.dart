import 'package:flutter/material.dart';

// ---------------- SUBJECT TEACHER SCREENS ----------------
import '../screens/subject_teacher/grades_analytics_page.dart';
import '../screens/subject_teacher/home_subject_teacher.dart';
import '../screens/subject_teacher/more_page.dart';
import '../screens/subject_teacher/subject_teacher_profile_page.dart';
import '../screens/subject_teacher/tasks_list_page.dart';
import '../screens/subject_teacher/task_details_page.dart';
import '../screens/subject_teacher/homework_list_page.dart';
import '../screens/subject_teacher/homework_details_page.dart';
import '../screens/subject_teacher/add_homework_page.dart';
import '../screens/subject_teacher/take_attendance_page.dart';
import '../screens/subject_teacher/attendance_summary_page.dart';
import '../screens/subject_teacher/weekly_schedule_page.dart';
import '../screens/subject_teacher/activity_page.dart';
import '../screens/subject_teacher/search_page.dart';
import '../screens/subject_teacher/upload_grade_page.dart';
import '../screens/subject_teacher/settings_screen.dart';
import '../screens/subject_teacher/class_attendance_detail_page.dart';
import '../screens/subject_teacher/attendance_analytics_page.dart';

// ---------------- COMMON / PRINCIPAL SCREENS ----------------

// ---------------- SEARCH & DETAIL SCREENS ----------------
import '../screens/subject_teacher/class_search_page.dart';
import '../screens/subject_teacher/teacher_search_page.dart';
import '../screens/subject_teacher/student_search_page.dart';
import '../screens/subject_teacher/class_details_page.dart';
import '../screens/subject_teacher/student_profile_page.dart';
import '../screens/subject_teacher/teacher_profile_page.dart';

class SubjectTeacherRoutes {
  // ---------------- ROUTE NAMES ----------------
  static const String morePage = '/subject-teacher/more';

  static const String home = '/subject-teacher/home';
  static const String profile = '/subject-teacher/profile';
  static const String settings = '/subject-teacher/settings';
  static const String tasks = '/subject-teacher/tasks';
  static const String taskDetails = '/subject-teacher/task-details';
  static const String homework = '/subject-teacher/homework';
  static const String homeworkDetails = '/subject-teacher/homework-details';
  static const String addHomework = '/subject-teacher/add-homework';
  static const String takeAttendance = '/subject-teacher/take-attendance';
  static const String attendanceSummary = '/subject-teacher/attendance-summary';
  static const String classAttendance = '/subject-teacher/class-attendance';
  static const String schedule = '/subject-teacher/schedule';
  static const String activity = '/subject-teacher/activity';
  static const String search = '/subject-teacher/search';
  static const String uploadGrades = '/subject-teacher/upload-grades';

  // Analytics
  static const String gradesAnalytics = '/subject-teacher/grades-analytics';
  static const String attendanceAnalytics =
      '/subject-teacher/attendance-analytics';

  // Search
  static const String classSearch = '/subject-teacher/class-search';
  static const String teacherSearch = '/subject-teacher/teacher-search';
  static const String studentSearch = '/subject-teacher/student-search';

  // Details
  static const String classDetails = '/subject-teacher/class-details';
  static const String studentProfile = '/subject-teacher/student-profile';
  static const String teacherProfile = '/subject-teacher/teacher-profile';

  // ---------------- ROUTE GENERATOR ----------------

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final routeName = routeSettings.name;
    final args = routeSettings.arguments;

    // HOME
    if (routeName == home) {
      return MaterialPageRoute(builder: (_) => const HomeSubjectTeacher());
    }

    // ---------------- ANALYTICS ----------------

    // Grades Analytics
    else if (routeName == gradesAnalytics) {
      if (args is Map<String, dynamic>) {
        return MaterialPageRoute(
          builder: (_) => GradesAnalyticsPage(
            studentData: args['studentData'],
          ),
        );
      }
      return MaterialPageRoute(
        builder: (_) => const GradesAnalyticsPage(studentData: null),
      );
    }

    else if (routeName == morePage) {
      return MaterialPageRoute(
        builder: (_) => const MorePage(),
      );
    }


    // Attendance Analytics
    else if (routeName == attendanceAnalytics) {
      if (args is Map<String, dynamic>) {
        return MaterialPageRoute(
          builder: (_) => AttendanceAnalyticsPage(
            studentData: args['studentData'],
          ),
        );
      }
      return MaterialPageRoute(
        builder: (_) => const AttendanceAnalyticsPage(),
      );
    }

    // ---------------- PROFILE & SETTINGS ----------------

    else if (routeName == profile) {
      return MaterialPageRoute(
        builder: (_) => SubjectTeacherProfilePage(
          teacherData: args is Map<String, dynamic> ? args : {},
        ),
      );
    }

    else if (routeName == settings) {
      return MaterialPageRoute(builder: (_) => const SettingsScreen());
    }

    // ---------------- TASKS & HOMEWORK ----------------

    else if (routeName == tasks) {
      return MaterialPageRoute(builder: (_) => const TasksListPage());
    }

    else if (routeName == taskDetails &&
        args is Map<String, dynamic> &&
        args['taskData'] != null) {
      return MaterialPageRoute(
        builder: (_) => TaskDetailsPage(taskData: args['taskData']),
      );
    }

    else if (routeName == homework) {
      return MaterialPageRoute(builder: (_) => const HomeworkListPage());
    }

    else if (routeName == homeworkDetails &&
        args is Map<String, dynamic> &&
        args['homeworkData'] != null) {
      return MaterialPageRoute(
        builder: (_) =>
            HomeworkDetailsPage(homeworkData: args['homeworkData']),
      );
    }

    else if (routeName == addHomework) {
      return MaterialPageRoute(builder: (_) => const AddHomeworkPage());
    }

    // ---------------- ATTENDANCE ----------------

    else if (routeName == takeAttendance) {
      return MaterialPageRoute(builder: (_) => const TakeAttendancePage());
    }

    else if (routeName == attendanceSummary) {
      return MaterialPageRoute(builder: (_) => const AttendanceSummaryPage());
    }

    else if (routeName == classAttendance && args is Map<String, dynamic>) {
      return MaterialPageRoute(
        builder: (_) => ClassAttendanceDetailPage(classData: args),
      );
    }

    // ---------------- NAVIGATION ----------------

    else if (routeName == schedule) {
      return MaterialPageRoute(builder: (_) => const WeeklySchedulePage());
    }

    else if (routeName == activity) {
      return MaterialPageRoute(builder: (_) => const ActivityPage());
    }

    else if (routeName == search) {
      return MaterialPageRoute(builder: (_) => const SearchPage());
    }

    else if (routeName == uploadGrades) {
      return MaterialPageRoute(builder: (_) => const UploadGradePage());
    }

    // ---------------- SEARCH ----------------

    else if (routeName == classSearch) {
      return MaterialPageRoute(builder: (_) => const ClassSearchPage());
    }

    else if (routeName == teacherSearch) {
      return MaterialPageRoute(builder: (_) => const TeacherSearchPage());
    }

    else if (routeName == studentSearch) {
      return MaterialPageRoute(builder: (_) => const StudentSearchPage());
    }

    // ---------------- DETAILS ----------------

    else if (routeName == classDetails && args is Map<String, dynamic>) {
      return MaterialPageRoute(
        builder: (_) => ClassDetailsPage(classData: args),
      );
    }

    else if (routeName == studentProfile && args is Map<String, dynamic>) {
      return MaterialPageRoute(
        builder: (_) => StudentProfilePage(studentData: args),
      );
    }

    else if (routeName == teacherProfile && args is Map<String, dynamic>) {
      return MaterialPageRoute(
        builder: (_) => TeacherProfilePage(teacherData: args),
      );
    }

    // ---------------- FALLBACK ----------------

    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(child: Text('Route not found')),
      ),
    );
  }
}
