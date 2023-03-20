import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      builder: (BuildContext context, state) {
        var model = SocialCubit.get(context).userModel;
        return Padding(
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
              Text('${model.name}',
                  style: Theme.of(context).textTheme.bodyText1),
              Text(
                '${model.bio}',
                style: Theme.of(context)
                    .textTheme
                    .caption!
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
                                style: Theme.of(context).textTheme.subtitle2),
                            Text(
                              'posts',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
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
                            Text('100',
                                style: Theme.of(context).textTheme.subtitle2),
                            Text(
                              'posts',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
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
                            Text('100',
                                style: Theme.of(context).textTheme.subtitle2),
                            Text(
                              'posts',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
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
                            Text('100',
                                style: Theme.of(context).textTheme.subtitle2),
                            Text(
                              'posts',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
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
              defaultButton(
                voidCallback: () {},
                text: 'Edit Profile',
                width: double.infinity,
                radius: 5,
              )
            ],
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
