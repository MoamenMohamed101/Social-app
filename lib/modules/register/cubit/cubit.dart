import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialStates());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister(
      {String? email,
      String? password,
      String? name,
      String? phone,
      String? uId}) {
    emit(SocialRegisterLoadingStates());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!)
        .then(
      (value) {
        createUser(
            email: email,
            password: password,
            name: name,
            phone: phone,
            uId: value.user!.uid);
        emit(
          SocialRegisterSuccessStates(),
        );
      },
    ).catchError(
      (error) {
        emit(
          SocialRegisterErrorStates(
            error.toString(),
          ),
        );
      },
    );
  }

  void createUser(
      {String? email,
      String? password,
      String? name,
      String? phone,
      String? uId}) {
    UserModel? userModel = UserModel(
      email: email,
      password: password,
      name: name,
      phone: phone,
      isEmailVerified: false,
      uId: uId,
      image:
          'https://www.freepik.com/free-photo/middle-age-sad-upset-man-with-grey-hair-dark-color-shirt-crying-rubbing-his-eye-with-hand-standing-blue-background_26886305.htm?query=man%20with%20purple%20background#from_view=detail_alsolike',
      bio: 'Flutter Developer',
    );
    FirebaseFirestore.instance
        .collection('usersData')
        .doc(uId)
        .set(
          userModel.toJson(),
        )
        .then((value) {
      emit(SocialCreateUserSuccessStates());
    }).catchError((error) {
      emit(
        SocialCreateUserErrorStates(error.toString()),
      );
    });
  }
}
