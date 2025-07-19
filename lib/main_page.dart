import 'package:flutter/material.dart';
import 'package:vexhibition/brief_content.dart';
import 'package:vexhibition/briefing_data.dart';
import 'package:vexhibition/stream_pixel_embed.dart';
import 'package:vexhibition/table_widget.dart';
import 'package:vexhibition/tools.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isTitleOn = false;
  bool backgroundFocus = false;
  bool visibleDownIcon = true;
  bool playPixel = false;
  ScrollController contentScroll = ScrollController();
  Map<String, GlobalKey> tableData = {};

  void titleAnimation() async {
    await Future.delayed(Duration(milliseconds: 100));
    setState(() {
      isTitleOn = true;
      backgroundFocus = true;
    });
  }

  void setVisibleDownIcon() {
    setState(() {
      playPixel = false;
      visibleDownIcon = contentScroll.offset < 100;
    });
  }

  @override
  void initState() {
    super.initState();
    titleAnimation();
    contentScroll.addListener(setVisibleDownIcon);
  }

  @override
  void dispose() {
    contentScroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _background(),
        _content(),
        TableWidget(tableData, contentScroll),
      ],
    );
  }

  Widget _background() {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            "assets/images/main_background.png",
            fit: BoxFit.cover,
          ),
        ),
        AnimatedContainer(
          duration: Duration(seconds: 1),
          color: Colors.black.withValues(alpha: backgroundFocus ? 0.6 : 0.0),
        ),
      ],
    );
  }

  Widget _content() {
    return WebSmoothScroll(
      controller: contentScroll,
      child: SingleChildScrollView(
        controller: contentScroll,
        physics: isMobile() ? null : NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            _title(),
            _description(),
            ...briefingData.map((data) {
              GlobalKey key = GlobalKey();
              tableData[data.title] = key;
              return BriefContent(key, data);
            }),
            _streamPixel(),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    GlobalKey key = GlobalKey();
    tableData["VExhibition Project"] = key;
    return ScreenFrame(
      context,
      key: key,
      child: Stack(
        children: [
          Center(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: isTitleOn
                  ? (MediaQuery.of(context).size.width < 400 ? 150 : 100)
                  : 0,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "프로젝트 가상 전시회",
                      textAlign: TextAlign.center,
                      style: textStyle.copyWith(fontSize: 20),
                    ),
                    Text(
                      "VExhibition Project",
                      textAlign: TextAlign.center,
                      style: textStyle.copyWith(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            left: MediaQuery.of(context).size.width / 2 - 25,
            child: AnimatedOpacity(
              duration: Duration(seconds: 1),
              opacity: contentScroll.hasClients && visibleDownIcon ? 0.5 : 0,
              child: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _description() {
    GlobalKey key = GlobalKey();
    tableData["Summery"] = key;
    return ScreenFrame(
      context,
      key: key,
      padding: 100,
      child: Center(
        child: Row(
          spacing: 15,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Image.asset(
                "assets/images/unreal-engine-logo.png",
                width: 150,
              ),
            ),
            Flexible(
              flex: 3,
              child: Text(
                "\"메타버스만의 기능들을 접목하여,\n현실에서는 불가능한 색다른 전시 경험을 선사하는 가상 전시회 제작 프로젝트\"",
                textAlign: TextAlign.left,
                style: textStyle.copyWith(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _streamPixel() {
    GlobalKey key = GlobalKey();
    tableData["Play Embedding"] = key;
    return ScreenFrame(
      context,
      key: key,
      child: Center(
        child: playPixel
            ? Container(
                color: Colors.black,
                margin: EdgeInsets.all(100),
                child: StreamPixelEmbed(),
              )
            : IconButton(
                onPressed: () => setState(() {
                  playPixel = true;
                }),
                iconSize: 100,
                color: Colors.white.withValues(alpha: 0.7),
                icon: Icon(Icons.play_circle_outline),
              ),
      ),
    );
  }
}
