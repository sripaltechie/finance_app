import 'package:chanda_finance/model/creditorsListModel.dart';
import 'package:chanda_finance/utils/routes_name.dart';
import 'package:chanda_finance/utils/utils.dart';
import 'package:chanda_finance/view_model/creditorslist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:terrace_cricket/model/customerslist_model.dart';
// import 'package:terrace_cricket/model/movies_model.dart';
// import 'package:terrace_cricket/utils/routes_name.dart';
// import 'package:terrace_cricket/view_model/Home_view_model.dart';
// import 'package:terrace_cricket/view_model/services/splash_services.dart';
// import 'package:terrace_cricket/view_model/user_view_model.dart';

import '../data/response/status.dart';
// import '../utils/utils.dart';
import 'navbar_view.dart';

class CreditorsListView extends StatefulWidget {
  const CreditorsListView({super.key});

  @override
  State<CreditorsListView> createState() => _CreditorsListViewState();
}

class _CreditorsListViewState extends State<CreditorsListView> {
  CreditorsListViewModel creditorsListViewModel = CreditorsListViewModel();

  List<CreditorsList> filterUsers = [];
  final TextEditingController _filterInput = TextEditingController();
  FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  // bool _isForIntEnabled = true;
  bool _hideZeroAmount = false;
  bool _forInt = true;

  //alpha end
  // void _runFilter(String enteredKeyword) {
  //   CustomersListModel results = CustomersListModel();
  //   if (enteredKeyword.isEmpty) {
  //     results = users;
  //   } else {
  //     results = users
  //         .where((user) => user.Firstname!
  //             .toLowerCase()
  //             .contains(enteredKeyword.toLowerCase()))
  //         .toList();
  //   }
  //   setState(() {
  //     filterUsers = results;
  //   });
  //   _isloading = false;
  // }

  bool sortAscending = true;
  int sortColumnIndex = 0;
  List<Map<String, dynamic>> creditors =
      []; // Initialize it as an empty list initially

  // void _showPopupDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Filter"),
  //         content: Text("Your dialog content goes here."),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text("Close"),
  //             onPressed: () {
  //               Navigator.of(context).pop(); // Close the dialog
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void _sort<T>(Comparable<T> getField(Map<String, dynamic> d), int columnIndex,
      bool ascending) {
    // creditors.sort((a, b) {
    //   final aValue = (getField(a).runtimeType == int)
    //       ? int.tryParse(getField(a).toString())
    //       : getField(a).toString().toLowerCase();
    //   final bValue = (getField(b).runtimeType == int)
    //       ? int.tryParse(getField(b).toString())
    //       : getField(b).toString().toLowerCase();
    //   return ascending ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
    //   // ? Comparable.compare(aValue, bValue)
    //   // : Comparable.compare(bValue, aValue);
    // });
    creditors.sort((a, b) {
      // print(getField(a).runtimeType);
      final aValue = (getField(a).runtimeType == int)
          ? int.tryParse(getField(a).toString())
          : (getField(a).runtimeType == double)
              ? double.parse(getField(a).toString())
              : getField(a).toString().toLowerCase() as Comparable<dynamic>;

      final bValue = (getField(b).runtimeType == int)
          ? int.tryParse(getField(b).toString())
          : (getField(b).runtimeType == double)
              ? double.parse(getField(b).toString())
              : getField(b).toString().toLowerCase() as Comparable<dynamic>;

      if (aValue != null && bValue != null) {
        return ascending ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
      } else if (aValue != null) {
        return 1; // a non-null value is considered greater
      } else if (bValue != null) {
        return -1; // a non-null value is considered greater
      } else {
        return 0; // both values are null
      }
    });

    setState(() {
      sortColumnIndex = columnIndex;
      sortAscending = ascending;
    });
  }

  void getCreditorsList() {
    dynamic _filter = {
      "forint": (_forInt) ? "1" : "0",
      "sort_by": "a.firstname",
      "sort_order": "asc"
    };

    creditorsListViewModel.fetchCreditorsListApi(_filter);
    _focusNode.requestFocus();
  }

  void focusOnFilter() {
    Future.delayed(const Duration(milliseconds: 500), () {
      _focusNode.requestFocus();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCreditorsList();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 1;
    double width = MediaQuery.of(context).size.width * 1;
    // _isForIntEnabled = true;
    // final userPreference = Provider.of<CustomersListViewModel>(context);

    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Creditors List",
        ),
        actions: <Widget>[
          Center(
              child: Text(
            "For Int",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          )),
          Switch(
            value: _forInt, // Provide your switch value here
            onChanged: (bool value) {
              setState(() {
                _forInt = value;
                if (_forInt) {
                  creditorsListViewModel.fetchCreditorsListApi({
                    "forint": "1",
                    "sort_by": "a.firstname",
                    "sort_order": "asc"
                  });
                  focusOnFilter();
                } else {
                  creditorsListViewModel.fetchCreditorsListApi({
                    "forint": "0",
                    "sort_by": "a.firstname",
                    "sort_order": "asc"
                  });
                  focusOnFilter();
                }
              });
            },
          ),
        ],
      ),
      body: ChangeNotifierProvider<CreditorsListViewModel>(
        create: (BuildContext context) => creditorsListViewModel,
        child: Consumer<CreditorsListViewModel>(builder: (context, value, _) {
          switch (value.creditorsList.status!) {
            case Status.LOADING:
              // TODO: Handle this case.
              return const Center(child: CircularProgressIndicator());
            case Status.ERROR:
              // TODO: Handle this case.
              return Center(
                  child: Text(value.creditorsList.message.toString()));
            case Status.COMPLETED:
              // TODO: Handle this case.
              (_filterInput.text.isEmpty)
                  ? filterUsers = value.creditorsList.data!.creditorsList!
                  : null;
              Future.delayed(Duration.zero, () {
                if (value.iscreditorsListCalled) {
                  filterUsers.sort((a, b) => a.customername
                      .toString()
                      .toLowerCase()
                      .compareTo(b.customername
                          .toString()
                          .toLowerCase())); // Sort the list alphabetically by item name
                  creditors = filterUsers.map((user) {
                    return {
                      'customer': user.customer,
                      'customername': user.customername,
                      'amount': user.amount,
                      'interest': user.interest,
                      'intrate': user.intrate,
                      'inttilldate': user.inttilldate,
                      'lastintmonth': user.lastintmonth,
                    };
                  }).toList();
                  creditorsListViewModel.setiscreditorsListCalled(false);
                }
              });

              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Add other widgets here
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Hide Amount Column with Zero Values"),
                          Switch(
                            value: _hideZeroAmount,
                            onChanged: (bool value) {
                              // Update the local variable when the switch is toggled
                              setState(() {
                                _hideZeroAmount = value;
                                if (_hideZeroAmount) {
                                  creditors = creditors
                                      .where(
                                          (creditor) => creditor["amount"] != 0)
                                      .toList();
                                } else {
                                  creditors = filterUsers.map((user) {
                                    return {
                                      'customer': user.customer,
                                      'customername': user.customername,
                                      'amount': user.amount,
                                      'interest': user.interest,
                                      'intrate': user.intrate,
                                      'inttilldate': user.inttilldate,
                                      'lastintmonth': user.lastintmonth,
                                    };
                                  }).toList();
                                }
                              });
                            },
                          ),
                        ],
                      ),

                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextFormField(
                          controller: _filterInput,
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person_2,
                              color: Colors.blue[200],
                              size: 24,
                            ),
                            suffixIcon: (_filterInput.text.isNotEmpty)
                                ? IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      _filterInput.clear();
                                      setState(() {
                                        // creditors = .;
                                        creditors = value
                                            .creditorsList.data!.creditorsList!
                                            .map((user) {
                                          return {
                                            'customer': user.customer,
                                            'customername': user.customername,
                                            'amount': user.amount,
                                            'interest': user.interest,
                                            'intrate': user.intrate,
                                            'inttilldate': user.inttilldate,
                                            'lastintmonth': user.lastintmonth,
                                          };
                                        }).toList();
                                      });
                                    },
                                  )
                                : IconButton(
                                    icon: const Icon(Icons.refresh_rounded),
                                    onPressed: () {
                                      setState(() {
                                        getCreditorsList();
                                        focusOnFilter();
                                      });
                                    },
                                  ),
                          ),
                          onChanged: (enteredValue) {
                            if (enteredValue.isEmpty) {
                              setState(() {
                                // filterUsers =
                                //     value.creditorsList.data!.creditorsList!;
                                creditors = value
                                    .creditorsList.data!.creditorsList!
                                    .map((user) {
                                  return {
                                    'customer': user.customer,
                                    'customername': user.customername,
                                    'amount': user.amount,
                                    'interest': user.interest,
                                    'intrate': user.intrate,
                                    'inttilldate': user.inttilldate,
                                    'lastintmonth': user.lastintmonth,
                                  };
                                }).toList();
                              });
                            } else {
                              setState(() {
                                filterUsers = value
                                    .creditorsList.data!.creditorsList!
                                    .where((user) => user.customername!
                                        .toLowerCase()
                                        .contains(enteredValue.toLowerCase()))
                                    .toList();
                                creditors = filterUsers.map((user) {
                                  return {
                                    'customer': user.customer,
                                    'customername': user.customername,
                                    'amount': user.amount,
                                    'interest': user.interest,
                                    'intrate': user.intrate,
                                    'inttilldate': user.inttilldate,
                                    'lastintmonth': user.lastintmonth,
                                  };
                                }).toList();
                              });
                            }
                          },
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          sortColumnIndex: sortColumnIndex,
                          sortAscending: sortAscending,
                          showCheckboxColumn: false,
                          columns: [
                            DataColumn(
                              label: Text('Customer ID'),
                              onSort: (columnIndex, ascending) {
                                _sort((d) => d["customer"], columnIndex,
                                    ascending);
                              },
                            ),
                            DataColumn(
                              label: Text('Customer Name'),
                              onSort: (columnIndex, ascending) {
                                _sort((d) => d["customername"], columnIndex,
                                    ascending);
                              },
                            ),
                            DataColumn(
                              label: Text('Interest Rate'),
                              onSort: (columnIndex, ascending) {
                                _sort((d) => d["intrate"], columnIndex,
                                    ascending);
                              },
                            ),
                            DataColumn(
                              label: Text('Amount'),
                              onSort: (columnIndex, ascending) {
                                _sort(
                                    (d) => d["amount"], columnIndex, ascending);
                              },
                            ),
                            DataColumn(
                              label: Text('Interest'),
                              onSort: (columnIndex, ascending) {
                                _sort((d) => d["interest"], columnIndex,
                                    ascending);
                              },
                            ),
                          ],
                          rows: creditors.map((creditor) {
                            return DataRow(
                              cells: [
                                DataCell(Text(creditor["customer"].toString())),
                                DataCell(Text(creditor["customername"])),
                                DataCell(Text(creditor["intrate"].toString())),
                                DataCell(Text(creditor["amount"].toString())),
                                DataCell(Text(creditor["interest"].toString())),
                              ],
                              onSelectChanged: (selected) {
                                // Add your onTap function here
                                print(creditor);
                                if (selected!) {
                                  Navigator.pushNamed(
                                      context, RoutesName.ledgerView,
                                      arguments: [
                                        "2018-01-01",
                                        Utils.todaySqlDate(),
                                        creditor["customer"].toString(),
                                        creditor["customername"].toString(),
                                        (_forInt) ? "1" : "0"
                                      ]);
                                  // This function will be triggered when the DataRow is tapped.
                                  // You can navigate or perform any action you want here.
                                  // For example, you can navigate to a detailed view:
                                }
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ]),
              );
          }
        }),
      ),
    );
  }
}
          // Scaffold(
          //     drawer: const NavBar(),
          //     appBar: AppBar(
          //       centerTitle: true,
          //       title: const Text(
          //         "Creditors List",
          //       ),
          //       actions: <Widget>[
          //         Center(
          //             child: Text(
          //           "For Int",
          //           style:
          //               TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          //         )),
          //         Switch(
          //           value: _isForIntEnabled, // Provide your switch value here
          //           onChanged: (bool value) {
          //             setState(() {
          //               _isForIntEnabled = value;
          //               if (_isForIntEnabled) {
          //                 creditorsListViewModel.fetchCreditorsListApi({
          //                   "forint": "1",
          //                   "sort_by": "a.firstname",
          //                   "sort_order": "asc"
          //                 });
          //                 focusOnFilter();
          //               } else {
          //                 creditorsListViewModel.fetchCreditorsListApi({
          //                   "forint": "0",
          //                   "sort_by": "a.firstname",
          //                   "sort_order": "asc"
          //                 });
          //                 focusOnFilter();
          //               }
          //             });
          //           },
          //         ),
          //       ],
          //       // actions: [
          //       //   SwitchListTile(
          //       //     title: Text('For Int'),
          //       //     value: _isForIntEnabled,
          //       //     onChanged: (value) {
          //       //       // setState(() {
          //       //       //   _isForIntEnabled = value;
          //       //       //   if (_isForIntEnabled) {
          //       //       //   } else {}
          //       //       // });
          //       //     },
          //       //   ),
          //       // ],
          //     ),
          //     body: Column(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           // Add other widgets here
          //           Container(
          //             padding: const EdgeInsets.only(left: 20),
          //             child: TextFormField(
          //               controller: _filterInput,
          //               focusNode: _focusNode,
          //               decoration: InputDecoration(
          //                   prefixIcon: Icon(
          //                     Icons.person_2,
          //                     color: Colors.blue[200],
          //                     size: 24,
          //                   ),
          //                   suffixIcon: (_filterInput.text.isNotEmpty)
          //                       ? IconButton(
          //                           icon: const Icon(Icons.clear),
          //                           onPressed: () {
          //                             _filterInput.clear();
          //                             setState(() {
          //                               filterUsers = value.creditorsList
          //                                   .data!.creditorsList!;
          //                             });
          //                           },
          //                         )
          //                       : IconButton(
          //                           icon: const Icon(Icons.refresh_rounded),
          //                           onPressed: () {
          //                             setState(() {
          //                               getCreditorsList();
          //                               focusOnFilter();
          //                             });
          //                           },
          //                         )),
          //               onChanged: (enteredValue) {
          //                 if (enteredValue.isEmpty) {
          //                   setState(() {
          //                     filterUsers =
          //                         value.creditorsList.data!.creditorsList!;
          //                   });
          //                 } else {
          //                   setState(() {
          //                     filterUsers = value
          //                         .creditorsList.data!.creditorsList!
          //                         .where((user) => user.customername!
          //                             .toLowerCase()
          //                             .contains(enteredValue.toLowerCase()))
          //                         .toList();
          //                   });
          //                 }
          //               },
          //               // } //=> _runFilter(value),
          //             ),
          //           ),
          //           // ),
          //           Expanded(
          //             child: Scrollbar(
          //               controller: _scrollController,
          //               thumbVisibility: true,
          //               thickness: 10,
          //               interactive: true,
          //               child: ListView.builder(
          //                   controller: _scrollController,
          //                   scrollDirection: Axis.vertical,
          //                   shrinkWrap: true,
          //                   itemCount: filterUsers.length,
          //                   //value.customersList.data!.customers!.length,
          //                   itemBuilder: (context, index) {
          //                     return InkWell(
          //                       onTap: () => Navigator.pushNamed(
          //                           context, RoutesName.customer,
          //                           arguments: [
          //                             filterUsers[index].customer,
          //                             filterUsers[index]
          //                                 .customername
          //                                 .toString()
          //                             //value.customersList.data!.customers![index].id
          //                           ]),
          //                       child: Card(
          //                         child: ListTile(
          //                           title: Text(
          //                               'Customer Name: ${filterUsers[index].customername}'),
          //                           subtitle: Column(
          //                             crossAxisAlignment:
          //                                 CrossAxisAlignment.start,
          //                             children: [
          //                               Text(
          //                                   'Customer ID: ${filterUsers[index].customer}'),
          //                               Text(
          //                                   'Interest Rate: ${filterUsers[index].intrate}'),
          //                               Text(
          //                                   'Amount: ${filterUsers[index].amount}'),
          //                               Text(
          //                                   'Interest: ${filterUsers[index].interest}'),
          //                             ],
          //                           ),
          //                         ),
          //                         // child: ListTile(
          //                         //   // leading: CachedNetworkImage(
          //                         //   //   height: 40,
          //                         //   //   width: 40,
          //                         //   //   fit: BoxFit.cover,
          //                         //   //   imageUrl: value
          //                         //   //       .customersList.data!.customers![index].posterurl
          //                         //   //       .toString(),
          //                         //   //   placeholder: (context, url) =>
          //                         //   //       const CircularProgressIndicator(),
          //                         //   //   errorWidget: (context, url, error) =>
          //                         //   //       const Icon(Icons.error),
          //                         //   // ),
          //                         //   title: Text(
          //                         //       "${filterUsers[index].customername}"),
          //                         //   //"${value.customersList.data!.customers![index].firstname} ${value.customersList.data!.customers![index].lastName}"),
          //                         //   trailing: Row(
          //                         //     mainAxisSize: MainAxisSize.min,
          //                         //     children: [
          //                         //       Text(
          //                         //           // value.customersList.data!
          //                         //           //   .customers![index].phoneNo
          //                         //           filterUsers[index]
          //                         //               .amount
          //                         //               .toString()),
          //                         //       (_isForIntEnabled)
          //                         //           ? Text(filterUsers[index]
          //                         //               .intrate
          //                         //               .toString())
          //                         //           : Container()
          //                         //     ],
          //                         //   ),
          //                         // ),
          //                       ),
          //                     );
          //                   }),
          //             ),
          //           ),
          //         ]));
      
//       ),
//     );
//   }
// }
