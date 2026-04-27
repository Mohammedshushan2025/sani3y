import 'package:clean_arc/features---or-----modules/shared/auth/domain/entities/auth_entity.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final AuthEntity auth;
  LoginSuccess(this.auth);
}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}
