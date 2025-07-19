import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:vexhibition/briefing_data.dart';
import 'package:vexhibition/tools.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class BriefContent extends StatefulWidget {
  final GlobalKey tableKey;
  final Briefing data;
  const BriefContent(this.tableKey, this.data, {super.key});

  @override
  State<BriefContent> createState() => _BriefContentState();
}

class _BriefContentState extends State<BriefContent> {
  int itemIndex = 0;
  double imageSlideHeight = 400;

  void setItemIndex(int index) {
    setState(() {
      itemIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isOneItem = widget.data.content.length <= 1;
    return Padding(
      key: widget.tableKey,
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height / 10,
      ),
      child: Column(
        children: [
          Text("개발 진행 상황", style: textStyle.copyWith(fontSize: 15)),
          Text(widget.data.title, style: textStyle.copyWith(fontSize: 40)),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: isMobile() ? 0 : 30,
            ),
            child: ImageSlideshow(
              height: imageSlideHeight,
              indicatorRadius: isOneItem ? 0 : 3,
              onPageChanged: setItemIndex,
              disableUserScrolling: isOneItem,
              children: widget.data.content.map((data) {
                late YoutubePlayerController youtubeController;
                bool isYoutube = data.image.contains("youtube:");
                if (isYoutube) {
                  double time = data.image.contains("?time=")
                      ? double.parse(data.image.split("?time=").last)
                      : 0;
                  youtubeController = YoutubePlayerController.fromVideoId(
                    videoId: data.image
                        .replaceFirst("youtube:", "")
                        .split("?time=")
                        .first,
                    autoPlay: false,
                    startSeconds: time,
                    params: const YoutubePlayerParams(
                      showFullscreenButton: true,
                    ),
                  );
                }
                return GestureDetector(
                  onTap: () {
                    if (isYoutube) return;
                    showDialog(
                      context: context,
                      animationStyle: AnimationStyle(
                        duration: Duration(milliseconds: 300),
                      ),
                      barrierColor: Colors.black.withValues(alpha: 0.9),
                      builder: (builder) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Dialog(
                          child: Image.asset(
                            data.image,
                            fit: BoxFit.contain,
                            height: double.infinity,
                          ),
                        ),
                      ),
                    );
                  },
                  child: isYoutube
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 4,
                          ),
                          child: YoutubePlayer(
                            controller: youtubeController,
                            aspectRatio: 16 / 9,
                          ),
                        )
                      : Image.asset(data.image, fit: BoxFit.contain),
                );
              }).toList(),
            ),
          ),
          Text(
            widget.data.content[itemIndex].description,
            style: textStyle.copyWith(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
