import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      builder: (BuildContext context, state) {
        var model = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        var cubit = SocialCubit.get(context);
        nameController.text = model!.name!;
        bioController.text = model.bio!;
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
          body: Padding(
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
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 140,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  topRight: Radius.circular(4),
                                ),
                                image: DecorationImage(
                                  image: coverImage == null
                                      ? NetworkImage(
                                          '${model.cover}',
                                        )
                                      : FileImage(coverImage) as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                cubit.getCoverImage();
                              },
                              icon: const CircleAvatar(
                                radius: 20,
                                child: Icon(IconBroken.Camera),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 64,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: profileImage == null
                                  ? NetworkImage(
                                      '${model.image}',
                                    )
                                  : FileImage(profileImage) as ImageProvider,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              cubit.getProfileImage();
                            },
                            icon: const CircleAvatar(
                              radius: 20,
                              child: Icon(IconBroken.Camera),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultFormField(
                  controller: nameController,
                  keyboard: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'name must not be empty';
                    }
                    return null;
                  },
                  text: 'name',
                  prefixIcon: IconBroken.User,
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultFormField(
                  controller: bioController,
                  keyboard: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'bio must not be empty';
                    }
                    return null;
                  },
                  text: 'bio',
                  prefixIcon: IconBroken.Info_Circle,
                ),
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
