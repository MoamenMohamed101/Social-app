import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/cubit/states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialStates());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({String? email, String? password}) {
    emit(SocialLoginLoadingStates());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!)
        .then(
      (value) {
        emit(SocialLoginSuccessStates(value.user!.uid));
      },
    ).catchError(
      (error) {
        emit(
          SocialLoginErrorStates(
            error.toString(),
          ),
        );
      },
    );
  }
}
