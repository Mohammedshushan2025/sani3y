import 'package:clean_arc/core/enums/booking_status.dart';
import 'package:clean_arc/features---or-----modules/technician/booking/domain/repo/technician_booking_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'technician_booking_state.dart';

class TechnicianBookingCubit extends Cubit<TechnicianBookingState> {
  final TechnicianBookingRepo _repo;
  int selectedTabIndex = 0;

  TechnicianBookingCubit(this._repo) : super(TechnicianBookingInitial());

  static TechnicianBookingCubit of(context) => BlocProvider.of<TechnicianBookingCubit>(context);

  void changeTab(int index) {
    selectedTabIndex = index;
    emit(TechnicianBookingTabChanged(index));
  }

  Future<void> updateBookingStatus(int bookingId, BookingStatus status) async {
    emit(TechnicianBookingStatusLoading(bookingId, status));
    final result = await _repo.updateBookingStatus(bookingId, status);
    result.fold(
      (failure) => emit(TechnicianBookingStatusError(failure.message)),
      (_) => emit(TechnicianBookingStatusSuccess(bookingId, status)),
    );
  }
}
