import 'package:chanda_finance/data/network/BaseApiServices.dart';
import 'package:chanda_finance/data/network/NetworkApiService.dart';
import 'package:chanda_finance/data/response/api_response.dart';
import '../model/latest_notes.dart';
import '../res/components/app_url.dart';

class LatestNotesRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<ApiResponse<LatestNotesModel>> fetchLatestNotesList(
      dynamic chitiId) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          "${AppUrl.getlatestnotesUrl}/$chitiId", null);
      return ApiResponse.completed(LatestNotesModel.fromJson(response),
          response["message"], response['status']);
      //  <LatestNotesModel.fromJson(response)
      // , message = "ff");
      // .map<PaymentmodeModel>((json) => PaymentmodeModel.fromJson(json))
      // .toList();
      //PaymentmodeModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
