import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:find_my_waifu/networking/api_exceptions.dart';
import 'package:http/http.dart' as http;

// ApiBaseHelper class from https://medium.com/solidmvp-africa/making-your-api-calls-in-flutter-the-right-way-f0a03e35b4b1
class ApiBaseHelper {
  final String _baseUrl = "api.waifu.pics";

  Future<dynamic> get(String query) async {
    var responseJson;
    try {
      final response = await http.get(Uri.https(_baseUrl, query));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
