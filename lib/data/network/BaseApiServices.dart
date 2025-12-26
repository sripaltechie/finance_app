abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url, dynamic queryParameters);
  Future<dynamic> getPostApiResponse(String url, dynamic data);
  Future<dynamic> getPutApiResponse(String url, dynamic data);
  Future<dynamic> getDeleteApiResponse(String url);
  // Future<dynamic> getResponse(String url);
  // Future<dynamic> getResponse(String url);
}
