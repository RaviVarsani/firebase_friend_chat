part of 'contact_bloc.dart';

abstract class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object> get props => [];
}

class ContactInitial extends ContactState {}

class ContactLoadInProgress extends ContactState {}

class ContactLoadFailure extends ContactState {
  final String msg;

  const ContactLoadFailure({required this.msg});
}

class ContactLoadSuccess extends ContactState {
  final List<UserModel> contacts;

  const ContactLoadSuccess({required this.contacts});
}
