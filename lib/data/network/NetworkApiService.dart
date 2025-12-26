// ignore: file_names
import 'dart:convert';
// import 'dart:html';
import 'dart:io';

import 'package:http/http.dart';
import 'package:chanda_finance/data/app_exceptions.dart';
import 'package:chanda_finance/data/network/BaseApiServices.dart';
import 'package:http/http.dart' as http;

import '../../res/components/app_url.dart';
import '../../utils/constants.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future getGetApiResponse(String url, dynamic queryParameters) async {
    dynamic responseJson;
    final uri =
        Uri.http(AppUrl.getUrl, '${AppUrl.getPath}/$url', queryParameters);
    try {
      final response = await http
          .get(uri, headers: headers)
          .timeout(const Duration(seconds: 30));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      Response response =
          await post(Uri.parse(url), body: data, headers: headers)
              .timeout(const Duration(seconds: 30));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(' No Internet Connection');
    }
    // return returnResponse(responseJson);
    return responseJson;
  }

  @override
  Future getPutApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      Response response =
          await put(Uri.parse(url), body: data, headers: headers)
              .timeout(const Duration(seconds: 30));
      print(response.body);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(' No Internet Connection');
    }
    // return returnResponse(responseJson);
    return responseJson;
  }

  @override
  Future getDeleteApiResponse(String url) async {
    // TODO: implement getDeleteApiResponse
    dynamic responseJson;
    try {
      Response response = await delete(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 30));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(' No Internet Connection');
    }
    // return returnResponse(responseJson);
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with status code ${response.statusCode.toString()}');
    }
  }
}
