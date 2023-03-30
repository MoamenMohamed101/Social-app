import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/new_post_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      builder: (BuildContext context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: Text(
              cubit.titles[cubit.currentIndex!],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  SocialCubit.get(context).signOut(context);
                },
                icon: const Icon(IconBroken.Notification),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(IconBroken.Search),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex!],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            currentIndex: cubit.currentIndex!,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat), label: 'Chats'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper_Upload), label: 'Posts'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Location), label: 'Users'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting), label: 'Settings'),
            ],
          ),
        );
      },
      listener: (BuildContext context, Object? state) {
        if (state is SocialNewPost) {
          navigateTo(context: context, widget: NewPostScreen());
        }
      },
    );
  }
}
