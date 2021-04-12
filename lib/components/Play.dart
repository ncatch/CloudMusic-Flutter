/*
 * @Description: 
 * @Author: nocatch
 * @Date: 2021-04-09 14:33:57
 * @LastEditTime: 2021-04-09 15:59:56
 * @LastEditors: Walker
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  PlayState(Map params) {
    this.musicInfo = params['info'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.keyboard_arrow_down),
          color: Colors.black,
        ),
        leadingWidth: 30,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          child: Text(
            musicInfo['name'],
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Container(
        child: Text(musicInfo['id'].toString()),
      ),
    );
  }
}
