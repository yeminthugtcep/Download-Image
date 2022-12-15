import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class Language extends StatefulWidget {
  LanguageState createState() {
    return LanguageState();
  }
}

class LanguageState extends State<Language> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr("Language")),
        centerTitle: true,
      ),
      body: ListView(children: [
        Card(
          child: GestureDetector(
              onTap: () {
                context.locale = const Locale("en", "US");
              },
              child: ListTile(
                title: Text(tr("Englash Language")),
                // trailing: EasyLocalization.of(context)!.locale ==
                //         const Locale("en", "US")
                //     ? const Icon(Icons.check)
                //     : Text(tr("Select")),
              )),
        ),
        Card(
          child: GestureDetector(
            onTap: () {
              context.locale = const Locale("my", "MM");
            },
            child: ListTile(
              title: Text(tr("Myanmar Language")),
              // trailing: EasyLocalization.of(context)!.locale ==
              //         const Locale("my", "MM")
              //     ? const Icon(Icons.check)
              //     : Text(tr("Select")),
            ),
          ),
        ),
      ]),
    );
  }
}
