import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:offsbrasil/const/const.dart';
import 'package:offsbrasil/views/start_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginData = GetStorage();

    final emailController = TextEditingController();
    final passController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: THEME_COLOR,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Image.asset('assets/logo/logo.png'),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
              child: TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(20),
                  hintText: 'Email',
                  filled: true,
                  fillColor: Color.fromRGBO(242, 242, 242, 1),
                ),
                controller: emailController,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
              child: TextField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  border: InputBorder.none,
                  hintText: 'Senha',
                  filled: true,
                  fillColor: Color.fromRGBO(242, 242, 242, 1),
                ),
                obscureText: true,
                controller: passController,
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 80,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                child: FlatButton(
                  color: const Color.fromRGBO(255, 92, 74, 1),
                  onPressed: () {
                    loginData.write('email', emailController.text);
                    loginData.write('pass', passController.text);
                    loginData.write('logged', true);

                    Get.to(const StartPage());
                  },
                  child: const Text(
                    'ENTRAR',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
