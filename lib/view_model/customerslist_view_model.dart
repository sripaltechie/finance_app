import 'package:flutter/material.dart';
import 'package:chanda_finance/data/response/api_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/customerslist_model.dart';
import '../repository/customerList_repository.dart';

final customersListViewModelProvider =
    ChangeNotifierProvider.autoDispose((ref) => CustomersListViewModel());

class CustomersListViewModel with ChangeNotifier {
  final _myRepo = CustomersListRepository();

  ApiResponse<CustomersListModel> customersList = ApiResponse.loading();

  setCustomersList(ApiResponse<CustomersListModel> response) {
    customersList = response;
    notifyListeners();
  }

  Future<void> fetchCustomersListApi() async {
    setCustomersList(ApiResponse.loading());
    _myRepo.fetchCustomersList().then((value) {
      setCustomersList(
          ApiResponse.completed(value.data, value.message, value.Apistatus));
    }).onError((error, stackTrace) {
      setCustomersList(ApiResponse.error(error.toString()));
    });
  }
}
