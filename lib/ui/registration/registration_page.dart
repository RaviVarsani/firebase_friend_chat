import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friend_chat/model/user_model.dart';
import 'package:friend_chat/provider/registration_provider.dart';
import 'package:friend_chat/repository/registration_repository.dart';
import 'package:friend_chat/ui/registration/registration_view.dart';

import '../../bloc/registrationBloc/registration_bloc.dart';

class RegistrationPage extends StatelessWidget {
  final UserModel authenticatedUser;

  RegistrationPage({Key? key, required this.authenticatedUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationBloc(
        registrationRepository: RegistrationRepository(
          registrationProvider:
              RegistrationProvider(fireStore: FirebaseFirestore.instance),
        ),
      )..add(
          RegistrationDetailRequested(uid: authenticatedUser.uid),
        ),
      child: RegistrationView(authenticatedUser: authenticatedUser),
    );
  }
}
