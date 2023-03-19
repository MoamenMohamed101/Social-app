import 'package:flutter/material.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Card(
              elevation: 10.0,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: const EdgeInsets.all(8),
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: const [
                  Image(
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'https://img.freepik.com/free-photo/inspired-young-handsome-man-looking-camera-pointing-side-purple-background_141793-131010.jpg?w=1060&t=st=1679215417~exp=1679216017~hmac=448ef7412a0afb1fa99013a0c7eea86f50b5912dedc4d83bcc217c1aa54a6741',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'communicate with friends',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder:(context,index)=> buildItem(context),
              itemCount: 10,
              separatorBuilder: (BuildContext context, int index) => SizedBox(height: 8),
            ),
            SizedBox(height: 8,)
          ],
        ),
      ),
    );
  }
}

buildItem(context) => Card(
      elevation: 5,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-photo/angry-young-handsome-man-looking-camera-showing-empty-hand-purple-background_141793-131014.jpg?w=1060&t=st=1679217371~exp=1679217971~hmac=272c55bb53cee6dcd2e6f83fe28450e58228b8e97d7446c81ae53ae6f1169035')),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Text(
                            'Moamen Mohamed',
                            style: TextStyle(height: 1.4),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: defaultColor,
                            size: 16,
                          )
                        ],
                      ),
                      Text('January 21, 2021 at 11:00 pm',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1.4)),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    size: 16,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Container(
                color: Colors.grey[300],
                height: 1,
                width: double.infinity,
              ),
            ),
            const Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
              style: TextStyle(
                height: 1.3,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 5),
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6),
                      child: SizedBox(
                        height: 25,
                        child: MaterialButton(
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: const Text(
                            '#software',
                            style: TextStyle(color: defaultColor),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6),
                      child: SizedBox(
                        height: 25,
                        child: MaterialButton(
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: const Text(
                            '#flutter',
                            style: TextStyle(color: defaultColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: const DecorationImage(
                    image: NetworkImage(
                      'https://img.freepik.com/free-photo/inspired-young-handsome-man-looking-camera-pointing-side-purple-background_141793-131010.jpg?w=1060&t=st=1679215417~exp=1679216017~hmac=448ef7412a0afb1fa99013a0c7eea86f50b5912dedc4d83bcc217c1aa54a6741',
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            const Icon(
                              IconBroken.Heart,
                              color: Colors.red,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '120',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              IconBroken.Chat,
                              color: Colors.amber,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '120 comment',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                color: Colors.grey[300],
                height: 1,
                width: double.infinity,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        const CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(
                                'https://img.freepik.com/free-photo/angry-young-handsome-man-looking-camera-showing-empty-hand-purple-background_141793-131014.jpg?w=1060&t=st=1679217371~exp=1679217971~hmac=272c55bb53cee6dcd2e6f83fe28450e58228b8e97d7446c81ae53ae6f1169035')),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          'write a comment ........',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1.4),
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        IconBroken.Heart,
                        color: Colors.red,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '120 Like',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
