import 'package:clean_arc/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

// ════════════════════════════════════════════════
//  SETTINGS VIEW — صنايعي
// ════════════════════════════════════════════════

class ClientSettingsView extends StatelessWidget {
  const ClientSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ── Header ──
          SliverToBoxAdapter(child: _SettingsHeader()),

          // ── Profile card ──
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
            sliver: SliverToBoxAdapter(child: _ProfileCard()),
          ),

          // ── Account section ──
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
            sliver: SliverToBoxAdapter(
              child: _SettingsSection(
                title: 'الحساب',
                items: [
                  _SettingsItem(
                    icon: Icons.person_outline_rounded,
                    label: 'معلومات الملف الشخصي',
                    subtitle: 'تحديث بياناتك الشخصية',
                  ),
                  _SettingsItem(
                    icon: Icons.location_on_outlined,
                    label: 'العناوين المحفوظة',
                    subtitle: '3 عناوين محفوظة',
                  ),
                  _SettingsItem(
                    icon: Icons.notifications_outlined,
                    label: 'الإشعارات',
                    subtitle: 'إدارة تفضيلات الإشعارات',
                  ),
                ],
              ),
            ),
          ),

          // ── Payment section ──
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
            sliver: SliverToBoxAdapter(
              child: _SettingsSection(
                title: 'الدفع',
                items: [
                  _SettingsItem(
                    icon: Icons.credit_card_outlined,
                    label: 'وسائل الدفع',
                    subtitle: 'بطاقتان مضافتان',
                  ),
                ],
              ),
            ),
          ),

          // ── Support section ──
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
            sliver: SliverToBoxAdapter(
              child: _SettingsSection(
                title: 'الدعم',
                items: [
                  _SettingsItem(
                    icon: Icons.help_outline_rounded,
                    label: 'المساعدة والدعم',
                    subtitle: 'الحصول على مساعدة بشأن طلباتك',
                  ),
                  _SettingsItem(
                    icon: Icons.privacy_tip_outlined,
                    label: 'سياسة الخصوصية',
                    subtitle: 'اقرأ سياسة الخصوصية',
                  ),
                ],
              ),
            ),
          ),

          // ── Logout button ──
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
            sliver: SliverToBoxAdapter(child: _LogoutButton()),
          ),

          // ── Version ──
          const SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 20),
            sliver: SliverToBoxAdapter(child: _VersionLabel()),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Header (title only, no gradient panel here)
// ─────────────────────────────────────────────
class _SettingsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          20, MediaQuery.of(context).padding.top + 20, 20, 24),
      decoration: const BoxDecoration(
        gradient: AppColors.headerGradient,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: const Text('الإعدادات',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800)),
    );
  }
}

// ─────────────────────────────────────────────
// Profile card
// ─────────────────────────────────────────────
class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.violet, AppColors.teal],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.violet.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          const CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white24,
            child: Icon(Icons.person_rounded, color: Colors.white, size: 32),
          ),
          const SizedBox(width: 14),
          // User info
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('John Doe',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 4),
                Text('john.doe@email.com',
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
                SizedBox(height: 2),
                Text('+20 (555) 000-0000',
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
          // Edit button
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(10),
            ),
            child:
                const Icon(Icons.edit_outlined, color: Colors.white, size: 18),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Settings section (title + list of items)
// ─────────────────────────────────────────────
class _SettingsSection extends StatelessWidget {
  final String title;
  final List<_SettingsItem> items;

  const _SettingsSection({
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Padding(
          padding: const EdgeInsets.only(bottom: 10, right: 4),
          child: Text(title.toUpperCase(),
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textLight,
                  letterSpacing: 1.0)),
        ),
        // Items card
        Container(
          decoration: BoxDecoration(
            color: AppColors.cardWhite,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4))
            ],
          ),
          child: Column(
            children: [
              for (int i = 0; i < items.length; i++) ...[
                _SettingsItemTile(item: items[i]),
                if (i < items.length - 1)
                  const Divider(
                      height: 1, indent: 56, color: AppColors.divider),
              ]
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Settings item model
// ─────────────────────────────────────────────
class _SettingsItem {
  final IconData icon;
  final String label;
  final String subtitle;

  const _SettingsItem({
    required this.icon,
    required this.label,
    required this.subtitle,
  });
}

// ─────────────────────────────────────────────
// Settings item tile
// ─────────────────────────────────────────────
class _SettingsItemTile extends StatelessWidget {
  final _SettingsItem item;
  const _SettingsItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            // Icon container
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.violet.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(item.icon, color: AppColors.violet, size: 18),
            ),
            const SizedBox(width: 14),
            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.label,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark)),
                  const SizedBox(height: 2),
                  Text(item.subtitle,
                      style: const TextStyle(
                          fontSize: 11, color: AppColors.textLight)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded,
                color: AppColors.textLight, size: 20),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Logout button
// ─────────────────────────────────────────────
class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4))
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout_rounded, color: Color(0xFFFF6B6B), size: 20),
            SizedBox(width: 8),
            Text('تسجيل الخروج',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFF6B6B))),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Version label
// ─────────────────────────────────────────────
class _VersionLabel extends StatelessWidget {
  const _VersionLabel();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('الإصدار 1.0.0',
          style: TextStyle(fontSize: 12, color: AppColors.textLight)),
    );
  }
}
