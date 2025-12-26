import 'package:chanda_finance/data/response/api_response.dart';
import 'package:chanda_finance/model/yes_no_model.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../res/components/app_url.dart';

class YesNoRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<ApiResponse<YesNoModel>> getYesnoApi() async {
    try {
      var queryParameters = null;
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.getYesNoUrl, queryParameters);
      YesNoModel yesno = YesNoModel.fromJson(response);
      // return response;
      return ApiResponse.completed(
          yesno, response['message'], response['status']);
    } catch (e) {
      throw e;
    }
  }
}
