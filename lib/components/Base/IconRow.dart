/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-07-05 13:39:18
 * @LastEditTime: 2021-07-05 13:41:21
 * @LastEditors: Walker
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudmusic_flutter/model/PlayList.dart';
import 'package:cloudmusic_flutter/pages/playList/index.dart';
import 'package:flutter/material.dart';
import 'package:cloudmusic_flutter/libs/extends/StringExtend.dart';
import 'package:cloudmusic_flutter/libs/extends/IntExtend.dart';

class IconRow extends StatelessWidget {
  String image;
  String title;
  String descript;
  Function()? onTap;

  IconRow({
    Key? key,
    required this.title,
    required this.descript,
    required this.image,
    this.onTap,
  });

  songClick(context, id) {
    if (id > 0) {
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
        return PlayList(
          songId: id,
        );
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 80,
              height: 55,
              padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                Text(
                  descript,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
