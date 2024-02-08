part of 'bottom_bloc.dart';

abstract class BottomState extends Equatable {
  const BottomState();

  @override
  List<Object> get props => [];
}

class BottomContact extends BottomState {}

class BottomChat extends BottomState {}

class BottomProfile extends BottomState {}
