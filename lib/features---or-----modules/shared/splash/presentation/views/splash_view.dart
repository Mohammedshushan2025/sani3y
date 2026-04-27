import 'package:clean_arc/core/routes/navigator_push.dart';
import 'package:clean_arc/features---or-----modules/shared/auth/presentation/views/login_view.dart';
import 'package:clean_arc/features---or-----modules/shared/auth/presentation/cubit/auth_cubit.dart';
import 'package:clean_arc/features---or-----modules/shared/auth/presentation/cubit/auth_state.dart';
import 'package:clean_arc/features---or-----modules/technician/home/presentation/views/technician_home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/splash_background.dart';
import '../widgets/splash_loader.dart';
import '../widgets/splash_logo.dart';
import '../widgets/splash_tagline.dart';
import '../widgets/splash_title.dart';

// ════════════════════════════════════════════════
//  SPLASH VIEW — صنايعي
// ════════════════════════════════════════════════

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;
  late Animation<double> _slideAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _scaleAnim = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.8, curve: Curves.easeIn),
      ),
    );

    _slideAnim = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  void _onAnimationComplete(AuthState authState) {
    if (authState is AuthAuthenticated) {
      RouteManager.navigateAndPopAll(const TechnicianHomeView());
    } else {
      RouteManager.navigateAndPopAll(const LoginView());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {},
      child: Scaffold(
        body: SplashBackground(
          child: SafeArea(
            child: FutureBuilder(
                future: Future.delayed(const Duration(seconds: 4)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _onAnimationComplete(context.read<AuthCubit>().state);
                    });
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(flex: 2),
                      // ── Logo ──
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) => Transform.scale(
                          scale: _scaleAnim.value,
                          child: child,
                        ),
                        child: const SplashLogo(),
                      ),
                      const SizedBox(height: 28),
                      // ── App name ──
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) => Opacity(
                          opacity: _fadeAnim.value,
                          child: Transform.translate(
                            offset: Offset(0, _slideAnim.value),
                            child: child,
                          ),
                        ),
                        child: const SplashTitle(),
                      ),
                      const SizedBox(height: 12),
                      // ── Tagline ──
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) => Opacity(
                          opacity: _fadeAnim.value,
                          child: child,
                        ),
                        child: const SplashTagline(),
                      ),
                      const Spacer(flex: 2),
                      // ── Loading indicator ──
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) => Opacity(
                          opacity: _fadeAnim.value,
                          child: child,
                        ),
                        child: const SplashLoader(),
                      ),
                      const SizedBox(height: 48),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
