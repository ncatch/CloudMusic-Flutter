/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-06 11:22:42
 * @LastEditTime: 2021-05-08 14:27:03
 * @LastEditors: Walker
 */
import 'package:cloudmusic_flutter/services/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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

  login(User userStore) {
    loginByPhone(phoneText.text, passwordText.text).then((data) {
      if (data['code'] == 200) {
        userStore.initUserInfo(data);
        Navigator.pop(context);
      } else {
        EasyLoading.showToast(data['msg'] ?? '未知的错误');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var userStore = Provider.of<User>(context);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Wrap(
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
              obscureText: !passwordVisible,
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
            TextButton(
              onPressed: () {
                login(userStore);
              },
              child: Text('登录'),
            ),
          ],
        ),
      ),
    );
  }
}
