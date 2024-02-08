import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friend_chat/bloc/loginBloc/login_bloc.dart';
import 'package:friend_chat/firebase_options.dart';
import 'package:friend_chat/provider/login_provider.dart';
import 'package:friend_chat/repository/login_repository.dart';
import 'package:friend_chat/ui/app_theme.dart';
import 'package:friend_chat/ui/registration/registration_page.dart';
import 'package:friend_chat/utilities/app_strings.dart';

import 'bloc/theme/theme_cubit.dart';
import 'ui/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: true);

    return MaterialApp(
      theme: theme.isDark ? ThemeData.dark() : lightTheme,
      debugShowCheckedModeBanner: false,
      title: AppStrings.chattingApp,
      home: BlocProvider(
        create: (context) => LoginBloc(
          loginRepository: LoginRepository(
            loginProvider: LoginProvider(firebaseAuth: FirebaseAuth.instance),
          ),
        )..add(LoginVerified()),
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginFailure) {
              return LoginPage();
            } else if (state is LoginSuccess) {
              return RegistrationPage(authenticatedUser: state.user);
            } else if (state is LoginInProgress) {
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            return Text(AppStrings.loginFailed);
          },
        ),
      ),
    );
  }
}
