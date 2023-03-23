import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/Chats_screen.dart';
import 'package:social_app/modules/Feeds_Screen.dart';
import 'package:social_app/modules/new_post_screen.dart';
import 'package:social_app/modules/settings_screen.dart';
import 'package:social_app/modules/users_screen.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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
    if (index == 2) {
      emit(SocialNewPost());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNav());
    }
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessStates());
    } else {
      print('No image selected');
      emit(SocialProfileImagePickedErrorStates());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessStates());
    } else {
      print('No image selected');
      emit(SocialCoverImagePickedErrorStates());
    }
  }

  void uploadProfileImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.parse(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
      }).catchError((error) {});
    }).catchError((error) {});
  }
}
