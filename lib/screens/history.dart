import 'package:flutter/material.dart';
import 'package:my_port/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/navigation_bar-widget.dart';
import 'home.dart';
import 'login.dart';

class History extends StatefulWidget {
  static const routeName = '/history';
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    //timesList
    //       .map((times) => DataRow(cells: [
    //          DataCell(
    //            Text(times.toString(), textAlign: TextAlign.center),
    //          ),
    //       ]),
    //     )
    //     .toList(),

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(50, 100),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: NavigationBarWidget(
              title: 'History',
              endWidget: Row(
                children: [
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
                      // Navigator.of(context).pushNamed(History.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.white),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.wifi,
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
                ],
              ),
              startWidget: Image.asset('assets/logo.png')),
        ),
      ),
      body: Column(
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
                          label: Text('Index',
                              style: AppConstants.tableColumnStyle)),
                      DataColumn(
                          label: Text('Date & Time',
                              style: AppConstants.tableColumnStyle)),
                      DataColumn(
                          label: Text('Patient Name',
                              style: AppConstants.tableColumnStyle)),
                      DataColumn(
                          label: Text('Age',
                              style: AppConstants.tableColumnStyle)),
                      DataColumn(
                          label: Text('Cassette ID',
                              style: AppConstants.tableColumnStyle)),
                      DataColumn(
                          label: Text('Action',
                              style: AppConstants.tableColumnStyle))
                    ],
                    rows: [
                      DataRow(
                          // color: MaterialStateColor.resolveWith((states) =>
                          //     const Color(AppConstants.primaryColor)
                          //         .withOpacity(0.8)),
                          cells: [
                            DataCell(Text(
                              '1',
                              style: AppConstants.tableRowStyle,
                            )),
                            DataCell(Text(
                              'Today 12:56 PM',
                              style: AppConstants.tableRowStyle,
                            )),
                            DataCell(Text(
                              'Rohit',
                              style: AppConstants.tableRowStyle,
                            )),
                            DataCell(Text(
                              '23',
                              style: AppConstants.tableRowStyle,
                            )),
                            DataCell(Text(
                              '1245289',
                              style: AppConstants.tableRowStyle,
                            )),
                            DataCell(ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder()),
                              child: const Text('View'),
                            )),
                          ])
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
    );
  }
}
