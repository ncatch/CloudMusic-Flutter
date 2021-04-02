import 'package:dio/dio.dart';

import '../utils/http.dart';
import '../libs/config.dart';

Future<Response> getBanner (type) async {
  return await dio.post(server + '/banner/get',
    data: {
      'clientType': type,
    }
  );
}