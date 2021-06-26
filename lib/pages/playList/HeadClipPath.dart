/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-19 11:20:01
 * @LastEditTime: 2021-05-19 12:24:58
 * @LastEditors: Walker
 */
import 'package:flutter/material.dart';

class HeadClipPath extends AnimatedWidget {
  const HeadClipPath({
    Key? key,
    required ValueNotifier<double> valNotifier,
  }) : super(
          key: key,
          listenable: valNotifier,
        );

  @override
  Widget build(BuildContext context) {
    var sunkenHeightNoti = (listenable as ValueNotifier<double>).value;

    return ClipPath(
      key: UniqueKey(), // 不加这个 不会重新渲染
      clipper: HeadClipper(
        sunkenHeight: sunkenHeightNoti,
      ),
      child: Container(
        decoration: new BoxDecoration(
          color: Colors.white,
        ),
      ),
    );
  }
}

class HeadClipper extends CustomClipper<Path> {
  double sunkenHeight;

  HeadClipper({Key? key, this.sunkenHeight = 0});

  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0); //第一个点

    var firstControlPoint = Offset(size.width / 2, sunkenHeight); //曲线开始点
    var firstendPoint = Offset(size.width, 0); // 曲线结束点

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstendPoint.dx, firstendPoint.dy);

    path.lineTo(size.width, size.height); //第二个点
    path.lineTo(0, size.height); //第四个点
    path.lineTo(0, 0); // 第五个点
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
