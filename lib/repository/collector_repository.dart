// import 'package:chanda_finance/data/network/NetworkApiService.dart';
// import 'package:chanda_finance/data/response/api_response.dart';
// import 'package:chanda_finance/res/components/app_url.dart';
// import 'package:chanda_finance/data/network/BaseApiServices.dart';

// class CollectionRepository {
//   final BaseApiServices _apiServices = NetworkApiService();

//   Future<ApiResponse<List<CollectionModel>>> fetchCollectionList(
//       dynamic queryParameters) async {
//     try {
//       dynamic response = await _apiServices.getGetApiResponse(
//           AppUrl.getCollectionsListUrl, queryParameters);
//       List<CollectionModel> collectionList = response["collection"]
//           .map<CollectionModel>((json) => CollectionModel.fromJson(json))
//           .toList();
//       return ApiResponse.completed(
//           collectionList, response["message"], response["Apistatus"]);
//     } catch (e) {
//       throw e;
//     }
//   }
// }
