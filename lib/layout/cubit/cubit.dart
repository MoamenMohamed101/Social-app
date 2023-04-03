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

  // get user data from firebase firestore and save it in userModel variable to use it in all app screens
  void getUserData() async {
    uId = CacheHelper.getData(key: 'uId');
    emit(SocialGetUserLoadingStates());
    await FirebaseFirestore.instance
        .collection('usersData')
        .doc(uId)
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

// get profile image from gallery
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

// get cover image from gallery
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

// upload profile image to firebase storage and get url
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

// upload cover image to firebase storage and get url
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
// update user data in firebase database and cache helper data
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

  // remove post image from create post screen
  void removePostImage() {
    createPostImage = null;
    emit(SocialRemovePostImageSuccessStates());
  }

  // get post image from gallery
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

// upload post image to firebase storage and get image url and send it to create post function to create post with image
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

  // create post function with image and text and date time and user data and post id
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
      text: text,
      password: userModel!.password,
      bio: userModel!.bio,
      email: userModel!.email,
      phone: userModel!.phone,
      cover: userModel!.cover,
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

  // signOut function
  void signOut(context) {
    navigateTo(context: context, widget: SocialLoginScreen());
    FirebaseAuth.instance.signOut().then((value) {
      CacheHelper.removeData('uId')!.then((value) {
        uId = null;
      });
      emit(SocialSignOutSuccessStates());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(SocialSignOutErrorStates());
    });
  }

  // void logout(BuildContext context) {
  //   FirebaseFirestore.instance.collection('users').doc(uId).update(
  //     {'token': ''},
  //   );
  //   CacheHelper.removeData(key: 'uId');
  //   uId = null;
  //   users = [];
  //   userModel = null;
  //   emit(AppLogOutSuccessState());
  // }
  List<PostModel> posts = [];

  getPosts() {
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {
      for (var element in value.docs) {
        posts.add(PostModel.fromJson(element.data()));
      }
      emit(SocialGetPostsSuccessStates());
    })
        .catchError((error) {
      emit(SocialGetPostsErrorStates(error.toString()));
    });
  }
}
