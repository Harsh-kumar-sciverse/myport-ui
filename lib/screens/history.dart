import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../constants/app_constants.dart';
import './patient_complete_details.dart';
import '../widgets/navigation_bar-widget.dart';
import 'home.dart';


class History extends StatefulWidget {
  static const routeName = '/history';
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final patients = Hive.box('patients');
  List<Map<String, dynamic>> _items = [];

  void refreshData() {
    final data = patients.keys.map((key) {
      final item = patients.get(key);
      return {
        "key": key,
        "name": item['name'],
        "age": item['age'],
        "id": item['id'],
        "time": item['time'],
      };
    }).toList();
    setState(() {
      _items = data.reversed.toList();
      print('length ${_items.length}');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    List<DataRow> rows = _items
        .map((patient) => DataRow(
                // color: MaterialStateColor.resolveWith((states) =>
                //     const Color(AppConstants.primaryColor)
                //         .withOpacity(0.8)),
                cells: [
                  DataCell(Text(
                    '${_items.indexOf(patient) + 1}',
                    style: AppConstants.tableRowStyle,
                  )),
                  DataCell(Text(
                    '${patient['time']}',
                    style: AppConstants.tableRowStyle,
                  )),
                  DataCell(Text(
                    '${patient['name']}',
                    style: AppConstants.tableRowStyle,
                  )),
                  DataCell(Text(
                    '${patient['age']}',
                    style: AppConstants.tableRowStyle,
                  )),
                  DataCell(Text(
                    '${patient['id'].toString().substring(1, 6)}',
                    style: AppConstants.tableRowStyle,
                  )),
                  DataCell(ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(PatientCompleteDetails.routeName, arguments: {
                        'key': patient['key']
                      }); // Navigator.of(context).pushNamed(ViewDetails.routeName,
                      //     arguments: {'key': patient['key']});
                    },
                    style:
                        ElevatedButton.styleFrom(shape: const StadiumBorder()),
                    child: const Text('View'),
                  )),
                ]))
        .toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(50, 100),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: NavigationBarWidget(
            title: 'History',
            showLogoutIcon: true,
            otherLastWidget: Container(),
            showPowerOffIcon: false,
            showWifiListIcon: true,
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
            Expanded(
              child: SingleChildScrollView(
                child: Row(
                  children: [
                    Expanded(
                      child: DataTable(
                          // dataRowColor:
                          //     MaterialStateColor.resolveWith((states) => Colors.black),
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) =>
                                  const Color(AppConstants.primaryColor)),
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
                          rows: rows),
                    ),
                  ],
                ),
              ),
            ),
            // const Spacer(),
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
