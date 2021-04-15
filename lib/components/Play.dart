/*
 * @Description: 
 * @Author: nocatch
 * @Date: 2021-04-09 14:33:57
 * @LastEditTime: 2021-04-15 17:49:02
 * @LastEditors: Walker
 */

import 'dart:developer';
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
  var playInfo;
  AudioPlayer audioPlayer = new AudioPlayer();
  var sliderValue;
  var duration;
  var position;
  bool isPlayer = false;

  PlayState(Map params) {
    this.musicInfo = params['info'];
  }

  @override
  void initState() {
    super.initState();

    audioPlayer
      ..onDurationChanged.listen((duration) {
        setState(() {
          this.duration = duration;

          if (this.position != null) {
            this.sliderValue = (this.position.inSeconds / duration.inSeconds);
          }
        });
      })
      ..onAudioPositionChanged.listen((position) {
        setState(() {
          this.position = position;

          if (this.duration != null) {
            this.sliderValue = (position.inSeconds / this.duration.inSeconds);
          }
        });
      });

    getMusicUrl(musicInfo['id']).then((result) async {
      setState(() {
        playInfo = result;
      });
    });
  }

  @override
  deactivate() {
    audioPlayer.dispose();

    super.deactivate();
  }

  void play() async {
    var result;
    if (this.isPlayer) {
      result = await audioPlayer.pause();
    } else {
      result = await audioPlayer.play(playInfo[0]['url']);
    }

    if (result == 1) {
      // success
      this.setState(() {
        isPlayer = !isPlayer;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Stack(children: <Widget>[
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
            )),
          ),
        ),
        Container(
            padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    play();
                  },
                  icon: Icon(isPlayer ? Icons.pause : Icons.play_arrow),
                  color: Colors.white,
                ),
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
                Text(
                  sliderValue.toString() +
                      '-' +
                      duration.toString() +
                      '-' +
                      position.toString(),
                )
              ],
            ))
      ])),
    );
  }
}
