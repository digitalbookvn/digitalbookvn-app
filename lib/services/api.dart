import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:arbook/models/response.dart';

const urlBase = 'http://arbook.vietpix.com';

class API {
  static Future<dynamic> post(data, url) async {
    final http.Client httpClient = http.Client();
    try {
      final response = await httpClient.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data));
      final Response responseObject = Response.fromJson(json.decode(response.body));
      return responseObject;
    }catch(exception) {
      throw Exception("API Error");
    } finally {
      httpClient.close();
    }
  }

  static Future<dynamic> get(data, url) async {
    print(url);
    final http.Client httpClient = http.Client();
    try {

      final response = await httpClient.get(Uri.parse(url));
      // http.Response response = await http.post(
      //   Uri.https(url, 'albums'),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      //   body: data,
      // );
      final Response responseObject = Response.fromJson(json.decode(response.body));
      //return responseObject.data;
      return responseObject;
    }catch(exception) {
      throw Exception("API Error");
    } finally {
      httpClient.close();
    }
  }


}


