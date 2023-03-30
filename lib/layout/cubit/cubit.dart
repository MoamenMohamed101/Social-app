import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/Chats_screen.dart';
import 'package:social_app/modules/Feeds_Screen.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/modules/new_post_screen.dart';
import 'package:social_app/modules/settings_screen.dart';
import 'package:social_app/modules/users_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cach_helper.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialStates());

  static SocialCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;
 void getUserData() async{
   uid = CacheHelper.getData(key: 'uId');
    emit(SocialGetUserLoadingStates());
    await FirebaseFirestore.instance
        .collection('usersData')
        .doc(uid)
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorStates(error.toString()));
    });
  }

  int? currentIndex = 0;

  List<String> titles = [
    'Home',
    'Chats',
    'Posts',
    'Users',
    'Settings',
  ];

  List screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    NewPostScreen(),
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

  void uploadProfileImage({
    @required String? name,
    @required String? phone,
    @required String? bio,
  }) {
    emit(SocialUserUpdateLoadingStates());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .parse(profileImage!.path)
        .pathSegments
        .last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUserData(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorStates());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorStates());
    });
  }

  void uploadCoverImage({
    @required String? name,
    @required String? phone,
    @required String? bio,
  }) {
    emit(SocialUserUpdateLoadingStates());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .parse(coverImage!.path)
        .pathSegments
        .last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
        //emit(SocialUploadCoverImageSuccessStates());
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorStates());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorStates());
    });
  }

  // void updateUserImage({
  //   @required String? name,
  //   @required String? phone,
  //   @required String? bio,
  // }) {
  //   emit(SocialUserUpdateLoadingStates());
  //   if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null && coverImage != null) {
  //   } else {
  //     updateUserData(name: name, phone: phone, bio: bio);
  //   }
  // }

  updateUserData({
    @required String? name,
    @required String? phone,
    @required String? bio,
    String? image,
    String? cover,
  }) {
    UserModel? model = UserModel(
      name: name,
      phone: phone,
      cover: cover ?? userModel!.cover,
      image: image ?? userModel!.image,
      email: userModel!.email,
      isEmailVerified: false,
      bio: bio,
      uId: userModel!.uId,
      password: userModel!.password,
    );
    FirebaseFirestore.instance
        .collection('usersData')
        .doc(model.uId)
        .update(
      model.toJson(),
    )
        .then((value) {
      getUserData();
    }).catchError((error) {
      print(error.toString());
      emit(SocialUserUpdateErrorStates());
    });
  }

  File? createPostImage;
  void removePostImage(){
    createPostImage = null;
    emit(SocialRemovePostImageSuccessStates());
  }
  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      createPostImage = File(pickedFile.path);
      emit(SocialCreateImagePickedSuccessStates());
    } else {
      print('No image selected');
      emit(SocialCreateImagePickedErrorStates());
    }
  }

  void uploadPostImage({
    @required String? text,
    @required String? dateTime,
  }) {
    emit(SocialCreatePostLoadingStates());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .parse(createPostImage!.path)
        .pathSegments
        .last}')
        .putFile(createPostImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(dateTime: dateTime, text: text, postImage: value);
      }).catchError((error) {
        emit(SocialCreatePostErrorStates());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorStates());
    });
  }

  createPost({
    @required String? dateTime,
    @required String? text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingStates());
    PostModel? model = PostModel(
        name: userModel!.name,
        dataTime: dateTime,
        image: userModel!.image,
        uId: userModel!.uId,
        postImage: postImage ?? '',
        text: text
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(
      model.toJson(),
    )
        .then((value) {
          emit(SocialCreatePostSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreatePostErrorStates());
    });
  }

  // signOut
  void signOut(context) {
    FirebaseAuth.instance.signOut().then((value) {
      CacheHelper.removeData('uId')!.then((value) {
        navigateTo(context: context,widget:  SocialLoginScreen());
      });
      emit(SocialSignOutSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(SocialSignOutErrorStates());
    });
  }
  void name(){
    print('moamen');
  }
}