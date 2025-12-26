import 'package:chanda_finance/view/collectionReport_view.dart';
import 'package:chanda_finance/view/daybook.dart';
import 'package:chanda_finance/view/settings_view.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../res/color.dart';
import 'customerslist_view.dart';
import 'daily_collection_view.dart';
import 'last_payments_view.dart';
import 'navbar_view.dart';

class HomeView extends StatefulWidget {
  final chitiId;
  const HomeView({super.key, this.chitiId});
  static final String id = 'home_screen';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // late PageController _pageController;
  // PageController _pageController; // = PageController(initialPage: 2);
  final _pageController = PageController(initialPage: 2);
  late int _chitiId = 0;
  final int _Page = 2;

  @override
  void initState() {
    super.initState();
    if (widget.chitiId > 0) {
      _chitiId = widget.chitiId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: NavBar(),
      body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: <Widget>[
            const LastPaymentsView(),
            const CustomersListView(),
            DailyCollection(
              chitiId: _chitiId,
            ),
            // LoginView(),
            const DaybookView(),
            const CollectionReportView()
          ],

          // _pageController.jumpToPage(_Page);
          onPageChanged: (int index) {
            setState(() {
              _pageController.jumpToPage(index);
            });
          }),
      bottomNavigationBar: CurvedNavigationBar(
        animationCurve: Curves.easeInOutBack,
        index: 2,
        items: const <Widget>[
          Icon(Icons.trending_up, size: 30, color: Colors.white),
          Icon(Icons.group, size: 30, color: Colors.white),
          Icon(Icons.add, size: 30, color: Colors.white),
          Icon(Icons.book, size: 30, color: Colors.white),
          Icon(
            Icons.account_balance_wallet,
            size: 30,
            color: Colors.white,
          ),
        ],
        color: AppColors.ThemeBlue,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppColors.themeBlackColor
            : AppColors.whiteColor,
        height: 60.0,
        onTap: (int index) {
          setState(() {
            _pageController.jumpToPage(index);
          });
        },
      ),
    );
  }
}
