import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aqua_life/features/dashboard/presentation/view_model/dashboard_view_model.dart';
import 'package:aqua_life/features/home/presentation/pages/home_page.dart';
import 'package:aqua_life/app/theme/app_colors.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardViewModelProvider);
    final viewModel = ref.read(dashboardViewModelProvider.notifier);

    final List<Widget> pages = [
      const HomePage(),
      const Scaffold(
        backgroundColor: Color(0xFF0A1628),
        body: Center(child: Text("Connect View", style: TextStyle(color: Colors.white, fontSize: 18))),
      ),
      const Scaffold(
        backgroundColor: Color(0xFF0A1628),
        body: Center(child: Text("Jobs/Bag View", style: TextStyle(color: Colors.white, fontSize: 18))),
      ),
      const Scaffold(
        backgroundColor: Color(0xFF0A1628),
        body: Center(child: Text("Groups View", style: TextStyle(color: Colors.white, fontSize: 18))),
      ),
      const Scaffold(
        backgroundColor: Color(0xFF0A1628),
        body: Center(child: Text("Profile View", style: TextStyle(color: Colors.white, fontSize: 18))),
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0A1628),
      body: pages[state.currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Color(0xFF1E3A5C), width: 1),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFF112240),
          currentIndex: state.currentIndex,
          onTap: (index) => viewModel.updateCurrentIndex(index),
          selectedItemColor: AppColors.primaryBlue,
          unselectedItemColor: const Color(0xFF7AB8CC),
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_add_outlined),
              activeIcon: Icon(Icons.person_add),
              label: 'Connect',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.work_outline),
              activeIcon: Icon(Icons.work),
              label: 'Jobs',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.group_outlined),
              activeIcon: Icon(Icons.group),
              label: 'Groups',
            ),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                radius: 12,
                backgroundColor: const Color(0xFF1E3A5C),
                child: const Icon(Icons.person, size: 16, color: AppColors.primaryBlue),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
