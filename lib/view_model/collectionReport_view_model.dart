import 'package:chanda_finance/model/collectionReportModel.dart';
import 'package:chanda_finance/repository/collectionReport_repository.dart';
import 'package:flutter/material.dart';

import '../data/response/api_response.dart';

class CollectionReportViewModel with ChangeNotifier {
  final _myRepo = collectionReportRepository();
  ApiResponse<collectionReportModel> collectionReport = ApiResponse.loading();

  setCollectionReport(ApiResponse<collectionReportModel> response) {
    collectionReport = response;
    notifyListeners();
  }

  Future<void> fetchCollectionReport(dynamic queryParameters, context) async {
    setCollectionReport(ApiResponse.loading());
    _myRepo.fetchCollectionReport(queryParameters).then((value) {
      setCollectionReport(value);
    }).onError((error, stackTrace) {
      setCollectionReport(ApiResponse.error(error.toString()));
    });
  }
}
