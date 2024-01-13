import 'dart:async';
import 'package:example/app.dart';
import 'package:flutter/material.dart';
import 'package:r2f_x3dh_e2e/r2f_x3dh_e2e.dart';

Future<void> main() async {
  await R2FX3DHE2ESer().init();
  runApp(const App());
}
