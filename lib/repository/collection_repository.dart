import 'package:chanda_finance/data/network/BaseApiServices.dart';
import 'package:chanda_finance/data/network/NetworkApiService.dart';
import 'package:chanda_finance/data/response/api_response.dart';
import 'package:chanda_finance/res/components/app_url.dart';

import '../model/collection_model.dart';

class CollectionRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<ApiResponse<List<CollectionModel>>> fetchCollectionList(
      dynamic queryParameters) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.getCollectionsListUrl, queryParameters);
      List<CollectionModel> collectionList = response["collection"]
          .map<CollectionModel>((json) => CollectionModel.fromJson(json))
          .toList();
      return ApiResponse.completed(
          collectionList, response["message"], response["Apistatus"]);
    } catch (e) {
      throw e;
    }
  }

  Future<ApiResponse<CollectionModel>> fetchSingleCollection(dynamic id) async {
    try {
      // dynamic queryParameters = null;
      dynamic response = await _apiServices.getGetApiResponse(
          "${AppUrl.getCollectionsListUrl}/$id", null);
      // return response = CustomersListModel.fromJson(response);
      CollectionModel collection =
          CollectionModel.fromJson(response['collection']);
      return ApiResponse.completed(
          collection, response['message'], response['status']);
    } catch (e) {
      throw e;
    }
  }

  Future<ApiResponse<dynamic>> createCollectionRcvd(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.receivedIntUrl, data);
      return ApiResponse.completed(
          response, response["message"], response["status"]);
    } catch (e) {
      throw e;
    }
  }

  Future<ApiResponse<dynamic>> createCollection(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.createCollectionUrl, data);
      return ApiResponse.postResp(response);
    } catch (e) {
      throw e;
    }
  }
}
