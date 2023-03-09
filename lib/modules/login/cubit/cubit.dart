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
        print(value.user!.email);
        emit(SocialLoginSuccessStates());
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
