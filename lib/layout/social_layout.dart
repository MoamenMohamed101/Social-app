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
      child: BlocConsumer<SocialCubit, SocialStates>(
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: const Text('New Feed'),
            ),
            body: Column(
              children: [
                Container(
                  color: Colors.amber.withOpacity(.6),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline),
                        const SizedBox(width: 20,),
                        const Expanded(
                          child: Text('Please verify your email'),
                        ),
                        MaterialButton(
                          onPressed: () {},
                          child: const Text(
                            'SEND',
                            style: TextStyle(color:  Colors.blue,fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );
  }
}
