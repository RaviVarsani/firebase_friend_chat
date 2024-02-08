part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  RegistrationEvent();

  @override
  List<Object> get props => [];
}

class RegistrationDetailRequested extends RegistrationEvent {
  final String uid;

  RegistrationDetailRequested({required this.uid});

  @override
  List<Object> get props => [uid];
}

class RegistrationDetailUpdated extends RegistrationEvent {
  final UserModel user;

  RegistrationDetailUpdated({required this.user});

  @override
  List<Object> get props => [user];
}
