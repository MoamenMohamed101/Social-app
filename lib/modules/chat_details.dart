import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class ChatScreenDetails extends StatelessWidget {
  UserModel? userModel;
  var textController = TextEditingController();

  ChatScreenDetails(this.userModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessages(receiverId: userModel!.uId!);
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
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).messages.isNotEmpty,
                builder: (BuildContext context) => Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var messages = SocialCubit.get(context).messages[index];
                            if(SocialCubit.get(context).userModel!.uId == messages.senderId) {
                              return buildMyMessage(messages);
                            }else {
                              return buildMessage(messages);
                            }
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemCount: SocialCubit.get(context).messages.length,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: Colors.grey[300]!),
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
                      ),
                    ],
                  ),
                ),
                fallback: (BuildContext context) =>
                    const Center(child: CircularProgressIndicator()),
              ),
            );
          },
          listener: (BuildContext context, Object? state) {},
        );
      },
    );
  }
}

buildMessage(MessageModel messages) => Align(
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
        child: Text(messages.text!),
      ),
    );

buildMyMessage(MessageModel messages) => Align(
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
        child: Text(messages.text!),
      ),
    );
