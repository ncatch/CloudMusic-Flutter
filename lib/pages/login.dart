/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-06 11:22:42
 * @LastEditTime: 2021-05-06 15:12:28
 * @LastEditors: Walker
 */

import 'package:cloudmusic_flutter/services/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../store/User.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {
  bool passwordVisible = false;

  TextEditingController phoneText = new TextEditingController();
  TextEditingController passwordText = new TextEditingController();

  login(userStore) {
    loginByPhone(phoneText.text, passwordText.text).then((data) {
      if (data['code'] == 200) {
        userStore.setUserInfo(data['profile']);
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
          msg: data['msg'] ?? '未知的错误',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          fontSize: 16.0,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var userStore = Provider.of<User>(context);
    return Scaffold(
      body: Wrap(
        alignment: WrapAlignment.center,
        children: [
          TextField(
            controller: phoneText,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: '手机号',
              hintText: '请输手机号',
            ),
          ),
          TextField(
            controller: passwordText,
            keyboardType: TextInputType.text,
            obscureText: false,
            decoration: InputDecoration(
              labelText: '密码',
              hintText: '请输入密码',
              //下面是重点
              suffixIcon: IconButton(
                icon: Icon(
                  //根据passwordVisible状态显示不同的图标
                  passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  //更新状态控制密码显示或隐藏
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                login(userStore);
              },
              icon: Icon(Icons.navigate_next_outlined))
        ],
      ),
    );
  }
}
