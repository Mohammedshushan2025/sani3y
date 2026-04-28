import 'package:clean_arc/features---or-----modules/technician/home/presentation/views/technician_home_view.dart';
import 'package:clean_arc/features---or-----modules/technician/settings/presentation/views/technician_settings_view.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class TechnicianMainView extends StatefulWidget {
  const TechnicianMainView({super.key});

  @override
  State<TechnicianMainView> createState() => _TechnicianMainViewState();
}

class _TechnicianMainViewState extends State<TechnicianMainView> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const TechnicianHomeView(),
    Scaffold(body: Center(child: Text('orders'.tr()))),
    const TechnicianSettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            backgroundColor: Colors.white,
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                activeIcon: const Icon(Icons.home),
                label: 'home'.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.shopping_bag_outlined),
                activeIcon: const Icon(Icons.shopping_bag),
                label: 'orders'.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings_outlined),
                activeIcon: const Icon(Icons.settings),
                label: 'settings'.tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
