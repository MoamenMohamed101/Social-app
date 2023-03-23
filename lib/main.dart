import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/network/local/cach_helper.dart';
import 'package:social_app/shared/styles/themes.dart';

import 'shared/components/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper.init();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  Widget? widget;
  uid = CacheHelper.getData(key: 'uId');

  if (uid != null) {
    widget = const SocialLayout();
  } else {
    widget = SocialLoginScreen();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final startWidget;

  const MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()..getUserData(),
        ),
      ],
      child: MaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}
// : if false