import 'dart:convert';

import 'package:chanda_finance/model/collection_model.dart';
import 'package:chanda_finance/view_model/collection_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';
import '../model/paymentmodeModel.dart';
import '../model/user_model.dart';
import '../utils/utils.dart';
import '../view_model/paymentmodeslist_view_model.dart';
import '../view_model/user_view_model.dart';

class CollectionRcvdView extends StatefulWidget {
  final colId;
  const CollectionRcvdView({super.key, required this.colId});

  @override
  State<CollectionRcvdView> createState() => _CollectionRcvdViewState();
}

class _CollectionRcvdViewState extends State<CollectionRcvdView> {
  late int colId;
  final TextEditingController _dateInput = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _note = TextEditingController();
  final _myFormKey = GlobalKey<FormState>();
  List<String> pmnames = [];
  String dropdownValue = 'Cash';
  String customerName = "";
  bool _isLoading = false;
  PaymentmodesListViewModel paymentmodesListViewModel =
      PaymentmodesListViewModel();
  CollectionViewModel collectionViewModel = CollectionViewModel();
  Future<UserModel> getUserData() => UserViewModel().getUser();
  UserModel _user = UserModel();
  int _paymentmode = 1;
  List<PaymentmodeModel> _pmtrans = [];
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (int.parse(widget.colId.toString()) > 0) {
      colId = int.parse(widget.colId.toString());
      paymentmodesListViewModel.fetchPaymentmodesListApi(null);
      _dateInput.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
      collectionViewModel.fetchSingleCollectionApi(colId);
      getUserData().then((value) async {
        _user = value;
      });
      // _myRepo.fetchSingleCollection(colId).then((value) {
      //   if (value.data != null) {
      //     setState(() {
      //       _amount.text = value.data!.amount.toString();
      //       _note.text = value.data!.notes.toString();
      //       customerName = value.data!.customerFL.toString();
      //       _isLoading = false;
      //     });
      //   }
      // }).onError((error, stackTrace) {
      //   Utils.flushBarErrorMessage(error.toString(), context);
      // });
    }
  }

  void createReceived(CollectionModel collection) {
    if (_dateInput.text.contains(' ')) {
      _dateInput.text = (_dateInput.text.split(' '))[0];
      _dateInput.text = Utils.userFormat(_dateInput.text);
    }
    var tmp = {
      "rcvddate": Utils.sqlFormat(_dateInput.text),
      "userrcvddate": _dateInput.text.toString(),
      "customer": collection.customer.toString(),
      "customername": collection.customerFL.toString(),
      "chiti": collection.chiti.toString(),
      "collectedby": "0",
      "collectionarr": jsonEncode([
        {
          "colid": collection.id.toString(),
          "colamt": _amount.text.toString(),
          "paymentmode": _paymentmode.toString(),
          "pmtrans": (_paymentmode == 50) ? _pmtrans : []
        }
      ]),
      "paymentmode": "",
      "pmtrans": "",
      "note": _note.text.toString(),
      "note1": _note.text.toString(),
    };
    if (_paymentmode == 1) {
      tmp["collectedby"] = _user.collector.toString();
    } else if (_paymentmode == 50) {
      _pmtrans.forEach((e) {
        if (e.paymentmode == 1) {
          tmp["collectedby"] = _user.collector.toString();
        }
      });
    }

    collectionViewModel.createCollectionRcvdApi(tmp, context);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

    return ChangeNotifierProvider<CollectionViewModel>(
      create: (BuildContext context) => collectionViewModel,
      child: Consumer<CollectionViewModel>(builder: (context, value, _) {
        switch (value.collection.status!) {
          case Status.LOADING:
            // TODO: Handle this case.
            return const Center(child: CircularProgressIndicator());
          case Status.ERROR:
            // TODO: Handle this case.
            return Center(child: Text(value.collection.message.toString()));
          case Status.COMPLETED:
            Future.delayed(Duration.zero, () {
              if (value.isCollectionCalled) {
                _amount.text = value.collection.data!.amount.toString();
                customerName = value.collection.data!.customerFL.toString();
                value.setIsCollectionCalled(false);
              }
            });
            return Scaffold(
              appBar: AppBar(
                title: Text(
                    "${value.collection.data!.customerFL!.toString()}(${value.collection.data!.haminame}) "),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Form(
                        key: _myFormKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: Stack(fit: StackFit.expand, children: [
                                Container(
                                  margin: EdgeInsets.only(left: 35, right: 35),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter Date';
                                          }
                                          return null;
                                        },
                                        controller: _dateInput,
                                        //editing controller of this TextField
                                        decoration: const InputDecoration(
                                            icon: Icon(Icons
                                                .calendar_today), //icon of text field
                                            labelText:
                                                "Enter Date" //label text of field
                                            ),
                                        readOnly: true,
                                        //set it true, so that user will not able to edit text
                                        onTap: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime
                                                      .now(), //Add this in your Code.
                                                  // initialEntryMode: DatePickerEntryMode.input,
                                                  firstDate: DateTime(1950),
                                                  //DateTime.now() - not to allow to choose before today.
                                                  lastDate: DateTime(2100));

                                          if (pickedDate != null) {
                                            String formattedDate =
                                                DateFormat('dd/MM/yyyy')
                                                    .format(pickedDate);

                                            setState(() {
                                              _dateInput.text =
                                                  formattedDate; //set output date to TextField value.
                                            });
                                          } else {
                                            // var now = new DateTime.now();
                                            // var formattedDate =
                                            //     new DateFormat('dd-MM-yyyy');
                                            // print(formattedDate);
                                            setState(() {
                                              _dateInput.text =
                                                  DateTime.now().toString();
                                            });
                                          }
                                        },
                                      ),
                                      TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter Amount';
                                          }
                                          return null;
                                        },
                                        style: TextStyle(color: Colors.black),
                                        controller: _amount,
                                        // focusNode: amountFocusNode,
                                        decoration: InputDecoration(
                                            fillColor: Colors.grey.shade100,
                                            filled: true,
                                            helperText: "Amount",
                                            helperStyle: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            hintText: "Amount",
                                            hintStyle:
                                                TextStyle(color: Colors.black),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            )),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        style: TextStyle(color: Colors.black),
                                        controller: _note,
                                        decoration: InputDecoration(
                                            fillColor: Colors.grey.shade100,
                                            filled: true,
                                            helperText: "Note",
                                            helperStyle: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                            hintText: "Note",
                                            hintStyle: const TextStyle(
                                                color: Colors.black),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      // ChangeNotifierProvider<
                                      //         PaymentmodesListViewModel>(
                                      //     create: (BuildContext context) =>
                                      //         paymentmodesListViewModel,
                                      //     child: Consumer<
                                      //         PaymentmodesListViewModel>(
                                      //       builder: (context, pmvalue, _) {
                                      //         switch (pmvalue
                                      //             .PaymentmodesList.status!) {
                                      //           case Status.LOADING:
                                      //             // TODO: Handle this case.
                                      //             return const Center(
                                      //                 child:
                                      //                     CircularProgressIndicator());
                                      //           case Status.ERROR:
                                      //             // TODO: Handle this case.
                                      //             return Center(
                                      //                 child: Text(pmvalue
                                      //                     .PaymentmodesList
                                      //                     .message
                                      //                     .toString()));
                                      //           case Status.COMPLETED:
                                      //             Future.delayed(Duration.zero,
                                      //                 () {
                                      //               if (pmvalue
                                      //                   .isPmModeCalled) {
                                      //                 _paymentmodeList = pmvalue
                                      //                     .PaymentmodesList
                                      //                     .data!;
                                      //                 pmnames = Utils
                                      //                     .getpmnames(pmvalue
                                      //                         .PaymentmodesList
                                      //                         .data!);
                                      //                 pmvalue.setisPmModeCalled(
                                      //                     false);
                                      //               }
                                      //             });
                                      //             return DropdownButton<String>(
                                      //               isExpanded: true,
                                      //               value: dropdownValue,
                                      //               items: pmnames.map<
                                      //                       DropdownMenuItem<
                                      //                           String>>(
                                      //                   (String value) {
                                      //                 return DropdownMenuItem<
                                      //                     String>(
                                      //                   value: value,
                                      //                   child: Text(
                                      //                     value,
                                      //                     style:
                                      //                         const TextStyle(
                                      //                             fontSize: 15),
                                      //                   ),
                                      //                 );
                                      //               }).toList(),
                                      //               // Step 5.
                                      //               onChanged:
                                      //                   (String? newValue) {
                                      //                 setState(() {
                                      //                   dropdownValue =
                                      //                       newValue!;
                                      //                 });
                                      //               },
                                      //             );
                                      //         }
                                      //       },
                                      //     )),
                                      ChangeNotifierProvider<
                                              PaymentmodesListViewModel>(
                                          create: (BuildContext context) =>
                                              paymentmodesListViewModel,
                                          child: Consumer<
                                              PaymentmodesListViewModel>(
                                            builder: (context, pmvalue, _) {
                                              switch (pmvalue
                                                  .PaymentmodesList.status!) {
                                                case Status.LOADING:
                                                  // TODO: Handle this case.
                                                  return const Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                case Status.ERROR:
                                                  // TODO: Handle this case.
                                                  return Center(
                                                      child: Text(pmvalue
                                                          .PaymentmodesList
                                                          .message
                                                          .toString()));
                                                case Status.COMPLETED:
                                                  return (_paymentmode != 50)
                                                      ? Row(children: [
                                                          Expanded(
                                                            child:
                                                                DropdownButton<
                                                                    int>(
                                                              isExpanded: true,
                                                              value:
                                                                  _paymentmode,
                                                              items: pmvalue
                                                                  .PaymentmodesList
                                                                  .data!
                                                                  .map<DropdownMenuItem<int>>(
                                                                      (value) {
                                                                return DropdownMenuItem<
                                                                    int>(
                                                                  value: int
                                                                      .parse(value
                                                                          .id
                                                                          .toString()),
                                                                  child: Text(
                                                                    value
                                                                        .modename
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            15),
                                                                  ),
                                                                );
                                                              }).toList(),
                                                              // Step 5.
                                                              onChanged: (int?
                                                                  newValue) {
                                                                setState(() {
                                                                  _paymentmode =
                                                                      newValue!;
                                                                  if (_paymentmode ==
                                                                      50) {
                                                                    _pmtrans = [
                                                                      PaymentmodeModel(
                                                                          paymentmode:
                                                                              1,
                                                                          credit:
                                                                              0,
                                                                          debit:
                                                                              0),
                                                                      PaymentmodeModel(
                                                                          paymentmode:
                                                                              1,
                                                                          credit:
                                                                              0,
                                                                          debit:
                                                                              0),
                                                                    ];
                                                                    _controllers =
                                                                        List.generate(
                                                                      _pmtrans
                                                                          .length,
                                                                      (index) =>
                                                                          TextEditingController(),
                                                                    );
                                                                  }
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        ])
                                                      : SizedBox(
                                                          width: width,
                                                          height: height * 0.3,
                                                          child:
                                                              SingleChildScrollView(
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                    width:
                                                                        width,
                                                                    height:
                                                                        height *
                                                                            0.2,
                                                                    child: ListView
                                                                        .builder(
                                                                      itemCount:
                                                                          _pmtrans
                                                                              .length, // number of items in your data list
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int index) {
                                                                        return Column(
                                                                            children: [
                                                                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                                                Expanded(
                                                                                  child: DropdownButton<int>(
                                                                                    isExpanded: true,
                                                                                    value: _pmtrans[index].paymentmode,
                                                                                    items: pmvalue.PaymentmodesList.data!.map<DropdownMenuItem<int>>((value) {
                                                                                      return DropdownMenuItem<int>(
                                                                                        value: int.parse(value.id.toString()),
                                                                                        child: Text(
                                                                                          value.modename.toString(),
                                                                                          style: const TextStyle(fontSize: 15),
                                                                                        ),
                                                                                      );
                                                                                    }).toList(),
                                                                                    // Step 5.
                                                                                    onChanged: (int? newValue) {
                                                                                      setState(() {
                                                                                        _pmtrans[index].paymentmode = newValue!;
                                                                                      });
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 50,
                                                                                ),
                                                                                Expanded(
                                                                                  child: TextFormField(
                                                                                    keyboardType: TextInputType.numberWithOptions(signed: true),
                                                                                    controller: _controllers[index],
                                                                                    onChanged: (value) {
                                                                                      if (value.isNotEmpty) {
                                                                                        _pmtrans[index].credit = int.parse(value);
                                                                                      } else {
                                                                                        _pmtrans[index].credit = 0;
                                                                                      }
                                                                                      // print("hello ${_pmtrans[0].toJson().toString()} ${_pmtrans[1].toJson().toString()}");
                                                                                    },
                                                                                    validator: (String? msg) {
                                                                                      if (msg == null || msg.isEmpty) {
                                                                                        return "Please Enter Amount !!";
                                                                                      }

                                                                                      return null;
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                                InkWell(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        _pmtrans.removeAt(index);
                                                                                        _controllers.removeAt(index);
                                                                                      });
                                                                                    },
                                                                                    child: Icon(
                                                                                      Icons.delete,
                                                                                      color: Colors.red,
                                                                                    ))
                                                                              ]),
                                                                              SizedBox(
                                                                                height: 10,
                                                                              )
                                                                            ]);
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,

                                                                    // crossAxisAlignment: cro,
                                                                    children: [
                                                                      ElevatedButton(
                                                                          onPressed:
                                                                              () {
                                                                            setState(() {
                                                                              _pmtrans.add(PaymentmodeModel(paymentmode: 1, credit: 0, debit: 0));
                                                                              _controllers.add(TextEditingController());
                                                                            });
                                                                          },
                                                                          child:
                                                                              Text("Add")),
                                                                      SizedBox(
                                                                        width:
                                                                            20,
                                                                      ),
                                                                      ElevatedButton(
                                                                          onPressed:
                                                                              () {
                                                                            setState(() {
                                                                              _paymentmode = 1;
                                                                              _pmtrans = [];
                                                                            });
                                                                          },
                                                                          child:
                                                                              Text("Single")),
                                                                    ],
                                                                  )
                                                                ]),
                                                          ),
                                                        );
                                              }
                                            },
                                          )),
                                      ElevatedButton(
                                          onPressed: () {
                                            if (_myFormKey.currentState!
                                                .validate()) {
                                              if (_user.collector == null) {
                                                Utils.showToast(
                                                    "Please Login again and Make entry..!!",
                                                    "error",
                                                    context);
                                                return;
                                              }
                                              if (_paymentmode == 50) {
                                                if (_pmtrans.length >= 2) {
                                                  int ttl = 0;
                                                  _pmtrans.forEach((e) {
                                                    if (int.tryParse(e.credit
                                                                .toString()) !=
                                                            null &&
                                                        int.tryParse(e.credit
                                                                .toString())! >
                                                            0) {
                                                      ttl += int.parse(
                                                          e.credit.toString());
                                                    } else {
                                                      Utils.flushBarErrorMessage(
                                                          "Multi payment amounts not entered properly...!!",
                                                          context);
                                                      return;
                                                    }
                                                  });
                                                  if (_amount.text.isNotEmpty &&
                                                      ttl !=
                                                          int.tryParse(
                                                              _amount.text)) {
                                                    Utils.flushBarErrorMessage(
                                                        "Amount and Multi payment amounts doesn't match",
                                                        context);
                                                    return;
                                                  }
                                                } else {
                                                  Utils.flushBarErrorMessage(
                                                      "Minimum Two paymentmodes to be selected !!",
                                                      context);
                                                  return;
                                                }
                                              }
                                              createReceived(
                                                  value.collection.data!);
                                            }
                                          },
                                          child: const Text("Submit")),
                                      Builder(builder: (_) {
                                        if (_isLoading) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        } else {
                                          return Container();
                                        }
                                      })
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ]),
              // );
            );
        }
      }),
    );
  }
}
