class APIResponse<T> {
  late T? data;
  late bool? error;
  late String? errorMessage;
  late String? successMessage;

  APIResponse(
      {this.data, this.errorMessage, this.error = false, this.successMessage});
}
