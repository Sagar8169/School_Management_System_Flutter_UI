import 'package:flutter/material.dart';
import '../screens/subject_teacher/home_subject_teacher.dart';
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

// Import the search and detail pages for subject teacher
import '../screens/subject_teacher/class_search_page.dart';
import '../screens/subject_teacher/teacher_search_page.dart';
import '../screens/subject_teacher/student_search_page.dart';
import '../screens/subject_teacher/class_details_page.dart';
import '../screens/subject_teacher/student_profile_page.dart';
import '../screens/subject_teacher/teacher_profile_page.dart';

class SubjectTeacherRoutes {
  // Route names
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

  // Search Routes
  static const String classSearch = '/subject-teacher/class-search';
  static const String teacherSearch = '/subject-teacher/teacher-search';
  static const String studentSearch = '/subject-teacher/student-search';

  // Detail Pages
  static const String classDetails = '/subject-teacher/class-details';
  static const String studentProfile = '/subject-teacher/student-profile';
  static const String teacherProfile = '/subject-teacher/teacher-profile';

  // Route generator method
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final String? routeName = routeSettings.name;
    final args = routeSettings.arguments;

    // Use if-else instead of switch to avoid constant expression error
    if (routeName == home) {
      return MaterialPageRoute(builder: (_) => const HomeSubjectTeacher());
    } else if (routeName == profile) {
      if (args is Map<String, dynamic>) {
        return MaterialPageRoute(
          builder: (_) => SubjectTeacherProfilePage(teacherData: args),
        );
      }
      return MaterialPageRoute(
        builder: (_) => SubjectTeacherProfilePage(
          teacherData: {
            'name': 'Mr. Vijay Prasad',
            'role': 'Science Teacher',
            'employeeId': 'ST2024',
            'department': 'Science',
            'type': 'teacher',
            'isActive': true,
            'assignedClass': '8B, 9A, 10C',
            'subjects': 'Science',
            'phone': '+91 98765 43210',
            'email': 'vijay.prasad@adityaschool.edu',
            'address': '123 Staff Quarters, School Campus',
            'joinDate': 'January 15, 2020',
            'workLocation': 'Main Campus',
          },
        ),
      );
    } else if (routeName == settings) {
      return MaterialPageRoute(builder: (_) => const SettingsScreen());
    } else if (routeName == tasks) {
      return MaterialPageRoute(builder: (_) => const TasksListPage());
    } else if (routeName == taskDetails) {
      if (args is Map<String, dynamic> && args['taskData'] is Map<String, dynamic>) {
        return MaterialPageRoute(
          builder: (_) => TaskDetailsPage(taskData: args['taskData']),
        );
      }
      return MaterialPageRoute(builder: (_) => const TasksListPage());
    } else if (routeName == homework) {
      return MaterialPageRoute(builder: (_) => const HomeworkListPage());
    } else if (routeName == homeworkDetails) {
      if (args is Map<String, dynamic> && args['homeworkData'] is Map<String, dynamic>) {
        return MaterialPageRoute(
          builder: (_) => HomeworkDetailsPage(homeworkData: args['homeworkData']),
        );
      }
      return MaterialPageRoute(builder: (_) => const HomeworkListPage());
    } else if (routeName == addHomework) {
      return MaterialPageRoute(builder: (_) => const AddHomeworkPage());
    } else if (routeName == takeAttendance) {
      return MaterialPageRoute(builder: (_) => const TakeAttendancePage());
    } else if (routeName == attendanceSummary) {
      return MaterialPageRoute(builder: (_) => const AttendanceSummaryPage());
    } else if (routeName == classAttendance) {
      if (args is Map<String, dynamic>) {
        return MaterialPageRoute(
          builder: (_) => ClassAttendanceDetailPage(classData: args),
        );
      }
      return MaterialPageRoute(builder: (_) => const AttendanceSummaryPage());
    } else if (routeName == schedule) {
      return MaterialPageRoute(builder: (_) => const WeeklySchedulePage());
    } else if (routeName == activity) {
      return MaterialPageRoute(builder: (_) => const ActivityPage());
    } else if (routeName == search) {
      return MaterialPageRoute(builder: (_) => const SearchPage());
    } else if (routeName == uploadGrades) {
      return MaterialPageRoute(builder: (_) => const UploadGradePage());
    } else if (routeName == classSearch) {
      return MaterialPageRoute(builder: (_) => const ClassSearchPage());
    } else if (routeName == teacherSearch) {
      return MaterialPageRoute(builder: (_) => const TeacherSearchPage());
    } else if (routeName == studentSearch) {
      return MaterialPageRoute(builder: (_) => const StudentSearchPage());
    } else if (routeName == classDetails) {
      if (args is Map<String, dynamic>) {
        return MaterialPageRoute(
          builder: (_) => ClassDetailsPage(classData: args),
        );
      }
      return MaterialPageRoute(
        builder: (_) => ClassDetailsPage(classData: {
          'className': 'Class 8A',
          'section': 'Section A',
          'teacher': 'Not Assigned',
        }),
      );
    } else if (routeName == studentProfile) {
      if (args is Map<String, dynamic>) {
        return MaterialPageRoute(
          builder: (_) => StudentProfilePage(studentData: args),
        );
      }
      return MaterialPageRoute(
        builder: (_) => StudentProfilePage(studentData: {
          'name': 'Student Name',
          'grade': 'Class 8A',
          'id': 'STU-2023-001',
          'avgGrade': 75.0,
          'attendance': 85.0,
          'status': 'Normal',
          'isCritical': false,
        }),
      );
    } else if (routeName == teacherProfile) {
      if (args is Map<String, dynamic>) {
        return MaterialPageRoute(
          builder: (_) => TeacherProfilePage(teacherData: args),
        );
      }
      return MaterialPageRoute(
        builder: (_) => TeacherProfilePage(teacherData: {
          'name': 'Teacher Name',
          'subject': 'Mathematics',
          'role': 'Class Teacher',
          'classes': '8A, 9A',
          'experience': '8 years',
          'isClassTeacher': true,
        }),
      );
    }

    // Fallback route
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text('Route not found: $routeName'),
        ),
      ),
    );
  }
}