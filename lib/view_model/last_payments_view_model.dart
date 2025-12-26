import 'package:chanda_finance/model/lastdetails.dart';
import 'package:flutter/material.dart';
import 'package:chanda_finance/data/response/api_response.dart';
import '../repository/last_payments_repository.dart';

class LastPaymentsViewModel with ChangeNotifier {
  final _myRepo = LastPaymentsRepository();

  ApiResponse<LastPaymentsModel> lastPaymentsList = ApiResponse.loading();

  setLastPaymentsList(ApiResponse<LastPaymentsModel> response) {
    lastPaymentsList = response;
    notifyListeners();
  }

  Future<void> fetchLastPaymentsListApi() async {
    setLastPaymentsList(ApiResponse.loading());
    _myRepo.fetchLastPaymentsList().then((value) {
      setLastPaymentsList(
          ApiResponse.completed(value.data, value.message, value.Apistatus));
    }).onError((error, stackTrace) {
      setLastPaymentsList(ApiResponse.error(error.toString()));
    });
  }
}
