import 'package:clean_arc/core/injection/injection_app.dart';
import 'package:clean_arc/features---or-----modules/technician/booking/presentation/manager/technician_booking_cubit.dart';
import 'package:clean_arc/features---or-----modules/technician/booking/presentation/manager/technician_booking_state.dart';
import 'package:clean_arc/features---or-----modules/technician/booking/presentation/widgets/technician_order_card.dart';
import 'package:clean_arc/features---or-----modules/technician/booking/presentation/widgets/technician_orders_header.dart';
import 'package:clean_arc/features---or-----modules/technician/booking/presentation/widgets/technician_orders_tabs.dart';
import 'package:clean_arc/features---or-----modules/technician/home/presentation/cubit/technician_home_cubit.dart';
import 'package:clean_arc/features---or-----modules/technician/home/presentation/cubit/technician_home_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/auth/presentation/cubit/auth_cubit.dart';
import '../../../../shared/auth/presentation/cubit/auth_state.dart';

class TechnicianOrdersView extends StatelessWidget {
  const TechnicianOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TechnicianBookingCubit>(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FB),
        body: BlocListener<TechnicianBookingCubit, TechnicianBookingState>(
          listener: (context, state) {
            if (state is TechnicianBookingStatusSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('status_updated_successfully'.tr()), backgroundColor: Colors.green),
              );
              // Re-fetch bookings
              final authState = context.read<AuthCubit>().state;
              if (authState is AuthAuthenticated) {
                context.read<TechnicianHomeCubit>().fetchBookings(authState.auth.userId);
              }
            } else if (state is TechnicianBookingStatusError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: Colors.red),
              );
            }
          },
          child: Column(
            children: [
              const TechnicianOrdersHeader(),
              const TechnicianOrdersTabs(),
              Expanded(
                child: BlocBuilder<TechnicianBookingCubit, TechnicianBookingState>(
                  buildWhen: (previous, current) => current is TechnicianBookingTabChanged,
                  builder: (context, bookingState) {
                    final selectedTabIndex = TechnicianBookingCubit.of(context).selectedTabIndex;
                    
                    return BlocBuilder<TechnicianHomeCubit, TechnicianHomeState>(
                      builder: (context, homeState) {
                        if (homeState is TechnicianHomeLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (homeState is TechnicianHomeError) {
                          return Center(child: Text(homeState.message));
                        } else if (homeState is TechnicianHomeSuccess) {
                          final filteredBookings = homeState.bookings.where((b) {
                            final status = b.status?.toLowerCase();
                            if (selectedTabIndex == 0) {
                              return status == 'pending';
                            } else {
                              return status == 'completed' || status == 'accepted';
                            }
                          }).toList();

                          if (filteredBookings.isEmpty) {
                            return Center(child: Text('no_orders'.tr()));
                          }

                          return ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            itemCount: filteredBookings.length,
                            itemBuilder: (context, index) {
                              final booking = filteredBookings[index];
                              return TechnicianOrderCard(
                                booking: booking,
                                showActions: selectedTabIndex == 0 || booking.status?.toLowerCase() == 'accepted',
                              );
                            },
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
