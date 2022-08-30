/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-06 11:22:42
 * @LastEditTime: 2021-06-28 19:34:42
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/libs/extends/Toast.dart';
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
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      } else {
        Toast(data['msg'] ?? '网络异常');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var userStore = Provider.of<User>(context);

    var textStyle = TextStyle(
      color: Colors.black,
    );
    var hintStyle = TextStyle(
      color: Colors.black45,
    );

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              TextField(
                controller: phoneText,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelText: '手机号',
                    hintText: '请输手机号',
                    labelStyle: textStyle,
                    hintStyle: hintStyle),
              ),
              TextField(
                controller: passwordText,
                keyboardType: TextInputType.text,
                obscureText: !passwordVisible,
                decoration: InputDecoration(
                  labelText: '密码',
                  hintText: '请输入密码',
                  labelStyle: textStyle,
                  hintStyle: hintStyle,
                  //下面是重点
                  suffixIcon: IconButton(
                    icon: Icon(
                      //根据passwordVisible状态显示不同的图标
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.black45,
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
              TextButton(
                onPressed: () {
                  login(userStore);
                },
                child: Text('登录'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
