import 'dart:core';

import 'package:arbook/models/language.dart';
import 'package:arbook/services/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubLang extends StatefulWidget {
  @override
  SubLangState createState() => SubLangState();
}

class SubLangState extends State<SubLang> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late String subtitle1;
  late String subtitle2;

  List<Lang> listSubtitle1 = languages;

  List<Lang> listSubtitle2 = languages;

  var font = {
    "vi": "Nunito",
    "en": "Nunito",
    "thai": "Thai",
    "mong": "Nunito",
    "mnong": "Nunito",
    "khmer": "Khmer",
    "ede": "Nunito",
    "jrai": "Nunito",
    "cham": "Cham",
    "bahnar": "Nunito",
  };

  Future<void> getSubtitleFromSharedPrefernces() async {
    final SharedPreferences prefs = await _prefs;
    subtitle1 = prefs.getString('subtitle1')!;
    subtitle2 = prefs.getString('subtitle2')!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.only(right: 22),
              height: 50,
              child: Row(
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
          Text("Phụ đề 1"),
          Column(
            children: List.generate(listSubtitle1.length, (index) {
              return ListTile(
                title: const Text('Thomas Jefferson'),
                leading: Radio<String>(
                  value: listSubtitle1[index].id,
                  groupValue: subtitle1,
                  onChanged: (String? value) {
                    setState(() {
                      subtitle1 = value!;
                    });
                  },
                ),
              );
            }),
          ),
          Text("Phụ đề 2"),
          // Container(
          //   child: ListView.builder(
          //       itemCount: listSubtitle1.length,
          //       itemBuilder: (context, index) => Container()),
          // ),
        ],
      ),
    );
  }
}
