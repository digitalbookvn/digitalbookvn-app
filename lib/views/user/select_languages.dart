import 'package:arbook/models/language.dart';
import 'package:arbook/services/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';

class SelectLanguages extends StatefulWidget {
  const SelectLanguages({Key? key}) : super(key: key);

  @override
  _SelectLanguagesState createState() => _SelectLanguagesState();
}

class _SelectLanguagesState extends State<SelectLanguages> {
  List<Lang> lang = languages;

  var currentLang = 0;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // Future<Locale> currentLang;

  void checkCurrentLang() async {
    final SharedPreferences prefs = await _prefs;
    final String? currentLangCode = prefs.getString('lang');
    if (currentLangCode != null) {
      setState(() {
        currentLang =
            lang.indexWhere((element) => element.id == currentLangCode);
      });
    }
  }

  @override
  void initState() {
    checkCurrentLang();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: Scaffold(
        // appBar: AppBar(
        //   toolbarHeight: 0,
        //   backgroundColor: Theme.of(context).colorScheme.primary,
        //   elevation: 0,
        // ),
        body: Column(
          // shrinkWrap: true,
          children: <Widget>[
            Container(
                padding: const EdgeInsets.only(right: 22),
                height: 50,
                color: Theme.of(context).colorScheme.primary,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/back.svg',
                        width: 20,
                        height: 20,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Spacer(),
                  ],
                )),
            ListView.builder(
                shrinkWrap: true,
                itemCount: lang.length,
                itemBuilder: (BuildContext context, int index) {
                  return RadioListTile(
                    activeColor: Colors.blue,
                    title: Text(
                      lang[index].name,
                      style: TextStyle(fontFamily: lang[index].font),
                    ),
                    value: index,
                    groupValue: currentLang,
                    onChanged: (int? value) async {
                      setState(() {
                        currentLang = value!;
                      });
                      Locale locale;
                      print("Select"+lang[currentLang].id);
                      if (lang[currentLang].scriptCode != '') {
                        locale = Locale.fromSubtags(
                            languageCode: lang[currentLang].languageCode,
                            scriptCode: lang[currentLang].scriptCode);
                      } else {
                        locale = Locale(lang[currentLang].languageCode);
                      }
                      MyApp.setLocale(context, locale);
                      FlutterI18n.refresh(context, locale);
                      final SharedPreferences prefs = await _prefs;
                      await prefs.setString("lang", lang[currentLang].id);

                      Navigator.pop(context);
                    },
                  );
                }),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
