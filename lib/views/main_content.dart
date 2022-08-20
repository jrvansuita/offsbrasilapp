import 'dart:io' show Platform;

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:offsbrasil/const/const.dart';
import 'package:offsbrasil/utils/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MainContent extends StatefulWidget {
  const MainContent({Key? key}) : super(key: key);

  @override
  _MainContentState createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  late InAppWebViewController webViewController;
  double _progress = 0;
  final loginData = GetStorage();



  Widget webView() {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: Uri.parse(LOGIN_URL)),
      initialOptions: InAppWebViewGroupOptions(
        android: AndroidInAppWebViewOptions(
          useHybridComposition: true,
        ),
        crossPlatform: InAppWebViewOptions(
            useOnDownloadStart: true,
            cacheEnabled: true,
            useShouldOverrideUrlLoading: true),
      ),
      onWebViewCreated: (InAppWebViewController controller) {
        webViewController = controller;
      },
      onProgressChanged: (controller, progress) {
        setState(() {
          _progress = progress / 100;
        });
      },
      onLoadStart: (controller, url) async {
        hideKeyboard();
      },
      onDownloadStart: (controller, url) async {
        String dir;

        if (Platform.isAndroid) {
          dir = await ExternalPath.getExternalStoragePublicDirectory(
              ExternalPath.DIRECTORY_DOWNLOADS);
        } else {
          dir = (await getApplicationDocumentsDirectory()).path;
        }

        await FlutterDownloader.enqueue(
          url: "$url",
          savedDir: dir.toString(),
          showNotification: false,
          openFileFromNotification: false,
        ).whenComplete(
          () => Fluttertoast.showToast(
              msg: 'Download completo! Arquivo salvo em $dir',
              gravity: ToastGravity.CENTER,
              toastLength: Toast.LENGTH_LONG),
        );
      },
      androidOnPermissionRequest: (controller, origin, resources) async {
        print(origin);
        print(resources);
        return PermissionRequestResponse(
            resources: resources,
            action: PermissionRequestResponseAction.GRANT);
      },
      shouldOverrideUrlLoading: (controller, shouldOverrideUrlLoadingRequest) async {
        String url = shouldOverrideUrlLoadingRequest.request.url.toString();

        String action = url.split(':').first;
        List<String> customUrls = ['tel', 'whatsapp', 'mailto'];
        bool isCustomUrl = customUrls.contains(action);

        if (isCustomUrl) {
          if (await canLaunch(url)) {
            launch(url);
            return NavigationActionPolicy.CANCEL;
          }
        }
        return NavigationActionPolicy.ALLOW;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(context, webViewController),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              Stack(
                children: <Widget>[
                  Container(
                    height: 35,
                    padding: EdgeInsets.zero,
                    color: const Color.fromRGBO(237, 237, 237, 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            webViewController.goBack();
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        IconButton(
                          onPressed: () {
                            webViewController.reload();
                          },
                          icon: const Icon(Icons.replay_outlined),
                        ),
                        IconButton(
                          onPressed: () {
                            webViewController.goForward();
                          },
                          icon: const Icon(Icons.arrow_forward),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: _progress < 1.0
                        ? LinearProgressIndicator(
                            value: _progress,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color.fromRGBO(255, 92, 74, 1),
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
              Expanded(
                child: webView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

// void _onRefresh() async {
//   await Future.delayed(Duration(milliseconds: 1000));
//   webViewController.reload();

//   _refreshController.refreshCompleted();
// }

// void _onLoading() async {
//   await Future.delayed(Duration(milliseconds: 1000));
//   _refreshController.loadComplete();
// }
}
