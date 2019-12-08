import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future<dynamic> getData() async {
    http.Response result = await http.get(url);

    if (200 == result.statusCode) {
      String body = result.body;
      return jsonDecode(body);
    } else {
      print('Request failed with status code: ${result.statusCode}');
    }
  }
}
