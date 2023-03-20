import 'package:dio/dio.dart';

class ApiManager {
  static final Dio init =
      Dio(BaseOptions(baseUrl: "https://api.openweathermap.org/data/2.5/", headers: {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  }))
        ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
}
