import 'package:chanda_finance/data/response/api_response.dart';
import 'package:chanda_finance/model/daybookModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/daybook_repository.dart';
import '../utils/utils.dart';

final daybookViewModelProvider =
    ChangeNotifierProvider.autoDispose((ref) => DaybookViewModel());

class DaybookViewModel with ChangeNotifier {
  final _myRepo = DaybookRepository();
  ApiResponse<DaybookModel> daybook = ApiResponse.loading();

  setDaybook(ApiResponse<DaybookModel> response) {
    daybook = response;
    notifyListeners();
  }

  Future<void> getDaybook(dynamic queryParameters, context) async {
    setDaybook(ApiResponse.loading());
    _myRepo.getDaybookApi(queryParameters).then((value) {
      setDaybook(ApiResponse.completedobj(value));
    }).onError((error, stackTrace) {
      setDaybook(ApiResponse.error(error.toString()));
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }
}
