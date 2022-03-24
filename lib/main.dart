import 'package:flutter/material.dart';
import 'package:mvvm/app/app.dart';
import 'package:mvvm/app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(App());
}
