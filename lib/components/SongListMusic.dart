/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-02 16:09:03
 * @LastEditTime: 2021-05-08 16:04:51
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/components/Play.dart';
import 'package:cloudmusic_flutter/model/SongMusicList.dart';
import 'package:cloudmusic_flutter/store/PlayInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SongMusicList extends StatefulWidget {
  SongMusicListModel model;

  SongMusicList({Key? key, required this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SongListMusicState();
}

class SongListMusicState extends State<SongMusicList> {
  String handleSongName(String val) {
    if (val.length <= 10) return val;

    return val.substring(0, 9) + '...';
  }

  musicClick(context, id) {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
      Provider.of<PlayInfoStore>(context).playMusic(id);
      // 页面跳转时传入参数
      return Play();
    }));
  }

  void moreSongList() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Stack(
        children: [
          Text(
            widget.model.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Positioned(
            child: TextButton(
              child: Text(
                widget.model.btnText,
                style: TextStyle(color: Colors.black),
              ),
              onPressed: moreSongList,
            ),
            top: -3,
            right: 0,
          ),
          Container(
            child: Container(
              height: 180,
              margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: Swiper(
                itemBuilder: (BuildContext context, int page) {
                  var pageData = widget.model.musicLists[page];
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      var tmp = pageData[index];

                      return InkWell(
                        onTap: () {
                          musicClick(context, tmp.id);
                        },
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Container(
                              width: 45,
                              height: 40,
                              margin: EdgeInsets.fromLTRB(0, 0, 15, 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  tmp.iconUrl,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Wrap(
                              direction: Axis.vertical,
                              children: [
                                Row(
                                  children: [
                                    Text(handleSongName(tmp.musicName)),
                                    Text(
                                      ' - ' + tmp.singerName,
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ),
                                Container(
                                  child: Text(tmp.descript),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: pageData.length,
                  );
                },
                index: 0,
                autoplay: false,
                loop: false,
                itemCount: widget.model.musicLists.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
