/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-07-05 10:50:03
 * @LastEditTime: 2021-07-05 10:50:54
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/components/Skeleton/Skeleton.dart';
import 'package:flutter/cupertino.dart';

class IconRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Skeleton(
              width: 50,
              height: 50,
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
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Skeleton(
                    width: 260,
                    height: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
