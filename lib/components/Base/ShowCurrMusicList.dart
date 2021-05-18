/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-08 17:16:45
 * @LastEditTime: 2021-05-18 16:49:07
 * @LastEditors: Walker
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowCurrMusicList {
  getListItem(playInfoStore) {
    int playCount = playInfoStore.musicList.length;

    return ListView.builder(
      itemCount: playCount,
      itemBuilder: (context, index) {
        var tmpInfo = playInfoStore.musicList[index];

        return InkWell(
            onTap: () {
              playInfoStore.setPlayIndex(index);
              Navigator.pop(context);
            },
            child: Container(
              height: 30,
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Text(
                          tmpInfo.musicName,
                        ),
                        Text(
                          '-' + tmpInfo.singerName,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }

  showMusicList(context, playInfoStore) {
    int playCount = playInfoStore.musicList.length;

    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: false,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
          padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Flex(
            direction: Axis.vertical,
            children: [
              Container(
                height: 50,
                alignment: Alignment.centerLeft,
                child: Text(
                  '当前播放（$playCount）',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(flex: 1, child: getListItem(playInfoStore))
            ],
          ),
        );
      },
    );
  }
}
