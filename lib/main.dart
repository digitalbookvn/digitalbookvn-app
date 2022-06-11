import 'dart:io';

import 'package:arbook/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await FlutterDownloader.initialize(debug: true);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // const MyApp({Key? key}) : super(key: key);

  Locale _locale = const Locale('vi');

  final appSupportedLocales = const [
    Locale('vi'),
    Locale('en'),
    Locale.fromSubtags(languageCode: 'vi', scriptCode: 'Thai'),
    Locale.fromSubtags(languageCode: 'vi', scriptCode: 'Cham'),
    Locale.fromSubtags(languageCode: 'vi', scriptCode: 'Khmer'),
    Locale.fromSubtags(languageCode: 'vi', scriptCode: 'Jrai'),
    Locale.fromSubtags(languageCode: 'vi', scriptCode: 'Mong'),
    Locale.fromSubtags(languageCode: 'vi', scriptCode: 'Mnong'),
    Locale.fromSubtags(languageCode: 'vi', scriptCode: 'Ede'),
    Locale.fromSubtags(languageCode: 'vi', scriptCode: 'Bahnar'),
  ];

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  checkPermission() async {
    // var status = await Permission.camera.status;
    if (await Permission.camera.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      await Permission.camera.request();
    }
    if (await Permission.storage.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      await Permission.storage.request();
    }
    // if (await Permission.``)

    // You can request multiple permissions at once.
    // Map<Permission, PermissionStatus> statuses = await [
    //   Permission.camera,
    //   Permission.storage,
    // ].request();
    // print(statuses[Permission.location]);

// You can can also directly ask the permission about its status.
//     if (await Permission.location.isRestricted) {
//       // The OS restricts access, for example because of parental controls.
//     }
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // Future<String> _currentLang;

  Future<void> _getCurrentLanguage() async {
    final SharedPreferences prefs = await _prefs;
    final String? currentLang = prefs.getString('lang');
    if (currentLang != null) {
      if (currentLang.length == 2) {
        setLocale(Locale(currentLang));
        debugPrint("Current lang $currentLang");
      } else {
        var code = currentLang.split('_');
        debugPrint(code[0]);
        setLocale(
            Locale.fromSubtags(languageCode: code[0], scriptCode: code[1]));
      }
    } else {
      // check device languages

      String deviceLanguage = Platform.localeName.substring(0, 2);

      debugPrint("Platform lang $deviceLanguage");

      if (deviceLanguage == "en") {
        setLocale(Locale(deviceLanguage));
        prefs.setString("lang", "en");
      } else {
        // setLocale(const Locale("vi"));
        prefs.setString("lang", "vi");
      }
    }
  }

  @override
  void initState() {
    checkPermission();
    _getCurrentLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AR Book',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: const MaterialColor(
            0xFFFFFFFF,
            <int, Color>{
              50: Color(0xFFFFFFFF),
              100: Color(0xFFFFFFFF),
              200: Color(0xFFFFFFFF),
              300: Color(0xFFFFFFFF),
              400: Color(0xFFFFFFFF),
              500: Color(0xFFFFFFFF),
              600: Color(0xFFFFFFFF),
              700: Color(0xFFFFFFFF),
              800: Color(0xFFFFFFFF),
              900: Color(0xFFFFFFFF),
            },
          ),
          primaryColor: Colors.white,
          colorScheme: const ColorScheme(
            primaryVariant: Colors.white,
            secondaryVariant: Color(0xFFFBEFEB),
            primary: Colors.white,
            onPrimary: Colors.white,
            background: Colors.white,
            onBackground: Colors.white,
            secondary: Color(0xFFFBEFEB),
            onSecondary: Colors.white,
            error: Colors.black,
            onError: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black,
            brightness: Brightness.light,
          ),
          canvasColor: Colors.white,
          backgroundColor: Colors.white,
          fontFamily: "Nunito",
          textTheme: const TextTheme(
            headline1: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF006338)),
            headline2: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF202020)),
            headline3: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF006338)),
            headline4: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF97923)),
            headline5: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF006338)),
            headline6: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF202020)),
            button: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFFFFF)),
            bodyText1: TextStyle(fontSize: 14, color: Color(0xFF707070)),
            bodyText2: TextStyle(
                fontSize: 16,
                color: Color(0xFF202020),
                fontWeight: FontWeight.bold,
                height: 1.5),
          ),
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: Color(0xFF006338)),
        ),
        supportedLocales: appSupportedLocales,
        locale: _locale,
        localizationsDelegates: [
          FlutterI18nDelegate(
            translationLoader: FileTranslationLoader(
              useScriptCode: true,
              fallbackFile: "vi",
              basePath: "assets/i18n",
              // forcedLocale: Locale("en"),
            ),
            missingTranslationHandler: (key, locale) {
              debugPrint(
                  "--- Missing Key: $key, languageCode: ${locale!.languageCode} Script code ${locale.scriptCode}");
            },
          ),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        builder: FlutterI18n.rootAppBuilder(),
        home: const Splash());
  }
}
