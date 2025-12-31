import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:toki/screens/class_teacher/settings_screen.dart';
import 'package:toki/screens/subject_teacher/activity_page.dart';
import 'package:toki/screens/subject_teacher/home_page.dart';
import 'package:toki/screens/subject_teacher/more_page.dart';
import 'package:toki/screens/subject_teacher/search_page.dart';
import '../../routes/subject_teacher_routes.dart';

class HomeSubjectTeacher extends ConsumerWidget {
  HomeSubjectTeacher({Key? key}) : super(key: key);

  final Color _primaryPurple = const Color(0xFF7C3AED);
  final List<Widget> subjectTeacherPages = [
    const HomePage(),
    const SearchPage(),
    const ActivityPage(),
    const MorePage()
  ];

  // ... (baaki upar ka code same hai)
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomnavIndex = ref.watch(subjectTecherBottomNavIndexProvider);
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar(ref),
      body: subjectTeacherPages[bottomnavIndex],
    );
  }

// ... (baaki saare widget functions same rahenge)
  Widget _buildBottomNavigationBar(WidgetRef ref) {
    final bottomnavIndex = ref.watch(subjectTecherBottomNavIndexProvider);
    return BottomNavigationBar(
      currentIndex: bottomnavIndex,
      onTap: (value) {
        ref.read(subjectTecherBottomNavIndexProvider.notifier).state = value;
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: _primaryPurple,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined), label: 'Activity'),
        BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
      ],
    );
  }
}

final subjectTecherBottomNavIndexProvider = StateProvider((ref) {
  return 0;
});
