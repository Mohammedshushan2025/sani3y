import 'package:clean_arc/features---or-----modules/technician/booking/domain/repo/technician_booking_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'technician_home_state.dart';

class TechnicianHomeCubit extends Cubit<TechnicianHomeState> {
  final TechnicianBookingRepo _repo;

  TechnicianHomeCubit(this._repo) : super(TechnicianHomeInitial());

  static TechnicianHomeCubit of(context) => BlocProvider.of<TechnicianHomeCubit>(context);

  Future<void> fetchBookings(int userID) async {
    emit(TechnicianHomeLoading());
    final result = await _repo.getBookings(userID);
    result.fold(
      (failure) => emit(TechnicianHomeError(failure.message)),
      (bookings) => emit(TechnicianHomeSuccess(
        bookings: bookings,
        selectedDate: DateTime.now(),
      )),
    );
  }

  void updateSelectedDate(DateTime date) {
    if (state is TechnicianHomeSuccess) {
      final successState = state as TechnicianHomeSuccess;
      emit(successState.copyWith(selectedDate: date));
    }
  }
}
