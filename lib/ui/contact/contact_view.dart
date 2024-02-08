import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friend_chat/bloc/contactBloc/contact_bloc.dart';
import 'package:friend_chat/model/user_model.dart';
import 'package:friend_chat/utilities/app_strings.dart';

import '../conversation/conversation_page.dart';

class ContactView extends StatelessWidget {
  final UserModel loginUser;

  ContactView({Key? key, required this.loginUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          if (state is ContactLoadInProgress) {
            return CircularProgressIndicator();
          } else if (state is ContactLoadFailure) {
            return Text(AppStrings.unableToLoadContacts);
          } else if (state is ContactLoadSuccess) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Text(
                    AppStrings.allContactList,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                      child: ListView.builder(
                    itemCount: state.contacts.length,
                    itemBuilder: (context, index) {
                      var user = state.contacts[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ConversationPage(
                                    sender: loginUser, receiver: user),
                              ),
                            );
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(user.photoUrl),
                            ),
                            title: Text(
                              user.displayName,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              user.email,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      );
                    },
                  )),
                ],
              ),
            );
          }
          return Text(AppStrings.noUserFound);
        },
      ),
    );
  }
}
