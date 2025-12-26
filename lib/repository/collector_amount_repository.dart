import 'package:chanda_finance/data/network/BaseApiServices.dart';
import 'package:chanda_finance/data/network/NetworkApiService.dart';
import 'package:chanda_finance/data/response/api_response.dart';
import '../res/components/app_url.dart';

class CollectorAmountRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<ApiResponse<dynamic>> createCollectorAmountApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.collectoramountUrl, data);
      return ApiResponse.postResp(response);
    } catch (e) {
      throw e;
    }
  }
}
