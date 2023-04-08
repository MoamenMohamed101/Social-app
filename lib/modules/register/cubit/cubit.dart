import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialStates());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(SocialRegisterLoadingStates());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
      (value) {
        createUser(
          email: email,
          password: password,
          name: name,
          phone: phone,
          uId: value.user!.uid,
        );
      },
    ).catchError((error) {
      if (error.code == 'weak-password') {
      error = 'The password provided is too weak.';
      } else if (error.code == 'email-already-in-use') {
     error = 'The account already exists for that email.';
      }
        emit(
          SocialRegisterErrorStates(
            error.toString(),
          ),
        );
      },
    );
  }
/// todo fix this issue
  void createUser({
    String? email,
    String? password,
    String? name,
    String? phone,
    String? uId,
  }) {
    UserModel? userModel = UserModel(
      email: email,
      password: password,
      name: name,
      phone: phone,
      isEmailVerified: false,
      uId: uId,
      image:
          'https://i.stack.imgur.com/l60Hf.png',
      cover:
          'https://marketplace.canva.com/EAEmBit3KfU/1/0/1600w/canva-black-flatlay-photo-motivational-finance-quote-facebook-cover-myVl9DXwcjQ.jpg',
      bio: 'Write your bio ...',
    );
    FirebaseFirestore.instance
        .collection('usersData')
        .doc(userModel.uId)
        .set(
          userModel.toJson(),
        ).then((value) {
      emit(SocialCreateUserSuccessStates(uId!));
    }).catchError((error) {
      emit(
        SocialCreateUserErrorStates(error.toString()),
      );
    });
  }
}