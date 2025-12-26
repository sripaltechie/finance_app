import 'package:chanda_finance/data/response/api_response.dart';
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../res/components/app_url.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<ApiResponse<dynamic>> loginApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.loginUrl, data);
      // return response;
      return ApiResponse.completed(
          response, response['message'], response['status']);
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> signUpApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.signUpUrl, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
