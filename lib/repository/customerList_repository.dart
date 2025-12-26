import 'package:chanda_finance/data/network/BaseApiServices.dart';
import 'package:chanda_finance/data/network/NetworkApiService.dart';
import 'package:chanda_finance/data/response/api_response.dart';
import 'package:chanda_finance/model/customerslist_model.dart';

import '../res/components/app_url.dart';

class CustomersListRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<ApiResponse<CustomersListModel>> fetchCustomersList() async {
    try {
      dynamic queryParameters = null;
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.getcustomersListUrl, queryParameters);
      // return response = CustomersListModel.fromJson(response);
      return ApiResponse.completed(CustomersListModel.fromJson(response),
          response['message'], response['status']);
    } catch (e) {
      throw e;
    }
  }
}
