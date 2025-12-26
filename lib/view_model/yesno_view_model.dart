import 'package:chanda_finance/data/response/api_response.dart';
import 'package:chanda_finance/model/yes_no_model.dart';
import 'package:chanda_finance/repository/yesno_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/utils.dart';

final yesNoViewModelProvider =
    ChangeNotifierProvider.autoDispose((ref) => YesnoViewModel());

class YesnoViewModel with ChangeNotifier {
  final _myRepo = YesNoRepository();
  ApiResponse<YesNoModel> yesno = ApiResponse.loading();

  setYesnoList(ApiResponse<YesNoModel> response) {
    yesno = response;
    notifyListeners();
  }

  Future<void> getYesno(context) async {
    setYesnoList(ApiResponse.loading());
    _myRepo.getYesnoApi().then((value) {
      setYesnoList(value);
    }).onError((error, stackTrace) {
      setYesnoList(ApiResponse.error(error.toString()));
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }
}
