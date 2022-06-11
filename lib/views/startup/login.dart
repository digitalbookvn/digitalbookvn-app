import 'dart:async';
import 'dart:convert';

import 'package:arbook/models/response.dart';
import 'package:arbook/models/user.dart';
import 'package:arbook/views/home/home.dart';
import 'package:arbook/views/startup/register.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late User user;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _storage = const FlutterSecureStorage();

  String _email = '';
  String _password = '';
  Map<String, String> secret = {};

  @override
  void initState() {
    _readAll();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> login() async {
    // debugPrint("email ${_emailController.text} password ${_passwordController.text}");
    final http.Client httpClient = http.Client();
    try {
      final response = await httpClient.post(
          Uri.parse('http://arbook.vietpix.com/oauth/api/login/jwt'),
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
          body: {
            "email": _emailController.text,
            "password": _passwordController.text
          });
      final Response responseObject =
          Response.fromJson(json.decode(response.body));
      debugPrint(responseObject.status.toString());
      if (responseObject.status) {
        // xóa bỏ mật khẩu cũ
        await _deleteAll();
        await _addNewItem("email", _emailController.text);
        await _addNewItem("password", _passwordController.text);
        await _addNewItem('access_token', responseObject.accessToken);
        await _addNewItem('refresh_token', responseObject.refreshToken);
        debugPrint(responseObject.accessToken);
        debugPrint(responseObject.refreshToken);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
      } else {
        debugPrint("Login error");
        Fluttertoast.showToast(
            msg: "Sai tên đăng nhập hoặc mật khẩu",
            backgroundColor: Colors.red,
            textColor: Colors.white);
      }
    } catch (exception) {
      throw Exception("API Error");
    } finally {
      httpClient.close();
    }
  }

  IOSOptions _getIOSOptions() => const IOSOptions();

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  Future<void> _readAll() async {
    final all = await _storage.readAll(
        iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
    setState(() {
      for (var entry in all.entries) {
        secret[entry.key] = entry.value;
      }
      _email = secret["email"] ?? '';
      _password = secret["password"] ?? '';

      // debugPrint(secret.toString());
    });
    _emailController = TextEditingController(text: _email);
    _passwordController = TextEditingController(text: _password);
  }

  Future<void> _deleteAll() async {
    await _storage.deleteAll(
        iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
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
      body: Container(
        color: const Color(0xFFDFF1EB),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: ListView(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    "Đăng nhập",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.translate))
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Email",
                  style: TextStyle(
                      color: Color(0xFF707070),
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _emailController,
                // onChanged: (String value) {
                //   setState(() {
                //     _email = value;
                //   });
                // },
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    fillColor: Colors.white,
                    hoverColor: Colors.white,
                    focusColor: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Mật khẩu",
                  style: TextStyle(
                      color: Color(0xFF707070),
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _passwordController,
                // onChanged: (String value) {
                //   setState(() {
                //     _password = value;
                //   });
                // },
                obscureText: true,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    // hintText: "Nhập họ và tên",
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    fillColor: Colors.white,
                    hoverColor: Colors.white,
                    focusColor: Colors.white),
              ),
              const SizedBox(
                height: 50,
              ),
              TextButton(
                onPressed: () => login(),
                child: const Text(
                  "Đăng nhập",
                ),
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 12),
                    fixedSize: Size.fromWidth(
                        (MediaQuery.of(context).size.width - 65) / 2),
                    backgroundColor: const Color(0xFF006338),
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Color(0xFF006338),
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(50))),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Bạn chưa có tài khoản?",
                      style: TextStyle(
                          color: Color(0xff202020),
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterScreen()));
                    },
                    child: const Text("Đăng kí",
                        style: TextStyle(
                            color: Color(0xff006338),
                            fontWeight: FontWeight.w700)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
