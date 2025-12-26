class AppUrl {
  static var commonUrl = "type_website_url_here";

  static var baseUrl = "https://$commonUrl/api/v1/";
  static var getUrl = "www.$commonUrl";
  static var getPath = "/api/v1";

  static var loginUrl = '${baseUrl}login';
  static var signUpUrl = '${baseUrl}signup';
  static var asaluUrl = '${baseUrl}asalu';
  static var chitiUrl = '${baseUrl}chiti';
  static var receivedIntUrl = '${baseUrl}receivedcollection';
  static var drcrUrl = '${baseUrl}drcr';
  static var collectoramountUrl = '${baseUrl}collectoramount';
  static var createCollectionUrl = '${baseUrl}collection';

  //get urls
  static var getcustomersListUrl = 'customers';
  static var getcreditorsListUrl = 'creditors';
  static var getAsaluUrl = 'asalu';
  static var getCollectionsListUrl = 'collection';
  static var getpaymentmodesUrl = 'paymentmodes';
  static var getlatestnotesUrl = 'latestnotes';
  static var getlastpaymentsUrl = 'lastpayment';
  static var getchitiUrl = 'chiti';
  static var getDaybookUrl = 'daybook';
  static var getShowLedgerUrl = 'showledger';
  static var getYesNoUrl = 'yesno';
  static var getDrcrUrl = 'drcr';
  static var getCollectionReportUrl = 'collectionreport';
  static var getCollectorAmountUrl = 'collectorsamount';
  static var getSingleCollectorAmountUrl = 'collectoramount';
}
