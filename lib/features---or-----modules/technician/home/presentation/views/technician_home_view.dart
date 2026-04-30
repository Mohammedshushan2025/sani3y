import 'package:easy_localization/easy_localization.dart';
import 'package:clean_arc/features---or-----modules/shared/auth/presentation/cubit/auth_cubit.dart';
import 'package:clean_arc/features---or-----modules/technician/home/presentation/cubit/technician_home_cubit.dart';
import 'package:clean_arc/features---or-----modules/technician/home/presentation/cubit/technician_home_state.dart';
import 'package:clean_arc/features---or-----modules/technician/home/presentation/widgets/order_item_card.dart';
import 'package:clean_arc/features---or-----modules/technician/home/presentation/widgets/summary_card.dart';
import 'package:clean_arc/features---or-----modules/technician/home/presentation/widgets/technician_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_arc/core/routes/navigator_push.dart';
import 'package:clean_arc/features---or-----modules/shared/auth/presentation/views/login_view.dart';

import '../../../../shared/auth/presentation/cubit/auth_state.dart';

class TechnicianHomeView extends StatelessWidget {
  const TechnicianHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: BlocBuilder<TechnicianHomeCubit, TechnicianHomeState>(
        builder: (context, state) {
          if (state is TechnicianHomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TechnicianHomeError) {
            return Center(child: Text(state.message));
          } else if (state is TechnicianHomeSuccess) {
            return _buildBody(context, state);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, TechnicianHomeSuccess state) {
    final filteredBookings = state.bookings.where((b) {
      if (b.bookingDate == null) return false;
      final bookingDate = DateTime.parse(b.bookingDate!);
      return bookingDate.year == state.selectedDate.year &&
          bookingDate.month == state.selectedDate.month &&
          bookingDate.day == state.selectedDate.day;
    }).toList();

    final bookingDates = state.bookings
        .where((b) => b.bookingDate != null)
        .map((b) => DateTime.parse(b.bookingDate!))
        .toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(context, state),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                TechnicianCalendar(
                  selectedDate: state.selectedDate,
                  onDateSelected: (date) {
                    TechnicianHomeCubit.of(context).updateSelectedDate(date);
                  },
                  bookingDates: bookingDates,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${DateFormat('MMMM d', context.locale.toString()).format(state.selectedDate)} ${'schedule'.tr()}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    Text(
                      '${filteredBookings.length} ${'orders'.tr()}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...filteredBookings.map((booking) => OrderItemCard(
                      title: (context.locale.languageCode == 'ar' 
                          ? booking.serviceDetails?.nameAr 
                          : booking.serviceDetails?.nameEn) ?? 'service'.tr(),
                      customerName: '${'customer'.tr()} #${booking.customer}',
                      time: booking.bookingTime ?? '9:00 AM',
                      price: '${booking.serviceDetails?.price ?? '0'} ${'currency'.tr()}',
                    )),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, TechnicianHomeSuccess state) {
    final authState = context.read<AuthCubit>().state;
    
    // Calculations
    final completedBookings = state.bookings.where((b) => b.status?.toLowerCase() == 'completed').toList();
    
    final totalCompletedCount = completedBookings.length;
    
    final totalEarnings = completedBookings.fold<double>(0, (sum, b) {
      final price = double.tryParse(b.serviceDetails?.price ?? '0') ?? 0.0;
      return sum + price;
    });

    final now = DateTime.now();
    final monthlyEarnings = completedBookings.where((b) {
      if (b.bookingDate == null) return false;
      try {
        final date = DateTime.parse(b.bookingDate!);
        return date.year == now.year && date.month == now.month;
      } catch (_) {
        return false;
      }
    }).fold<double>(0, (sum, b) {
      final price = double.tryParse(b.serviceDetails?.price ?? '0') ?? 0.0;
      return sum + price;
    });

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFF9D5C), Color(0xFFFFD3B0)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'welcome_back'.tr(),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    (authState is AuthAuthenticated) 
                      ? (authState.auth.fullName ?? 'technician'.tr())
                      : 'technician'.tr(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.notifications_none, color: Colors.white),
                  onPressed: () {
                    // AuthCubit.of(context).logout();
                    // RouteManager.navigateAndPopAll(const LoginView());
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              SummaryCard(
                icon: Icons.check_circle_outline,
                title: 'completed'.tr(),
                value: totalCompletedCount.toString(),
                subtitle: 'total_orders'.tr(),
              ),
              const SizedBox(width: 16),
                SummaryCard(
                  icon: Icons.monetization_on_outlined,
                  title: 'earnings'.tr(),
                  value: '${totalEarnings.toStringAsFixed(0)} ${'currency'.tr()}',
                  subtitle: '+${monthlyEarnings.toStringAsFixed(0)} ${'currency'.tr()} ${'this_month'.tr()}',
                ),
            ],
          ),
        ],
      ),
    );
  }
}
