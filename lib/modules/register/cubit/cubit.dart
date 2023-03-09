import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialStates());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    String? email,
    String? password,
    String? name,
    String? phone,
  }) {
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
        );
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
      {String? email, String? password, String? name, String? phone}) {
    UserModel? userModel = UserModel(
      email: email,
      password: password,
      name: name,
      phone: phone,
    );
    FirebaseFirestore.instance
        .collection('usersData')
        .doc(name)
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
