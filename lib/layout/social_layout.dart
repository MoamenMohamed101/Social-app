import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialCubit()..getUserData(),
      child: BlocConsumer<SocialCubit , SocialStates>(
        builder: (BuildContext context, state) {
          return const Scaffold();
        },
      listener: (BuildContext context, Object? state) {  },
      ),
    );
  }
}
