import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:my_port/constants/app_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import '../widgets/navigation_bar-widget.dart';
import 'home.dart';
import 'login.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

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
  String? patientName;
  String? patientAge;
  TextEditingController toTextController = TextEditingController();
  TextEditingController subjectTextController = TextEditingController();
  TextEditingController ccTextController = TextEditingController();
  TextEditingController composeTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var uuid = const Uuid();

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
                /// kakxspxkwxcwlomr
                final pdf = pw.Document();
                pdf.addPage(pw.Page(
                    pageFormat: PdfPageFormat.a4,
                    build: (pw.Context context) {
                      return pw.Column(children: [
                        pw.Text('Patient Report',
                            style: pw.TextStyle(
                                fontSize: 30, fontWeight: pw.FontWeight.bold)),
                        pw.Text('Patient Name : Harsh'),
                        pw.SizedBox(
                          height: 20,
                        ),
                        pw.Table(children: [
                          pw.TableRow(
                            children: [
                              pw.Text('Name'),
                              pw.Text('Count'),
                              pw.Text('Probability'),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Text('RBC'),
                              pw.Text('${rbc == null ? 0 : rbc.toString()}'),
                              pw.Text(
                                  '${rbcProb == null ? 0 : rbcProb.toString()}'),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Text('Platelets'),
                              pw.Text(
                                  '${platelets == null ? 0 : plateletsProb.toString()}'),
                              pw.Text('Probability'),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Text('Neutrophils'),
                              pw.Text(
                                  '${neutrophilNumber == null ? 0 : neutrophilNumber.toString()}'),
                              pw.Text(
                                  '${neutrophilProbability == null ? 0 : neutrophilProbability.toString()}'),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Text('Eosinophils'),
                              pw.Text(
                                  '${eosinophilNumber == null ? 0 : eosinophilNumber.toString()}'),
                              pw.Text(
                                  '${eosinophilProbability == null ? 0 : eosinophilProbability.toString()}'),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Text('Basophils'),
                              pw.Text(
                                  '${basophilNumber == null ? 0 : basophilNumber.toString()}'),
                              pw.Text(
                                  '${basophilProbability == null ? 0 : basophilProbability.toString()}'),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Text('Lymphocyte'),
                              pw.Text(
                                  '${lymphocyteNumber == null ? 0 : lymphocyteNumber.toString()}'),
                              pw.Text(
                                  '${lymphocyteProbability == null ? 0 : lymphocyteProbability.toString()}'),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Text('Monocyte'),
                              pw.Text(
                                  '${monocyteNumber == null ? 0 : monocyteNumber.toString()}'),
                              pw.Text(
                                  '${monocyteProbability == null ? 0 : monocyteProbability.toString()}'),
                            ],
                          ),
                        ])
                      ]);
                    }));
                const path = '/home/sci/Documents/Patient Reports';
                await Directory(path).create(recursive: true);
                String fileName = uuid.v4();
                final file = File('$path/$fileName.pdf');
                await file.writeAsBytes(await pdf.save());
                if (!mounted) return;

                AppDialogs.showEmailDialog(
                    context: context,
                    initialValue: 'myportsci@gmail.com',
                    toEmailController: toTextController,
                    ccEmailController: ccTextController,
                    validator: (val) {
                      String pattern = AppConstants.emailPattern;
                      RegExp regEx = RegExp(pattern);
                      if (val!.isEmpty) {
                        return 'Please enter email!';
                      }
                      if (!regEx.hasMatch(val)) {
                        return 'Please enter valid email!';
                      }
                      return null;
                    },
                    subjectEditingController: subjectTextController,
                    composeTextEditingController: composeTextController,
                    pdfName: '$fileName.pdf',
                    function: () async {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save;

                        Navigator.of(context).pop();
                        AppDialogs.showCircularDialog(context: context);
                        if (ccTextController.text.isNotEmpty) {
                          String username = 'myportsci@gmail.com';
                          String password = 'kakxspxkwxcwlomr';
                          final smtpServer = gmail(username, password);
                          try {
                            final equivalentMessage = Message()
                              ..from = Address(username, 'MyPort')
                              ..recipients.add(Address(toTextController.text))
                              ..ccRecipients.addAll([
                                Address(ccTextController.text),
                              ])
                              ..subject = subjectTextController.text
                              ..text = composeTextController.text
                              ..html =
                                  '<h1>Patient Report</h1>\n<p> ${composeTextController.text} \nAttached pdf is patient report</p>'
                              ..attachments = [
                                FileAttachment(file)..location = Location.inline
                              ];
                            var connection = PersistentConnection(smtpServer);
                            await connection.send(equivalentMessage);
                            await connection.close();
                            toTextController.text = '';
                            ccTextController.text = '';
                            subjectTextController.text = '';
                            composeTextController.text = '';
                            Navigator.of(context).pop();
                            AppDialogs.showSuccessDialog(
                                context: context,
                                content: 'Email sent successfully.',
                                image: Icon(
                                  Icons.done,
                                  color: Color(AppConstants.primaryColor),
                                  size: 80,
                                ));
                          } catch (error) {
                            Navigator.of(context).pop();
                            toTextController.text = '';
                            ccTextController.text = '';
                            subjectTextController.text = '';
                            composeTextController.text = '';
                            AppDialogs.showErrorDialog(
                                context: context,
                                content: 'Error occurred sending email',
                                image: Icon(
                                  Icons.error,
                                  size: 80,
                                  color: Color(AppConstants.primaryColor),
                                ));
                            print('error sending mail $error');
                          }
                        } else {
                          String username = 'myportsci@gmail.com';
                          String password = 'kakxspxkwxcwlomr';
                          final smtpServer = gmail(username, password);
                          print(toTextController.text);
                          try {
                            final equivalentMessage = Message()
                              ..from = Address(username, 'MyPort')
                              ..recipients.add(Address(toTextController.text))
                              ..subject = subjectTextController.text
                              ..text = composeTextController.text
                              ..html =
                                  '<h1>Patient Report</h1>\n<p> ${composeTextController.text} \n \n Attached pdf is patient report</p>'
                              ..attachments = [
                                FileAttachment(file)..location = Location.inline
                              ];
                            var connection = PersistentConnection(smtpServer);
                            await connection.send(equivalentMessage);
                            await connection.close();
                            Navigator.of(context).pop();
                            toTextController.text = '';
                            ccTextController.text = '';
                            subjectTextController.text = '';
                            composeTextController.text = '';
                            AppDialogs.showSuccessDialog(
                                context: context,
                                content: 'Email sent successfully.',
                                image: Icon(
                                  Icons.done,
                                  color: Color(AppConstants.primaryColor),
                                  size: 80,
                                ));
                          } catch (error) {
                            toTextController.text = '';
                            ccTextController.text = '';
                            subjectTextController.text = '';
                            composeTextController.text = '';
                            Navigator.of(context).pop();
                            AppDialogs.showErrorDialog(
                                context: context,
                                content: 'Error occurred sending email',
                                image: Icon(
                                  Icons.error,
                                  size: 80,
                                  color: Color(AppConstants.primaryColor),
                                ));
                            print('error sending mail $error');
                          }
                        }
                      }
                    },
                    formKey: formKey);
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
                            '${rbcProb == null ? 0 : rbcProb.toString()}',
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
                            '${plateletsProb == null ? 0 : plateletsProb.toString()}',
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
