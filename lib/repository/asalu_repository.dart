import 'package:chanda_finance/data/network/BaseApiServices.dart';
import 'package:chanda_finance/data/network/NetworkApiService.dart';
import 'package:chanda_finance/data/response/api_response.dart';
import 'package:chanda_finance/model/asalu.dart';

import '../res/components/app_url.dart';
import '../utils/utils.dart';

class AsaluRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<ApiResponse<dynamic>> createAsaluApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.asaluUrl, data);
      return ApiResponse.completed(
          response, response["message"], response["status"]);
    } catch (e) {
      throw e;
    }
  }

  Future<ApiResponse<AsaluModel>> fetchSingleAsalu(dynamic id) async {
    try {
      // dynamic queryParameters = null;
      dynamic response = await _apiServices.getGetApiResponse(
          "${AppUrl.getAsaluUrl}/$id", null);
      // return response = CustomersListModel.fromJson(response);
      AsaluModel asalu = AsaluModel.fromJson(response['asalu']);
      return ApiResponse.completed(
          asalu, response['message'], response['status']);
    } catch (e) {
      throw e;
    }
  }

  Future<ApiResponse<List<AsaluModel>>> fetchAsaluList(
      dynamic queryParameters) async {
    try {
      // dynamic queryParameters = null;
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.getAsaluUrl, queryParameters);
      // return response = CustomersListModel.fromJson(response);

      // List<AsaluModel> asaluList = response['asalu'].isEmpty
      //     ? <AsaluModel>[]
      //     : response['asalu']
      //         .map<AsaluModel>((json) => AsaluModel.fromJson(json))
      //         .toList();
      List<AsaluModel> asaluList = response['asalu']
          .map<AsaluModel>((json) => AsaluModel.fromJson(json))
          .toList();
      return ApiResponse.completed(
          asaluList, response['message'], response['status']);
    } catch (e) {
      throw e;
    }
  }

  Future<ApiResponse<dynamic>> editAsaluApi(dynamic id, dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPutApiResponse("${AppUrl.asaluUrl}/$id", data);
      return ApiResponse.completed(
          response, response['message'], response['status']);
    } catch (e) {
      throw e;
    }
  }

  Future<ApiResponse<dynamic>> deleteAsaluApi(int id, context) async {
    try {
      var msg = "Deleting....";
      Utils.showSnackBar(context, msg);
      dynamic response =
          await _apiServices.getDeleteApiResponse("${AppUrl.asaluUrl}/$id");
      // return response = CustomersListModel.fromJson(response);
      return ApiResponse.completed(
          null, response['message'], response['status']);
    } catch (e) {
      throw e;
    }
  }
}
