import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                      image: DecorationImage(
                          image: NetworkImage(
                            'https://img.freepik.com/free-photo/inspired-young-handsome-man-looking-camera-pointing-side-purple-background_141793-131010.jpg?w=1060&t=st=1679215417~exp=1679216017~hmac=448ef7412a0afb1fa99013a0c7eea86f50b5912dedc4d83bcc217c1aa54a6741',
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 64,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: const CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                      'https://img.freepik.com/free-photo/angry-young-handsome-man-looking-camera-showing-empty-hand-purple-background_141793-131014.jpg?w=1060&t=st=1679217371~exp=1679217971~hmac=272c55bb53cee6dcd2e6f83fe28450e58228b8e97d7446c81ae53ae6f1169035',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
