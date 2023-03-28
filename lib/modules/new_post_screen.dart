import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
    NewPostScreen({Key? key}) : super(key: key);
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      builder: (BuildContext context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create New Post',
            action: [
              TextButton(
                onPressed: () {
                  var now = DateTime.now();
                  if (cubit.createPostImage == null) {
                    cubit.createPost(
                      dateTime: now.toString(),
                      text: textController.text,
                    );
                  } else {
                    cubit.uploadPostImage(
                      text: textController.text,
                      dateTime: now.toString(),
                    );
                  }
                },
                child: const Text('post'),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingStates)
                  const LinearProgressIndicator()
                else
                  const SizedBox(height: 10,),
                Row(
                  children: const [
                    CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                            'https://img.freepik.com/free-photo/angry-young-handsome-man-looking-camera-showing-empty-hand-purple-background_141793-131014.jpg?w=1060&t=st=1679217371~exp=1679217971~hmac=272c55bb53cee6dcd2e6f83fe28450e58228b8e97d7446c81ae53ae6f1169035')),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        'Moamen Mohamed',
                        style: TextStyle(height: 1.4),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                        hintText: 'what is on your mind.....',
                        border: InputBorder.none),
                  ),
                ),
                if(cubit.createPostImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            image: FileImage(cubit.createPostImage!), fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          cubit.removePostImage();
                        },
                        icon: const CircleAvatar(
                          radius: 20,
                          child: Icon(Icons.close),
                        ),
                      ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          cubit.getPostImage();
                        },
                        child: Row(
                          children: const [
                            Icon(IconBroken.Image),
                            SizedBox(
                              width: 5,
                            ),
                            Text('add photo'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('# tags'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
