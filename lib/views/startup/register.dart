import 'package:arbook/models/response.dart';
import 'package:arbook/services/api.dart';
import 'package:arbook/views/startup/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  void submit() async {
    final Response response = await API.post({
      "data": {
        "name": _nameController.text,
        "roles":["user"],
        "modules":["arbook"],
        "arbook":{
          "liked_book":[],
          "viewed_book":[]
        }
      },
      "email":_emailController.text,
      "password":_passwordController.text
    }, '$urlBase/arbook/api/user/register');

    if(response.status) {
      Fluttertoast.showToast(
          msg: "Đăng kí thành công",
          backgroundColor: Colors.green,
          textColor: Colors.white);
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              transitionDuration: const Duration(seconds: 0),
              pageBuilder: (context, animation1, animation2) =>
              const LoginScreen()));

    } else {
      Fluttertoast.showToast(
          msg: response.error ?? "Error",
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }
  }

  void validate() {
    // if (_nameController.text.isEmpty) or (s)
  }

  @override
  void initState() {
    super.initState();
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
                    "Đăng kí",
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
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    // hintText: "hãy n/hập email của bạn",
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
                  "Họ và tên",
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
                controller: _nameController,
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
                obscureText: true,
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
                height: 50,
              ),
              TextButton(
                onPressed: () => submit(),
                child: const Text(
                  "Đăng kí",
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
                  const Text("Bạn đã có tài khoản?",
                      style: TextStyle(
                          color: Color(0xff202020),
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      // debugPrint('Login');
                      Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                              transitionDuration: const Duration(seconds: 0),
                              pageBuilder: (context, animation1, animation2) =>
                                  const LoginScreen()));
                    },
                    child: const Text("Đăng nhập",
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
