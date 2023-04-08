import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chat_details.dart';
import 'package:social_app/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      builder: (BuildContext context, state) {
        var cubit = SocialCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.users.isNotEmpty,
          builder: (BuildContext context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                buildChatItem(cubit.users[index], context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: cubit.users.length,
          ),
          fallback: (BuildContext context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}

buildChatItem(UserModel user, context) => InkWell(
      onTap: () => navigateTo(
        context: context,
        widget: ChatScreenDetails(user),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage('${user.image}'),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              '${user.name}',
              style: const TextStyle(height: 1.4),
            ),
          ],
        ),
      ),
    );
