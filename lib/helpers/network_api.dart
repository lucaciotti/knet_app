import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NetApiHelper {
  // next three lines makes this class a Singleton
  static NetApiHelper _instance = new NetApiHelper.internal();
  NetApiHelper.internal();
  factory NetApiHelper() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> get(Uri url, {Map headers}) {
    if (headers == null) headers={"Accept": "application/json"};
    return http.get(url, headers: headers).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if ((statusCode != 200 && statusCode != 401) || res == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> post(Uri url, {Map headers, body, encoding}) {
    // if (headers == null) headers={"Accept": "application/json"};
    return http
        .post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if ((statusCode != 200 && statusCode != 401) || res == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }
}