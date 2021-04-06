/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-01 14:05:41
 * @LastEditTime: 2021-04-06 14:04:36
 * @LastEditors: Walker
 */
import 'package:dio/dio.dart';

class DioUtil {
  static Dio dio = new Dio();

  //拦截器部分
  // static tokenInter() {
  //   dio.interceptors
  //       .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
  //     // 在发送请求之前做一些预处理
  //     //我这边是在发送前到SharedPreferences（本地存储）中取出token的值，然后添加到请求头中
  //     //dio.lock()是先锁定请求不发送出去，当整个取值添加到请求头后再dio.unlock()解锁发送出去
  //     return options;
  //   }, onResponse: (Response response) {
  //     // 在返回响应数据之前做一些预处理
  //     return response; // continue
  //   }, onError: (DioError e) {
  //     // 当请求失败时做一些预处理
  //     return e; //continue
  //   }));
  // }
}
