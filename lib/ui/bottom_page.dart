import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friend_chat/model/user_model.dart';
import 'package:friend_chat/ui/contact/contact_page.dart';
import 'package:friend_chat/ui/profile_page.dart';
import 'package:friend_chat/utilities/app_assets.dart';
import 'package:friend_chat/utilities/app_colors.dart';
import 'package:friend_chat/utilities/app_strings.dart';

import '../bloc/bottomBloc/bottom_bloc.dart';
import '../bloc/theme/theme_cubit.dart';
import 'chat/chat_page.dart';

class BottomPage extends StatelessWidget {
  final UserModel authenticatedUser;

  BottomPage({Key? key, required this.authenticatedUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomBloc(),
      child: BottomView(authenticatedUser: authenticatedUser),
    );
  }
}

class BottomView extends StatefulWidget {
  final UserModel authenticatedUser;

  BottomView({Key? key, required this.authenticatedUser}) : super(key: key);

  @override
  State<BottomView> createState() => _BottomViewState();
}

class _BottomViewState extends State<BottomView> {
  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppStrings.chattingApp),
        actions: [
          IconButton(
            onPressed: () {
              theme.changeTheme();
            },
            icon: theme.isDark
                ? Icon(Icons.dark_mode_outlined)
                : Icon(Icons.light_mode_outlined),
          ),
        ],
      ),
      body: BlocBuilder<BottomBloc, BottomState>(
        builder: (context, state) {
          if (state is BottomContact) {
            return ContactPage(authenticatedUser: widget.authenticatedUser);
          } else if (state is BottomChat) {
            return ChatPage(authenticatedUser: widget.authenticatedUser);
          } else {
            return ProfilePage(authenticatedUser: widget.authenticatedUser);
          }
        },
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: AppColors.primary.withOpacity(.2),
        ),
        child: BottomNavigationBar(
          currentIndex: selectedItem,
          onTap: _onBottomNavTapped,
          backgroundColor: Colors.transparent,
          elevation: 0,
          unselectedItemColor: AppColors.grey,
          selectedItemColor: AppColors.primary,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            navigationbarItem(pngIcon: Assets.contactLogo, index: 0),
            navigationbarItem(pngIcon: Assets.chatLogo, index: 1),
            navigationbarItem(pngIcon: Assets.profileLogo, index: 2)
          ],
        ),
      ),
    );
  }

  void _onBottomNavTapped(int value) {
    if (value == 0) {
      BlocProvider.of<BottomBloc>(context).add(BottomContactTapped());
    } else if (value == 1) {
      BlocProvider.of<BottomBloc>(context).add(BottomChatTapped());
    } else {
      BlocProvider.of<BottomBloc>(context).add(BottomProfileTapped());
    }
    setState(() => selectedItem = value);
  }

  BottomNavigationBarItem navigationbarItem(
      {required String pngIcon, required int index}) {
    return BottomNavigationBarItem(
      icon: Column(
        children: [
          Image.asset(pngIcon,
              height: 25,
              fit: BoxFit.cover,
              color: index == selectedItem
                  ? AppColors.pinkAccent
                  : AppColors.grey),
          SizedBox(height: 5),
          Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index == selectedItem
                      ? AppColors.primary
                      : Colors.transparent))
        ],
      ),
      label: '',
    );
  }
}
