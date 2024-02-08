import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friend_chat/model/user_model.dart';
import 'package:friend_chat/provider/contact_provider.dart';
import 'package:friend_chat/repository/contact_repository.dart';

import '../../bloc/contactBloc/contact_bloc.dart';
import 'contact_view.dart';

class ContactPage extends StatelessWidget {
  final UserModel authenticatedUser;

  ContactPage({Key? key, required this.authenticatedUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactBloc(
        ContactRepository(
          contactProvider:
              ContactProvider(firestore: FirebaseFirestore.instance),
        ),
      )..add(
          ContactListRequested(loginUID: authenticatedUser.uid),
        ),
      child: ContactView(loginUser: authenticatedUser),
    );
  }
}
