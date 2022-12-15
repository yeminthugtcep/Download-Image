import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_download/image_download/home/home.dart';
import 'package:image_download/image_download/search/search.dart';
import 'package:image_download/image_download/setting/applanguage/applanguage.dart';
import 'package:image_download/image_download/setting/theme_provider.dart/theme_provider.dart';
import 'package:image_download/image_download/utils/extension.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  SettingState createState() {
    return SettingState();
  }
}

class SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr("Setting")),
        centerTitle: true,
      ),
      body: ListView(children: [
        Card(
          child: ListTile(
            leading: const Icon(Icons.brightness_2),
            title: Text(tr("Night Mode")),
            trailing: Consumer<ThemeProvider>(
              builder: (context, themevalue, child) {
                return Switch(
                    value: themevalue.themeMode == ThemeMode.dark,
                    onChanged: (isOn) {
                      if (isOn) {
                        themevalue.changeToDark();
                      } else {
                        themevalue.changeToLight();
                      }
                    });
              },
            ),
          ),
        ),
        Card(
          child: GestureDetector(
            onTap: () {
              context.push(Language()).then((value) {
                setState(() {});
              });
            },
            child: ListTile(
              leading: const Icon(Icons.language),
              title: Text(tr("Language")),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
        ),
      ]),
    );
  }
}
