import 'package:flutter/material.dart';

import '../widgets/navigation_bar-widget.dart';
import '../constants/app_constants.dart';
import 'home.dart';

class Calibration extends StatelessWidget {
  static const routeName = '/calibration';
  const Calibration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(50, 100),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: NavigationBarWidget(
            title: 'Calibration',
            showLogoutIcon: true,
            showPowerOffIcon: false,
            showWifiListIcon: true,
            otherLastWidget: Container(),
          ),
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
                            label: Text('Protocol',
                                style: AppConstants.tableColumnStyle)),
                        DataColumn(
                            label: Text('X',
                                style: AppConstants.tableColumnStyle)),
                        DataColumn(
                            label: Text('Y',
                                style: AppConstants.tableColumnStyle)),
                        DataColumn(
                            label: Text('Z',
                                style: AppConstants.tableColumnStyle)),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text(
                            'Homing',
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
                          DataCell(Text(
                            '0',
                            style: AppConstants.tableRowStyle,
                          )),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(
                            'Center',
                            style: AppConstants.tableRowStyle,
                          )),
                          DataCell(Text(
                            '9250',
                            style: AppConstants.tableRowStyle,
                          )),
                          DataCell(Text(
                            '9250',
                            style: AppConstants.tableRowStyle,
                          )),
                          DataCell(Text(
                            '7250',
                            style: AppConstants.tableRowStyle,
                          )),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(
                            'Eject',
                            style: AppConstants.tableRowStyle,
                          )),
                          DataCell(Text(
                            '18500',
                            style: AppConstants.tableRowStyle,
                          )),
                          DataCell(Text(
                            '9250',
                            style: AppConstants.tableRowStyle,
                          )),
                          DataCell(Text(
                            '7250',
                            style: AppConstants.tableRowStyle,
                          )),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(
                            'Retract',
                            style: AppConstants.tableRowStyle,
                          )),
                          DataCell(Text(
                            '9250',
                            style: AppConstants.tableRowStyle,
                          )),
                          DataCell(Text(
                            '9250',
                            style: AppConstants.tableRowStyle,
                          )),
                          DataCell(Text(
                            '7250',
                            style: AppConstants.tableRowStyle,
                          )),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(
                            'Scan',
                            style: AppConstants.tableRowStyle,
                          )),
                          DataCell(Text(
                            '7500',
                            style: AppConstants.tableRowStyle,
                          )),
                          DataCell(Text(
                            '10500',
                            style: AppConstants.tableRowStyle,
                          )),
                          DataCell(Text(
                            '13960',
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
