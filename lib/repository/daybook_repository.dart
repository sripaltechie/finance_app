import 'package:chanda_finance/data/response/api_response.dart';
import 'package:chanda_finance/model/daybookModel.dart';
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../res/components/app_url.dart';

class DaybookRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<ApiResponse<dynamic>> getDaybookApi(dynamic queryParameters) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.getDaybookUrl, queryParameters);
      DaybookModel daybook = DaybookModel.fromJson(response["daybook"]);
      // return response;
      return ApiResponse.completed(
          daybook, response['message'], response['status']);
    } catch (e) {
      throw e;
    }
  }
}
