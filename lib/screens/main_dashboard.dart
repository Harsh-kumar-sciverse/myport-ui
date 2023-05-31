import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import '../widgets/navigation_bar-widget.dart';
import 'login.dart';

class MainDashboard extends StatefulWidget {
  static const routeName = '/final-report';
  const MainDashboard({Key? key}) : super(key: key);

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int selectedIndex = -1;
  double? platelets;
  double? plateletsProb;
  double? rbc;
  double? rbcProb;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Map<String, dynamic> data =
        ModalRoute.of(context)!.settings!.arguments as Map<String, dynamic>;
    platelets = data['platelets'];
    plateletsProb = data['plateletsProb'];
    rbc = data['rbc'];
    rbcProb = data['rbcProb'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(50, 100),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: NavigationBarWidget(
              title: 'Result',
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
                ],
              ),
              startWidget: Image.asset('assets/logo.png')),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 220,
              width: MediaQuery.of(context).size.width / 1.5,
              decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                        primary: false,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: 100,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 100,
                            width: 100,
                            color: Colors.red,
                          );
                        }),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height - 220,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blue)),
                child: DataTable(
                    dataRowHeight:
                        (MediaQuery.of(context).size.height - 220) / 8,
                    // dataRowColor:
                    //     MaterialStateColor.resolveWith((states) => Colors.black),
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => const Color(AppConstants.primaryColor)),
                    showCheckboxColumn: false,
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
                          selected: 0 == selectedIndex,
                          // color: MaterialStateColor.resolveWith((states) =>
                          //     const Color(AppConstants.primaryColor)
                          //         .withOpacity(0.8)),
                          onSelectChanged: (val) {
                            setState(() {
                              selectedIndex = 0;
                            });
                          },
                          cells: [
                            DataCell(Text(
                              'RBC',
                              style: AppConstants.tableRowStyle,
                            )),
                            DataCell(Text(
                              '${rbc == null ? 0 : rbc.toString()}',
                              style: AppConstants.tableRowStyle,
                            )),
                            DataCell(Text(
                              '${rbcProb == null ? 0 : rbcProb.toString()}',
                              style: AppConstants.tableRowStyle,
                            )),
                          ]),
                      DataRow(
                          selected: 1 == selectedIndex,
                          // color: MaterialStateColor.resolveWith((states) =>
                          //     const Color(AppConstants.primaryColor)
                          //         .withOpacity(0.8)),
                          onSelectChanged: (val) {
                            setState(() {
                              selectedIndex = 1;
                            });
                          },
                          cells: [
                            DataCell(Text(
                              'Platelets',
                              style: AppConstants.tableRowStyle,
                            )),
                            DataCell(Text(
                              '${platelets == null ? 0 : platelets.toString()}',
                              style: AppConstants.tableRowStyle,
                            )),
                            DataCell(Text(
                              '${plateletsProb == null ? 0 : plateletsProb.toString()}',
                              style: AppConstants.tableRowStyle,
                            )),
                          ]),
                      DataRow(
                          selected: 2 == selectedIndex,
                          // color: MaterialStateColor.resolveWith((states) =>
                          //     const Color(AppConstants.primaryColor)
                          //         .withOpacity(0.8)),
                          onSelectChanged: (val) {
                            setState(() {
                              selectedIndex = 2;
                            });
                          },
                          cells: [
                            DataCell(Text(
                              'Neutrophil',
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
                          selected: 3 == selectedIndex,
                          // color: MaterialStateColor.resolveWith((states) =>
                          //     const Color(AppConstants.primaryColor)
                          //         .withOpacity(0.8)),
                          onSelectChanged: (val) {
                            setState(() {
                              selectedIndex = 3;
                            });
                          },
                          cells: [
                            DataCell(Text(
                              'Eosinophil',
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
                          selected: 4 == selectedIndex,
                          // color: MaterialStateColor.resolveWith((states) =>
                          //     const Color(AppConstants.primaryColor)
                          //         .withOpacity(0.8)),
                          onSelectChanged: (val) {
                            setState(() {
                              selectedIndex = 4;
                            });
                          },
                          cells: [
                            DataCell(Text(
                              'Basophil',
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
                          selected: 5 == selectedIndex,
                          // color: MaterialStateColor.resolveWith((states) =>
                          //     const Color(AppConstants.primaryColor)
                          //         .withOpacity(0.8)),
                          onSelectChanged: (val) {
                            setState(() {
                              selectedIndex = 5;
                            });
                          },
                          cells: [
                            DataCell(Text(
                              'Lymphocyte',
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
                          selected: 6 == selectedIndex,
                          // color: MaterialStateColor.resolveWith((states) =>
                          //     const Color(AppConstants.primaryColor)
                          //         .withOpacity(0.8)),
                          onSelectChanged: (val) {
                            setState(() {
                              selectedIndex = 6;
                            });
                          },
                          cells: [
                            DataCell(Text(
                              'Monocyte',
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
                          ])
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
