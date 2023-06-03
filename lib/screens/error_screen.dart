import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/navigation_bar-widget.dart';

class ErrorScreen extends StatelessWidget {
  static const routeName = '/error';
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(50, 100),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: NavigationBarWidget(
              title: 'Error',
              endWidget: Row(
                children: const [
                  SizedBox(
                    width: 50,
                    height: 50,
                  )
                ],
              ),
              startWidget: Image.asset('assets/logo.png')),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).canPop()
                    ? Navigator.of(context).pop()
                    : null;
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
              ),
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/error.png'),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Please connect to admin.',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
