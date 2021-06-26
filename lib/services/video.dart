/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-31 17:24:17
 * @LastEditTime: 2021-05-31 17:31:32
 * @LastEditors: Walker
 */
import '../utils/http.dart';

Future<dynamic> getVideoDetail(id) {
  return DioUtil.dio.get('/video/detail?id=$id').then((value) {
    return value.data;
  });
}
