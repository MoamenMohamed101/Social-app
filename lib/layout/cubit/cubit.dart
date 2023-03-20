import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/Chats_screen.dart';
import 'package:social_app/modules/Feeds_Screen.dart';
import 'package:social_app/modules/new_post_screen.dart';
import 'package:social_app/modules/settings_screen.dart';
import 'package:social_app/modules/users_screen.dart';
import 'package:social_app/shared/components/constants.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialStates());

  static SocialCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;
  int? currentIndex = 0;

  List<String> titles = [
    'Home',
    'Chats',
    'Posts',
    'Users',
    'Settings',
  ];

  void getUserData() {
    emit(SocialGetUserLoadingStates());
    FirebaseFirestore.instance
        .collection('usersData')
        .doc(uid)
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data()!);
      print(userModel!.bio);
      print(userModel!.name);
      print(userModel!.image);
      print(userModel!.cover);
      emit(SocialGetUserSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(
        SocialGetUserErrorStates(error.toString()),
      );
    });
  }
  List screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    const NewPostScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];

  void changeBottomNav(int? index) {
    if(index == 2) {
      emit(SocialNewPost());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNav());
    }
  }
}
