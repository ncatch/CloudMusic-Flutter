/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-06-01 11:15:30
 * @LastEditTime: 2021-06-02 10:56:40
 * @LastEditors: Walker
 */

// getExternalStorageDirectories

import 'dart:io';

import 'package:cloudmusic_flutter/model/MusicInfo.dart';
import 'package:cloudmusic_flutter/services/music.dart';
import 'package:cloudmusic_flutter/utils/http.dart';
import 'package:cloudmusic_flutter/utils/preference.dart';
import 'package:path_provider/path_provider.dart';

class FileUtil {
  static String basePath = "";
  static String downloadMusicPath = "/download/music";

  static checkPath() async {
    if (basePath == "") {
      Directory appDocDir = await getApplicationDocumentsDirectory();

      basePath = appDocDir.path;
    }
  }

  static Future<List<MusicInfo>> getDownloadMusicList() async {
    List<MusicInfo> list = [];

    var storage = await PreferenceUtils.getJSON(PreferencesKey.DOWNLOAD_MUSIC);
    if (storage != null) {
      list = List<MusicInfo>.from(
          storage.map<MusicInfo>((ele) => MusicInfo.fromJson(ele)));
    }

    return list;
  }

  static Future<String> downloadFile(
    String fileName,
    String url,
    String path, {
    void Function(int, int)? onReceiveProgress,
  }) async {
    await checkPath();

    String saveUrl = basePath + '$path/$fileName.mp3';

    return DioUtil.dio
        .download(url, saveUrl, onReceiveProgress: onReceiveProgress)
        .then((value) {
      if (onReceiveProgress != null) {
        onReceiveProgress(1, 1);
      }
      return saveUrl;
    });
  }

  static downloadMusic(
    MusicInfo info, {
    void Function(int, int)? onReceiveProgress,
  }) {
    getMusicUrl(info.id).then((result) {
      if (result[0]['url'] != null) {
        // TODO 下载歌词
        downloadFile(
          info.id.toString(),
          result[0]['url'],
          downloadMusicPath,
          onReceiveProgress: onReceiveProgress,
        ).then((value) async {
          info.localUrl = value;

          List<MusicInfo> list = await getDownloadMusicList();

          list.add(info);

          PreferenceUtils.saveJSON(PreferencesKey.DOWNLOAD_MUSIC, list);
        });
      }
    });
  }

  static Future deleteMusic(MusicInfo info) async {
    List<MusicInfo> list = await getDownloadMusicList();

    list.removeAt(list.indexWhere((ele) => ele.id == info.id));

    File file = new File(info.localUrl);

    try {
      file.deleteSync();
    } catch (e) {
      print(e);
    }

    PreferenceUtils.saveJSON(PreferencesKey.DOWNLOAD_MUSIC, list);
  }

  // static Future<List<FileSystemEntity>> getDownloadMusicList() async {
  //   await checkPath();

  //   var musicDir = new Directory('$basePath$downloadMusicPath');

  //   if (await musicDir.exists()) {
  //     return musicDir.list().toList();
  //   } else {
  //     musicDir.create();
  //     return [];
  //   }
  // }
}
