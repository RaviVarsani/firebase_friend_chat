import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friend_chat/utilities/app_assets.dart';
import 'package:friend_chat/utilities/app_strings.dart';
import 'package:lottie/lottie.dart';

import '../bloc/loginBloc/login_bloc.dart';
import '../bloc/theme/theme_cubit.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppStrings.loginPage),
        actions: [
          IconButton(
            onPressed: () {
              theme.changeTheme();
              print(theme);
            },
            icon: theme.isDark
                ? Icon(Icons.dark_mode_outlined)
                : Icon(Icons.light_mode_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(Assets.chatLottie),
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<LoginBloc>(context)
                        .add(LoginWithGooglePressed());
                  },
                  child: Container(
                    height: 48,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.withOpacity(.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(Assets.googleLogo, height: 30),
                        SizedBox(width: 15),
                        Text(
                          AppStrings.signInWithGoogle,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
