import 'dart:async';

import 'package:arbook/models/response.dart';
import 'package:arbook/models/user.dart';
import 'package:arbook/services/api.dart';
import 'package:arbook/views/home/collection.dart';
import 'package:arbook/views/dashboard/dashboard.dart';
import 'package:arbook/views/home/menu.dart';
import 'package:arbook/views/user/info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

// search() {}

class _HomeState extends State<Home> {
  final _storage = const FlutterSecureStorage();

  Map<String, String> secret = {};

  IOSOptions _getIOSOptions() => const IOSOptions();

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  late User user;

  Future<void> _readAll() async {
    final all = await _storage.readAll(
        iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
    setState(() {
      for (var entry in all.entries) {
        secret[entry.key] = entry.value;
      }

    });
  }

  int _selectedIndex = 0;

  // static const TextStyle optionStyle = TextStyle(fontSize: 20);
  static final List<Widget> _widgetOptions = <Widget>[
    const Dashboard(),
    const Menu(),
    const Collection(),
    const UserInfo(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
      await _readAll();
      String email = secret['email'] ?? '';
      final Response response = await API.get({}, '$urlBase/arbook/api/user/profile/$email');
      setState(() {
        user =User.fromJson(response.item);
        debugPrint(user.id);
        secret['uuid']=user.id;
      });
      _addNewItem('uuid', user.id);


  }

  Future<void> _addNewItem(key, value) async {
    await _storage.write(
        key: key,
        value: value,
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(index: _selectedIndex, children: _widgetOptions),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0XFF21A56C),
          unselectedItemColor: const Color(0xFF869A95),
          elevation: 15,
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/nav_home.svg',
                  width: 24,
                  height: 24,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/nav_home_fill.svg',
                  width: 24,
                  height: 24,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/nav_book.svg',
                  width: 24,
                  height: 24,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/nav_book_fill.svg',
                  width: 24,
                  height: 24,
                ),
                label: 'Menu'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/nav_bookmark_blank.svg',
                  width: 24,
                  height: 24,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/nav_bookmark.svg',
                  width: 24,
                  height: 24,
                ),
                label: 'Lib'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/nav_user.svg',
                  width: 24,
                  height: 24,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/nav_user_fill.svg',
                  width: 24,
                  height: 24,
                ),
                label: 'User'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ));
  }
}
