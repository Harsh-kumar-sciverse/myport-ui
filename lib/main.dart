import 'package:flutter/material.dart';
import 'my_port.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('patients');
  runApp(const MyPort());
}
