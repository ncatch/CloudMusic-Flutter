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

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {
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
              bottom: size.height * 0.2,
              width: size.width,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/AccountLogin');
                    },
                    child: Container(
                      width: size.width * 0.7,
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '立即登录',
                        style: TextStyle(color: primaryColor),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: size.width * 0.7,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 15),
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '立即体验',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
