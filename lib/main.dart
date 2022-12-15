import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:image_download/image_download/setting/theme_provider.dart/theme_provider.dart';

import 'package:image_download/image_download/utils/advertisement.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale("en", "US"), Locale("my", "MM")],
        path: 'language', // <-- change the path of the translation files
        fallbackLocale: const Locale('en', 'US'),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
      create: (context) {
        return ThemeProvider();
      },
      child: Consumer<ThemeProvider>(
        builder: (context, themevalue, child) {
          return MaterialApp(
              title: "Image Download",
              debugShowCheckedModeBanner: false,
              themeMode: themevalue.themeMode,
              theme: ThemeData(
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  selectedItemColor: Colors.green[900],
                ),
                switchTheme: SwitchThemeData(
                    thumbColor: MaterialStateProperty.all(Colors.green[900])),
                primaryColor: Colors.green[900],
                buttonTheme: ButtonThemeData(buttonColor: Colors.green[900]),
                brightness: Brightness.light,
                appBarTheme: AppBarTheme(backgroundColor: Colors.green[900]),
              ),
              darkTheme: ThemeData(
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  selectedItemColor: Color.fromARGB(255, 49, 47, 135),
                ),
                switchTheme: SwitchThemeData(
                    trackColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 49, 47, 135)),
                    thumbColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 5, 3, 131))),
                primaryColor: const Color.fromARGB(255, 5, 3, 131),
                brightness: Brightness.dark,
                appBarTheme: const AppBarTheme(
                    backgroundColor: Color.fromARGB(255, 5, 3, 131)),
              ),
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              home: Advertisement());
        },
      ),
    );
  }
}
