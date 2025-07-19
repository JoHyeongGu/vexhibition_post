import 'dart:ui_web' as ui_web;
import 'package:web/web.dart' as web;
import 'package:flutter/material.dart';

class StreamPixelEmbed extends StatelessWidget {
  StreamPixelEmbed({super.key}) {
    ui_web.platformViewRegistry.registerViewFactory('streampixel-iframe', (
      int viewId,
    ) {
      final iframe = web.HTMLIFrameElement()
        ..src = 'https://share.streampixel.io/687b582ede3b119ed0c0ce64'
        ..style.border = 'none'
        ..width = '100%'
        ..height = '600';
      return iframe;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: 'streampixel-iframe');
  }
}
