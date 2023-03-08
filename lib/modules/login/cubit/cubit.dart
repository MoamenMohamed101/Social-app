import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/cubit/states.dart';



class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialStates());

  static SocialLoginCubit get(context) => BlocProvider.of(context);
  // void userLogin({String? email, String? password}) {
  //   emit(SocialLoginLoadingStates());
  //   DioHelper.postData(
  //       url: 'login', data: {'email': email, 'password': password})!
  //       .then((value) {
  //     shopLoginModel = SocialLoginModel.fromJson(value.data);
  //     emit(SocialLoginSuccessStates(shopLoginModel!));
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(
  //       SocialLoginErrorStates(
  //         error.toString(),
  //       ),
  //     );
  //   });
  // }
}