/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-06-01 11:15:30
 * @LastEditTime: 2021-06-01 15:14:24
 * @LastEditors: Walker
 */

// getExternalStorageDirectories

import 'dart:io';

import 'package:cloudmusic_flutter/model/MusicInfo.dart';
import 'package:cloudmusic_flutter/services/music.dart';
import 'package:cloudmusic_flutter/utils/http.dart';
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

  static Future<String> downloadFile(
    String fileName,
    String url,
    String path, {
    void Function(int, int)? onReceiveProgress,
  }) async {
    await checkPath();

    DioUtil.dio.download(url, basePath + '$path$fileName',
        onReceiveProgress: onReceiveProgress);
    return "";
  }

  static downloadMusic(
    MusicInfo info, {
    void Function(int, int)? onReceiveProgress,
  }) {
    getMusicUrl(info.id).then((result) {
      if (result[0]['url'] != null) {
        downloadFile(
          info.musicName,
          result[0]['url'],
          downloadMusicPath,
          onReceiveProgress: onReceiveProgress,
        );
      }
    });
  }

  static Future<List<FileSystemEntity>> getDownloadMusicList() async {
    await checkPath();

    var musicDir = new Directory('$basePath$downloadMusicPath');

    return musicDir.list().toList();
  }
}
