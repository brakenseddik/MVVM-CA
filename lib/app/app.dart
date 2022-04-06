import 'package:flutter/material.dart';
import 'package:mvvm/presentation/resources/routes_manager.dart';
import 'package:mvvm/presentation/resources/theme_manager.dart';

// ignore: must_be_immutable
class App extends StatelessWidget {
  //STEP 1
  static final App instance = App._internal();
  //single instance singleton
  int appState = 0;
  //STEP 2

  factory App() => instance;
  //STEP 3

  App._internal();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mv & Vm',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashRoute,
      onGenerateRoute: RouteGenerator.getRoute,
      theme: appTheme(),
    );
  }
}
