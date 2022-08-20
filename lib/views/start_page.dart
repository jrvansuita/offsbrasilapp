import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:offsbrasil/const/const.dart';
import 'package:offsbrasil/views/contact.dart';
import 'package:offsbrasil/views/main_content.dart';
import 'package:share/share.dart';


class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int selectedIndex = 1;

  final List<Widget> pages = [
    const ContactPage(),
    const MainContent(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          Platform.isAndroid ? materialAppBar() : cupertinoAppBar(),
      body: IndexedStack(index: selectedIndex, children: pages),
    );
  }

  void onItemSelected(int index) {
    if (index == 2) {
      Share.share(SHARE_CONTENT);
    } else {
      setState(() {
        selectedIndex = index;
      });
    }
  }

  Widget materialAppBar() {
    return BottomNavigationBar(
      backgroundColor: const Color.fromRGBO(237, 237, 237, 1),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: 'Atendimento',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mic),
          label: 'Offs Brasil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.share),
          label: 'Compartilhar',
        ),
      ],
      currentIndex: selectedIndex,
      fixedColor: const Color.fromRGBO(62, 62, 62, 1),
      onTap: onItemSelected,
    );
  }

  Widget cupertinoAppBar() {
    return CupertinoTabBar(
      backgroundColor: const Color.fromRGBO(237, 237, 237, 1),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: 'Atendimento',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mic),
          label: 'Offs Brasil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.share),
          label: 'Compartilhar',
        ),
      ],
      currentIndex: selectedIndex,
      onTap: onItemSelected,
      activeColor: const Color.fromRGBO(62, 62, 62, 1),
    );
  }
}
