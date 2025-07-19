import 'dart:html' as html;

import 'package:flutter/material.dart';

TextStyle textStyle = TextStyle(
  fontFamily: "JamSil",
  color: Colors.white,
  fontWeight: FontWeight.w400,
);

bool isMobile() {
  final userAgent = html.window.navigator.userAgent.toLowerCase();
  return userAgent.contains('iphone') ||
      userAgent.contains('android') ||
      userAgent.contains('ipad') ||
      userAgent.contains('mobile');
}

Widget ScreenFrame(
  BuildContext context, {
  required Widget child,
  double padding = 0,
  GlobalKey? key,
}) {
  return Container(
    key: key,
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    padding: EdgeInsets.all(padding),
    child: child,
  );
}
