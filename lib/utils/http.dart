import 'package:dio/dio.dart';

final Dio dio = new Dio();

// dio.interceptors.add(InterceptorsWrapper(
//   onRequest:(RequestOptions options) async {
//     // Do something before request is sent
//     return options; //continue
//     // If you want to resolve the request with some custom data，
//     // you can return a `Response` object or return `dio.resolve(data)`.
//     // If you want to reject the request with a error message,
//     // you can return a `DioError` object or return `dio.reject(errMsg)`
//   },
//   onResponse:(Response response) async {
//     // Do something with response data
//     return response; // continue
//   },
//   onError: (DioError e) async {
//     // Do something with response error
//     return  e;//continue
//   }
// ));