import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_port/screens/home.dart';
import '../constants/app_constants.dart';
import '../models/cell_model.dart';
import '../widgets/navigation_bar-widget.dart';

class MainDashboard extends StatefulWidget {
  static const routeName = '/final-report';
  const MainDashboard({Key? key}) : super(key: key);

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int selectedIndex = -1;
  String? platelets;
  String? plateletsProb;
  String? rbc;
  String? rbcProb;
  String? neutrophilNumber;
  String? neutrophilProbability;
  String? eosinophilNumber;
  String? eosinophilProbability;
  String? basophilNumber;
  String? basophilProbability;
  String? lymphocyteNumber;
  String? lymphocyteProbability;
  String? monocyteNumber;
  String? monocyteProbability;
  List<dynamic>? imageData;
  List<CellModel> cells = [];
  List<CellModel>? queryCells;
  String? mch;
  String? hemoglobin;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    imageData = arguments['response']['data']['predictions'];
    platelets = (arguments['platelets']).toString();
    plateletsProb = arguments['plateletsProb'].toString();
    rbc = arguments['rbc'].toString();
    rbcProb = arguments['rbcProb'].toString();
    neutrophilNumber = arguments['neutrophils'].toString();
    neutrophilProbability = arguments['neutrophilsProb'].toString();
    eosinophilNumber = arguments['eosinophils'].toString();
    eosinophilProbability = arguments['eosinophilProb'].toString();
    basophilNumber = arguments['basophils'].toString();
    basophilProbability = arguments['basophilProb'].toString();
    lymphocyteNumber = arguments['lymphocyts'].toString();
    lymphocyteProbability = arguments['lymphocytProb'].toString();
    monocyteNumber = arguments['monocytes'].toString();
    monocyteProbability = arguments['monocyteProb'].toString();

    cells = imageData!
        .map((data) => CellModel(
            cellName: data['tag_name'].toString(),
            probability: data['probability'].toString(),
            cellPath: data['image_path']))
        .toList();
    mch = arguments['mch'].toString();
    hemoglobin = arguments['hemoglobin'].toString();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: PreferredSize(
    //     preferredSize: const Size(50, 100),
    //     child: Padding(
    //       padding: const EdgeInsets.only(left: 20, right: 20),
    //       child: NavigationBarWidget(
    //         title: 'Result',
    //         showLogoutIcon: true,
    //         otherLastWidget: Container(),
    //         showPowerOffIcon: true,
    //         showWifiListIcon: true,
    //       ),
    //     ),
    //   ),
    //   bottomSheet: Padding(
    //     padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       children: [
    //         ElevatedButton(
    //           onPressed: () {
    //             Navigator.of(context).pushReplacementNamed(Home.routeName);
    //           },
    //           style: ElevatedButton.styleFrom(
    //             shape: const CircleBorder(),
    //           ),
    //           child: const Padding(
    //             padding: EdgeInsets.all(15.0),
    //             child: Icon(
    //               Icons.home,
    //               color: Colors.white,
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    //   body: Padding(
    //     padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
    //     child: Row(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Container(
    //           //  height: MediaQuery.of(context).size.height - 220,
    //           width: MediaQuery.of(context).size.width / 1.5,
    //           decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
    //           child: Column(
    //             children: [
    //               Expanded(
    //                 child: GridView.builder(
    //                     primary: false,
    //                     gridDelegate:
    //                         const SliverGridDelegateWithFixedCrossAxisCount(
    //                       crossAxisCount: 5,
    //                       mainAxisSpacing: 2,
    //                       crossAxisSpacing: 2,
    //                     ),
    //                     itemCount: imageData!.length,
    //                     itemBuilder: (context, index) {
    //                       String path = '/home/sci/Documents/ViewPort/app/';
    //                       final completePath =
    //                           path + imageData![index]['image_path'];
    //                       final myFile = File(completePath);
    //                       print(path + completePath);
    //
    //                       return Container(
    //                         height: 100,
    //                         width: 100,
    //                         decoration: BoxDecoration(
    //                             border: Border.all(
    //                                 color: const Color(
    //                                     AppConstants.primaryColor))),
    //                         child: Image.file(myFile),
    //                       );
    //                     }),
    //               ),
    //             ],
    //           ),
    //         ),
    //         const SizedBox(
    //           width: 10,
    //         ),
    //         Expanded(
    //           child: Container(
    //             height: MediaQuery.of(context).size.height,
    //             decoration:
    //                 BoxDecoration(border: Border.all(color: Colors.blue)),
    //             child: DataTable(
    //                 dataRowHeight: (MediaQuery.of(context).size.height) / 10,
    //                 // dataRowColor:
    //                 //     MaterialStateColor.resolveWith((states) => Colors.black),
    //                 headingRowColor: MaterialStateColor.resolveWith(
    //                     (states) => const Color(AppConstants.primaryColor)),
    //                 showCheckboxColumn: false,
    //                 columns: [
    //                   DataColumn(
    //                       label: Text('Name',
    //                           style: AppConstants.tableColumnStyle)),
    //                   DataColumn(
    //                       label: Text('Count',
    //                           style: AppConstants.tableColumnStyle)),
    //                   DataColumn(
    //                       label: Text('Probability',
    //                           style: AppConstants.tableColumnStyle)),
    //                 ],
    //                 rows: [
    //                   DataRow(
    //                       selected: 0 == selectedIndex,
    //                       // color: MaterialStateColor.resolveWith((states) =>
    //                       //     const Color(AppConstants.primaryColor)
    //                       //         .withOpacity(0.8)),
    //                       onSelectChanged: (val) {
    //                         setState(() {
    //                           selectedIndex = 0;
    //                         });
    //                       },
    //                       cells: [
    //                         DataCell(Text(
    //                           'RBC',
    //                           style: AppConstants.tableRowStyle,
    //                         )),
    //                         DataCell(Text(
    //                           '${rbc == null ? 0 : rbc.toString()}',
    //                           style: AppConstants.tableRowStyle,
    //                         )),
    //                         DataCell(Text(
    //                           '${rbcProb == null ? 0 : double.parse(rbcProb.toString()).toStringAsFixed(2)}',
    //                           style: AppConstants.tableRowStyle,
    //                         )),
    //                       ]),
    //                   DataRow(
    //                       selected: 1 == selectedIndex,
    //                       // color: MaterialStateColor.resolveWith((states) =>
    //                       //     const Color(AppConstants.primaryColor)
    //                       //         .withOpacity(0.8)),
    //                       onSelectChanged: (val) {
    //                         setState(() {
    //                           selectedIndex = 1;
    //                         });
    //                       },
    //                       cells: [
    //                         DataCell(Text(
    //                           'Platelets',
    //                           style: AppConstants.tableRowStyle,
    //                         )),
    //                         DataCell(Text(
    //                           '${platelets == null ? 0 : platelets.toString()}',
    //                           style: AppConstants.tableRowStyle,
    //                         )),
    //                         DataCell(Text(
    //                           '${plateletsProb == null ? 0 : double.parse(plateletsProb.toString()).toStringAsFixed(2)}',
    //                           style: AppConstants.tableRowStyle,
    //                         )),
    //                       ]),
    //                   DataRow(
    //                       selected: 2 == selectedIndex,
    //                       // color: MaterialStateColor.resolveWith((states) =>
    //                       //     const Color(AppConstants.primaryColor)
    //                       //         .withOpacity(0.8)),
    //                       onSelectChanged: (val) {
    //                         setState(() {
    //                           selectedIndex = 2;
    //                         });
    //                       },
    //                       cells: [
    //                         DataCell(Text(
    //                           'Neutrophil',
    //                           style: AppConstants.tableRowStyle,
    //                         )),
    //                         DataCell(Text(
    //                           '${neutrophilNumber ?? 0}',
    //                           style: AppConstants.tableRowStyle,
    //                         )),
    //                         DataCell(Text(
    //                           '${neutrophilProbability == null ? 0 : neutrophilProbability}',
    //                           style: AppConstants.tableRowStyle,
    //                         )),
    //                       ]),
    //                   DataRow(
    //                       selected: 3 == selectedIndex,
    //                       // color: MaterialStateColor.resolveWith((states) =>
    //                       //     const Color(AppConstants.primaryColor)
    //                       //         .withOpacity(0.8)),
    //                       onSelectChanged: (val) {
    //                         setState(() {
    //                           selectedIndex = 3;
    //                         });
    //                       },
    //                       cells: [
    //                         DataCell(Text(
    //                           'Eosinophil',
    //                           style: AppConstants.tableRowStyle,
    //                         )),
    //                         DataCell(Text(
    //                           '${eosinophilNumber ?? 0}',
    //                           style: AppConstants.tableRowStyle,
    //                         )),
    //                         DataCell(Text(
    //                           '${eosinophilProbability == null ? 0 : eosinophilProbability}',
    //                           style: AppConstants.tableRowStyle,
    //                         )),
    //                       ]),
    //                   DataRow(
    //                       selected: 4 == selectedIndex,
    //                       // color: MaterialStateColor.resolveWith((states) =>
    //                       //     const Color(AppConstants.primaryColor)
    //                       //         .withOpacity(0.8)),
    //                       onSelectChanged: (val) {
    //                         setState(() {
    //                           selectedIndex = 4;
    //                         });
    //                       },
    //                       cells: [
    //                         DataCell(Text(
    //                           'Basophil',
    //                           style: AppConstants.tableRowStyle,
    //                         )),
    //                         DataCell(Text(
    //                           '${basophilNumber ?? 0}',
    //                           style: AppConstants.tableRowStyle,
    //                         )),
    //                         DataCell(Text(
    //                           '${basophilProbability == null ? 0 : basophilProbability}',
    //                           style: AppConstants.tableRowStyle,
    //                         )),
    //                       ]),
    //                   DataRow(
    //                       selected: 5 == selectedIndex,
    //                       // color: MaterialStateColor.resolveWith((states) =>
    //                       //     const Color(AppConstants.primaryColor)
    //                       //         .withOpacity(0.8)),
    //                       onSelectChanged: (val) {
    //                         setState(() {
    //                           selectedIndex = 5;
    //                         });
    //                       },
    //                       cells: [
    //                         DataCell(Text(
    //                           'Lymphocyte',
    //                           style: AppConstants.tableRowStyle,
    //                         )),
    //                         DataCell(Text(
    //                           '${lymphocyteNumber ?? 0}',
    //                           style: AppConstants.tableRowStyle,
    //                         )),
    //                         DataCell(Text(
    //                           '${lymphocyteProbability == null ? 0 : lymphocyteProbability}',
    //                           style: AppConstants.tableRowStyle,
    //                         )),
    //                       ]),
    //                   DataRow(
    //                       selected: 6 == selectedIndex,
    //                       // color: MaterialStateColor.resolveWith((states) =>
    //                       //     const Color(AppConstants.primaryColor)
    //                       //         .withOpacity(0.8)),
    //                       onSelectChanged: (val) {
    //                         setState(() {
    //                           selectedIndex = 6;
    //                         });
    //                       },
    //                       cells: [
    //                         DataCell(Text(
    //                           'Monocyte',
    //                           style: AppConstants.tableRowStyle,
    //                         )),
    //                         DataCell(Text(
    //                           '${monocyteNumber ?? 0}',
    //                           style: AppConstants.tableRowStyle,
    //                         )),
    //                         DataCell(Text(
    //                           '${monocyteProbability ?? 0}',
    //                           style: AppConstants.tableRowStyle,
    //                         )),
    //                       ])
    //                 ]),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(50, 100),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: NavigationBarWidget(
            title: 'Result',
            showLogoutIcon: true,
            otherLastWidget: Container(),
            showPowerOffIcon: false,
            showWifiListIcon: true,
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(Home.routeName);
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
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 70),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              //  height: MediaQuery.of(context).size.height - 220,
              width: MediaQuery.of(context).size.width / 1.6,
              decoration: BoxDecoration(border: Border.all(color: Colors.blue)),

              child: Column(
                children: [
                  Expanded(
                    child: queryCells == null
                        ? GridView.builder(
                            primary: false,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              mainAxisSpacing: 2,
                              crossAxisSpacing: 2,
                            ),
                            itemCount: cells.length,
                            itemBuilder: (context, index) {
                              String path =
                                  '/home/sciverse/Documents/ViewPort/app/';
                              final completePath = path + cells[index].cellPath;
                              final myFile = File(completePath);

                              return Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white)),
                                child: Image.file(
                                  myFile,
                                  // fit: BoxFit.fill,
                                ),
                              );
                            })
                        : GridView.builder(
                            primary: false,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              mainAxisSpacing: 2,
                              crossAxisSpacing: 2,
                            ),
                            itemCount: queryCells!.length,
                            itemBuilder: (context, index) {
                              String path =
                                  '/home/sciverse/Documents/ViewPort/app/';
                              final completePath =
                                  path + queryCells![index].cellPath;
                              final myFile = File(completePath);
                              print('');

                              return Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(
                                            AppConstants.primaryColor))),
                                child: Image.file(myFile),
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
                height: MediaQuery.of(context).size.height - 40,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blue)),
                child: DataTable(
                    dataRowHeight: (MediaQuery.of(context).size.height) / 16,
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
                          label: Text('Absolute Count',
                              style: AppConstants.tableColumnStyle)),
                    ],
                    rows: [
                      DataRow(
                          //selected: 0 == selectedIndex,
                          // color: MaterialStateColor.resolveWith((states) =>
                          //     const Color(AppConstants.primaryColor)
                          //         .withOpacity(0.8)),
                          // onSelectChanged: (val) {
                          //   queryCells = cells
                          //       .where((cell) => cell.cellName.contains('RBC'))
                          //       .toList();
                          //   setState(() {
                          //     selectedIndex = 0;
                          //   });
                          // },
                          cells: [
                            DataCell(Text(
                              'Hemoglobin',
                              style: AppConstants.tableRowStyle,
                            )),
                            DataCell(Text(
                              '${hemoglobin}',
                              style: AppConstants.tableRowStyle,
                            )),
                            DataCell(Text(
                              '',
                              style: AppConstants.tableRowStyle,
                            )),
                          ]),
                      DataRow(
                          selected: 0 == selectedIndex,
                          // color: MaterialStateColor.resolveWith((states) =>
                          //     const Color(AppConstants.primaryColor)
                          //         .withOpacity(0.8)),
                          onSelectChanged: (val) {
                            queryCells = cells
                                .where((cell) => cell.cellName.contains('RBC'))
                                .toList();
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
                              '${rbc}',
                              style: AppConstants.tableRowStyle,
                            )),
                            DataCell(Text(
                              '',
                              style: AppConstants.tableRowStyle,
                            )),
                          ]),
                      DataRow(
                          // selected: 0 == selectedIndex,
                          // // color: MaterialStateColor.resolveWith((states) =>
                          // //     const Color(AppConstants.primaryColor)
                          // //         .withOpacity(0.8)),
                          // onSelectChanged: (val) {
                          //   queryCells = cells
                          //       .where((cell) => cell.cellName.contains('RBC'))
                          //       .toList();
                          //   setState(() {
                          //     selectedIndex = 0;
                          //   });
                          // },
                          cells: [
                            DataCell(Text(
                              'MCH',
                              style: AppConstants.tableRowStyle,
                            )),
                            DataCell(Text(
                              '${mch}',
                              style: AppConstants.tableRowStyle,
                            )),
                            DataCell(Text(
                              '',
                              style: AppConstants.tableRowStyle,
                            )),
                          ]),
                      DataRow(
                          selected: 1 == selectedIndex,
                          // color: MaterialStateColor.resolveWith((states) =>
                          //     const Color(AppConstants.primaryColor)
                          //         .withOpacity(0.8)),
                          onSelectChanged: (val) {
                            queryCells = cells
                                .where((cell) =>
                                    cell.cellName.contains('Platelets'))
                                .toList();
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
                              '${platelets}',
                              style: AppConstants.tableRowStyle,
                            )),
                            DataCell(Text(
                              '',
                              style: AppConstants.tableRowStyle,
                            )),
                          ]),
                      DataRow(
                          selected: 2 == selectedIndex,
                          // color: MaterialStateColor.resolveWith((states) =>
                          //     const Color(AppConstants.primaryColor)
                          //         .withOpacity(0.8)),
                          onSelectChanged: (val) {
                            queryCells = cells
                                .where((cell) =>
                                    cell.cellName.contains('Neutrophils'))
                                .toList();
                            setState(() {
                              selectedIndex = 2;
                            });
                          },
                          cells: [
                            DataCell(Text(
                              'Neutrophils',
                              style: AppConstants.tableRowStyle,
                            )),
                            DataCell(Text(
                              '${neutrophilNumber}',
                              style: AppConstants.tableRowStyle,
                            )),
                            DataCell(Text(
                              '${neutrophilNumber}',
                              style: AppConstants.tableRowStyle,
                            )),
                          ]),
                      DataRow(
                          selected: 3 == selectedIndex,
                          // color: MaterialStateColor.resolveWith((states) =>
                          //     const Color(AppConstants.primaryColor)
                          //         .withOpacity(0.8)),
                          onSelectChanged: (val) {
                            queryCells = cells
                                .where((cell) =>
                                    cell.cellName.contains('Eosinophils'))
                                .toList();
                            setState(() {
                              selectedIndex = 3;
                            });
                          },
                          cells: [
                            DataCell(Text(
                              'Eosinophils',
                              style: AppConstants.tableRowStyle,
                            )),
                            DataCell(Text(
                              '${eosinophilNumber}',
                              style: AppConstants.tableRowStyle,
                            )),
                            DataCell(Text(
                              '${eosinophilNumber}',
                              style: AppConstants.tableRowStyle,
                            )),
                          ]),
                      DataRow(
                          selected: 4 == selectedIndex,
                          // color: MaterialStateColor.resolveWith((states) =>
                          //     const Color(AppConstants.primaryColor)
                          //         .withOpacity(0.8)),
                          onSelectChanged: (val) {
                            queryCells = cells
                                .where((cell) =>
                                    cell.cellName.contains('Basophils'))
                                .toList();
                            setState(() {
                              selectedIndex = 4;
                            });
                          },
                          cells: [
                            DataCell(Text(
                              'Basophils',
                              style: AppConstants.tableRowStyle,
                            )),
                            DataCell(Text(
                              '${basophilNumber}',
                              style: AppConstants.tableRowStyle,
                            )),
                            DataCell(Text(
                              '${basophilNumber}',
                              style: AppConstants.tableRowStyle,
                            )),
                          ]),
                      DataRow(
                          selected: 5 == selectedIndex,
                          // color: MaterialStateColor.resolveWith((states) =>
                          //     const Color(AppConstants.primaryColor)
                          //         .withOpacity(0.8)),
                          onSelectChanged: (val) {
                            queryCells = cells
                                .where((cell) =>
                                    cell.cellName.contains('Lymphocytes'))
                                .toList();
                            setState(() {
                              selectedIndex = 5;
                            });
                          },
                          cells: [
                            DataCell(Text(
                              'Lymphocytes',
                              style: AppConstants.tableRowStyle,
                            )),
                            DataCell(Text(
                              '${lymphocyteNumber}',
                              style: AppConstants.tableRowStyle,
                            )),
                            DataCell(Text(
                              '${lymphocyteNumber}',
                              style: AppConstants.tableRowStyle,
                            )),
                          ]),
                      DataRow(
                          selected: 6 == selectedIndex,
                          // color: MaterialStateColor.resolveWith((states) =>
                          //     const Color(AppConstants.primaryColor)
                          //         .withOpacity(0.8)),
                          onSelectChanged: (val) {
                            queryCells = cells
                                .where((cell) =>
                                    cell.cellName.contains('Monocytes'))
                                .toList();
                            setState(() {
                              selectedIndex = 6;
                            });
                          },
                          cells: [
                            DataCell(Text(
                              'Monocytes',
                              style: AppConstants.tableRowStyle,
                            )),
                            DataCell(Text(
                              '${monocyteNumber}',
                              style: AppConstants.tableRowStyle,
                            )),
                            DataCell(Text(
                              '${monocyteNumber}',
                              style: AppConstants.tableRowStyle,
                            )),
                          ]),
                      DataRow(
                          selected: 6 == selectedIndex,
                          // color: MaterialStateColor.resolveWith((states) =>
                          //     const Color(AppConstants.primaryColor)
                          //         .withOpacity(0.8)),
                          onSelectChanged: (val) {
                            queryCells = null;
                            setState(() {
                              selectedIndex = 6;
                            });
                          },
                          cells: [
                            DataCell(Text(
                              'All',
                              style: AppConstants.tableRowStyle,
                            )),
                            DataCell(Text(
                              '',
                              style: AppConstants.tableRowStyle,
                            )),
                            DataCell(Text(
                              '',
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
