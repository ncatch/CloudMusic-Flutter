/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-01 14:05:41
 * @LastEditTime: 2021-05-08 16:42:00
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/components/SongList.dart';
import 'package:cloudmusic_flutter/components/SongListMusic.dart';
import 'package:cloudmusic_flutter/model/Banner.dart';
import 'package:cloudmusic_flutter/model/Song.dart';
import 'package:cloudmusic_flutter/model/SongMusicList.dart';
import 'package:cloudmusic_flutter/services/home.dart';
import 'package:cloudmusic_flutter/utils/preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

// 当前页面组件
import '../../../components/Banner.dart' as BannerComponent;
import './discover/menu.dart';

class Discover extends StatefulWidget {
  Discover({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DiscoverState();
}

class DiscoverState extends State<Discover> {
  List<Widget> homeModel = [];

  @override
  void initState() {
    super.initState();

    PreferenceUtils.getJSON(PreferencesKey.HOME_DATA).then((value) {
      initHomeComponents(value);
    });

    refreshHomeData();
  }

  refreshHomeData() {
    getHomeData().then((value) {
      if (value['code'] == 200) {
        PreferenceUtils.saveJSON(PreferencesKey.HOME_DATA, value['data']);
        initHomeComponents(value['data']);
      } else {
        EasyLoading.showToast(value['message'] ?? '网络异常');
      }
    }).catchError(() {
      EasyLoading.showToast('网络异常');
    });
  }

  initHomeComponents(value) {
    List<Widget> tmp = [];
    for (var i = 0; i < value['blocks'].length; i++) {
      var ele = value['blocks'][i];

      switch (ele["showType"]) {
        case "BANNER":
          var data = List<BannerModel>.from(ele['extInfo']['banners']
              .map((ele) => BannerModel.fromJson(ele)));

          tmp.add(BannerComponent.Banner(banners: data));
          break;
        case "HOMEPAGE_SLIDE_PLAYLIST":
          var data = SongListModel.fromJson(ele);

          tmp.add(SongList(songList: data));
          break;
        case "HOMEPAGE_SLIDE_SONGLIST_ALIGN":
          var data = SongMusicListModel.fromJson(ele);

          tmp.add(SongMusicList(model: data));
          break;
        default:
      }

      if (i == 0) {
        homeModel.add(DiscoverMenu());
      }
    }
    this.setState(() {
      homeModel = tmp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Column(
          children: homeModel,
        ),
      ),
    );
  }
}
