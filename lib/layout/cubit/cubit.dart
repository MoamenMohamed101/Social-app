import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/components/constants.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialStates());

  static SocialCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingStates());
    FirebaseFirestore.instance
        .collection('usersData')
        .doc(uid)
        .get()
        .then((value) {
      //print(value.data());
      userModel = UserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(
        SocialGetUserErrorStates(error.toString()),
      );
    });
  }
}
