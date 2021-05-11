/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-29 11:53:57
 * @LastEditTime: 2021-05-11 17:34:34
 * @LastEditors: Walker
 */

import 'dart:convert';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloudmusic_flutter/libs/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:volume_controller/volume_controller.dart';
import '../model/PlayInfo.dart';
import '../model/MusicInfo.dart';

import '../libs/config.dart';
import '../utils/preference.dart';

import '../services/music.dart';

class PlayInfoStore with ChangeNotifier {
  //1
  AudioPlayer audioPlayer = new AudioPlayer();

  double sliderValue = 0.0;
  Duration duration = new Duration();
  Duration position = new Duration();
  double _volume = 0.2;

  bool isPlayer = false;

  bool musicLoading = true;
  bool lyricLoading = true;

  List<MusicInfo> musicList = [];
  MusicInfo musicInfo = new MusicInfo();
  String musicLyric = "";
  List<String> lyricArr = [];
  int playIndex = -1;

  var playMode = playModes.repeat;

  PlayInfoStore() {
    // 监听系统声音变化 调整播放声音
    VolumeController.volumeListener.listen((volume) {
      audioPlayer.setVolume(volume);
      _volume = volume;
    });
    VolumeController.getVolume().then((volume) => _volume = volume);

    audioPlayer
      ..onDurationChanged.listen((e) {
        duration = e;
        sliderValue = (position.inSeconds / duration.inSeconds);
        notifyListeners();
      })
      ..onAudioPositionChanged.listen((e) {
        position = e;
        sliderValue = (position.inSeconds / duration.inSeconds);
        notifyListeners();
      })
      ..onPlayerCompletion.listen((event) {
        switch (playMode) {
          case playModes.order:
            if (playIndex < musicList.length - 1) {
              next();
            } else {
              audioPlayer.stop();
            }
            break;
          case playModes.random:
            var tmpIndex;
            do {
              tmpIndex = Random().nextInt(musicList.length);
            } while (tmpIndex == playIndex);

            setPlayIndex(tmpIndex);
            break;
          case playModes.repeat:
            if (playIndex < musicList.length - 1) {
              next();
            } else {
              setPlayIndex(0);
            }
            break;
          case playModes.repeatOne:
            position = new Duration(seconds: 0);
            audioPlayer.seek(position);
            break;
        }
      });

    getCacheData();
  }

  // 获取缓存数据
  getCacheData() async {
    var cache = await PreferenceUtils.getJSON(PreferencesKey.PLAY_INFO);

    if (cache != null) {
      playIndex = cache['playIndex'];
      musicLyric = cache['musicLyric'];
      playMode = playModes.values[cache['playModeval']];
      musicInfo = MusicInfo.fromJson(cache['musicInfo']);

      musicList = List<MusicInfo>.from(
          cache['musicList'].map((ele) => MusicInfo.fromJson(ele)));

      initPalyInfo(musicInfo.id);
    }
  }

  // 缓存数据
  cacheData() {
    var playModeIndex = playModes.values.indexOf(playMode);

    PreferenceUtils.saveJSON(PreferencesKey.PLAY_INFO, {
      "playIndex": playIndex,
      "musicLyric": musicLyric,
      "musicInfo": musicInfo,
      "musicList": musicList,
      "playModeval": playModeIndex,
    });
  }

  // 初始化播放信息 歌词 播放链接
  Future<List<dynamic>> initPalyInfo(id) {
    musicLoading = true;
    lyricLoading = true;
    notifyListeners();

    getMusicLyric(id).then((lyric) {
      var tmp = "歌曲暂无歌词";
      if (lyric != null &&
          lyric['lrc'] != null &&
          lyric['lrc']['lyric'] != null) {
        tmp = lyric['lrc']['lyric'];
      }

      musicLyric = tmp;
      lyricArr = tmp.split('\n');
      lyricLoading = false;
      notifyListeners();
    });

    getMusicDetail([id]).then((res) {
      if (res.length > 0) {
        // musicInfo.id = id;
        // musicInfo.iconUrl = res[0]['al']['picUrl'];
        // musicInfo.musicName = res[0]['name'];
        // musicInfo.singerName = res[0]['ar'][0]['name'];

        musicInfo = MusicInfo.fromData(res[0]);

        if (musicList.indexWhere((ele) => ele.id == id) < 0) {
          musicList.add(musicInfo);
        }

        notifyListeners();
      }
    });

    return getMusicUrl(id).then((result) {
      musicLoading = false;
      setPlayMusic(result[0]['url']);
      notifyListeners();

      return result;
    });
  }

  setPlayMusic(String url) {
    audioPlayer.setUrl(url);
    audioPlayer.setVolume(_volume);
  }

  Future<int> playMusic(id) async {
    await initPalyInfo(id);

    return audioPlayer.resume().then((value) {
      sliderValue = 0.0;
      isPlayer = value == 1;
      notifyListeners();
      return value;
    });
  }

  // 设置播放列表
  setPlayList(List<MusicInfo> list, [int index = 0]) {
    if (musicList.length == 0 ||
        (list.length > 0 && list[0].id != musicList[0].id)) {
      musicList = list;
      this.setPlayIndex(index);

      cacheData();
    } else if (index != playIndex) {
      this.setPlayIndex(index);
    }
  }

  // 设置当前播放歌曲的下标
  setPlayIndex(int index) {
    var tmp = musicList[index];

    if (musicInfo.id != tmp.id) {
      playIndex = index;
      isPlayer = true;

      // musicInfo = musicList[index];
      musicInfo.bgImgUrl = tmp.bgImgUrl;
      playMusic(tmp.id);
      cacheData();
    }
  }

  removeByIndex(index) {
    musicList.removeAt(index);

    if (playIndex >= index) {
      playIndex--;
    }
    if (playIndex < 0) {
      playIndex = 0;
    }

    notifyListeners();
  }

  // 修改播放模式
  changePlayMode(playModes mode) {
    playMode = mode;
    notifyListeners();
  }

  // 播放/暂停
  // TODO 暂停声音逐渐减小
  play() async {
    var result;
    if (isPlayer) {
      result = await audioPlayer.pause();
    } else {
      result = await audioPlayer.resume();
    }

    if (result == 1) {
      // success
      isPlayer = !isPlayer;
      notifyListeners();
    }
  }

  // 上一首
  previous() {
    playIndex > 0 && setPlayIndex(playIndex - 1);
  }

  // 下一首
  next() {
    playIndex < musicList.length - 1 && setPlayIndex(playIndex + 1);
  }
}
