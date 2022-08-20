import 'package:flutter/material.dart';
import 'package:offsbrasil/const/const.dart';
import 'package:social_media_buttons/social_media_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 92, 74, 1),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Image.asset('assets/logo/logo.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    TELEPHONE,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    child: const Text(
                      WHATSAPP,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onTap: () {
                      launch(WHATSAPP_MSG);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    child: const Text(
                      EMAIL,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onTap: () {
                      launch("mailto:$EMAIL");
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      ADDRESS,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SocialMediaButton.instagram(
                  url: INSTAGRAM_URL,
                  size: 35,
                  color: Colors.white,
                  onTap: () {},
                ),
                const SocialMediaButton.facebook(
                  url: FACEBOOK_URL,
                  color: Colors.white,
                  size: 35,
                ),
                const SocialMediaButton.youtube(
                  url: YOUTUBE_URL,
                  size: 35,
                  color: Colors.white,
                ),
                const SocialMediaButton.facebook(
                  url: BLOG_URL,
                  iconData: Icons.rss_feed,
                  color: Colors.white,
                  size: 35,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
