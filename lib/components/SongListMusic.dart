/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-02 16:09:03
 * @LastEditTime: 2021-06-02 15:37:41
 * @LastEditors: Walker
 */
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudmusic_flutter/components/Base/HomeBlock.dart';
import 'package:cloudmusic_flutter/components/Play.dart';
import 'package:cloudmusic_flutter/components/SongList.dart';
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
  List<SongMusic> musicList = [];

  @override
  initState() {
    super.initState();

    widget.model.musicList.forEach((element) {
      musicList.addAll(element);
    });
  }

  String handleSongName(String val) {
    if (val.length <= 10) return val;

    return val.substring(0, 9) + '...';
  }

  musicClick(context, [int? id]) {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
      int index = 0;
      if (id != null) {
        index = musicList.indexWhere((element) => element.id == id);
      }
      Provider.of<PlayInfoStore>(context).setPlayList(musicList, index);

      // 页面跳转时传入参数
      return Play();
    }));
  }

  void btnClick(context) {
    musicClick(context);
  }

  moreClick() {}

  @override
  Widget build(BuildContext context) {
    return HomeBlock(
      height: 200,
      title: widget.model.title,
      btnText: widget.model.btnText,
      onPressed: moreClick,
      child: Container(
        child: Container(
          height: 180,
          margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
          child: Swiper(
            key: UniqueKey(),
            itemBuilder: (BuildContext context, int page) {
              var pageData = widget.model.musicList[page];
              return Column(
                children: pageData.map<Widget>(
                  (tmp) {
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
                              child: CachedNetworkImage(
                                imageUrl: tmp.iconUrl,
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
                ).toList(),
              );
            },
            index: 0,
            itemCount: widget.model.musicList.length,
          ),
        ),
      ),
    );
  }
}
