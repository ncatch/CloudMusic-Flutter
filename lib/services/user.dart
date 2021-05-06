/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-06 13:51:53
 * @LastEditTime: 2021-05-06 13:56:13
 * @LastEditors: Walker
 */

import '../utils/http.dart';
import '../libs/config.dart';

Future<dynamic> loginByPhone(phone, password) {
  return DioUtil.dio
      .get(server + '/login/cellphone?phone=$phone&password=$password')
      .then((value) {
    return value.data;
  });
}
