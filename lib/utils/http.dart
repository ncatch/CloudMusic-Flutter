/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-01 14:05:41
 * @LastEditTime: 2021-06-11 14:59:52
 * @LastEditors: Walker
 */

import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import '../libs/config.dart';
import './preference.dart';

class DioUtil {
  static Dio dio = new Dio();
  static var cookieJar = CookieJar();
  static String? cookie;
  static bool cache = false;

  //拦截器部分
  static tokenInter() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;

      var cj = PersistCookieJar(
          ignoreExpires: true, storage: FileStorage(appDocPath + "/.cookies/"));
      dio.interceptors.add(CookieManager(cj));
    } catch (e) {}

    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      // 接口权限
      options.headers['Authorization'] = token;

      // 用户身份
      if (cookie == null || cookie == "") {
        cookie = await PreferenceUtils.getString(PreferencesKey.USER_COOKIE);
      }

      if (!cache) {
        options.queryParameters['v'] = Random().nextInt(100000);
      }

      options.queryParameters['cookie'] = Uri.encodeComponent(cookie ?? "");

      // 拼接服务器地址
      if (!options.path.startsWith('http')) {
        options.path = server + options.path;
      }

      // Do something before request is sent
      return handler.next(options); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    }, onResponse: (response, handler) {
      // Do something with response data
      return handler.next(response); // continue
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    }, onError: (DioError e, handler) {
      // Do something with response error
      if (e.response?.statusCode != 200) {
        return handler.resolve(e.response!);
      }
      return handler.next(e); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
    }));
  }
}
