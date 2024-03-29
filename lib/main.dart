import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/local/cach_helper.dart';
import 'package:social_app/shared/styles/themes.dart';
import 'shared/components/constants.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  showToast(message: 'on background message', states: ToastStates.SUCCESS);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper.init();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  debugPrint('token: $token');
  FirebaseMessaging.onMessage.listen((event) {
    debugPrint(event.data.toString());
    showToast(message: 'on message', states: ToastStates.SUCCESS);
    //debugPrint(event.notification!.body);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    debugPrint(event.data.toString());
    showToast(message: 'on message opened app', states: ToastStates.SUCCESS);
    //debugPrint(event.notification!.body);
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  Bloc.observer = MyBlocObserver();
  Widget? widget;
  uId = await CacheHelper.getData(key: 'uId');
  debugPrint('>>>>>>>>>>>>>>> $uId');

  if (uId != null) {
    widget = const SocialLayout();
  } else {
    widget = SocialLoginScreen();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp(this.startWidget, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return SocialCubit()
              ..getUserData()
              ..getPosts();
          },
        ),
      ],
      child: MaterialApp(
        theme: lightTheme,
        //darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}
// : if false
// how to use todo
// await $$ then
