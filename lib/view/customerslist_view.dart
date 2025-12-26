import 'package:cached_network_image/cached_network_image.dart';
import 'package:chanda_finance/model/customerslist_model.dart';
import 'package:chanda_finance/utils/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:terrace_cricket/model/customerslist_model.dart';
// import 'package:terrace_cricket/model/movies_model.dart';
import 'package:chanda_finance/res/components/sized_box.dart';
// import 'package:terrace_cricket/utils/routes_name.dart';
// import 'package:terrace_cricket/view_model/Home_view_model.dart';
// import 'package:terrace_cricket/view_model/services/splash_services.dart';
// import 'package:terrace_cricket/view_model/user_view_model.dart';

import '../data/response/status.dart';
// import '../utils/utils.dart';
import '../view_model/customerslist_view_model.dart';
import 'navbar_view.dart';

class CustomersListView extends StatefulWidget {
  const CustomersListView({super.key});

  @override
  State<CustomersListView> createState() => _CustomersListViewState();
}

class _CustomersListViewState extends State<CustomersListView> {
  CustomersListViewModel customersListViewModel = CustomersListViewModel();
  List<Customers> filterUsers = [];
  final TextEditingController _filterInput = TextEditingController();
  FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

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

  void getCustomersList() {
    customersListViewModel.fetchCustomersListApi();
    _focusNode.requestFocus();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCustomersList();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 1;
    double width = MediaQuery.of(context).size.width * 1;
    // final userPreference = Provider.of<CustomersListViewModel>(context);
    return ChangeNotifierProvider<CustomersListViewModel>(
      create: (BuildContext context) => customersListViewModel,
      child: Consumer<CustomersListViewModel>(builder: (context, value, _) {
        switch (value.customersList.status!) {
          case Status.LOADING:
            // TODO: Handle this case.
            return const Center(child: CircularProgressIndicator());
          case Status.ERROR:
            // TODO: Handle this case.
            return Center(child: Text(value.customersList.message.toString()));
          case Status.COMPLETED:
            // TODO: Handle this case.
            (_filterInput.text.isEmpty)
                ? filterUsers = value.customersList.data!.customers!
                : null;
            filterUsers.sort((a, b) => a.fullname.toString().compareTo(b
                .fullname
                .toString())); // Sort the list alphabetically by item name
            return Scaffold(
                drawer: const NavBar(),
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text(
                    "Customers List",
                  ),
                ),
                body: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Add other widgets here
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
                                          filterUsers = value
                                              .customersList.data!.customers!;
                                        });
                                      },
                                    )
                                  : IconButton(
                                      icon: const Icon(Icons.refresh_rounded),
                                      onPressed: () {
                                        setState(() {
                                          getCustomersList();
                                        });
                                      },
                                    )),
                          onChanged: (enteredValue) {
                            if (enteredValue.isEmpty) {
                              setState(() {
                                filterUsers =
                                    value.customersList.data!.customers!;
                              });
                            } else {
                              setState(() {
                                filterUsers = value
                                    .customersList.data!.customers!
                                    .where((user) => user.fullname!
                                        .toLowerCase()
                                        .contains(enteredValue.toLowerCase()))
                                    .toList();
                              });
                            }
                          },
                          // } //=> _runFilter(value),
                        ),
                      ),
                      // ),
                      Expanded(
                        child: Scrollbar(
                          controller: _scrollController,
                          thumbVisibility: true,
                          thickness: 10,
                          interactive: true,
                          child: ListView.builder(
                              controller: _scrollController,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: filterUsers.length,
                              //value.customersList.data!.customers!.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () => Navigator.pushNamed(
                                      context, RoutesName.customer,
                                      arguments: [
                                        filterUsers[index].id,
                                        filterUsers[index].fullname.toString()
                                        //value.customersList.data!.customers![index].id
                                      ]),
                                  child: Card(
                                      child: ListTile(
                                    // leading: CachedNetworkImage(
                                    //   height: 40,
                                    //   width: 40,
                                    //   fit: BoxFit.cover,
                                    //   imageUrl: value
                                    //       .customersList.data!.customers![index].posterurl
                                    //       .toString(),
                                    //   placeholder: (context, url) =>
                                    //       const CircularProgressIndicator(),
                                    //   errorWidget: (context, url, error) =>
                                    //       const Icon(Icons.error),
                                    // ),
                                    title: Text(
                                        "${filterUsers[index].firstname} ${filterUsers[index].lastName}"),
                                    //"${value.customersList.data!.customers![index].firstname} ${value.customersList.data!.customers![index].lastName}"),
                                    subtitle: Text(
                                        //value.customersList.data!
                                        //.customers![index].hamiFirstName
                                        filterUsers[index]
                                            .hamiFirstName
                                            .toString()),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                            // value.customersList.data!
                                            //   .customers![index].phoneNo
                                            filterUsers[index]
                                                .phoneNo
                                                .toString()),
                                      ],
                                    ),
                                  )),
                                );
                              }),
                        ),
                      ),
                    ]));
        }
      }),
    );
  }
}
//git commit -m "0.0.8 Basic structure for login with only post
