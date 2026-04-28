import 'package:clean_arc/core/errors/exceptions.dart';
import 'package:clean_arc/features---or-----modules/technician/booking/data/data_source/technician_booking_remote_data_source.dart';
import 'package:clean_arc/features---or-----modules/technician/booking/data/model/technician_booking_model.dart';
import 'package:clean_arc/features---or-----modules/technician/booking/domain/repo/technician_booking_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';

class TechnicianBookingRepoImpl implements TechnicianBookingRepo {
  final TechnicianBookingRemoteDataSource _dataSource;

  TechnicianBookingRepoImpl(this._dataSource);

  @override
  Future<Either<Failure, List<TechnicianBooking>>> getBookings(int userID) async {
    try {
      final result = await _dataSource.getBookings(userID);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.errorModel.message));
    } catch (e) {
      return const Left(ServerFailure(message: 'Something went wrong'));
    }
  }
}
