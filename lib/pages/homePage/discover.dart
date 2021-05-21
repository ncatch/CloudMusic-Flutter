/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-01 14:05:41
 * @LastEditTime: 2021-05-21 19:21:04
 * @LastEditors: Walker
 */
import 'package:bot_toast/bot_toast.dart';
import 'package:cloudmusic_flutter/components/Base/HeightRefresh.dart';
import 'package:cloudmusic_flutter/components/SongList.dart';
import 'package:cloudmusic_flutter/components/SongListMusic.dart';
import 'package:cloudmusic_flutter/libs/config.dart';
import 'package:cloudmusic_flutter/libs/extends/Toast.dart';
import 'package:cloudmusic_flutter/libs/theme.dart';
import 'package:cloudmusic_flutter/model/Banner.dart';
import 'package:cloudmusic_flutter/model/Song.dart';
import 'package:cloudmusic_flutter/model/SongMusicList.dart';
import 'package:cloudmusic_flutter/services/home.dart';
import 'package:cloudmusic_flutter/store/SystemInfo.dart';
import 'package:cloudmusic_flutter/utils/preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:provider/provider.dart';

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
  List<dynamic> homeData = [];

  @override
  void initState() {
    super.initState();

    PreferenceUtils.getJSON(PreferencesKey.HOME_DATA).then((value) {
      if (value != null) {
        this.setState(() {
          homeData = value['blocks'];
        });
      }
    });

    refreshHomeData();
  }

  refreshHomeData() {
    return getHomeData().then((value) {
      if (value['code'] == 200) {
        PreferenceUtils.saveJSON(PreferencesKey.HOME_DATA, value['data']);
        setState(() {
          homeData = value['data']['blocks'];
        });
      } else {
        Toast(value['message'] ?? '网络异常');
      }
      return true;
    });
  }

  Widget getWidgetByType(ele) {
    switch (ele["showType"]) {
      case "BANNER":
        var data = List<BannerModel>.from(
            ele['extInfo']['banners'].map((ele) => BannerModel.fromJson(ele)));

        return BannerComponent.Banner(banners: data);
      case "HOMEPAGE_SLIDE_PLAYLIST":
        var data = SongListModel.fromJson(ele);

        return SongList(songList: data);
      case "HOMEPAGE_SLIDE_SONGLIST_ALIGN":
        var data = SongMusicListModel.fromJson(ele);

        return SongMusicList(model: data);
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tmp = [];

    if (homeData.length > 0) {
      for (var i = 0; i < homeData.length; i++) {
        var ele = homeData[i];

        tmp.add(getWidgetByType(ele));
      }

      tmp.insert(1, DiscoverMenu());
    }

    var systemInfo = Provider.of<SystemInfo>(context);

    return HeightRefresh(
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            height: 38,
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/search');
              },
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  Text(
                    '搜索',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
          ),
          brightness: systemInfo.brightNess,
        ),
        body: RefreshIndicator(
          color: primaryColor,
          onRefresh: () async {
            return refreshHomeData();
          },
          child: ListView(
            children: tmp,
          ),
        ),
      ),
    );
  }
}
