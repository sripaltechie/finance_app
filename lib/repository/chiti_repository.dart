import 'package:chanda_finance/data/network/BaseApiServices.dart';
import 'package:chanda_finance/data/network/NetworkApiService.dart';
import 'package:chanda_finance/data/response/api_response.dart';
import 'package:chanda_finance/model/chitiModel.dart';
import 'package:chanda_finance/model/latest_notes.dart';
import 'package:chanda_finance/res/components/app_url.dart';

class ChitiRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<ApiResponse<ChitiModel>> getSingleChitiApi(dynamic id) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          "${AppUrl.getchitiUrl}/$id", null);
      return ApiResponse.completed(ChitiModel.fromJson(response['chiti']),
          response['message'], response['Apistatus']);
    } catch (e) {
      throw e;
    }
  }

  Future<ApiResponse<List<ChitiModel>>> getChitiListApi(
      dynamic queryParameters) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.getchitiUrl, queryParameters);
      List<ChitiModel> chitiList = response['chiti']
          .map<ChitiModel>((json) => ChitiModel.fromJson(json))
          .toList();
      return ApiResponse.completed(
          chitiList, response['message'], response['Apistatus']);
    } catch (e) {
      throw e;
    }
  }

  Future<ApiResponse<dynamic>> editChitiApi(dynamic id, dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPutApiResponse("${AppUrl.chitiUrl}/$id", data);
      return ApiResponse.completed(
          response, response['message'], response['status']);
    } catch (e) {
      throw e;
    }
  }
}
