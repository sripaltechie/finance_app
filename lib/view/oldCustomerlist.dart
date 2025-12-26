// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:chanda_finance/model/customerslist_model.dart';
// import 'package:chanda_finance/utils/routes_name.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// // import 'package:terrace_cricket/model/customerslist_model.dart';
// // import 'package:terrace_cricket/model/movies_model.dart';
// import 'package:chanda_finance/res/components/sized_box.dart';
// // import 'package:terrace_cricket/utils/routes_name.dart';
// // import 'package:terrace_cricket/view_model/Home_view_model.dart';
// // import 'package:terrace_cricket/view_model/services/splash_services.dart';
// // import 'package:terrace_cricket/view_model/user_view_model.dart';

// import '../data/response/status.dart';
// // import '../utils/utils.dart';
// import '../view_model/customerslist_view_model.dart';
// import 'navbar_view.dart';

// class CustomersListView extends StatefulWidget {
//   const CustomersListView({super.key});

//   @override
//   State<CustomersListView> createState() => _CustomersListViewState();
// }

// class _CustomersListViewState extends State<CustomersListView> {
//   CustomersListViewModel customersListViewModel = CustomersListViewModel();
//   List<Customers> filterUsers = [];
//   // void _runFilter(String enteredKeyword) {
//   //   CustomersListModel results = CustomersListModel();
//   //   if (enteredKeyword.isEmpty) {
//   //     results = users;
//   //   } else {
//   //     results = users
//   //         .where((user) => user.Firstname!
//   //             .toLowerCase()
//   //             .contains(enteredKeyword.toLowerCase()))
//   //         .toList();
//   //   }
//   //   setState(() {
//   //     filterUsers = results;
//   //   });
//   //   _isloading = false;
//   // }

//   @override
//   void initState() {
//     // TODO: implement initState
//     customersListViewModel.fetchCustomersListApi();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height * 1;
//     double width = MediaQuery.of(context).size.width * 1;
//     // final userPreference = Provider.of<CustomersListViewModel>(context);
//     return ChangeNotifierProvider<CustomersListViewModel>(
//       create: (BuildContext context) => customersListViewModel,
//       child: Consumer<CustomersListViewModel>(builder: (context, value, _) {
//         switch (value.customersList.status!) {
//           case Status.LOADING:
//             // TODO: Handle this case.
//             return const Center(child: CircularProgressIndicator());
//           case Status.ERROR:
//             // TODO: Handle this case.
//             return Center(child: Text(value.customersList.message.toString()));
//           case Status.COMPLETED:
//             // TODO: Handle this case.

//             return Scaffold(
//                 drawer: const NavBar(),
//                 appBar: AppBar(
//                   centerTitle: true,
//                   title: const Text(
//                     "Customers List",
//                   ),
//                   // automaticallyImplyLeading: false,
//                   // actions: [
//                   //   InkWell(
//                   //     onTap: () {
//                   //       // userPreference.remove().then((value) {
//                   //       // Navigator.pushNamed(context, RoutesName.login);
//                   //       // });
//                   //       // Utils.toastMessage("No Internet");
//                   //     },
//                   //     child: Center(
//                   //         child: Wrap(
//                   //       direction: Axis.horizontal,
//                   //       crossAxisAlignment: WrapCrossAlignment.center,
//                   //       children: const <Widget>[
//                   //         Icon(Icons.power_settings_new),
//                   //         Text('Logout'),
//                   //       ],
//                   //     )),
//                   //   ),
//                   //   10.pw,
//                   // ],
//                 ),
//                 body: SizedBox(
//                     width: width,
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           // Row(children: [
//                           // TextFormField(

//                           //   onChanged: (enteredValue) {
//                           //   if (enteredValue.isEmpty) {
//                           //     filterUsers =
//                           //         value.customersList.data!.customers!;
//                           //   } else {
//                           //     filterUsers = value
//                           //         .customersList.data!.customers!
//                           //         .where((user) => user.firstname!
//                           //             .toLowerCase()
//                           //             .contains(enteredValue.toLowerCase()))
//                           //         .toList();
//                           //   }
//                           //   setState(() {});
//                           // }
//                           //     // } //=> _runFilter(value),
//                           //     ),
//                           // ]),
//                           Row(children: [
//                             ListView.builder(
//                                 scrollDirection: Axis.vertical,
//                                 shrinkWrap: true,
//                                 itemCount:
//                                     value.customersList.data!.customers!.length,
//                                 itemBuilder: (context, index) {
//                                   return InkWell(
//                                     onTap: () => Navigator.pushNamed(
//                                         context, RoutesName.customer,
//                                         arguments: [
//                                           value.customersList.data!
//                                               .customers![index].id
//                                         ]),
//                                     child: Card(
//                                         child: ListTile(
//                                       // leading: CachedNetworkImage(
//                                       //   height: 40,
//                                       //   width: 40,
//                                       //   fit: BoxFit.cover,
//                                       //   imageUrl: value
//                                       //       .customersList.data!.customers![index].posterurl
//                                       //       .toString(),
//                                       //   placeholder: (context, url) =>
//                                       //       const CircularProgressIndicator(),
//                                       //   errorWidget: (context, url, error) =>
//                                       //       const Icon(Icons.error),
//                                       // ),
//                                       title: Text(
//                                           "${value.customersList.data!.customers![index].firstname} ${value.customersList.data!.customers![index].lastName}"),
//                                       subtitle: Text(value.customersList.data!
//                                           .customers![index].hamiFirstName
//                                           .toString()),
//                                       trailing: Row(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Text(value.customersList.data!
//                                               .customers![index].phoneNo
//                                               .toString()),
//                                           const Icon(
//                                             Icons.star,
//                                             color: Colors.yellow,
//                                           )
//                                         ],
//                                       ),
//                                     )),
//                                   );
//                                 }),
//                           ]),
//                         ])));
//         }
//       }),
//     );
//   }
// }
// //git commit -m "0.0.8 Basic structure for login with only post
