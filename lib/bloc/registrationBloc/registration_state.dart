part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  RegistrationState();

  @override
  List<Object> get props => [];
}

class RegistrationInitial extends RegistrationState {}

class RegistrationUpdateSuccess extends RegistrationState {
  final UserModel user;

  RegistrationUpdateSuccess({required this.user});
}

class RegistrationDetailRequestSuccess extends RegistrationState {
  final UserModel user;

  RegistrationDetailRequestSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class RegistrationActionFailure extends RegistrationState {
  final String message;

  RegistrationActionFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class RegistrationActionError extends RegistrationState {
  final String message;

  RegistrationActionError({required this.message});

  @override
  List<Object> get props => [message];
}

class RegistrationInProgress extends RegistrationState {}
