/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-29 11:53:57
 * @LastEditTime: 2021-04-29 17:18:03
 * @LastEditors: Walker
 */

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:volume_controller/volume_controller.dart';
import '../model/PlayInfo.dart';

import '../libs/config.dart';

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
  int playIndex = -1;

  MusicInfo musicInfo = new MusicInfo();
  String musicLyric = "";

  PlayInfoStore() {
    // 监听系统声音变化 调整播放声音
    VolumeController.volumeListener.listen((volume) {
      // TODO 调试 合适的音量变化
      audioPlayer.setVolume(volume / 2);
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
        // TODO 根据播放模式进行下一步操作 目前没有效果
        if (playIndex < musicList.length - 1) {
          next();
        } else {
          audioPlayer.stop();
        }
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
      lyricLoading = false;
      notifyListeners();
    });

    return getMusicUrl(id).then((result) {
      musicLoading = false;
      notifyListeners();

      return result;
    });
  }

  Future<int> playMusic(id) async {
    var res = await initPalyInfo(id);

    return audioPlayer
        .play(
      res[0]['url'],
      volume: _volume,
      stayAwake: true,
    )
        .then((value) {
      if (value != 1) {
        // 播放歌曲失败
        isPlayer = false;
        notifyListeners();
      }
      return value;
    });
  }

  // 设置播放列表
  setPlayList(List<MusicInfo> list, [int index = 0]) {
    if (musicList.length == 0 ||
        (list.length > 0 && list[0].id != musicList[0].id)) {
      musicList = list;

      this.setPlayIndex(index);
    }
  }

  // 设置当前播放歌曲的下标
  setPlayIndex(int index) {
    var tmp = musicList[index];

    if (musicInfo.id != tmp.id) {
      playIndex = index;
      sliderValue = 0.0;
      isPlayer = true;

      musicInfo = musicList[index];
      playMusic(musicInfo.id);

      notifyListeners();
    }
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
