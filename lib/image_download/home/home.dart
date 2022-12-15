import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_download/image_download/search/search.dart';
import 'package:image_download/image_download/setting/setting/setting.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  int iconCurrentIndex = 0;
  List<Widget> widgetList = const [Search(), Setting()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: iconCurrentIndex,
          onTap: (value) {
            setState(() {
              iconCurrentIndex = value;
            });
          },
          // unselectedIconTheme: IconThemeData(color: Colors.green[900]),
          // selectedItemColor: Colors.green[900],
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.home), label: tr("Home")),
            BottomNavigationBarItem(
                icon: const Icon(Icons.settings), label: tr("Setting")),
          ]),
      body: SafeArea(
          bottom: false, top: false, child: widgetList[iconCurrentIndex]),
    );
  }
}
