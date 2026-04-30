import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repo/auth_repo.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _repo;

  AuthCubit(this._repo) : super(AuthInitial());

  static AuthCubit of(context) => BlocProvider.of<AuthCubit>(context);

  Future<void> checkAuth() async {
    emit(AuthLoading());
    final result = await _repo.getSavedAuth();
    result.fold(
      (failure) => emit(AuthUnauthenticated()),
      (auth) {
        if (auth != null) {
          emit(AuthAuthenticated(auth));
        } else {
          emit(AuthUnauthenticated());
        }
      },
    );
  }

  void loginSuccess(AuthEntity auth, {bool rememberMe = true}) {
    if (rememberMe) {
      _repo.saveAuth(auth);
    }
    emit(AuthAuthenticated(auth));
  }

  Future<void> logout() async {
    emit(AuthLoading());
    final result = await _repo.logout();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthUnauthenticated()),
    );
  }
}
