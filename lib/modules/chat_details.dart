import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class ChatScreenDetails extends StatelessWidget {
  UserModel? userModel;
  var textController = TextEditingController();

  ChatScreenDetails(this.userModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage('${userModel!.image}'),
                ),
                const SizedBox(width: 15),
                Text('${userModel!.name}'),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                buildMessage(),
                buildMyMessage(),
                const Spacer(),
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: TextFormField(
                            controller: textController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'type your message here .....'),
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        color: defaultColor,
                        child: MaterialButton(
                          minWidth: 1.0,
                          onPressed: () {
                            SocialCubit.get(context).sendMessages(
                              receiverId: userModel!.uId!,
                              text: textController.text,
                              dataTime: DateTime.now().toString(),
                            );
                          },
                          child: const Icon(IconBroken.Send),
                        ),
                      )
                    ],
                  ),
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

buildMessage() => Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10),
            topStart: Radius.circular(10),
            topEnd: Radius.circular(10),
          ),
        ),
        child: const Text('Hello world'),
      ),
    );

buildMyMessage() => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: defaultColor.withOpacity(.2),
          borderRadius: const BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10),
            topStart: Radius.circular(10),
            topEnd: Radius.circular(10),
          ),
        ),
        child: const Text('Hello world'),
      ),
    );
