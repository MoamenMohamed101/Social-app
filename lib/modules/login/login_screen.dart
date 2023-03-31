import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/login/cubit/cubit.dart';
import 'package:social_app/modules/login/cubit/states.dart';
import 'package:social_app/modules/register/register_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cach_helper.dart';

class SocialLoginScreen extends StatelessWidget {
  SocialLoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool? isPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        builder: (BuildContext context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Login now to communicate with friends',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        defaultFormField(
                          controller: emailController,
                          keyboard: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'enter email';
                            }
                            return null;
                          },
                          text: 'Enter email address',
                          prefixIcon: Icons.email,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                            controller: passwordController,
                            keyboard: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'enter password';
                              }
                              return null;
                            },
                            text: 'Enter your password',
                            prefixIcon: Icons.lock,
                            suffixIcon: Icons.add,
                            isPassword: isPassword!,
                            iconSuffix: () {},
                            onFieldSubmitted: (value) {
                              SocialLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }),
                        const SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingStates,
                          builder: (context) => defaultButton(
                            color: Colors.blue,
                            text: 'login',
                            voidCallback: () async {
                              if (formKey.currentState!.validate()) {
                                await SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            width: double.infinity,
                            isUpperCase: true,
                          ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account ?',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(
                                  context: context,
                                  widget: SocialRegisterScreen(),
                                );
                              },
                              child: const Text('Register'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (BuildContext context, Object? state) async{
          if (state is SocialLoginErrorStates) {
            showToast(message: state.error, states: ToastStates.ERROR);
          }
          if (state is SocialLoginSuccessStates) {
            //showToast(state.uId, ToastStates.SUCCESS);
            uId = state.uId; //... best way
            await CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              NavigateAndFinsh(context: context, widget: const SocialLayout());
            }).catchError(
              (error) {
                print(error.toString());
              },
            );

          }
        },
      ),
    );
  }
}
