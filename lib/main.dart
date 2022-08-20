// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:offsbrasil/const/const.dart';
import 'package:offsbrasil/views/start-page.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();
  await Permission.storage.request();
  await Permission.microphone.request();
  await GetStorage.init();

  runApp(const RunApp());
}

class RunApp extends StatelessWidget {
  const RunApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Offs Brasil',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: THEME_COLOR,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: checkAutoLogin() ? StartPage() : LoginPage(),
      home: const StartPage(),
    );
  }
}

checkAutoLogin() {
  final loginData = GetStorage();
  final bool isLogged =
      loginData.read('logged') ?? false;
  return isLogged;
}
