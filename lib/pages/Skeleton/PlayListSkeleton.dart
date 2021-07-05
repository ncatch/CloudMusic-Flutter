/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-07-05 10:27:19
 * @LastEditTime: 2021-07-05 11:54:29
 * @LastEditors: Walker
 */

import 'package:cloudmusic_flutter/components/Skeleton/IconRow.dart';
import 'package:cloudmusic_flutter/components/Skeleton/Skeleton.dart';
import 'package:flutter/cupertino.dart';

class PlayListSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var iconRow = IconRow();

    return Wrap(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Skeleton(
                  width: 80,
                  height: 80,
                ),
              ),
              Expanded(
                flex: 1,
                child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 10),
                      child: Skeleton(
                        width: 300,
                        height: 20,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 10),
                      child: Skeleton(
                        width: 150,
                        height: 20,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Skeleton(
                        width: 150,
                        height: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        iconRow,
        iconRow,
        iconRow,
      ],
    );
  }
}
