import 'package:flutter/material.dart';
import 'package:mvvm/presentation/main/home_view.dart';
import 'package:mvvm/presentation/main/notifications_view.dart';
import 'package:mvvm/presentation/main/search_view.dart';
import 'package:mvvm/presentation/main/settings_view.dart';
import 'package:mvvm/presentation/resources/color_manager.dart';
import 'package:mvvm/presentation/resources/strings_manager.dart';
import 'package:mvvm/presentation/resources/values_manager.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    HomeView(),
    SearchView(),
    NotificationsView(),
    SettingsView()
  ];

  List<String> titles = [
    AppStrings.home,
    AppStrings.search,
    AppStrings.notifications,
    AppStrings.settings,
  ];
  int _currentIndex = 0;

  var _title = AppStrings.home;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: ColorManager.black, spreadRadius: AppSize.s1_5)
        ]),
        child: BottomNavigationBar(
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.grey,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: AppStrings.home),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: AppStrings.search),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: AppStrings.notifications),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: AppStrings.settings),
          ],
        ),
      ),
      body: pages[_currentIndex],
    );
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }
}
