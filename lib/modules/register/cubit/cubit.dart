import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialStates());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);


  // void userRegister({
  //   String? email,
  //   String? password,
  //   String? name,
  //   String? phone,
  // }) {
  //   emit(SocialRegisterLoadingStates());
  //   DioHelper.postData(url: Register, data: {
  //     'email': email,
  //     'password': password,
  //     'name': name,
  //     'phone': phone,
  //   })!
  //       .then((value) {
  //     shopLoginModel = SocialLoginModel.fromJson(value.data);
  //     print(shopLoginModel!.data);
  //     emit(SocialRegisterSuccessStates(shopLoginModel!));
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(
  //       SocialRegisterErrorStates(
  //         error.toString(),
  //       ),
  //     );
  //   });
  // }
}
