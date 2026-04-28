import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/domain/entities/category_entity.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/presentation/cubit/technician_register_cubit.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/presentation/cubit/technician_register_state.dart';

// ════════════════════════════════════════════════
//  REGISTER DROPDOWN FIELD
//  Matches AppTextField visual style.
//  Shows a loader while categories are fetching
//  and an error + retry on failure.
// ════════════════════════════════════════════════

class RegisterDropdownField extends StatelessWidget {
  final int? selectedCategoryId;
  final ValueChanged<int?> onChanged;

  const RegisterDropdownField({
    super.key,
    required this.selectedCategoryId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TechnicianRegisterCubit, TechnicianRegisterState>(
      buildWhen: (prev, curr) =>
          curr is CategoriesLoadingState ||
          curr is CategoriesSuccessState ||
          curr is CategoriesErrorState,
      builder: (context, state) {
        final cubit = TechnicianRegisterCubit.of(context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Label ──
            Text(
              'category'.tr(),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF444444),
              ),
            ),
            const SizedBox(height: 8),

            // ── Loading ──
            if (state is CategoriesLoadingState)
              _loadingWidget()

            // ── Error + retry ──
            else if (state is CategoriesErrorState)
              _errorWidget(state.message, cubit)

            // ── Dropdown ──
            else
              _dropdownWidget(context, cubit.categories),
          ],
        );
      },
    );
  }

  Widget _loadingWidget() => Container(
        height: 52,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5FA),
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Center(
          child: SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Color(0xFF6C63FF),
            ),
          ),
        ),
      );

  Widget _errorWidget(String message, TechnicianRegisterCubit cubit) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: const TextStyle(color: Colors.redAccent, fontSize: 12),
          ),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: cubit.fetchCategories,
            child: Text(
              'retry'.tr(),
              style: const TextStyle(
                color: Color(0xFF6C63FF),
                fontSize: 13,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
                decorationColor: Color(0xFF6C63FF),
              ),
            ),
          ),
        ],
      );

  Widget _dropdownWidget(
      BuildContext context, List<CategoryEntity> categories) {
    return DropdownButtonFormField<int>(
      value: selectedCategoryId,
      onChanged: onChanged,
      hint: Text(
        'select_category'.tr(),
        style: const TextStyle(color: Color(0xFFAAAAAA), fontSize: 14),
      ),
      icon: const Icon(Icons.keyboard_arrow_down_rounded,
          color: Color(0xFF6C63FF)),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.build_outlined,
            color: Color(0xFF6C63FF), size: 20),
        filled: true,
        fillColor: const Color(0xFFF5F5FA),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide:
              const BorderSide(color: Color(0xFF6C63FF), width: 1.5),
        ),
      ),
      items: categories
          .map(
            (cat) => DropdownMenuItem<int>(
              value: cat.id,
              child: Text(
                context.locale.languageCode == 'ar' ? cat.nameAr : cat.nameEn,
                style: const TextStyle(
                    fontSize: 14, color: Color(0xFF222222)),
              ),
            ),
          )
          .toList(),
    );
  }
}
