import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'my_port.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('patients');
  runApp(const MyPort());
}
