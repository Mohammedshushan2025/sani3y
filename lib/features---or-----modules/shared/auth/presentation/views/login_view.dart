import 'package:clean_arc/core/routes/navigator_push.dart';
import 'package:clean_arc/features---or-----modules/client/nav_bar/presentation/views/main_nav_bar.dart';
import 'package:clean_arc/features---or-----modules/shared/auth/presentation/views/register_view.dart';
import 'package:flutter/material.dart';

import '../widgets/login_background.dart';
import '../widgets/login_card.dart';
import '../widgets/login_header.dart';
import 'package:clean_arc/core/routes/navigator_push.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/presentation/views/technician_login_view.dart';

// ════════════════════════════════════════════════
//  LOGIN VIEW — صنايعي
// ════════════════════════════════════════════════

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
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
          const LoginBackground(),

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
                        onTechnicianSignIn: _handleTechnicianSignIn,
                        onSignUp: _handleSignUp,
                        onForgotPassword: _handleForgotPassword,
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

  // ── Actions (navigate / call your BLoC/Cubit here) ──
  void _handleSignIn() {
    RouteManager.navigateTo(const MainNavView());
  }

  void _handleTechnicianSignIn() {
    RouteManager.navigateReplacement(const TechnicianLoginView());
  }

  void _handleSignUp() => RouteManager.navigateTo(const RegisterView());

  void _handleForgotPassword() {}
}
