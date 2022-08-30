/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-06 11:22:42
 * @LastEditTime: 2021-06-11 14:03:58
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/libs/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginLayout extends StatefulWidget {
  Widget child;
  double bottom;

  LoginLayout({Key? key, required this.child, this.bottom = 0})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginLayoutState();
}

class LoginLayoutState extends State<LoginLayout> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: primaryColor,
        alignment: Alignment.center,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: size.height * 0.15,
              height: 100,
              width: size.width,
              child: Image.asset(
                '/icon.png',
                width: 100,
                height: 100,
              ),
            ),
            Positioned(
                bottom: widget.bottom > 0 ? widget.bottom : (size.height * 0.2),
                width: size.width,
                child: widget.child),
          ],
        ),
      ),
    );
  }
}
