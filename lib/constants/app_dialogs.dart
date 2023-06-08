import 'package:flutter/material.dart';
import 'package:my_port/constants/app_constants.dart';

class AppDialogs {
  static showErrorDialog({
    required BuildContext context,
    required String content,
    required Image image,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            actionsPadding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  content,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(AppConstants.primaryColor)),
                ),
                const SizedBox(
                  height: 20,
                ),
                image
              ],
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Padding(
                    padding:
                        EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                    child: Text('Ok'),
                  )),
            ],
          );
        });
  }

  static showAttentionDialog(
      {required BuildContext context,
      required String content,
      required Image image,
      required VoidCallback function}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            actionsPadding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  content,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(AppConstants.primaryColor)),
                ),
                const SizedBox(
                  height: 20,
                ),
                image
              ],
            ),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Padding(
                    padding:
                        EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                    child: Text('No'),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
                  onPressed: function,
                  child: const Padding(
                    padding:
                        EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                    child: Text('Yes'),
                  )),
            ],
          );
        });
  }

  static showCircularDialog({required BuildContext context}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            contentPadding: const EdgeInsets.all(20),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Please wait...',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(AppConstants.primaryColor)),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                    height: 30,
                    width: 30,
                    child: Center(child: CircularProgressIndicator())),
              ],
            ),
          );
        });
  }
}
