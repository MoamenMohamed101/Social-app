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
    // String? uId,
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
          uId: value.user!.uid,
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
          'https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.pngplay.com%2Fwp-content%2Fuploads%2F12%2FUser-Avatar-Profile-PNG-Free-File-Download.png&tbnid=10gbQCyo1jc3lM&vet=12ahUKEwjOgqGFsfT9AhUhokwKHV_GB-EQMygdegUIARCLAg..i&imgrefurl=https%3A%2F%2Fwww.pngplay.com%2Far%2Fimage%2F325494&docid=PshJLLfKxXEEXM&w=2601&h=3023&q=profile%20avatar%20images&ved=2ahUKEwjOgqGFsfT9AhUhokwKHV_GB-EQMygdegUIARCLAg',
      cover:
          'https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.pngplay.com%2Fwp-content%2Fuploads%2F12%2FUser-Avatar-Profile-PNG-Free-File-Download.png&tbnid=10gbQCyo1jc3lM&vet=12ahUKEwjOgqGFsfT9AhUhokwKHV_GB-EQMygdegUIARCLAg..i&imgrefurl=https%3A%2F%2Fwww.pngplay.com%2Far%2Fimage%2F325494&docid=PshJLLfKxXEEXM&w=2601&h=3023&q=profile%20avatar%20images&ved=2ahUKEwjOgqGFsfT9AhUhokwKHV_GB-EQMygdegUIARCLAg',
      bio: 'Flutter Developer',
    );
    FirebaseFirestore.instance
        .collection('usersData')
        .doc(uId)
        .set(
          userModel.toJson(),
          //SetOptions(merge: true)
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
