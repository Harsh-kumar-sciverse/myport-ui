import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import '../widgets/navigation_bar-widget.dart';
import 'home.dart';
import 'login.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ViewDetails extends StatefulWidget {
  static const routeName = 'view-details';
  const ViewDetails({Key? key}) : super(key: key);

  @override
  State<ViewDetails> createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  final patients = Hive.box('patients');
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
  final pdf = pw.Document();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final arguments1 = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final key = arguments1['key'];
    final arguments = patients.get(key);
    platelets = (arguments['platelets']);
    plateletsProb = arguments['plateletsProb'];
    rbc = arguments['rbc'];
    rbcProb = arguments['rbcProb'];
    neutrophilNumber = arguments['neutrophils'];
    neutrophilProbability = arguments['neutrophilsProb'];
    eosinophilNumber = arguments['eosinophils'];
    eosinophilProbability = arguments['eosinophilProb'];
    basophilNumber = arguments['basophils'];
    basophilProbability = arguments['basophilProb'];
    lymphocyteNumber = arguments['lymphocyts'];
    lymphocyteProbability = arguments['lymphocytProb'];
    monocyteNumber = arguments['monocytes'];
    monocyteProbability = arguments['monocyteProb'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(50, 100),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: NavigationBarWidget(
            title: 'Final Report',
            showLogoutIcon: true,
            otherLastWidget: ElevatedButton(
              onPressed: () async {
                // pdf.addPage(pw.Page(
                //     pageFormat: PdfPageFormat.a4,
                //     build: (pw.Context context) {
                //       return pw.Center(
                //         child: pw.Text("Hello World"),
                //       ); // Center
                //     }));
                final file = File('C:/Users/HARSH/my_folder/example.pdf');
                XFile file2 = XFile(file.path);
                // await file.writeAsBytes(await pdf.save());
                Share.shareXFiles([file2], subject: 'wedwwedw');

                // On Flutter, use the [path_provider](https://pub.dev/packages/path_provider) library:
              },
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(), backgroundColor: Colors.white),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.share,
                  color: Color(AppConstants.primaryColor),
                ),
              ),
            ),
            showPowerOffIcon: true,
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
                        DataRow(cells: [
                          DataCell(Text(
                            'RBC',
                            style: AppConstants.tableRowStyle,
                          )),
                          DataCell(Text(
                            '${rbc == null ? 0 : rbc.toString()}',
                            style: AppConstants.tableRowStyle,
                          )),
                          DataCell(Text(
                            '${rbcProb == null ? 0 : double.parse(rbcProb.toString()).toStringAsFixed(2)}',
                            style: AppConstants.tableRowStyle,
                          )),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(
                            'Platelets',
                            style: AppConstants.tableRowStyle,
                          )),
                          DataCell(Text(
                            '${platelets == null ? 0 : platelets.toString()}',
                            style: AppConstants.tableRowStyle,
                          )),
                          DataCell(Text(
                            '${plateletsProb == null ? 0 : double.parse(plateletsProb.toString()).toStringAsFixed(2)}',
                            style: AppConstants.tableRowStyle,
                          )),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(
                            'Neutrophil',
                            style: AppConstants.tableRowStyle,
                          )),
                          DataCell(Text(
                            '${neutrophilNumber ?? 0}',
                            style: AppConstants.tableRowStyle,
                          )),
                          DataCell(Text(
                            '${neutrophilProbability == null ? 0 : neutrophilProbability}',
                            style: AppConstants.tableRowStyle,
                          )),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(
                            'Eosinophil',
                            style: AppConstants.tableRowStyle,
                          )),
                          DataCell(Text(
                            '${eosinophilNumber ?? 0}',
                            style: AppConstants.tableRowStyle,
                          )),
                          DataCell(Text(
                            '${eosinophilProbability == null ? 0 : eosinophilProbability}',
                            style: AppConstants.tableRowStyle,
                          )),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(
                            'Basophil',
                            style: AppConstants.tableRowStyle,
                          )),
                          DataCell(Text(
                            '${basophilNumber ?? 0}',
                            style: AppConstants.tableRowStyle,
                          )),
                          DataCell(Text(
                            '${basophilProbability == null ? 0 : basophilProbability}',
                            style: AppConstants.tableRowStyle,
                          )),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(
                            'Lymphocyte',
                            style: AppConstants.tableRowStyle,
                          )),
                          DataCell(Text(
                            '${lymphocyteNumber ?? 0}',
                            style: AppConstants.tableRowStyle,
                          )),
                          DataCell(Text(
                            '${lymphocyteProbability == null ? 0 : lymphocyteProbability}',
                            style: AppConstants.tableRowStyle,
                          )),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(
                            'Monocyte',
                            style: AppConstants.tableRowStyle,
                          )),
                          DataCell(Text(
                            '${monocyteNumber ?? 0}',
                            style: AppConstants.tableRowStyle,
                          )),
                          DataCell(Text(
                            '${monocyteProbability ?? 0}',
                            style: AppConstants.tableRowStyle,
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
      ),
    );
  }
}
