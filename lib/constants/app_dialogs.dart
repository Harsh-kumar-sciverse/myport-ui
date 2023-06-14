import 'package:flutter/material.dart';
import 'package:my_port/constants/app_constants.dart';

class AppDialogs {
  static showErrorDialog({
    required BuildContext context,
    required String content,
    required Widget image,
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

  static showSuccessDialog({
    required BuildContext context,
    required String content,
    required Widget image,
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
      required Widget image,
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

  static showEmailDialog({
    required BuildContext context,
    required TextEditingController toEmailController,
    required FormFieldValidator<String> validator,
    required VoidCallback function,
    required GlobalKey<FormState> formKey,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              contentPadding: const EdgeInsets.all(20),
              actionsPadding:
                  const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Email Report',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(AppConstants.primaryColor)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Icon(
                      Icons.email_outlined,
                      color: Color(AppConstants.primaryColor),
                      size: 80,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: toEmailController,
                      validator: validator,
                      decoration: const InputDecoration(
                        prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                        prefixIcon: Text(
                          'To  ',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
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
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 5),
                      child: Text('Discard'),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                    onPressed: function,
                    child: const Padding(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 5),
                      child: Text('Send'),
                    )),
              ],
            );
          });
        });
  }
}
