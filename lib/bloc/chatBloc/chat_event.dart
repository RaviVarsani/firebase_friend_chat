import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatRequested extends ChatEvent {
  final String loginUID;

  ChatRequested({required this.loginUID});

  @override
  List<Object> get props => [loginUID];
}
