import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HttpService {
  static Future<Response> get<T>(String url) async {
    final dio = Dio();
    try {
      return await dio
          .get<T>(
        url,
        options: Options(
          responseType: ResponseType.plain,
        ),
      )
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return Response(
            requestOptions: RequestOptions(),
            statusCode: 408,
            statusMessage: 'Request Timeout Expired',
          ); // Request Timeout response status code
        },
      );
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        debugPrint(e.response?.data);
        debugPrint(e.response?.headers.toString());
        debugPrint(e.response?.requestOptions.toString());
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        debugPrint(e.requestOptions.toString());
        debugPrint(e.message);
      }
      rethrow;
    }
  }

  static Future<Response> post<T>(String url, Object? data) async {
    final dio = Dio();
    try {
      return await dio
          .post(
        url,
        data: data,
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            'Content-Type': 'application/json', // Set the content type to JSON
          },
        ),
      )
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return Response(
            requestOptions: RequestOptions(),
            statusCode: 408,
            statusMessage: 'Request Timeout Expired',
          ); // Request Timeout response status code
        },
      );
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        debugPrint(e.response?.data);
        debugPrint(e.response?.headers.toString());
        debugPrint(e.response?.requestOptions.toString());
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        debugPrint(e.requestOptions.toString());
        debugPrint(e.message);
      }
      rethrow;
    }
  }
}
