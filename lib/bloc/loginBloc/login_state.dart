part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  final UserModel user;

  LoginSuccess({required this.user});
}

class LoginRemoveSuccess extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginFailure extends LoginState {}
