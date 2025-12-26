import 'package:chanda_finance/data/response/api_response.dart';
import 'package:chanda_finance/model/chitiModel.dart';
import 'package:chanda_finance/repository/chiti_repository.dart';
import 'package:chanda_finance/res/components/app_url.dart';
import 'package:chanda_finance/utils/routes_name.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class ChitiViewModel with ChangeNotifier {
  final _myRepo = ChitiRepository();

  ApiResponse<ChitiModel> chiti = ApiResponse.loading();

  setChiti(ApiResponse<ChitiModel> response) {
    chiti = response;
    notifyListeners();
  }

  ApiResponse<List<ChitiModel>> chitiList = ApiResponse.loading();

  setChitiList(ApiResponse<List<ChitiModel>> response) {
    chitiList = response;
    notifyListeners();
  }

  ApiResponse<dynamic> editChiti = ApiResponse.loading();

  setEditChiti(ApiResponse<dynamic> response) {
    editChiti = response;
    notifyListeners();
  }

  Future<void> fetchSingleChiti(dynamic id) async {
    setChiti(ApiResponse.loading());
    _myRepo.getSingleChitiApi(id).then((value) {
      setChiti(
          ApiResponse.completed(value.data, value.message, value.Apistatus));
    }).onError((error, stackTrace) {
      setChiti(ApiResponse.error(error.toString()));
    });
  }

  Future<void> fetchChitiList(dynamic queryParameters) async {
    setChitiList(ApiResponse.loading());
    _myRepo.getChitiListApi(queryParameters).then((value) {
      setChitiList(
          ApiResponse.completed(value.data, value.message, value.Apistatus));
    }).onError((error, stackTrace) {
      setChitiList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> updateChiti(dynamic id, dynamic data, context) async {
    setEditChiti(ApiResponse.loading());
    _myRepo.editChitiApi(id, data).then((value) {
      setEditChiti(
          ApiResponse.completed(value.data, value.message, value.Apistatus));
      Utils.showResponseToast(value, context);
      if (value.Apistatus == "success") {
        Navigator.pushReplacementNamed(context, RoutesName.chiti,
            arguments: [int.parse(id.toString())]);
      }

      // _myRepo.getSingleChitiApi(id).then((value) {
      //   setChiti(
      //       ApiResponse.completed(value.data, value.message, value.Apistatus));
      // }).onError((error, stackTrace) {
      //   setChiti(ApiResponse.error(error.toString()));
      // });
    }).onError((error, stackTrace) {
      setEditChiti(ApiResponse.error(error.toString()));
    });
  }
}
