import 'package:chanda_finance/data/network/BaseApiServices.dart';
import 'package:chanda_finance/data/network/NetworkApiService.dart';
import 'package:chanda_finance/model/lastdetails.dart';

import '../data/response/api_response.dart';
import '../res/components/app_url.dart';

class LastPaymentsRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<ApiResponse<LastPaymentsModel>> fetchLastPaymentsList() async {
    try {
      dynamic queryParameters = null;
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.getlastpaymentsUrl, queryParameters);
      // return response = CustomersListModel.fromJson(response);
      return ApiResponse.completed(LastPaymentsModel.fromJson(response),
          response['message'], response['status']);
    } catch (e) {
      throw e;
    }
  }
}
