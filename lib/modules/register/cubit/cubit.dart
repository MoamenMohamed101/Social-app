import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        //print(value.user!.email);
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
}