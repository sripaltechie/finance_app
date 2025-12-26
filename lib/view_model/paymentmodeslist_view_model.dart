import 'package:flutter/material.dart';
import 'package:chanda_finance/data/response/api_response.dart';

import '../model/paymentmodeModel.dart';
import '../repository/paymentmodesList_repository.dart';
import '../utils/utils.dart';

class PaymentmodesListViewModel with ChangeNotifier {
  final _myRepo = PaymentmodesListRepository();

  ApiResponse<List<PaymentmodeModel>> PaymentmodesList = ApiResponse.loading();
  bool isPmModeCalled = false;

  setPaymentmodesList(ApiResponse<List<PaymentmodeModel>> response) {
    PaymentmodesList = response;
    notifyListeners();
  }

  setisPmModeCalled(bool value) {
    isPmModeCalled = value;
    notifyListeners();
  }

  Future<void> fetchPaymentmodesListApi(dynamic queryParameters) async {
    setisPmModeCalled(true);
    setPaymentmodesList(ApiResponse.loading());
    _myRepo.fetchPaymentmodesList(queryParameters).then((value) {
      setPaymentmodesList(
          ApiResponse.completed(value.data, value.message, value.Apistatus));
    }).onError((error, stackTrace) {
      setPaymentmodesList(ApiResponse.error(error.toString()));
    });
  }
}
