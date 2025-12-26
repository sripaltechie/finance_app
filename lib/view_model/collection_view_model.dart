import 'package:chanda_finance/data/response/api_response.dart';
import 'package:flutter/material.dart';
import '../model/collection_model.dart';
import '../repository/collection_repository.dart';
import '../utils/utils.dart';

class CollectionViewModel with ChangeNotifier {
  final _myRepo = CollectionRepository();
  ApiResponse<List<CollectionModel>> collectionsList = ApiResponse.loading();
  ApiResponse<CollectionModel> collection = ApiResponse.loading();
  ApiResponse<dynamic> collectionRcvdstatus = ApiResponse.loading();
  ApiResponse<dynamic> createCollectionStatus = ApiResponse.loading();
  bool isCollectionCalled = false;
  bool isCollectionListCalled = false;

  setCollectionsList(ApiResponse<List<CollectionModel>> response) {
    collectionsList = response;
    notifyListeners();
  }

  setSingleCollection(ApiResponse<CollectionModel> response) {
    collection = response;
    notifyListeners();
  }

  setCreateCollRcvdstatus(ApiResponse<dynamic> response) {
    collectionRcvdstatus = response;
    notifyListeners();
  }

  setCreateCollStatus(ApiResponse<dynamic> response) {
    createCollectionStatus = response;
    notifyListeners();
  }

  setIsCollectionCalled(bool value) {
    isCollectionCalled = value;
    notifyListeners();
  }

  setIsCollectionListCalled(bool value) {
    isCollectionListCalled = value;
    notifyListeners();
  }

  Future<void> createCollectionRcvdApi(
      dynamic data, BuildContext context) async {
    _myRepo.createCollectionRcvd(data).then((value) {
      setCreateCollRcvdstatus(ApiResponse.completedobj(value));
      Utils.showResponseToast(value, context);
      if (value.Apistatus != "error") {
        Navigator.pop(context, true);
      }
      // Navigator.popAndPushNamed(context, RoutesName.chiti,
      //     arguments: int.tryParse(data['chiti'].toString()));
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }

  Future<void> createCollectionApi(dynamic data, BuildContext context) async {
    _myRepo.createCollection(data).then((value) {
      setCreateCollStatus(ApiResponse.completedobj(value));
      Utils.showResponseToast(value, context);
      if (value.Apistatus != "error") {
        Navigator.pop(context, true);
      }
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }

  Future<void> fetchCollectionsList(dynamic queryParameters) async {
    setIsCollectionListCalled(true);
    setCollectionsList(ApiResponse.loading());
    _myRepo.fetchCollectionList(queryParameters).then((value) {
      setCollectionsList(
          ApiResponse.completed(value.data, value.message, value.Apistatus));
    }).onError((error, stackTrace) {
      setCollectionsList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> fetchSingleCollectionApi(dynamic id) async {
    setSingleCollection(ApiResponse.loading());
    setIsCollectionCalled(true);
    _myRepo.fetchSingleCollection(id).then((value) {
      setSingleCollection(ApiResponse.completedobj(value));
    }).onError((error, stackTrace) {
      setSingleCollection(ApiResponse.error(error.toString()));
    });
  }
}
