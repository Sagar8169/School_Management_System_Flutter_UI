import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:toki_principal/screens/principal/activity_page.dart';
import 'package:toki_principal/screens/principal/more_page.dart';
import 'package:toki_principal/screens/principal/principal_home_page.dart';
import 'package:toki_principal/screens/principal/search_page.dart';

const Color themeBlue = Color(0xFF1E3A8A);
const Color themeLightBlue = Color(0xFF3B82F6);
const Color themeGreen = Color(0xFF059669);
const Color backgroundSlate = Color(0xFFF8FAFC);

class HomePrincipal extends ConsumerWidget {
  HomePrincipal({super.key});
  // void _onBottomNavTap(int index) {
  //   switch (index) {
  //     case 0:
  //       Navigator.pushReplacementNamed(context, PrincipalRoutes.home);
  //       break;
  //     case 1:
  //       Navigator.pushReplacementNamed(context, PrincipalRoutes.search);
  //       break;
  //     case 2:
  //       Navigator.pushReplacementNamed(context, PrincipalRoutes.activity);
  //       break;
  //     case 3:
  //       Navigator.pushReplacementNamed(
  //         context,
  //         PrincipalRoutes.morePage,
  //         arguments: {'section': null},
  //       );
  //       break;
  //   }
  // }

  final List<Widget> pages = [
    PrincipalHomePage(),
    SearchPage(),
    ActivityPage(),
    MorePage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navindex = ref.watch(principalBottomNavIndexProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[navindex],
      bottomNavigationBar: _buildBottomNav(ref),
    );
  }

  Widget _buildBottomNav(WidgetRef ref) {
    final navindex = ref.watch(principalBottomNavIndexProvider);
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xFFF1F5F9),
            width: 2,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: navindex,

        // ✅ CORRECT onTap (int only)
        onTap: (value) {
          ref.read(principalBottomNavIndexProvider.notifier).state = value;
        },

        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: themeBlue,
        unselectedItemColor: const Color(0xFF94A3B8),
        elevation: 0,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_rounded),
            label: "Activity",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: "More",
          ),
        ],
      ),
    );
  }
}

final principalBottomNavIndexProvider = StateProvider((ref) {
  return 0;
});
