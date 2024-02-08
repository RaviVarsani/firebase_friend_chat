import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:friend_chat/model/user_model.dart';
import 'package:friend_chat/repository/registration_repository.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final RegistrationRepository registrationRepository;

  RegistrationBloc({required this.registrationRepository})
      : super(RegistrationInitial()) {
    on<RegistrationDetailRequested>(_onRegistrationDetailRequestedToState);
    on<RegistrationDetailUpdated>(_onRegistrationUpdatedToState);
  }

  FutureOr<void> _onRegistrationDetailRequestedToState(
    RegistrationDetailRequested event,
    Emitter<RegistrationState> emit,
  ) async {
    try {
      emit(RegistrationInProgress());

      final user = await registrationRepository.getUserDetail(uid: event.uid);

      emit(
        user == null
            ? RegistrationActionFailure(message: 'user not found')
            : RegistrationDetailRequestSuccess(user: user),
      );
    } catch (e) {
      log(e.toString());

      emit(RegistrationActionError(message: 'Error occurred while searching'));
    }
  }

  FutureOr<void> _onRegistrationUpdatedToState(
      RegistrationDetailUpdated event, Emitter<RegistrationState> emit) async {
    try {
      emit(RegistrationInProgress());

      await registrationRepository.registerUserDetail(user: event.user);

      emit(RegistrationUpdateSuccess(user: event.user));
    } catch (e) {
      log(e.toString());

      emit(RegistrationActionError(message: 'Error occurred while updating'));
    }
  }
}
