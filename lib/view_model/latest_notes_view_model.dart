import 'package:chanda_finance/res/globals.dart';
import 'package:chanda_finance/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:chanda_finance/data/response/api_response.dart';

import '../model/latest_notes.dart';
import '../repository/latestnotes_repository.dart';

class LatestNotesViewModel with ChangeNotifier {
  final _myRepo = LatestNotesRepository();

  bool _ischitiCalled = false;
  bool get ischitiCalled => _ischitiCalled;

  setIschitiCalled(bool value) {
    _ischitiCalled = value;
    notifyListeners();
  }

  ApiResponse<LatestNotesModel> latestNotes = ApiResponse.loading();

  setLatestNotes(ApiResponse<LatestNotesModel> response) {
    latestNotes = response;
    notifyListeners();
  }

  Future<void> fetchLatestNotesListApi(
      dynamic chitiId, BuildContext context) async {
    setLatestNotes(ApiResponse.loading());
    _myRepo.fetchLatestNotesList(chitiId).then((value) {
      setLatestNotes(
          ApiResponse.completed(value.data, value.message, value.Apistatus));
      setIschitiCalled(true);
      Utils.showResponseToast(value, context);
    }).onError((error, stackTrace) {
      Utils.showToast(error.toString(), "error", context);
      setLatestNotes(ApiResponse.error(error.toString()));
    });
  }
}
