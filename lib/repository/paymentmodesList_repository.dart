import 'package:chanda_finance/data/network/BaseApiServices.dart';
import 'package:chanda_finance/data/network/NetworkApiService.dart';
import 'package:chanda_finance/data/response/api_response.dart';
import 'package:chanda_finance/model/paymentmodeModel.dart';

import '../res/components/app_url.dart';

class PaymentmodesListRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<ApiResponse<List<PaymentmodeModel>>> fetchPaymentmodesList(
      dynamic queryParameters) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.getpaymentmodesUrl, queryParameters);
      return ApiResponse.completed(
          response['paymentmode']
              .map<PaymentmodeModel>((json) => PaymentmodeModel.fromJson(json))
              .toList(),
          response["message"],
          response['status']);
      //PaymentmodeModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
