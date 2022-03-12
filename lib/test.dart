import 'package:flutter/material.dart';
import 'package:mvvm/app/app.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  void update() {
    App.instance.appState = 10;
  }
  
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
