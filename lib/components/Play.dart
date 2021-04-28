/*
 * @Description: 
 * @Author: nocatch
 * @Date: 2021-04-09 14:33:57
 * @LastEditTime: 2021-04-28 16:34:24
 * @LastEditors: Walker
 */

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/music.dart';

import 'package:audioplayers/audioplayers.dart';

class Play extends StatefulWidget {
  var params;

  Play({Map? params}) {
    this.params = params;
  }

  @override
  State<StatefulWidget> createState() => PlayState(params);
}

class PlayState extends State<Play> {
  var musicInfo;
  var musicList;

  var playInfo;
  AudioPlayer audioPlayer = new AudioPlayer();
  var sliderValue;
  var duration;
  var position;
  bool isPlayer = false;
  var playIndex;
  var musicLyric = null;

  bool musicLoading = true;
  bool lyricLoading = true;

  double volume = 0.2;

  PlayState(Map params) {
    this.musicInfo = params['info'];
    this.musicList = params['list'];
    this.playIndex = params['index'];
  }

  @override
  void initState() {
    super.initState();

    audioPlayer
      ..onDurationChanged.listen((e) {
        setState(() {
          duration = e;

          if (position != null) {
            sliderValue = (position.inSeconds / duration.inSeconds);
          }
        });
      })
      ..onAudioPositionChanged.listen((e) {
        setState(() {
          position = e;

          if (duration != null) {
            sliderValue = (position.inSeconds / duration.inSeconds);
          }
        });
      })
      ..onPlayerCompletion.listen((event) {
        audioPlayer.stop();
      });

    playMusic(musicInfo['id']);
  }

  @override
  deactivate() {
    audioPlayer.dispose();

    super.deactivate();
  }

  play() async {
    var result;
    if (isPlayer) {
      result = await audioPlayer.pause();
    } else {
      result = await audioPlayer.resume();
    }

    if (result == 1) {
      // success
      setState(() {
        isPlayer = !isPlayer;
      });
    }
  }

  Future<List<dynamic>> initPalyInfo(id) {
    this.setState(() {
      musicLoading = true;
      lyricLoading = true;
    });
    getMusicLyric(id).then((lyric) {
      var tmp;
      if (lyric != null &&
          lyric['lrc'] != null &&
          lyric['lrc']['lyric'] != null) {
        tmp = lyric['lrc']['lyric'];
      }

      this.setState(() {
        musicLyric = tmp;
        lyricLoading = false;
      });
    });

    return getMusicUrl(id).then((result) {
      this.setState(() {
        playInfo = result;
        musicLoading = false;
      });

      return result;
    });
  }

  Future<int> playMusic(id) async {
    var res = await initPalyInfo(id);

    return audioPlayer
        .play(
      res[0]['url'],
      volume: volume,
      stayAwake: true,
    )
        .then((value) {
      if (value == 1) {
        this.setState(() {
          isPlayer = true;
        });
      }
      return value;
    });
  }

  // 上一首
  previous() {
    if (playIndex > 0) {
      var index = playIndex - 1;
      var tmp = musicList[index];

      playMusic(tmp['id']);

      this.setState(() {
        playIndex = index;
        musicInfo = tmp;
      });
    }
  }

  // 下一首
  next() {
    if (playIndex < musicList.length - 1) {
      var index = playIndex + 1;
      var tmp = musicList[index];

      playMusic(tmp['id']);

      this.setState(() {
        playIndex = index;
        musicInfo = tmp;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new NetworkImage(musicInfo['artists'][0]['img1v1Url']),
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                    Colors.black54,
                    BlendMode.overlay,
                  ),
                ),
              ),
            ),
            Container(
                child: new BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Opacity(
                opacity: 0.6,
                child: new Container(
                  decoration: new BoxDecoration(
                    color: Colors.grey.shade900,
                  ),
                ),
              ),
            )),
            Container(
              child: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.keyboard_arrow_down),
                  color: Colors.white,
                ),
                leadingWidth: 30,
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Center(
                  child: Column(
                    children: [
                      Text(
                        musicInfo['name'],
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      Text(
                        musicInfo['artists'][0]['name'],
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              width: width,
              top: 60,
              height: height - 200,
              child: Container(
                alignment: Alignment.center,
                child: lyricLoading
                    ? Text(
                        '歌词加载中...',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : Text(
                        musicLyric == null
                            ? '歌曲暂无歌词'
                            : musicLyric,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
              ),
            ),
            Positioned(
                width: width,
                bottom: 10,
                child: Column(
                  children: [
                    Slider(
                      onChanged: (newValue) {
                        if (duration != null) {
                          int seconds = (duration.inSeconds * newValue).round();
                          audioPlayer.seek(new Duration(seconds: seconds));
                        }
                      },
                      activeColor: Colors.white,
                      inactiveColor: Colors.white,
                      value: sliderValue ?? 0.0,
                    ),
                    Wrap(
                      // alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        IconButton(
                          onPressed: previous,
                          icon: Icon(Icons.skip_previous_outlined),
                          color: playIndex == 0 ? Colors.grey : Colors.white,
                          iconSize: 30,
                        ),
                        IconButton(
                          onPressed: play,
                          icon: Icon(isPlayer
                              ? Icons.pause_circle_outline
                              : Icons.play_circle_outline),
                          color: Colors.white,
                          iconSize: 50,
                        ),
                        IconButton(
                          onPressed: next,
                          icon: Icon(Icons.skip_next_outlined),
                          color: playIndex >= musicList.length - 1
                              ? Colors.grey
                              : Colors.white,
                          iconSize: 30,
                        )
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
