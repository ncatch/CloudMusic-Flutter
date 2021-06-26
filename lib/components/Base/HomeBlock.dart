/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-31 17:46:41
 * @LastEditTime: 2021-06-02 19:18:54
 * @LastEditors: Walker
 */

import 'package:flutter/material.dart';

class HomeBlock extends StatelessWidget {
  String title;
  String btnText;
  void Function() onPressed;
  Widget child;
  double? height;

  HomeBlock({
    Key? key,
    required this.child,
    required this.title,
    required this.btnText,
    required this.onPressed,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      margin: EdgeInsets.only(bottom: 15),
      child: Stack(
        children: [
          Container(
            height: 40,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Container(
                  width: 80,
                  child: TextButton(
                    child: Text(
                      btnText,
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: onPressed,
                  ),
                )
              ],
            ),
          ),
          child
        ],
      ),
    );
  }
}
