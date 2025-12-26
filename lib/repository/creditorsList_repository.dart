import 'package:chanda_finance/data/network/BaseApiServices.dart';
import 'package:chanda_finance/data/network/NetworkApiService.dart';
import 'package:chanda_finance/data/response/api_response.dart';
import 'package:chanda_finance/model/creditorsListModel.dart';

import '../res/components/app_url.dart';

class CreditorsListRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<ApiResponse<creditorsListModel>> fetchCreditorsList(
      dynamic queryParameters) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.getcreditorsListUrl, queryParameters);
      // return response = creditorsListModel.fromJson(response);
      return ApiResponse.completed(creditorsListModel.fromJson(response),
          response['message'], response['status']);
    } catch (e) {
      throw e;
    }
  }
}
