/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-06 11:22:42
 * @LastEditTime: 2021-06-01 17:56:31
 * @LastEditors: Walker
 */
import 'package:bot_toast/bot_toast.dart';
import 'package:cloudmusic_flutter/libs/extends/Toast.dart';
import 'package:cloudmusic_flutter/libs/theme.dart';
import 'package:cloudmusic_flutter/services/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../store/User.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {
  bool passwordVisible = false;

  TextEditingController? phoneText;
  TextEditingController? passwordText;

  @override
  initState() {
    super.initState();

    phoneText = TextEditingController();
    passwordText = TextEditingController();

    phoneText?.value = TextEditingValue(text: '15083525898');
    passwordText?.value = TextEditingValue(text: 'nocatch.96');
  }

  @override
  dispose() {
    super.dispose();

    phoneText?.dispose();
    passwordText?.dispose();
  }

  login(User userStore) {
    if (phoneText?.text == "") {
      return Toast('请输入账号');
    } else if (passwordText?.text == "") {
      return Toast('请输入密码');
    }

    loginByPhone(phoneText?.text, passwordText?.text).then((data) {
      if (data['code'] == 200) {
        userStore.initUserInfo(data);
        Navigator.pop(context);
      } else {
        Toast(data['msg'] ?? '网络异常');
      }
    });
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
                'icon.png',
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
