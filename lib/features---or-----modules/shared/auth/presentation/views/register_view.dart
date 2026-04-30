import 'package:clean_arc/core/routes/navigator_push.dart';
import 'package:flutter/material.dart';

import '../widgets/login_background.dart';
import '../widgets/register_card.dart';
import '../widgets/register_header.dart';

// ════════════════════════════════════════════════
//  REGISTER VIEW — صنايعي
// ════════════════════════════════════════════════

enum UserType { customer, technician }

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView>
    with SingleTickerProviderStateMixin {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  UserType _selectedUserType = UserType.customer;

  // TODO: Replace with data from API
  final List<Map<String, String>> _categories = [
    {'id': '1', 'name': 'سباكة'},
    {'id': '2', 'name': 'كهرباء'},
    {'id': '3', 'name': 'نجارة'},
    {'id': '4', 'name': 'نقاشة'},
  ];
  String? _selectedCategoryId;

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
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const LoginBackground(),
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
                      const SizedBox(height: 36),

                      // ── Header ──
                      const RegisterHeader(),

                      const SizedBox(height: 32),

                      // ── Form card ──
                      RegisterCard(
                        nameController: _nameController,
                        emailController: _emailController,
                        phoneController: _phoneController,
                        passwordController: _passwordController,
                        confirmPasswordController: _confirmPasswordController,
                        obscurePassword: _obscurePassword,
                        obscureConfirmPassword: _obscureConfirmPassword,
                        selectedUserType: _selectedUserType,
                        categories: _categories,
                        selectedCategoryId: _selectedCategoryId,
                        onTogglePassword: () => setState(
                            () => _obscurePassword = !_obscurePassword),
                        onToggleConfirmPassword: () => setState(() =>
                            _obscureConfirmPassword = !_obscureConfirmPassword),
                        onUserTypeChanged: (type) =>
                            setState(() => _selectedUserType = type),
                        onCategoryChanged: (categoryId) =>
                            setState(() => _selectedCategoryId = categoryId),
                        onCreateAccount: _handleCreateAccount,
                        onSignIn: _handleSignIn,
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

  void _handleCreateAccount() {}
  void _handleSignIn() {
    RouteManager.pop();
  }
}
