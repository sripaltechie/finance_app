import 'package:chanda_finance/model/ledgerModel.dart';
import 'package:chanda_finance/repository/ledger_repository.dart';
import 'package:flutter/material.dart';
import 'package:chanda_finance/data/response/api_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ledgerViewModelProvider =
    ChangeNotifierProvider.autoDispose((ref) => LedgerViewModel());

class LedgerViewModel with ChangeNotifier {
  final _myRepo = LedgerRepository(); //change

  ApiResponse<ledgerModel> ledgerData = ApiResponse.loading();
  // bool _iscreditorsListCalled = false;
  // bool get iscreditorsListCalled => _iscreditorsListCalled;

  // setiscreditorsListCalled(bool value) {
  //   _iscreditorsListCalled = value;
  //   notifyListeners();
  // }

  setLedgerData(ApiResponse<ledgerModel> response) {
    ledgerData = response;
    notifyListeners();
  }

  Future<void> fetchLedgerApi(queryParameters) async {
    // setiscreditorsListCalled(true);
    setLedgerData(ApiResponse.loading());
    _myRepo.fetchLedger(queryParameters).then((value) {
      setLedgerData(
          ApiResponse.completed(value.data, value.message, value.Apistatus));
    }).onError((error, stackTrace) {
      setLedgerData(ApiResponse.error(error.toString()));
    });
  }
}
