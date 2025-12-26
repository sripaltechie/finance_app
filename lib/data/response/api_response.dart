import 'package:chanda_finance/data/response/status.dart';

class ApiResponse<T> {
  Status? status;
  String? Apistatus;
  T? data;
  String? message;

  ApiResponse(this.status, this.Apistatus, this.data, this.message);

  ApiResponse.loading() : status = Status.LOADING;
  ApiResponse.completed(this.data, this.message, this.Apistatus)
      : status = Status.COMPLETED;
  ApiResponse.completedobj(ApiResponse<dynamic> value) {
    this.data = value.data;
    this.message = value.message;
    this.Apistatus = value.Apistatus;
    status = Status.COMPLETED;
  }

  ApiResponse.completedData_status(dynamic data, dynamic res) {
    this.data = data;
    this.message = res['message'];
    this.Apistatus = res['status'];
    status = Status.COMPLETED;
  }

  ApiResponse.postResp(dynamic value) {
    this.data = value["id"];
    this.message = value["message"];
    this.Apistatus = value["status"];
    status = Status.COMPLETED;
  }

  ApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n ApiStatus : $Apistatus \n Message : $message \n Data: $data";
  }
}
