import 'package:chanda_finance/model/collectionReportModel.dart';
import 'package:chanda_finance/res/color.dart';
import 'package:chanda_finance/view_model/collectionReport_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';
import '../model/user_model.dart';
import '../res/components/tableWidget.dart';
import '../res/components/widget/scrollable_widget.dart';
import '../utils/routes_name.dart';
import '../utils/utils.dart';
import '../view_model/user_view_model.dart';

class CollectionReportView extends StatefulWidget {
  const CollectionReportView({super.key});

  @override
  State<CollectionReportView> createState() => _CollectionReportViewState();
}

class _CollectionReportViewState extends State<CollectionReportView> {
  final _dateController = TextEditingController();
  CollectionReportViewModel collectionReportViewModel =
      CollectionReportViewModel();
  bool isPressed = false;
  Future<UserModel> getUserData() => UserViewModel().getUser();
  UserModel _user = UserModel();
  int _collTtl = 0;
  int _rcvdTtl = 0;
  int _onlineTtl = 0;
  int _allTtl = 0;

  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  void getCollectionReport() {
    isPressed = true;
    _collTtl = 0;
    _onlineTtl = 0;
    _allTtl = 0;
    _rcvdTtl = 0;
    if (_dateController.text.contains(' ')) {
      _dateController.text = (_dateController.text.split(' '))[0];
      _dateController.text = Utils.userFormat(_dateController.text);
    }
    collectionReportViewModel.fetchCollectionReport({
      "date": Utils.sqlFormat(_dateController.text),
      "collector": _user.collector
    }, context);
  }

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    getUserData().then((value) async {
      _user = value;
      getCollectionReport();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text("Collection Report"),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, RoutesName.createCollectorAmount),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
                // border: Border.all(
                //   color: Colors.black,
                //   width: 2,
                // ),
              ),
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  SizedBox(
                      width: 8), // Add some space between the icon and text
                  Text(
                    'Add',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(children: [
                Expanded(
                  child: TextFormField(
                    validator: (String? msg) {
                      if (msg == null || msg.isEmpty) {
                        return "Please Enter Date !!";
                      }

                      return null;
                    },
                    controller: _dateController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Select Date',
                      icon: Icon(Icons.calendar_today), //icon of text field
                    ),
                    readOnly: true,
                    //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime initDate = (_dateController.text.isEmpty)
                          ? DateTime.now()
                          : Utils.convertUserToDateTime(_dateController.text);
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: initDate, //Add this in your Code.
                          // initialEntryMode: DatePickerEntryMode.input,
                          firstDate: DateTime(1950),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2100));

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('dd/MM/yyyy').format(pickedDate);

                        setState(() {
                          _dateController.text =
                              formattedDate; //set output date to TextField value.
                          getCollectionReport();
                        });
                      } else {
                        setState(() {
                          _dateController.text =
                              DateFormat('dd/MM/yyyy').format(DateTime.now());
                          getCollectionReport();
                          // _dateController.text = DateTime.now().toString();
                        });
                      }
                    },
                  ),
                ),
                SizedBox(width: 5),
                SizedBox(
                  width: 50,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(20)),
                          textStyle: MaterialStateProperty.all(const TextStyle(
                              fontSize: 14, color: Colors.black))),
                      onPressed: () {
                        setState(() {
                          _dateController.text = _dateController.text =
                              DateFormat('dd/MM/yyyy').format(DateTime.now());
                        });
                        getCollectionReport();
                      },
                      child: const Text('0')),
                ),
                SizedBox(width: 5),
                SizedBox(
                  width: 50,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(20)),
                          textStyle: MaterialStateProperty.all(const TextStyle(
                              fontSize: 14, color: Colors.black))),
                      onPressed: () {
                        // Get yesterday's date
                        DateTime yesterday =
                            DateTime.now().subtract(Duration(days: 1));
                        // Format the date as string
                        String formattedDate =
                            DateFormat('dd/MM/yyyy').format(yesterday);
                        // Set the formatted date as the initial value of the text field
                        setState(() {
                          _dateController.text = formattedDate;
                        });

                        getCollectionReport();
                      },
                      child: const Text('1')),
                ),
                SizedBox(width: 5),
                SizedBox(
                  width: 50,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(20)),
                          textStyle: MaterialStateProperty.all(const TextStyle(
                              fontSize: 14, color: Colors.black))),
                      onPressed: () {
                        // Get yesterday's date
                        DateTime yesterday =
                            DateTime.now().subtract(Duration(days: 2));
                        // Format the date as string
                        String formattedDate =
                            DateFormat('dd/MM/yyyy').format(yesterday);
                        // Set the formatted date as the initial value of the text field
                        setState(() {
                          _dateController.text = formattedDate;
                        });

                        getCollectionReport();
                      },
                      child: const Text('2')),
                ),
                SizedBox(width: 5),
                SizedBox(
                  width: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(20)),
                        textStyle: MaterialStateProperty.all(const TextStyle(
                            fontSize: 14, color: Colors.black))),
                    onPressed: () {
                      // Get yesterday's date
                      DateTime yesterday =
                          DateTime.now().subtract(Duration(days: 3));
                      // Format the date as string
                      String formattedDate =
                          DateFormat('dd/MM/yyyy').format(yesterday);
                      // Set the formatted date as the initial value of the text field
                      setState(() {
                        _dateController.text = formattedDate;
                      });

                      getCollectionReport();
                    },
                    child: const Text("3"),
                  ),
                ),
              ]),

              Container(
                child: ChangeNotifierProvider<CollectionReportViewModel>(
                  create: (BuildContext context) => collectionReportViewModel,
                  child: Consumer<CollectionReportViewModel>(
                    builder: (context, value, _) {
                      if (_dateController.text.isNotEmpty && isPressed) {
                        switch (value.collectionReport.status!) {
                          case Status.LOADING:
                            return SizedBox(
                                width: width * 0.95,
                                height: height * 0.5,
                                child: Center(
                                    child: const CircularProgressIndicator()));

                          case Status.ERROR:
                            return Container(
                                child: Text(
                                    value.collectionReport.message.toString()));

                          case Status.COMPLETED:
                            final List<CollectionList> collectionList = value
                                .collectionReport
                                .data!
                                .collectionreport!
                                .collectionList!;
                            final List<CollectionRcvd> collectionRcvd = value
                                .collectionReport
                                .data!
                                .collectionreport!
                                .collectionRcvd!;
                            final List<CollectionList> onlineCollection = value
                                .collectionReport
                                .data!
                                .collectionreport!
                                .onlinecollection!;
                            List<dynamic> CollrawData = [];
                            if (collectionList.isNotEmpty) {
                              _collTtl = 0;
                              for (var e in collectionList) {
                                _collTtl += int.parse(e.amount.toString());
                                Map tmp = {
                                  "id": e.id,
                                  "date": e.date,
                                  "amount": e.amount,
                                  "chiti": e.chiti,
                                  "customername": (e.type == "collection")
                                      ? "${e.customername} (${e.chiti}) "
                                      : e.customername.toString(),
                                  "note": e.note,
                                  "paymentmode": e.paymentmode,
                                  "paymentmodename": e.paymentmodename,
                                  "ontapRoute": (e.type == "collection")
                                      ? RoutesName.chiti
                                      : RoutesName.editCashEntry,
                                  "ontapArg":
                                      (e.type == "collection") ? e.chiti : e.id
                                };
                                CollrawData.add(tmp);
                                // }
                              }
                              Map tmp = {
                                "id": "Total",
                                "date": "",
                                "amount": _collTtl,
                                "chiti": "",
                                "customername": "Total",
                                "note": "",
                                "paymentmode": "",
                                "paymentmodename": "",
                              };
                              CollrawData.add(tmp);
                            }

                            List<dynamic> onlineRawData = [];
                            if (onlineCollection.isNotEmpty) {
                              _onlineTtl = 0;
                              _allTtl = 0;
                              for (var e in onlineCollection) {
                                _onlineTtl += int.parse(e.amount.toString());

                                Map tmp = {
                                  "id": e.id,
                                  "date": e.date,
                                  "amount": e.amount,
                                  "chiti": e.chiti,
                                  "customername":
                                      "${e.customername} (${e.chiti}) ",
                                  "note": e.note,
                                  "paymentmode": e.paymentmode,
                                  "paymentmodename": e.paymentmodename,
                                  "ontapRoute": RoutesName.chiti,
                                  "ontapArg": e.chiti
                                };
                                onlineRawData.add(tmp);
                                // }
                              }
                              Map tmp = {
                                "id": "Total",
                                "date": "",
                                "amount": _onlineTtl,
                                "chiti": "",
                                "customername": "",
                                "note": "",
                                "paymentmode": "",
                                "paymentmodename": "",
                              };
                              onlineRawData.add(tmp);
                              _allTtl = _collTtl + _onlineTtl;
                            }

                            List<dynamic> RcvdrawData = [];
                            if (collectionRcvd.isNotEmpty) {
                              _rcvdTtl = 0;
                              for (var e in collectionRcvd) {
                                _rcvdTtl += int.parse(e.amount.toString());
                                Map tmp = {
                                  "id": e.id,
                                  "date": e.date,
                                  "amount": e.amount,
                                  "note": e.note,
                                };
                                RcvdrawData.add(tmp);
                                // }
                              }
                              Map tmp = {
                                "date": "Total",
                                "amount": _rcvdTtl,
                                "chiti": "",
                                "customername": "",
                                "note": "",
                                "paymentmode": "",
                                "paymentmodename": "",
                              };
                              RcvdrawData.add(tmp);
                            }

                            return Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                (_allTtl > 0)
                                    ? Container(
                                        width: width,
                                        color: AppColors.ThemeBlue,
                                        child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: "Today Total $_allTtl ",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            TextSpan(
                                              text: "         ",
                                            ),
                                            TextSpan(
                                              text: "Online Total $_onlineTtl ",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ]),
                                        ))
                                    : Container(),
                                (_collTtl > 0)
                                    ? Container(
                                        width: width,
                                        color: (_collTtl - _rcvdTtl == 0)
                                            ? Colors.green
                                            : Colors.red,
                                        child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text:
                                                  "   Collection Total $_collTtl",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            TextSpan(
                                              text: "                      ",
                                            ),
                                            ((_collTtl - _rcvdTtl) == 0)
                                                ? TextSpan(
                                                    text:
                                                        "Total Collection Paid",
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  )
                                                : ((_collTtl - _rcvdTtl) > 0)
                                                    ? TextSpan(
                                                        text:
                                                            "Collection Paid $_rcvdTtl \n                    Pending Collection ${_collTtl - _rcvdTtl}",
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      )
                                                    : TextSpan(
                                                        text:
                                                            "Collections Paid ",
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      )
                                          ]),
                                        ))
                                    : Container(),
                                SizedBox(
                                  height: 10,
                                ),
                                (collectionList.isNotEmpty)
                                    ? SizedBox(
                                        height: height * 0.5,
                                        child: ScrollableWidget(
                                          child: TableWidget(
                                            columns: [
                                              'SNO',
                                              'Customer',
                                              'Amount',
                                              'Note',
                                              'Paymentmode',
                                            ],
                                            rowData: CollrawData,
                                            rows: [
                                              'sno',
                                              'customername',
                                              'amount',
                                              'note',
                                              'paymentmodename',
                                            ],
                                            tableCons: {
                                              "total": true,
                                              "ontap": "dynamic",
                                            },
                                          ),
                                        ),

                                        // Row(children: [
                                        // ]),
                                      )
                                    : Container(),
                                (onlineCollection.isNotEmpty)
                                    ? SizedBox(
                                        height: height * 0.5,
                                        child: ScrollableWidget(
                                          child: TableWidget(
                                            columns: [
                                              'SNO',
                                              'Customer',
                                              'Amount',
                                              'Note',
                                              'Paymentmode',
                                            ],
                                            rowData: onlineRawData,
                                            rows: [
                                              'sno',
                                              'customername',
                                              'amount',
                                              'note',
                                              'paymentmodename',
                                            ],
                                            tableCons: {
                                              "total": true,
                                              "contextMenu": [
                                                {
                                                  "value": "editcollreport",
                                                  "child": "Edit"
                                                },
                                                {
                                                  "value": "deletecollReport",
                                                  "child": "Delete"
                                                },
                                              ]
                                            },
                                          ),
                                        ),

                                        // Row(children: [
                                        // ]),
                                      )
                                    : Container(),
                                (collectionRcvd.isNotEmpty)
                                    ? SizedBox(
                                        height: height * 0.2,
                                        child: ScrollableWidget(
                                          child: TableWidget(
                                            columns: [
                                              'SNO',
                                              'Date',
                                              'Amount',
                                              'Note',
                                            ],
                                            rowData: RcvdrawData,
                                            rows: [
                                              'sno',
                                              'date',
                                              'amount',
                                              'note',
                                            ],
                                            tableCons: {
                                              "total": true,
                                              "contextMenu": [
                                                {
                                                  "value": "editcollreport",
                                                  "child": "Edit"
                                                },
                                                {
                                                  "value": "deletecollReport",
                                                  "child": "Delete"
                                                },
                                              ]
                                            },
                                          ),
                                        ),

                                        // Row(children: [
                                        // ]),
                                      )
                                    : Container(),
                              ],
                            );
                          //   ),
                          // );
                        }
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ),

              // ),
            ],
          ),
        ),
      ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   heroTag: 'float',
      //   child: Icon(Icons.add),
      //   onPressed: () =>
      //       Navigator.pushNamed(context, RoutesName.createCollectorAmount),
      //   backgroundColor: AppColors.ThemeBlue,
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
    );
  }
}
