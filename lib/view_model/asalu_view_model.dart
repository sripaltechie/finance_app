import 'package:chanda_finance/model/asalu.dart';
import 'package:chanda_finance/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:chanda_finance/data/response/api_response.dart';

import '../repository/asalu_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final AsaluViewModelProvider =
//     ChangeNotifierProvider.autoDispose((ref) => AsaluViewModel());

class AsaluViewModel with ChangeNotifier {
  final _myRepo = AsaluRepository();
  bool _iscreateAsaluCalled = false;
  bool get iscreateAsaluCalled => _iscreateAsaluCalled;

  ApiResponse<dynamic> asalu = ApiResponse.loading();
  ApiResponse<List<AsaluModel>> asaluList = ApiResponse.loading();
  ApiResponse<AsaluModel> singleAsalu = ApiResponse.loading();

  setAsalu(ApiResponse<dynamic> response) {
    asalu = response;
    notifyListeners();
  }

  setAsaluList(ApiResponse<List<AsaluModel>> response) {
    asaluList = response;
    notifyListeners();
  }

  setSingleAsalu(ApiResponse<AsaluModel> response) {
    singleAsalu = response;
    notifyListeners();
  }

  setiscreateAsaluCalled(bool value) {
    _iscreateAsaluCalled = value;
    notifyListeners();
  }

  Future<void> createAsaluApi(dynamic data, BuildContext context) async {
    setiscreateAsaluCalled(true);
    _myRepo.createAsaluApi(data).then((value) {
      setAsalu(value);

      Utils.showResponseToast(value, context);
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }

  Future<void> fetchSingleAsaluApi(dynamic id) async {
    setSingleAsalu(ApiResponse.loading());
    _myRepo.fetchSingleAsalu(id).then((value) {
      setSingleAsalu(
          ApiResponse.completed(value.data, value.message, value.Apistatus));
    }).onError((error, stackTrace) {
      setSingleAsalu(ApiResponse.error(error.toString()));
    });
  }

  Future<void> fetchAsaluListApi(queryParameters) async {
    setAsaluList(ApiResponse.loading());
    _myRepo.fetchAsaluList(queryParameters).then((value) {
      setAsaluList(
          ApiResponse.completed(value.data, value.message, value.Apistatus));
    }).onError((error, stackTrace) {
      setAsaluList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> deleteAsaluApi(int id, BuildContext context) async {
    setAsalu(ApiResponse.loading());
    _myRepo.deleteAsaluApi(id, context).then((value) {
      setAsalu(
          ApiResponse.completed(value.data, value.message, value.Apistatus));
      Utils.showResponseToast(value, context);
    }).onError((error, stackTrace) {
      setAsalu(ApiResponse.error(error.toString()));
    });
  }
}
