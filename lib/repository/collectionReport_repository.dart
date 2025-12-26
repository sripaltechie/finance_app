import 'package:chanda_finance/data/network/BaseApiServices.dart';
import 'package:chanda_finance/data/network/NetworkApiService.dart';
import 'package:chanda_finance/data/response/api_response.dart';
import 'package:chanda_finance/model/collectionReportModel.dart';
import 'package:chanda_finance/res/components/app_url.dart';

class collectionReportRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<ApiResponse<collectionReportModel>> fetchCollectionReport(
      dynamic queryParameters) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.getCollectionReportUrl, queryParameters);
      collectionReportModel collectionReport =
          collectionReportModel.fromJson(response);

      return ApiResponse.completedData_status(collectionReport, response);
    } catch (e) {
      throw e;
    }
  }
}
