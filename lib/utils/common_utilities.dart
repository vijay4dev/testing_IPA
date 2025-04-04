
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// void toast({BuildContext? context, required String content, Toast? toastLength = Toast.LENGTH_SHORT}) {
//   Fluttertoast.showToast(
//       msg: content,
//       toastLength: toastLength,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 2,
//       backgroundColor: Colors.black,
//       textColor: Colors.white,
//       fontSize: 16.0);
// }


class GlobalVariable {
  static final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();

  static showMsg({String msg = ""}) {
    SnackBar snackBar = SnackBar(
      content: Text(msg),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(GlobalVariable.navState.currentState!.context).showSnackBar(snackBar);
  }
}
