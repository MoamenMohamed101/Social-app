import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/edit_profile_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      builder: (BuildContext context, state) {
        var model = SocialCubit
            .get(context)
            .userModel;
        return ConditionalBuilder(
          condition: model != null,
          builder: (context) =>
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
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
                              Theme
                                  .of(context)
                                  .scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage('${model.image}'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('${model.name}',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyLarge),
                      Text(
                        '${model.bio}',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(height: 1.9),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                child: Column(
                                  children: [
                                    Text('100',
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .titleSmall),
                                    Text(
                                      'posts',
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(height: 1.5),
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                child: Column(
                                  children: [
                                    Text('265',
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .titleSmall),
                                    Text(
                                      'Photos',
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(height: 1.5),
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                child: Column(
                                  children: [
                                    Text('10k',
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .titleSmall),
                                    Text(
                                      'followers',
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(height: 1.5),
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                child: Column(
                                  children: [
                                    Text('64',
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .titleSmall),
                                    Text(
                                      'followings',
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(height: 1.5),
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              child: const Text('Add Photos'),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          OutlinedButton(
                            onPressed: () {
                              navigateTo(
                                context: context,
                                widget: EditProfileScreen(),
                              );
                            },
                            child: const Icon(IconBroken.Edit, size: 16),
                          ),
                        ],
                      ),
                      // buttom to log out
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            SocialCubit.get(context).signOut(context);
                          },
                          child: const Text('Log Out'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          fallback: (context) => const Center(child: CircularProgressIndicator(),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}