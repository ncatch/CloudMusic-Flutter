/*
 * @Description: 
 * @Author: nocatch
 * @Date: 2021-04-03 15:50:55
 * @LastEditTime: 2021-05-21 17:32:40
 * @LastEditors: Walker
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Blogs extends StatefulWidget {
  Blogs({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BlogsState();
  }
}

class BlogsState extends State<Blogs> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('博客'));
  }
}
