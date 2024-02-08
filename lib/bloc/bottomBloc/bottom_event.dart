part of 'bottom_bloc.dart';

abstract class BottomEvent extends Equatable {
  const BottomEvent();

  @override
  List<Object> get props => [];
}

class BottomContactTapped extends BottomEvent {}

class BottomChatTapped extends BottomEvent {}

class BottomProfileTapped extends BottomEvent {}
