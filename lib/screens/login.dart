import 'package:flutter/material.dart';
import 'package:my_port/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/navigation_bar-widget.dart';
import '../constants/app_dialogs.dart';
import 'home.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final idController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(50, 100),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: NavigationBarWidget(
            title: 'Login',
            showLogoutIcon: false,
            otherLastWidget: Container(),
            showPowerOffIcon: false,
            showWifiListIcon: true,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: 500,
            width: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.account_circle_rounded,
                  size: 100,
                  color: Color(AppConstants.primaryColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: idController,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                    label: Text('User Id'),
                    contentPadding:
                        EdgeInsets.only(top: 30, bottom: 30, left: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter id';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: passwordController,
                  style: const TextStyle(fontSize: 20),
                  obscureText: true,
                  decoration: const InputDecoration(
                    label: Text('Password'),
                    contentPadding:
                        EdgeInsets.only(top: 30, bottom: 30, left: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.center,
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      if (passwordController.text == 'admin' &&
                                          idController.text == 'admin') {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        SharedPreferences preferences =
                                            await SharedPreferences
                                                .getInstance();
                                        preferences.setBool('isLoggedIn', true);
                                        setState(() {
                                          isLoading = true;
                                        });
                                        if (!mounted) return;
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                Home.routeName,
                                                (route) => false);
                                      } else {
                                        AppDialogs.showErrorDialog(
                                            context: context,
                                            content:
                                                'Id password didn\'t match.',
                                            image: Icon(
                                              Icons.error,
                                              size: 80,
                                              color: Color(
                                                  AppConstants.primaryColor),
                                            ));
                                        return;
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(20),
                                  ),
                                  child: const Text(
                                    'Next',
                                    style: TextStyle(fontSize: 20),
                                  )),
                            ),
                          ],
                        ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: const [
                //     Icon(Icons.account_circle_rounded),
                //     SizedBox(
                //       width: 10,
                //     ),
                //     Text('Login Id'),
                //   ],
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                //
                // const SizedBox(
                //   height: 20,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: const [
                //     Icon(Icons.password),
                //     SizedBox(
                //       width: 10,
                //     ),
                //     Text('Password'),
                //   ],
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                //
                // const SizedBox(
                //   height: 20,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
