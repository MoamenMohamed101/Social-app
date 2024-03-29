import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

myDivider() => Container(height: 1, width: double.infinity, color: Colors.grey);

defaultFormField({
  @required TextEditingController? controller,
  @required TextInputType? keyboard,
  void Function(String)? onFieldSubmitted,
  void Function(String)? onChanged,
  @required String? Function(String?)? validator,
  @required String? text,
  @required IconData? prefixIcon,
  IconData? suffixIcon,
  bool isPassword = false,
  VoidCallback? iconSuffix,
  VoidCallback? onTap,
}) =>
    TextFormField(
      onTap: onTap,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        labelText: text!,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(prefixIcon!),
        // suffixIcon: suffixIcon != null
        //     ? IconButton(
        //         onPressed: iconSuffix,
        //         icon: isPassword
        //             ? const Icon(Icons.visibility_off)
        //             : const Icon(Icons.remove_red_eye),
        //       )
        //     : null,
      ),
      keyboardType: keyboard,
      obscureText: isPassword,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
    );

defaultButton({
  double? width,
  Color? color = Colors.blue,
  @required VoidCallback? voidCallback,
  @required String? text,
  bool? isUpperCase = true,
  double? radius = 10.0,
}) =>
    Container(
      height: 45,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius!),
      ),
      child: MaterialButton(
        onPressed: voidCallback,
        child: Text(
          isUpperCase! ? text!.toUpperCase() : text!,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );

navigateTo({context, widget}) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void NavigateAndFinsh({context, widget}) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (Route<dynamic> route) => false);

showToast({required String message,required  ToastStates states}) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: chooseToastColor(states),
    textColor: Colors.white,
    fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates states) {
  Color color;
  switch (states) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

defaultAppBar({
  String? title,
  @required BuildContext? context,
  List<Widget> action = const [],
}) =>
    AppBar(
      actions: action,
      title: Text(title!),
      titleSpacing: 5.0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context!);
        },
        icon: const Icon(IconBroken.Arrow___Left_2),
      ),
    );