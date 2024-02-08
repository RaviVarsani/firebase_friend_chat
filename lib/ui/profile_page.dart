// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friend_chat/model/user_model.dart';
import 'package:friend_chat/utilities/app_colors.dart';
import 'package:friend_chat/utilities/app_strings.dart';
import 'package:friend_chat/widget/text_field.dart';

import '../bloc/loginBloc/login_bloc.dart';

class ProfilePage extends StatelessWidget {
  final UserModel authenticatedUser;

  ProfilePage({Key? key, required this.authenticatedUser}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = authenticatedUser.displayName;
    emailController.text = authenticatedUser.email;

    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 220,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(.7),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 120),
                child: Container(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(authenticatedUser.photoUrl),
                    radius: 60,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 20),
              textInputField(
                readOnly: true,
                controllers: nameController,
                icon: Icons.person,
              ),
              SizedBox(height: 20),
              textInputField(
                readOnly: true,
                controllers: emailController,
                icon: Icons.person,
              ),
              SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  BlocProvider.of<LoginBloc>(context).add(LoginRemoved());
                },
                icon: Icon(Icons.logout),
                label: Text(AppStrings.logOut),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 23, vertical: 11),
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                ),
              )
            ],
          ),
        ))
      ],
    )

        // Center(
        //   child: Padding(
        //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        //     child: SingleChildScrollView(
        //       child: Column(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           CircleAvatar(
        //             backgroundColor: Colors.transparent,
        //             backgroundImage: NetworkImage(authenticatedUser.photoUrl),
        //             radius: 60,
        //           ),
        //           SizedBox(height: 50),
        //           textInputField(
        //             readOnly: true,
        //             controllers: nameController,
        //             icon: Icons.person,
        //           ),
        //           SizedBox(height: 20),
        //           textInputField(
        //             readOnly: true,
        //             controllers: emailController,
        //             icon: Icons.email,
        //           ),
        //           SizedBox(height: 50),
        //           ElevatedButton.icon(
        //             onPressed: () {
        //               BlocProvider.of<LoginBloc>(context).add(LoginRemoved());
        //             },
        //             icon: Icon(Icons.logout),
        //             label: Text(AppStrings.logOut),
        //             style: ElevatedButton.styleFrom(
        //               padding: EdgeInsets.symmetric(horizontal: 23, vertical: 11),
        //               backgroundColor: AppColors.primary,
        //               elevation: 0,
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        );
  }
}
