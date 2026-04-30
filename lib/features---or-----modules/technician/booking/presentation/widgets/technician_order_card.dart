import 'package:clean_arc/core/enums/booking_status.dart';
import 'package:clean_arc/features---or-----modules/technician/booking/data/model/technician_booking_model.dart';
import 'package:clean_arc/features---or-----modules/technician/booking/presentation/manager/technician_booking_cubit.dart';
import 'package:clean_arc/features---or-----modules/technician/booking/presentation/manager/technician_booking_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TechnicianOrderCard extends StatelessWidget {
  final TechnicianBooking booking;
  final bool showActions;

  const TechnicianOrderCard({
    super.key,
    required this.booking,
    this.showActions = false,
  });

  @override
  Widget build(BuildContext context) {
    final service = booking.serviceDetails;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  (context.locale.languageCode == 'ar' ? service?.nameAr : service?.nameEn) ?? '',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                '${service?.price ?? '0'} ${'currency'.tr()}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            booking.status?.tr() ?? 'pending_approval'.tr(),
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          const SizedBox(height: 20),
          _InfoRow(icon: Icons.person_outline, text: 'Sarah Miller'), // Placeholder name
          _InfoRow(icon: Icons.phone_outlined, text: '+1 (555) 123-4567', color: const Color(0xFF48CAE4)),
          _InfoRow(icon: Icons.calendar_today_outlined, text: '${booking.bookingDate} at ${booking.bookingTime}'),
          _InfoRow(icon: Icons.location_on_outlined, text: '${booking.streetAddress}, ${booking.city}'),
          const SizedBox(height: 20),
          _NotesSection(notes: service?.description ?? ''),
          if (showActions) ...[
            const SizedBox(height: 20),
            BlocBuilder<TechnicianBookingCubit, TechnicianBookingState>(
              builder: (context, state) {
                final isLoading = state is TechnicianBookingStatusLoading && state.bookingId == booking.id;
                
                if (booking.status?.toLowerCase() == 'accepted') {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : () {
                        TechnicianBookingCubit.of(context).updateBookingStatus(booking.id!, BookingStatus.completed);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 0,
                      ),
                      child: isLoading 
                        ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : Text('mark_as_completed'.tr()),
                    ),
                  );
                }

                return Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: isLoading ? null : () {
                          TechnicianBookingCubit.of(context).updateBookingStatus(booking.id!, BookingStatus.rejected);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          side: BorderSide(color: Colors.grey[300]!),
                        ),
                        child: Text('decline'.tr(), style: const TextStyle(color: Colors.black)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: isLoading ? null : () {
                          TechnicianBookingCubit.of(context).updateBookingStatus(booking.id!, BookingStatus.accepted);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          elevation: 0,
                        ),
                        child: isLoading 
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : Text('accept'.tr()),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? color;

  const _InfoRow({required this.icon, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: color ?? Colors.grey[800], fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotesSection extends StatelessWidget {
  final String notes;

  const _NotesSection({required this.notes});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'customer_notes'.tr(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            notes.isEmpty ? 'no_notes_provided'.tr() : notes,
            style: TextStyle(color: Colors.grey[600], fontSize: 13),
          ),
        ],
      ),
    );
  }
}
