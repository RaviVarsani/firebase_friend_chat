import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_event.dart';
part 'bottom_state.dart';

class BottomBloc extends Bloc<BottomEvent, BottomState> {
  BottomBloc() : super(BottomContact()) {
    on<BottomContactTapped>(_onContactTapped);
    on<BottomChatTapped>(_onChatTapped);
    on<BottomProfileTapped>(_onProfileTapped);
  }

  FutureOr<void> _onContactTapped(
      BottomContactTapped event, Emitter<BottomState> emit) {
    emit(BottomContact());
  }

  FutureOr<void> _onChatTapped(
      BottomChatTapped event, Emitter<BottomState> emit) {
    emit(BottomChat());
  }

  FutureOr<void> _onProfileTapped(
      BottomProfileTapped event, Emitter<BottomState> emit) {
    emit(BottomProfile());
  }
}
