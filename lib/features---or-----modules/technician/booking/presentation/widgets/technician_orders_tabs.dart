import 'package:clean_arc/features---or-----modules/technician/booking/presentation/manager/technician_booking_cubit.dart';
import 'package:clean_arc/features---or-----modules/technician/booking/presentation/manager/technician_booking_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TechnicianOrdersTabs extends StatelessWidget {
  const TechnicianOrdersTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TechnicianBookingCubit, TechnicianBookingState>(
      buildWhen: (previous, current) => current is TechnicianBookingTabChanged,
      builder: (context, state) {
        final cubit = TechnicianBookingCubit.of(context);
        return Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: _TabItem(
                  index: 0,
                  title: 'pending_approval'.tr(),
                  icon: Icons.access_time,
                  isSelected: cubit.selectedTabIndex == 0,
                  onTap: () => cubit.changeTab(0),
                ),
              ),
              Expanded(
                child: _TabItem(
                  index: 1,
                  title: 'completed'.tr(),
                  icon: Icons.check_circle_outline,
                  isSelected: cubit.selectedTabIndex == 1,
                  onTap: () => cubit.changeTab(1),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TabItem extends StatelessWidget {
  final int index;
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItem({
    required this.index,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF5ED) : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? Colors.orange : Colors.grey, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.orange : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
