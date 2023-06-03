import 'package:flutter/material.dart';

class AppDialogs {
  static showErrorDialog({
    required BuildContext context,
    required String content,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: const [
                Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Error occurred !'),
              ],
            ),
            content: Text(content),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok'))
            ],
          );
        });
  }

  static showAttentionDialog(
      {required BuildContext context,
      required String content,
      required String title,
      required VoidCallback function}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                const Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            content: Text(content),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'No',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              TextButton(
                onPressed: function,
                child: const Text(
                  'Yes',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          );
        });
  }

  static showCircularDialog({required BuildContext context}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const AlertDialog(
            contentPadding: EdgeInsets.all(20),
            content: SizedBox(
                height: 30,
                width: 30,
                child: Center(child: CircularProgressIndicator())),
          );
        });
  }
}
