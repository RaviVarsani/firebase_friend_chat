part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginWithGooglePressed extends LoginEvent {}

class LoginVerified extends LoginEvent {}

class LoginStateChanged extends LoginEvent {
  final UserModel? user;

  LoginStateChanged({this.user});
}

class LoginRemoved extends LoginEvent {}
