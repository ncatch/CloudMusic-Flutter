/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-31 16:48:48
 * @LastEditTime: 2021-05-31 17:32:59
 * @LastEditors: Walker
 */

import 'package:cloudmusic_flutter/services/video.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class MusicMlog extends StatefulWidget {
  MusicMlog({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MusicMlogState();
}

class MusicMlogState extends State<MusicMlog> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    // getVideoDetail('1472862669');

    _controller = VideoPlayerController.network(
        'http://p5.music.126.net/Y7FDCG2F2PxY69SJqiR1Og==/109951163788099542')
      // 'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  moreClick() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Stack(
        children: [
          Text(
            'title',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Positioned(
            child: TextButton(
              child: Text(
                '更多',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: moreClick,
            ),
            top: -3,
            right: 0,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
