import 'package:chanda_finance/model/drcrModel.dart';
import 'package:chanda_finance/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:chanda_finance/data/response/api_response.dart';
import '../repository/drcr_repository.dart';

class DrcrViewModel with ChangeNotifier {
  final _myRepo = DrcrRepository();
  bool _iscreateDrcrCalled = false;
  bool get iscreateDrcrCalled => _iscreateDrcrCalled;

  bool _isSingleDrcrCalled = false;
  bool get isSingleDrcrCalled => _isSingleDrcrCalled;

  ApiResponse<dynamic> createDrcr = ApiResponse.loading();
  // ApiResponse<List<AsaluModel>> asaluList = ApiResponse.loading();
  ApiResponse<DrcrModel> singleDrcr = ApiResponse.loading();
  ApiResponse<dynamic> editDrcr = ApiResponse.loading();

  setCreateDrcr(ApiResponse<dynamic> response) {
    createDrcr = response;
    notifyListeners();
  }

  setEditDrcr(ApiResponse<dynamic> response) {
    editDrcr = response;
    notifyListeners();
  }

  // setDrcrList(ApiResponse<List<DrcrModel>> response) {
  //   drcrList = response;
  //   notifyListeners();
  // }

  setSingleDrcr(ApiResponse<DrcrModel> response) {
    singleDrcr = response;
    notifyListeners();
  }

  setiscreateDrcrCalled(bool value) {
    _iscreateDrcrCalled = value;
    notifyListeners();
  }

  setisSingleDrcrCalled(bool value) {
    _isSingleDrcrCalled = value;
    notifyListeners();
  }

  Future<void> createDrcrApi(dynamic data, BuildContext context) async {
    setiscreateDrcrCalled(true);
    setCreateDrcr(ApiResponse.loading());
    _myRepo.createDrcrApi(data).then((value) {
      setCreateDrcr(value);
      Utils.showResponseToast(value, context);
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }

  Future<void> fetchSingleDrcrApi(dynamic id) async {
    setisSingleDrcrCalled(true);
    setSingleDrcr(ApiResponse.loading());
    _myRepo.fetchSingleDrcr(id).then((value) {
      setSingleDrcr(value);
    }).onError((error, stackTrace) {
      setSingleDrcr(ApiResponse.error(error.toString()));
    });
  }

  Future<void> editDrcrApi(
      dynamic id, dynamic data, BuildContext context) async {
    setEditDrcr(ApiResponse.loading());
    _myRepo.editDrcrApi(id, data).then((value) {
      setEditDrcr(value);
      Utils.showResponseToast(value, context);
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }

  // Future<void> fetchAsaluListApi(queryParameters) async {
  //   setAsaluList(ApiResponse.loading());
  //   _myRepo.fetchAsaluList(queryParameters).then((value) {
  //     setAsaluList(
  //         ApiResponse.completed(value.data, value.message, value.Apistatus));
  //   }).onError((error, stackTrace) {
  //     setAsaluList(ApiResponse.error(error.toString()));
  //   });
  // }

  // Future<void> deleteAsaluApi(int id, BuildContext context) async {
  //   setAsalu(ApiResponse.loading());
  //   _myRepo.deleteAsaluApi(id, context).then((value) {
  //     setAsalu(
  //         ApiResponse.completed(value.data, value.message, value.Apistatus));
  //     Utils.showResponseToast(value, context);
  //   }).onError((error, stackTrace) {
  //     setAsalu(ApiResponse.error(error.toString()));
  //   });
  // }
}
