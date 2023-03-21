import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit , SocialStates>(
      builder: (BuildContext context, state) {
        var model = SocialCubit.get(context).userModel;
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Post',
            action: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  'UPDATE',
                  style: TextStyle(fontSize: 17),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
          body: Column(
            children: [
              SizedBox(
                height: 185,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                              '${model!.cover}',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor:
                      Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                          '${model.image}',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          )
        );
      },
      listener: (BuildContext context, Object? state) {  },
    );
  }
}