import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import '../widgets/navigation_bar-widget.dart';
import 'home.dart';
import 'login.dart';
import 'package:share_plus/share_plus.dart';

class ViewDetails extends StatefulWidget {
  static const routeName = 'view-details';
  const ViewDetails({Key? key}) : super(key: key);

  @override
  State<ViewDetails> createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(50, 100),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: NavigationBarWidget(
              title: 'Final Report',
              endWidget: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.white),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.print,
                        color: Color(AppConstants.primaryColor),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.remove('isLoggedIn');

                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Login.routeName, (route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.white),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.logout,
                        color: Color(AppConstants.primaryColor),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.white),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.power_settings_new,
                        color: Color(AppConstants.primaryColor),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Navigator.of(context).pop();
                      await Share.share(
                          'check out my website https://example.com');
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.white),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.share,
                        color: Color(AppConstants.primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
              startWidget: Image.asset('assets/logo.png')),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: DataTable(
                      // dataRowColor:
                      //     MaterialStateColor.resolveWith((states) => Colors.black),
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => const Color(AppConstants.primaryColor)),
                      columns: [
                        DataColumn(
                            label: Text('Name',
                                style: AppConstants.tableColumnStyle)),
                        DataColumn(
                            label: Text('Count',
                                style: AppConstants.tableColumnStyle)),
                        DataColumn(
                            label: Text('Probability',
                                style: AppConstants.tableColumnStyle)),
                      ],
                      rows: [
                        DataRow(
                            // color: MaterialStateColor.resolveWith((states) =>
                            //     const Color(AppConstants.primaryColor)
                            //         .withOpacity(0.8)),
                            cells: [
                              DataCell(Text(
                                'Platelets',
                                style: AppConstants.tableRowStyle,
                              )),
                              DataCell(Text(
                                '0',
                                style: AppConstants.tableRowStyle,
                              )),
                              DataCell(Text(
                                '0',
                                style: AppConstants.tableRowStyle,
                              )),
                            ]),
                        DataRow(
                            // color: MaterialStateColor.resolveWith((states) =>
                            //     const Color(AppConstants.primaryColor)
                            //         .withOpacity(0.8)),
                            cells: [
                              DataCell(Text(
                                'RBC',
                                style: AppConstants.tableRowStyle,
                              )),
                              DataCell(Text(
                                '0',
                                style: AppConstants.tableRowStyle,
                              )),
                              DataCell(Text(
                                '0',
                                style: AppConstants.tableRowStyle,
                              )),
                            ]),
                        DataRow(
                            // color: MaterialStateColor.resolveWith((states) =>
                            //     const Color(AppConstants.primaryColor)
                            //         .withOpacity(0.8)),
                            cells: [
                              DataCell(Text(
                                'Platelets',
                                style: AppConstants.tableRowStyle,
                              )),
                              DataCell(Text(
                                '0',
                                style: AppConstants.tableRowStyle,
                              )),
                              DataCell(Text(
                                '0',
                                style: AppConstants.tableRowStyle,
                              )),
                            ]),
                      ]),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Home.routeName, (route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
