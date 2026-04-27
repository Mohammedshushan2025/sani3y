import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repo/auth_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo _repo;

  LoginCubit(this._repo) : super(LoginInitial());

  static LoginCubit of(context) => BlocProvider.of<LoginCubit>(context);

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    final result = await _repo.login(email: email, password: password);
    result.fold(
      (failure) => emit(LoginError(failure.message)),
      (auth) => emit(LoginSuccess(auth)),
    );
  }
}
