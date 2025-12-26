import 'package:chanda_finance/data/network/BaseApiServices.dart';
import 'package:chanda_finance/data/network/NetworkApiService.dart';
import 'package:chanda_finance/data/response/api_response.dart';
import 'package:chanda_finance/model/ledgerModel.dart';

import '../res/components/app_url.dart';

class LedgerRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<ApiResponse<ledgerModel>> fetchLedger(dynamic queryParameters) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.getShowLedgerUrl, queryParameters);
      // return response = creditorsListModel.fromJson(response);
      return ApiResponse.completed(ledgerModel.fromJson(response),
          response['message'], response['status']);
    } catch (e) {
      throw e;
    }
  }
}
