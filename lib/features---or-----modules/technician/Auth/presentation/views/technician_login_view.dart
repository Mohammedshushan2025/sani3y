import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:clean_arc/core/routes/navigator_push.dart';
import 'package:clean_arc/features---or-----modules/shared/auth/presentation/views/login_view.dart';
import 'package:clean_arc/features---or-----modules/shared/auth/presentation/widgets/login_card.dart';
import 'package:clean_arc/features---or-----modules/shared/auth/presentation/widgets/login_header.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/presentation/widgets/technician_login_background.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/presentation/views/technician_register_view.dart';
import 'package:clean_arc/features---or-----modules/technician/home/presentation/views/technician_main_view.dart';
import 'package:clean_arc/features---or-----modules/shared/auth/presentation/cubit/auth_cubit.dart';
import 'package:clean_arc/features---or-----modules/shared/auth/presentation/cubit/login_cubit.dart';
import 'package:clean_arc/features---or-----modules/shared/auth/presentation/cubit/login_state.dart';
import 'package:clean_arc/core/injection/injection_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocProvider(
      create: (_) => getIt<LoginCubit>(),
      child: Scaffold(
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
                  child: BlocListener<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSuccess) {
                        AuthCubit.of(context).loginSuccess(state.auth);
                        RouteManager.navigateAndPopAll(const TechnicianMainView());
                      } else if (state is LoginError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message), backgroundColor: Colors.redAccent),
                        );
                      }
                    },
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
                          Builder(
                            builder: (context) => LoginCard(
                              emailController: _emailController,
                              passwordController: _passwordController,
                              rememberMe: _rememberMe,
                              obscurePassword: _obscurePassword,
                              onRememberMeChanged: (val) =>
                                  setState(() => _rememberMe = val ?? false),
                              onTogglePassword: () => setState(
                                  () => _obscurePassword = !_obscurePassword),
                              onSignIn: () => _handleSignIn(context),
                              onTechnicianSignIn: _handleUserSignIn,
                              onSignUp: _handleSignUp,
                              onForgotPassword: _handleForgotPassword,
                              technicianToggleLabel: 'login_as_user'.tr(),
                            ),
                          ),

                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // ── Language Toggle ──
            Positioned(
              top: 50,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextButton(
                  onPressed: () {
                    if (context.locale.languageCode == 'ar') {
                      context.setLocale(const Locale('en'));
                    } else {
                      context.setLocale(const Locale('ar'));
                    }
                  },
                  child: Text(
                    context.locale.languageCode == 'ar' ? 'EN' : 'AR',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSignIn(BuildContext context) {
    LoginCubit.of(context).login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  void _handleUserSignIn() {
    RouteManager.navigateReplacement(const LoginView());
  }

  void _handleSignUp() {
    RouteManager.navigateTo(const TechnicianRegisterView());
  }

  void _handleForgotPassword() {}
}
