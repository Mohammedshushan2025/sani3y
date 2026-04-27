import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_arc/core/injection/injection_app.dart';
import 'package:clean_arc/core/routes/navigator_push.dart';
import 'package:clean_arc/core/validation/validations.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/presentation/cubit/technician_register_cubit.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/presentation/cubit/technician_register_state.dart';
import 'package:clean_arc/features---or-----modules/technician/home/presentation/views/technician_home_view.dart';
import 'package:clean_arc/features---or-----modules/shared/auth/presentation/cubit/auth_cubit.dart';
import '../widgets/register_background.dart';
import '../widgets/register_form_card.dart';
import '../widgets/register_header.dart';

// ════════════════════════════════════════════════
//  TECHNICIAN REGISTER VIEW — صنايعي
// ════════════════════════════════════════════════

class TechnicianRegisterView extends StatefulWidget {
  const TechnicianRegisterView({super.key});

  @override
  State<TechnicianRegisterView> createState() => _TechnicianRegisterViewState();
}

class _TechnicianRegisterViewState extends State<TechnicianRegisterView>
    with SingleTickerProviderStateMixin {
  // ── Controllers ───────────────────────────────
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _governorateController = TextEditingController();
  final _cityController = TextEditingController();
  final _ageController = TextEditingController();

  // ── UI state ──────────────────────────────────
  bool _obscurePassword = true;
  int? _selectedCategoryId;
  final Map<String, String?> _fieldErrors = {};

  // ── Animation ─────────────────────────────────
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
    _fadeAnim =
        CurvedAnimation(parent: _animController, curve: Curves.easeIn);
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
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _governorateController.dispose();
    _cityController.dispose();
    _ageController.dispose();
    _animController.dispose();
    super.dispose();
  }

  // ── Validate all fields ───────────────────────
  bool _validate() {
    final errors = <String, String?>{
      'fullName': AppValidations.validateFullName(_fullNameController.text),
      'email': AppValidations.validateEmail(_emailController.text),
      'password': AppValidations.validatePassword(_passwordController.text),
      'phone': AppValidations.validatePhone(_phoneController.text),
      'governorate': AppValidations.validateRequired(
          _governorateController.text,
          fieldName: 'المحافظة'),
      'city': AppValidations.validateRequired(_cityController.text,
          fieldName: 'المدينة'),
      'age': AppValidations.validateAge(_ageController.text),
      'category': _selectedCategoryId == null ? 'يرجى اختيار التخصص' : null,
    };

    setState(() {
      _fieldErrors
        ..clear()
        ..addAll(errors);
    });

    return errors.values.every((e) => e == null);
  }

  // ── Submit handler ────────────────────────────
  void _handleRegister(TechnicianRegisterCubit cubit) {
    if (!_validate()) return;
    cubit.register(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      fullName: _fullNameController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      governorate: _governorateController.text.trim(),
      city: _cityController.text.trim(),
      age: _ageController.text.trim(),
      categoryId: _selectedCategoryId!,
    );
  }

  // ── Build ─────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TechnicianRegisterCubit>()..fetchCategories(),
      child: Scaffold(
        body: Stack(
          children: [
            // ── Gradient background ──
            const RegisterBackground(),

            // ── Scrollable content ──
            SafeArea(
              child: FadeTransition(
                opacity: _fadeAnim,
                child: SlideTransition(
                  position: _slideAnim,
                  child: BlocConsumer<TechnicianRegisterCubit,
                      TechnicianRegisterState>(
                    listener: (context, state) {
                      if (state is RegisterSuccessState) {
                        // Establish global auth session
                        AuthCubit.of(context).loginSuccess(state.auth);

                        // Show brief success toast then navigate
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: const Color(0xFF6C63FF),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                        Future.delayed(const Duration(milliseconds: 600), () {
                          RouteManager.navigateAndPopAll(
                              const TechnicianHomeView());
                        });
                      } else if (state is RegisterErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.redAccent,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      final cubit = TechnicianRegisterCubit.of(context);
                      return SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 40),

                            // ── Header ──
                            const RegisterHeader(),

                            const SizedBox(height: 32),

                            // ── Form card ──
                            RegisterFormCard(
                              fullNameController: _fullNameController,
                              emailController: _emailController,
                              passwordController: _passwordController,
                              phoneController: _phoneController,
                              governorateController: _governorateController,
                              cityController: _cityController,
                              ageController: _ageController,
                              obscurePassword: _obscurePassword,
                              onTogglePassword: () => setState(
                                  () => _obscurePassword = !_obscurePassword),
                              selectedCategoryId: _selectedCategoryId,
                              onCategoryChanged: (val) =>
                                  setState(() => _selectedCategoryId = val),
                              onSubmit: () => _handleRegister(cubit),
                              fieldErrors: _fieldErrors,
                            ),

                            const SizedBox(height: 24),

                            // ── Already have account ──
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'لديك حساب بالفعل؟ ',
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 14),
                                ),
                                GestureDetector(
                                  onTap: () => RouteManager.pop(),
                                  child: const Text(
                                    'تسجيل الدخول',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 40),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
