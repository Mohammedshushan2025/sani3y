import 'package:clean_arc/core/theme/app_colors.dart';
import 'package:clean_arc/features---or-----modules/client/client_favorites/presentation/views/client_favorites.dart';
import 'package:clean_arc/features---or-----modules/client/client_home/presentation/views/client_home.dart';
import 'package:clean_arc/features---or-----modules/client/client_orders/presentation/views/client_orders.dart';
import 'package:clean_arc/features---or-----modules/client/client_settings/presentation/views/client_settings.dart';
import 'package:flutter/material.dart';

// ════════════════════════════════════════════════
//  MAIN NAVIGATION — صنايعي
//  Entry point that hosts the bottom nav bar
//  and switches between the 4 main screens.
// ════════════════════════════════════════════════

class MainNavView extends StatefulWidget {
  const MainNavView({super.key});

  @override
  State<MainNavView> createState() => _MainNavViewState();
}

class _MainNavViewState extends State<MainNavView> {
  int _currentIndex = 0;

  // ── Screens list — add / reorder here only ──
  final List<Widget> _screens = const [
    ClientHomeView(),
    ClientOrdersView(),
    ClientFavoritesView(),
    ClientSettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: _AppBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Bottom navigation bar widget
// ─────────────────────────────────────────────
class _AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _AppBottomNavBar({
    required this.currentIndex,
    required this.onTap,
  });

  // ── Nav items definition ──
  static const List<_NavItem> _items = [
    _NavItem(
        label: 'الرئيسية',
        icon: Icons.home_outlined,
        activeIcon: Icons.home_rounded),
    _NavItem(
        label: 'طلباتي',
        icon: Icons.receipt_long_outlined,
        activeIcon: Icons.receipt_long_rounded),
    _NavItem(
        label: 'المفضلة',
        icon: Icons.favorite_border_rounded,
        activeIcon: Icons.favorite_rounded),
    _NavItem(
        label: 'الإعدادات',
        icon: Icons.settings_outlined,
        activeIcon: Icons.settings_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 64,
          child: Row(
            children: List.generate(
              _items.length,
              (i) => _NavBarItem(
                item: _items[i],
                isActive: currentIndex == i,
                onTap: () => onTap(i),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Single nav bar item
// ─────────────────────────────────────────────
class _NavItem {
  final String label;
  final IconData icon;
  final IconData activeIcon;

  const _NavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });
}

class _NavBarItem extends StatelessWidget {
  final _NavItem item;
  final bool isActive;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ── Animated icon with indicator dot ──
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: isActive
                  ? BoxDecoration(
                      color: AppColors.violet.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    )
                  : null,
              child: Icon(
                isActive ? item.activeIcon : item.icon,
                size: 24,
                color: isActive ? AppColors.violet : AppColors.textLight,
              ),
            ),
            const SizedBox(height: 2),
            // ── Label ──
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: TextStyle(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
                color: isActive ? AppColors.violet : AppColors.textLight,
              ),
              child: Text(item.label),
            ),
          ],
        ),
      ),
    );
  }
}
