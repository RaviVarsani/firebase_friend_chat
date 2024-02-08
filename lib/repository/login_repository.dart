import 'package:friend_chat/model/user_model.dart';
import 'package:friend_chat/provider/login_provider.dart';

class LoginRepository {
  final LoginProvider loginProvider;

  LoginRepository({required this.loginProvider});

  Future<UserModel?> loginWithGoogle() async {
    final firebaseUser = await loginProvider.loginWithGoogle();
    return firebaseUser == null
        ? null
        : UserModel(
            uid: firebaseUser.uid,
            displayName: firebaseUser.displayName ?? '',
            email: firebaseUser.email ?? '',
            photoUrl: firebaseUser.photoURL ?? '',
          );
  }

  Stream<bool> isLoggedIn() {
    final streamOfUser = loginProvider.getLoggedInUserStates();
    return streamOfUser.map((user) => user != null);
  }

  Stream<UserModel?> getLoggedInUser() {
    final loggedInUserStream = loginProvider.getLoggedInUserStates();
    return loggedInUserStream.map((firebaseUser) {
      if (firebaseUser == null) {
        return null;
      } else {
        return UserModel(
          uid: firebaseUser.uid,
          displayName: firebaseUser.displayName ?? '',
          email: firebaseUser.email ?? '',
          photoUrl: firebaseUser.photoURL ?? '',
        );
      }
    });
  }

  Future<void> logOut() async {
    await loginProvider.logOut();
  }
}
