import 'package:arbook/models/language.dart';
import 'package:arbook/services/data.dart';
import 'package:arbook/views/startup/login.dart';
import 'package:arbook/views/user/select_languages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:arbook/models/user.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final User user = const User(
    id: '1',
    ten: 'Min',
    email: 'minmin@gmail.com',
    anh: 'assets/images/avater.png',
    data: {},
  );

  final List<Lang> lang = languages;

  var current_lang = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).colorScheme.secondary,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              Stack(children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                  radius: 40,
                ),
                Positioned(
                    height: 18,
                    width: 18,
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        // color: Colors.white,
                        padding: const EdgeInsets.all(4),
                        iconSize: 10,
                        icon: SvgPicture.asset('assets/icons/camera.svg'),
                        onPressed: () {
                          // print('Change avatar');
                        },
                      ),
                    )),
              ]),
              const SizedBox(
                height: 10,
              ),
              Text(
                user.ten,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF006338)),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                user.email,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 30),
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/info.svg',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    FlutterI18n.translate(context, 'user.profile'),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF202020)),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    'assets/icons/forward.svg',
                    width: 10,
                    height: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/password.svg',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    FlutterI18n.translate(context, 'user.change-password'),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF202020)),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    'assets/icons/forward.svg',
                    width: 10,
                    height: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/read-book.svg',
                    width: 24,
                    height: 24,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    FlutterI18n.translate(context, 'user.read-books'),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF202020)),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    'assets/icons/forward.svg',
                    width: 10,
                    height: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 35,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectLanguages()));
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/global.svg',
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      FlutterI18n.translate(context, 'user.language'),
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF202020)),
                    ),
                    const Spacer(),
                    Text(
                      FlutterI18n.translate(context, 'user.language-name'),
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset(
                      'assets/icons/forward.svg',
                      width: 10,
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/logout.svg',
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      FlutterI18n.translate(context, 'user.logout'),
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF202020)),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
