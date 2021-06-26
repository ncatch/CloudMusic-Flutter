/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-27 19:20:49
 * @LastEditTime: 2021-05-28 14:49:28
 * @LastEditors: Walker
 */
import 'package:flutter/material.dart';

class ModelComponent extends StatelessWidget {
  final List<Widget> children;
  final String title;
  final String descript;
  TextStyle? titleStyle;

  ModelComponent({
    Key? key,
    required this.children,
    this.title = "",
    this.descript = '',
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
      padding: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title != ""
              ? Container(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    title,
                    style: titleStyle ??
                        TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                )
              : Container(
                  padding: EdgeInsets.only(top: 15),
                ),
          ...children,
        ],
      ),
    );
  }
}
