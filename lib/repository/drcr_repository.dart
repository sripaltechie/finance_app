import 'package:chanda_finance/data/network/BaseApiServices.dart';
import 'package:chanda_finance/data/network/NetworkApiService.dart';
import 'package:chanda_finance/data/response/api_response.dart';
import '../model/drcrModel.dart';
import '../res/components/app_url.dart';

class DrcrRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<ApiResponse<dynamic>> createDrcrApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.drcrUrl, data);
      return ApiResponse.postResp(response);
    } catch (e) {
      throw e;
    }
  }

  Future<ApiResponse<DrcrModel>> fetchSingleDrcr(dynamic id) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          "${AppUrl.getDrcrUrl}/$id", null);

      DrcrModel drcr = DrcrModel.fromJson(response['drcr']);
      return ApiResponse.completed(
          drcr, response['message'], response['status']);
    } catch (e) {
      throw e;
    }
  }

  Future<ApiResponse<dynamic>> editDrcrApi(dynamic id, dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPutApiResponse("${AppUrl.drcrUrl}/$id", data);
      return ApiResponse.completed(
          response, response['message'], response['status']);
    } catch (e) {
      throw e;
    }
  }

  // Future<ApiResponse<List<AsaluModel>>> fetchAsaluList(
  //     dynamic queryParameters) async {
  //   try {

  //     dynamic response = await _apiServices.getGetApiResponse(
  //         AppUrl.getAsaluUrl, queryParameters);

  //     List<AsaluModel> asaluList = response['asalu']
  //         .map<AsaluModel>((json) => AsaluModel.fromJson(json))
  //         .toList();
  //     return ApiResponse.completed(
  //         asaluList, response['message'], response['status']);
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  // Future<ApiResponse<dynamic>> deleteAsaluApi(int id, context) async {
  //   try {
  //     var msg = "Deleting....";
  //     Utils.showSnackBar(context, msg);
  //     dynamic response =
  //         await _apiServices.getDeleteApiResponse("${AppUrl.asaluUrl}/$id");

  //     return ApiResponse.completed(
  //         null, response['message'], response['status']);
  //   } catch (e) {
  //     throw e;
  //   }
  // }
}
