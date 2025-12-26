import 'package:chanda_finance/model/creditorsListModel.dart';
import 'package:chanda_finance/repository/creditorsList_repository.dart';
import 'package:flutter/material.dart';
import 'package:chanda_finance/data/response/api_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final creditorsListViewModelProvider =
    ChangeNotifierProvider.autoDispose((ref) => CreditorsListViewModel());

class CreditorsListViewModel with ChangeNotifier {
  final _myRepo = CreditorsListRepository(); //change

  ApiResponse<creditorsListModel> creditorsList = ApiResponse.loading();
  bool _iscreditorsListCalled = false;
  bool get iscreditorsListCalled => _iscreditorsListCalled;

  setiscreditorsListCalled(bool value) {
    _iscreditorsListCalled = value;
    notifyListeners();
  }

  setCreditorsList(ApiResponse<creditorsListModel> response) {
    creditorsList = response;
    notifyListeners();
  }

  Future<void> fetchCreditorsListApi(queryParameters) async {
    setiscreditorsListCalled(true);
    setCreditorsList(ApiResponse.loading());
    _myRepo.fetchCreditorsList(queryParameters).then((value) {
      setCreditorsList(
          ApiResponse.completed(value.data, value.message, value.Apistatus));
    }).onError((error, stackTrace) {
      setCreditorsList(ApiResponse.error(error.toString()));
    });
  }
}
