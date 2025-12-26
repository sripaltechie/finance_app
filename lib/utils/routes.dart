import 'package:chanda_finance/view/add_interest_entry_view.dart';
import 'package:chanda_finance/view/chiti_view.dart';
import 'package:chanda_finance/view/create_cash_entry_view.dart';
import 'package:chanda_finance/view/creditorslist_view.dart';
import 'package:chanda_finance/view/daily_collection_view.dart';
import 'package:chanda_finance/view/editasalu.dart';
import 'package:chanda_finance/view/ledger_view.dart';
import 'package:chanda_finance/view/profilepic_view.dart';
import 'package:chanda_finance/view/theme_changer_view.dart';
import 'package:flutter/material.dart';
import 'package:chanda_finance/utils/routes_name.dart';
import 'package:chanda_finance/view/login_view.dart';
import 'package:chanda_finance/view/signup_view.dart';
import 'package:chanda_finance/view/splash_view.dart';

import '../view/collection_rcvd_view.dart';
import '../view/create_collectoramount_view.dart';
import '../view/customer_view.dart';
import '../view/customerslist_view.dart';
import '../view/edit_cash_entry.dart';
import '../view/home_view.dart';
import '../view/last_payments_view.dart';
import '../view/settings_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    List<dynamic> args = [];
    if (settings.arguments != null) {
      args = settings.arguments as List<dynamic>;
    }

    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashView());
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => HomeView(
                  chitiId: (args.isNotEmpty) ? args[0] : 0,
                ));
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginView());
      case RoutesName.signUp:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignUpView());
      case RoutesName.dailycollection:
        return MaterialPageRoute(
            builder: (BuildContext context) => DailyCollection(
                  chitiId: (args.isNotEmpty) ? args[0] : 0,
                ));
      case RoutesName.customer:
        return MaterialPageRoute(
            builder: (BuildContext context) => CustomerView(
                  id: (args.isNotEmpty) ? args[0] : 0,
                  customername: (args.length > 1) ? args[1] : 0,
                ));

      case RoutesName.editasalu:
        return MaterialPageRoute(
            builder: (BuildContext context) => EditAsaluView(
                  id: (args.isNotEmpty) ? args[0] : 0,
                  backPage: args[1] ?? args[1],
                ));
      case RoutesName.collection_rcvd:
        return MaterialPageRoute(
            builder: (BuildContext context) => CollectionRcvdView(
                  colId: (args.isNotEmpty) ? args[0] : 0,
                ));
      case RoutesName.add_interest_entry:
        return MaterialPageRoute(
            builder: (BuildContext context) => AddInterestEntryView(
                  chitiId: (args.isNotEmpty) ? args[0] : 0,
                  customerId: (args.isNotEmpty) ? args[1] : 0,
                  lastDate: (args.isNotEmpty) ? args[2] : 0,
                ));

      case RoutesName.customerslist:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CustomersListView());
      case RoutesName.creditorslist:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CreditorsListView());
      case RoutesName.ledgerView:
        return MaterialPageRoute(
            builder: (BuildContext context) => LedgerView(
                  fromDate: (args.isNotEmpty) ? args[0] : 0,
                  toDate: (args.isNotEmpty) ? args[1] : 0,
                  customerId: (args.isNotEmpty) ? args[2] : 0,
                  customerName: (args.isNotEmpty) ? args[3] : 0,
                  forInt: (args.isNotEmpty) ? args[4] : 0,
                ));
      case RoutesName.lastpayments:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LastPaymentsView());
      case RoutesName.themechanger:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ThemeChangerView());
      case RoutesName.profilePic:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ProfilePicScreen());
      case RoutesName.chiti:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                ChitiView(chitiId: (args.isNotEmpty) ? args[0] : 0));
      case RoutesName.settings:
        return MaterialPageRoute(
            builder: (BuildContext context) => SettingsView());
      case RoutesName.createCashEntry:
        return MaterialPageRoute(
            builder: (BuildContext context) => CashEntryView());
      case RoutesName.editCashEntry:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                EditCashEntryView(Id: (args.isNotEmpty) ? args[0] : 0));
      case RoutesName.createCollectorAmount:
        return MaterialPageRoute(
            builder: (BuildContext context) => CreateCollectorAmountView());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No Route Defined'),
            ),
          );
        });
    }
  }
}
