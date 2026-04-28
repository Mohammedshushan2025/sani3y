import 'package:clean_arc/core/routes/navigator_push.dart';
import 'package:clean_arc/features---or-----modules/shared/auth/presentation/cubit/auth_cubit.dart';
import 'package:clean_arc/features---or-----modules/shared/auth/presentation/views/login_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TechnicianSettingsView extends StatelessWidget {
  const TechnicianSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        title: Text(
          'settings'.tr(),
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildSectionTitle('language'.tr()),
            const SizedBox(height: 12),
            _buildLanguageCard(context),
            const SizedBox(height: 32),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  Widget _buildLanguageCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildLanguageOption(
            context,
            title: 'English',
            locale: const Locale('en'),
            isSelected: context.locale.languageCode == 'en',
          ),
          Divider(height: 1, color: Colors.grey[100], indent: 20, endIndent: 20),
          _buildLanguageOption(
            context,
            title: 'العربية',
            locale: const Locale('ar'),
            isSelected: context.locale.languageCode == 'ar',
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context, {
    required String title,
    required Locale locale,
    required bool isSelected,
  }) {
    return ListTile(
      onTap: () => context.setLocale(locale),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Colors.orange : Colors.black,
        ),
      ),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: Colors.orange)
          : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => _handleLogout(context),
        icon: const Icon(Icons.logout_rounded, color: Colors.white),
        label: Text(
          'logout'.tr(), // I'll add this key
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
      ),
    );
  }

  void _handleLogout(BuildContext context) {
    AuthCubit.of(context).logout();
    RouteManager.navigateAndPopAll(const LoginView());
  }
}
