import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:friend_chat/model/user_model.dart';
import 'package:friend_chat/repository/login_repository.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.loginRepository}) : super(LoginInitial()) {
    on<LoginWithGooglePressed>(_onLoginWithGoogle);
    on<LoginVerified>(_onLoginVerified);
    on<LoginStateChanged>(_onLoginStateChanged);
    on<LoginRemoved>(_onLoginRemoved);
  }

  final LoginRepository loginRepository;
  late StreamSubscription isLoginStates;

  @override
  Future<void> close() {
    isLoginStates.cancel();
    return super.close();
  }

  Future<void> _onLoginWithGoogle(
      LoginWithGooglePressed event, Emitter<LoginState> emit) async {
    try {
      emit(LoginInProgress());

      final authenticatedUser = await loginRepository.loginWithGoogle();

      log('${authenticatedUser?.displayName}');
      emit(
        authenticatedUser == null
            ? LoginFailure()
            : LoginSuccess(user: authenticatedUser),
      );
    } catch (any) {
      log(any.toString());
      emit(LoginFailure());
    }
  }

  void _onLoginVerified(LoginVerified event, Emitter<LoginState> emit) {
    try {
      emit(LoginInProgress());

      isLoginStates = loginRepository.getLoggedInUser().listen((user) {
        add(LoginStateChanged(user: user));
      });
    } catch (e) {
      log(e.toString());
      emit(LoginFailure());
    }
  }

  FutureOr<void> _onLoginStateChanged(
      LoginStateChanged event, Emitter<LoginState> emit) {
    final user = event.user;

    emit(user == null ? LoginFailure() : LoginSuccess(user: user));
  }

  FutureOr<void> _onLoginRemoved(
      LoginRemoved event, Emitter<LoginState> emit) async {
    try {
      emit(LoginInProgress());

      await loginRepository.logOut();
    } catch (e) {
      log(e.toString());
      LoginFailure();
    }
  }
}
