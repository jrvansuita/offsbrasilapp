import 'dart:io';

import 'package:flutter/services.dart';

hideKeyboard() {
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}

checkIfDirectoryExists(String dir) async {
  bool exists = await Directory(dir).exists();

  if (exists == true) {
    return dir;
  } else {
    Directory(dir).create().then((Directory directory) {
      return directory.path;
    });
  }
}

Future<bool> onWillPop(context, webViewController) async {
  if (await webViewController.canGoBack()) {
    webViewController.goBack();
    return Future.value(false);
  } else {
    return Future.value(true);
  }
}
