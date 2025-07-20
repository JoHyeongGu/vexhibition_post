import 'package:flutter/material.dart';
import 'package:vexhibition/tools.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class TableWidget extends StatefulWidget {
  final Map<String, GlobalKey> data;
  final ScrollController controller;
  const TableWidget(this.data, this.controller, {super.key});

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  bool onTable = false;
  ScrollController scrollController = ScrollController();
  String sectionTitle = "";
  String clickedSection = "";

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = onTable ? MediaQuery.of(context).size.width / 5 : 20;
    double height = onTable ? 45 * widget.data.keys.length.toDouble() : 100;
    return Positioned(
      right: 0,
      top: 100,
      child: MouseRegion(
        onEnter: (details) => setState(() {
          onTable = true;
        }),
        onExit: (details) => setState(() {
          onTable = false;
        }),
        child: GestureDetector(
          onTap: () => setState(() {
            onTable = !onTable;
          }),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOutQuart,
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: onTable ? 0.15 : 0.5),
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(onTable ? 30 : 100),
              ),
            ),
            padding: EdgeInsets.all(30),
            child: WebSmoothScroll(
              controller: scrollController,
              child: SingleChildScrollView(
                controller: scrollController,
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  spacing: 15,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (onTable)
                      ...widget.data.entries.map(
                        (e) => _section(e.key, e.value),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _section(String title, GlobalKey key) {
    return MouseRegion(
      onEnter: (details) => setState(() {
        sectionTitle = title;
      }),
      onExit: (details) => setState(() {
        sectionTitle = "";
      }),
      child: GestureDetector(
        onTapDown: (details) => setState(() {
          clickedSection = title;
        }),
        onTapUp: (details) => setState(() {
          clickedSection = "";
        }),
        onTap: () {
          Scrollable.ensureVisible(
            key.currentContext!,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            title,
            style: textStyle.copyWith(
              fontSize: 14,
              color: Colors.white.withValues(
                alpha: clickedSection == title
                    ? 1
                    : sectionTitle == title
                    ? 0.9
                    : 0.7,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
