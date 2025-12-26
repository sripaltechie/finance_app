import 'package:chanda_finance/model/asalu.dart';
import 'package:chanda_finance/repository/collector_amount_repository.dart';
import 'package:chanda_finance/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:chanda_finance/data/response/api_response.dart';

import '../repository/asalu_repository.dart';

class Collector_Amount_ViewModel with ChangeNotifier {
  final _myRepo = CollectorAmountRepository();

  ApiResponse<dynamic> CreateCollectorAmount = ApiResponse.loading();
  bool _createLoading = false;
  bool get createLoading => _createLoading;

  setcreateLoading(bool value) {
    _createLoading = value;
    notifyListeners();
  }

  setCreateCollectorAmount(ApiResponse<dynamic> response) {
    CreateCollectorAmount = response;
    notifyListeners();
  }

  Future<void> createCollectorAmountApi(
      dynamic data, BuildContext context) async {
    setcreateLoading(true);
    _myRepo.createCollectorAmountApi(data).then((value) {
      setcreateLoading(false);
      setCreateCollectorAmount(value);
      Utils.showResponseToast(value, context);
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }
}
