import 'package:flutter/material.dart';
import 'package:clean_arc/core/routes/navigator_push.dart';
import 'package:clean_arc/features---or-----modules/shared/auth/presentation/views/login_view.dart';
import 'package:clean_arc/features---or-----modules/shared/auth/presentation/widgets/login_card.dart';
import 'package:clean_arc/features---or-----modules/shared/auth/presentation/widgets/login_header.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/presentation/widgets/technician_login_background.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/presentation/views/technician_register_view.dart';

class TechnicianLoginView extends StatefulWidget {
  const TechnicianLoginView({super.key});

  @override
  State<TechnicianLoginView> createState() => _TechnicianLoginViewState();
}

class _TechnicianLoginViewState extends State<TechnicianLoginView>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;

  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeIn);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ── Gradient background ──
          const TechnicianLoginBackground(),

          // ── Scrollable content ──
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SlideTransition(
                position: _slideAnim,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40),

                      // ── Header section ──
                      const LoginHeader(),

                      const SizedBox(height: 40),

                      // ── Card with form ──
                      LoginCard(
                        emailController: _emailController,
                        passwordController: _passwordController,
                        rememberMe: _rememberMe,
                        obscurePassword: _obscurePassword,
                        onRememberMeChanged: (val) =>
                            setState(() => _rememberMe = val ?? false),
                        onTogglePassword: () => setState(
                            () => _obscurePassword = !_obscurePassword),
                        onSignIn: _handleSignIn,
                        onTechnicianSignIn: _handleUserSignIn,
                        onSignUp: _handleSignUp,
                        onForgotPassword: _handleForgotPassword,
                        technicianToggleLabel: 'دخول كمستخدم',
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSignIn() {
    // Implement technician login logic
  }

  void _handleUserSignIn() {
    RouteManager.navigateReplacement(const LoginView());
  }

  void _handleSignUp() {
    RouteManager.navigateTo(const TechnicianRegisterView());
  }

  void _handleForgotPassword() {}
}
