/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-31 17:46:41
 * @LastEditTime: 2021-06-02 15:41:46
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
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Positioned(
            child: TextButton(
              child: Text(
                btnText,
                style: TextStyle(color: Colors.black),
              ),
              onPressed: onPressed,
            ),
            top: -3,
            right: 0,
          ),
          child
        ],
      ),
    );
  }
}
