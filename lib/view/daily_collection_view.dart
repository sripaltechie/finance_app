import 'dart:convert';

import 'package:chanda_finance/data/response/api_response.dart';
import 'package:chanda_finance/model/latest_notes.dart';
import 'package:chanda_finance/model/paymentmodeModel.dart';
import 'package:chanda_finance/res/components/tableWidget.dart';
import 'package:chanda_finance/res/globals.dart';
import 'package:chanda_finance/utils/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../data/response/status.dart';
import '../model/user_model.dart';
import '../repository/asalu_repository.dart';
import '../utils/showAlertDialog.dart';
import '../utils/utils.dart';
import '../view_model/latest_notes_view_model.dart';
import '../view_model/paymentmodeslist_view_model.dart';
import '../view_model/user_view_model.dart';
import 'navbar_view.dart';

class DailyCollection extends StatefulWidget {
  final int chitiId;
  const DailyCollection({Key? key, required this.chitiId}) : super(key: key);
  @override
  State<DailyCollection> createState() => _DailyCollectionState();
}

class _DailyCollectionState extends State<DailyCollection> {
  int _paymentmode = 1;
  List<PaymentmodeModel> _pmtrans = [];
  late List<TextEditingController> _controllers;
  final _myFormKey = GlobalKey<FormState>();
  final _chitiId = TextEditingController();
  final _dateInput = TextEditingController();
  final _amount = TextEditingController();
  final _note = TextEditingController();
  final customername = "";
  FocusNode chitiFocusNode = FocusNode();
  FocusNode amountFocusNode = FocusNode();
  FocusNode noteFocusNode = FocusNode();
  bool isCollected = false;
  Future<UserModel> getUserData() => UserViewModel().getUser();
  UserModel _user = UserModel();
  Chiti _chiti = Chiti();
  LatestNotesViewModel latestNotesViewModel = LatestNotesViewModel();
  PaymentmodesListViewModel paymentmodesListViewModel =
      PaymentmodesListViewModel();

  void getChitiData(value) {
    // setState(() {
    _chiti = Chiti();
    latestNotesViewModel.fetchLatestNotesListApi(_chitiId.text, context);
    // ScrollViewKeyboardDismissBehavior;
    FocusManager.instance.primaryFocus?.unfocus();
    if (value == 1) {
      setState(() {
        _chitiId.text = "";
        _dateInput.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
        _amount.text = "";
        _note.text = "";
        _pmtrans = [];
        _controllers = [];
      });
    } else {
      isCollected = false;
    }
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentmodesListViewModel.fetchPaymentmodesListApi(null);
    getUserData().then((value) async {
      _user = value;
    });
    // amountFocusNode.addListener(() {
    //   if (!amountFocusNode.hasFocus && _amount.text.isNotEmpty) {
    //     if (int.parse(_amount.text) >= _chiti.perday!) {
    //       getNotes(_amount.text);
    //     } else {
    //       String msg = "Per Day for ${_chiti.customername} is ${_chiti.perday}";
    //       Utils.showToast(msg, "info", context);
    //     }
    //   }
    // });

    _dateInput.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    // paymentmodeList = await DbLists().getpaymentmodeList() as Paymentmode;
    if (widget.chitiId > 0) {
      _chitiId.text = widget.chitiId.toString();
      latestNotesViewModel.fetchLatestNotesListApi(_chitiId.text, context);
      // getTextFieldValue();
    }
    chitiFocusNode.requestFocus();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    isDisposed = true;

    super.dispose();

    _amount.dispose();
    _dateInput.dispose();
    _chitiId.dispose();
    _note.dispose();
    chitiFocusNode.dispose();
    amountFocusNode.dispose();
    noteFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   toast = new ToastNotification(ftoast.init(context));
    // });
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Daily Collection"),
          actions: [
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text('Profile'),
                    value: 'profile',
                  ),
                  PopupMenuItem(
                    child: Text('Logout'),
                    value: 'logout',
                  ),
                ];
              },
              onSelected: (value) {
                if (value == 'logout') {
                  Provider.of<UserViewModel>(context, listen: false).remove();
                  Navigator.of(context).pushReplacementNamed(
                    RoutesName.login,
                    // arguments: 'Hello there from the first page!',
                  );
                }
              },
              child: Row(
                children: <Widget>[
                  Icon(Icons.person),
                  SizedBox(width: 5.0),
                  Text(
                    _user.firstname.toString(),
                  ),
                  // DropdownButton<String>(
                  //   items: [
                  //     DropdownMenuItem<String>(
                  //       value: 'logout',
                  //       child: Text('Logout'),
                  //     ),
                  //   ],
                  //   onChanged: (String? value) {
                  //     if (value == 'logout') {
                  //       // Handle logout action
                  //     }
                  //   },
                  // ),

                  SizedBox(width: 15.0),
                ],
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: SizedBox(
                width: width * 0.9,
                child: Column(
                  children: [
                    Form(
                      key: _myFormKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              validator: (String? msg) {
                                if (msg == null || msg.isEmpty) {
                                  return "Please Enter Date !!";
                                }

                                return null;
                              },
                              controller: _dateInput,
                              //editing controller of this TextField
                              decoration: const InputDecoration(
                                  icon: Icon(Icons
                                      .calendar_today), //icon of text field
                                  labelText: "Enter Date" //label text of field
                                  ),
                              readOnly: true,
                              //set it true, so that user will not able to edit text
                              onTap: () async {
                                DateTime initDate = (_dateInput.text.isEmpty)
                                    ? DateTime.now()
                                    : Utils.convertUserToDateTime(
                                        _dateInput.text);
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate:
                                        initDate, //Add this in your Code.
                                    // initialEntryMode: DatePickerEntryMode.input,
                                    firstDate: DateTime(1950),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2100));

                                if (pickedDate != null) {
                                  // print(
                                  //     pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate =
                                      DateFormat('dd/MM/yyyy')
                                          .format(pickedDate);
                                  // print(
                                  //     formattedDate); //formatted date output using intl package =>  2021-03-16
                                  setState(() {
                                    _dateInput.text =
                                        formattedDate; //set output date to TextField value.
                                    chitiFocusNode.requestFocus();
                                  });
                                } else {
                                  // var now = new DateTime.now();
                                  // var formattedDate =
                                  //     new DateFormat('dd-MM-yyyy');
                                  // print(formattedDate);
                                  setState(() {
                                    _dateInput.text = DateTime.now().toString();
                                  });
                                }
                              },
                            ),
                            TextFormField(
                              style: const TextStyle(color: Colors.black),
                              controller: _chitiId,
                              focusNode: chitiFocusNode,
                              onChanged: (value) {
                                if (value.length == 3) {
                                  getChitiData(0);
                                }
                              },
                              keyboardType: TextInputType.number,
                              validator: (String? msg) {
                                if (msg == null || msg.isEmpty) {
                                  return "Please Enter Chiti ID !!";
                                }
                                return null;
                              },
                              onFieldSubmitted: (_) {
                                Utils.fieldFocusChange(
                                    context, chitiFocusNode, amountFocusNode);
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Chiti ID",
                                hintStyle: const TextStyle(color: Colors.black),
                                helperText: "Chiti ID",
                                helperStyle: const TextStyle(fontSize: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                suffixIcon: Container(
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.green),
                                          padding: MaterialStateProperty.all(
                                              const EdgeInsets.all(20)),
                                          textStyle: MaterialStateProperty.all(
                                              const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black))),
                                      onPressed: () {
                                        getChitiData(0);
                                      },
                                      child: const Text('Ok')),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (String? msg) {
                                if (msg == null || msg.isEmpty) {
                                  return "Please Enter Amount !!";
                                }
                                return null;
                              },
                              style: TextStyle(color: Colors.black),
                              controller: _amount,
                              focusNode: amountFocusNode,
                              onChanged: (value) {
                                if (int.parse(value.toString()) > 0) {
                                  getNotes(value);
                                }
                              },
                              onFieldSubmitted: (value) {
                                Utils.fieldFocusChange(
                                    context, amountFocusNode, noteFocusNode);
                              },
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "Amount",
                                  hintStyle:
                                      const TextStyle(color: Colors.black),
                                  helperText: "Amount",
                                  helperStyle: const TextStyle(fontSize: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ChangeNotifierProvider<LatestNotesViewModel>.value(
                              value: latestNotesViewModel,
                              // create: (BuildContext context) =>
                              //     latestNotesViewModel,
                              child: Consumer<LatestNotesViewModel>(
                                  builder: (context, value, _) {
                                if (value.latestNotes.status ==
                                    Status.COMPLETED) {
                                  return Row(children: [
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0),
                                        child: Container(
                                            child: FloatingActionButton(
                                          backgroundColor: Colors.lightBlue,
                                          heroTag: "btn1",
                                          shape: const RoundedRectangleBorder(),
                                          child: const Text(
                                            "1",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          onPressed: () {
                                            _amount.text =
                                                _chiti.perday.toString();
                                            // _note.text =
                                            //     "${_chiti.notes!.floor()}";
                                            getNotes(_amount.text);
                                          },
                                        ))),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0),
                                        child: FloatingActionButton(
                                          backgroundColor: Colors.lightBlue,
                                          heroTag: "btn2",
                                          shape: const RoundedRectangleBorder(),
                                          child: const Text(
                                            "2",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          onPressed: () {
                                            _amount.text =
                                                (_chiti.perday! * 2).toString();
                                            // _note.text =
                                            //     "${_chiti.notes!.floor()},${(_chiti.notes! + 1).floor()}";
                                            getNotes(_amount.text);
                                          },
                                        )),
                                    Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 0),
                                        child: Container(
                                            child: FloatingActionButton(
                                          backgroundColor: Colors.lightBlue,
                                          heroTag: "btn3",
                                          shape: RoundedRectangleBorder(),
                                          child: const Text(
                                            "3",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          onPressed: () {
                                            _amount.text =
                                                (_chiti.perday! * 3).toString();
                                            // _note.text =
                                            //     "${_chiti.notes!.floor()}-${(_chiti.notes! + 2).floor()}";
                                            getNotes(_amount.text);
                                          },
                                        ))),
                                    Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 0),
                                        child: Container(
                                            child: FloatingActionButton(
                                          backgroundColor: Colors.lightBlue,
                                          heroTag: "btn4",
                                          shape: RoundedRectangleBorder(),
                                          child: const Text(
                                            "4",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          onPressed: () {
                                            _amount.text =
                                                (_chiti.perday! * 4).toString();
                                            // _note.text =
                                            //     "${_chiti.notes!.floor()}-${(_chiti.notes! + 3).floor()}";
                                            getNotes(_amount.text);
                                          },
                                        ))),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      child: Container(
                                        child: FloatingActionButton(
                                          backgroundColor: Colors.lightBlue,
                                          heroTag: "btn5",
                                          shape: const RoundedRectangleBorder(),
                                          child: const Text(
                                            "5",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          onPressed: () {
                                            _amount.text =
                                                (_chiti.perday! * 5).toString();
                                            // _note.text =
                                            //     "${_chiti.notes!.floor()}-${(_chiti.notes! + 4).floor()}";
                                            getNotes(_amount.text);
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      child: Container(
                                        child: FloatingActionButton(
                                          backgroundColor: Colors.lightBlue,
                                          heroTag: "btn6",
                                          shape: const RoundedRectangleBorder(),
                                          child: const Text(
                                            "10",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          onPressed: () {
                                            _amount.text = (_chiti.perday! * 10)
                                                .toString();
                                            // _note.text =
                                            //     "${_chiti.notes!.floor()}-${(_chiti.notes! + 9).floor()}";
                                            getNotes(_amount.text);
                                          },
                                        ),
                                      ),
                                    ),
                                  ]);
                                } else {
                                  return Container();
                                }
                              }),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              validator: (String? msg) {
                                if (msg == null || msg.isEmpty) {
                                  return "Please Enter Notes !!";
                                }
                                return null;
                              },
                              style: const TextStyle(color: Colors.black),
                              controller: _note,
                              focusNode: noteFocusNode,
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "Note",
                                  hintStyle:
                                      const TextStyle(color: Colors.black),
                                  helperText: "Note",
                                  helperStyle: const TextStyle(fontSize: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ChangeNotifierProvider<PaymentmodesListViewModel>(
                                create: (BuildContext context) =>
                                    paymentmodesListViewModel,
                                child: Consumer<PaymentmodesListViewModel>(
                                  builder: (context, pmvalue, _) {
                                    switch (pmvalue.PaymentmodesList.status!) {
                                      case Status.LOADING:
                                        // TODO: Handle this case.
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      case Status.ERROR:
                                        // TODO: Handle this case.
                                        return Center(
                                            child: Text(pmvalue
                                                .PaymentmodesList.message
                                                .toString()));
                                      case Status.COMPLETED:
                                        return (_paymentmode != 50)
                                            ? Row(children: [
                                                Expanded(
                                                  child: DropdownButton<int>(
                                                    isExpanded: true,
                                                    value: _paymentmode,
                                                    items: pmvalue
                                                        .PaymentmodesList.data!
                                                        .map<
                                                            DropdownMenuItem<
                                                                int>>((value) {
                                                      return DropdownMenuItem<
                                                          int>(
                                                        value: int.parse(value
                                                            .id
                                                            .toString()),
                                                        child: Text(
                                                          value.modename
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 15),
                                                        ),
                                                      );
                                                    }).toList(),
                                                    // Step 5.
                                                    onChanged: (int? newValue) {
                                                      setState(() {
                                                        _paymentmode =
                                                            newValue!;
                                                        if (_paymentmode ==
                                                            50) {
                                                          _pmtrans = [
                                                            PaymentmodeModel(
                                                                paymentmode: 1,
                                                                credit: 0,
                                                                debit: 0),
                                                            PaymentmodeModel(
                                                                paymentmode: 1,
                                                                credit: 0,
                                                                debit: 0),
                                                          ];
                                                          _controllers =
                                                              List.generate(
                                                            _pmtrans.length,
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
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  child: Column(children: [
                                                    SizedBox(
                                                      width: width,
                                                      height: height * 0.2,
                                                      child: ListView.builder(
                                                        itemCount: _pmtrans
                                                            .length, // number of items in your data list
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return Column(
                                                              children: [
                                                                Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Expanded(
                                                                        child: DropdownButton<
                                                                            int>(
                                                                          isExpanded:
                                                                              true,
                                                                          value:
                                                                              _pmtrans[index].paymentmode,
                                                                          items: pmvalue
                                                                              .PaymentmodesList
                                                                              .data!
                                                                              .map<DropdownMenuItem<int>>((value) {
                                                                            return DropdownMenuItem<int>(
                                                                              value: int.parse(value.id.toString()),
                                                                              child: Text(
                                                                                value.modename.toString(),
                                                                                style: const TextStyle(fontSize: 15),
                                                                              ),
                                                                            );
                                                                          }).toList(),
                                                                          // Step 5.
                                                                          onChanged:
                                                                              (int? newValue) {
                                                                            setState(() {
                                                                              _pmtrans[index].paymentmode = newValue!;
                                                                            });
                                                                          },
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            50,
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            TextFormField(
                                                                          keyboardType:
                                                                              TextInputType.numberWithOptions(signed: true),
                                                                          controller:
                                                                              _controllers[index],
                                                                          onChanged:
                                                                              (value) {
                                                                            if (value.isNotEmpty) {
                                                                              _pmtrans[index].credit = int.parse(value);
                                                                            } else {
                                                                              _pmtrans[index].credit = 0;
                                                                            }
                                                                            // print("hello ${_pmtrans[0].toJson().toString()} ${_pmtrans[1].toJson().toString()}");
                                                                          },
                                                                          validator:
                                                                              (String? msg) {
                                                                            if (msg == null ||
                                                                                msg.isEmpty) {
                                                                              return "Please Enter Amount !!";
                                                                            }

                                                                            return null;
                                                                          },
                                                                        ),
                                                                      ),
                                                                      InkWell(
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              _pmtrans.removeAt(index);
                                                                              _controllers.removeAt(index);
                                                                            });
                                                                          },
                                                                          child:
                                                                              Icon(
                                                                            Icons.delete,
                                                                            color:
                                                                                Colors.red,
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
                                                            onPressed: () {
                                                              setState(() {
                                                                _pmtrans.add(
                                                                    PaymentmodeModel(
                                                                        paymentmode:
                                                                            1,
                                                                        credit:
                                                                            0,
                                                                        debit:
                                                                            0));
                                                                _controllers.add(
                                                                    TextEditingController());
                                                              });
                                                            },
                                                            child: Text("Add")),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        ElevatedButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                _paymentmode =
                                                                    1;
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
                            ChangeNotifierProvider<LatestNotesViewModel>(
                              create: (BuildContext context) =>
                                  latestNotesViewModel,
                              child: Consumer<LatestNotesViewModel>(
                                  builder: (context, value, _) {
                                switch (value.latestNotes.status!) {
                                  case Status.LOADING:
                                    // TODO: Handle this case.
                                    return (_chitiId.text.isNotEmpty)
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : Container();
                                  case Status.ERROR:
                                    // TODO: Handle this case.
                                    return Center(
                                        child: Text(value.latestNotes.message
                                            .toString()));
                                  case Status.COMPLETED:
                                    // TODO: Handle this case.
                                    (value.ischitiCalled && !isCollected)
                                        ? Future.delayed(Duration.zero, () {
                                            _amount.text =
                                                _chiti.regularamt.toString();
                                            _paymentmode = int.parse(value
                                                .latestNotes
                                                .data!
                                                .chiti!
                                                .regularpmmode!
                                                .toString());
                                            getNotes(_amount.text);
                                            value.setIschitiCalled(false);
                                            if (value.latestNotes.data!.chiti!
                                                    .status ==
                                                2) {
                                              showAlertDialogbox(
                                                  context,
                                                  "Chiti is Cleared..!! \n Ask your boss Sripal Jain before adding entry",
                                                  "Chiti Cleared..!!");
                                            } else if (value.latestNotes.data!
                                                    .chiti!.remainingdays! <
                                                0) {
                                              Utils.showToast(
                                                  "100 Days Completed !!! \n Kindly ask your boss Before adding Entry",
                                                  "error",
                                                  context);
                                            }
                                          })
                                        : null;
                                    List<String> columns = [
                                      "Days",
                                      "Date",
                                      "Amount",
                                      "Notes",
                                      "Paymentmode"
                                    ];
                                    List rows = [
                                      "days",
                                      "date",
                                      "amount",
                                      "note",
                                      "paymentmode"
                                    ];
                                    List<dynamic> rawData = [];
                                    for (var e in value
                                        .latestNotes.data!.chiti!.lasttrans!) {
                                      Map tmp = {
                                        "id": e.id,
                                        "chiti": e.chiti,
                                        "days": e.days,
                                        "date": e.date,
                                        "amount": e.amount,
                                        "note": e.note,
                                        "paymentmode": e.paymentmode,
                                        "paymentmodename": e.paymentmodename,
                                        "backPage": RoutesName.dailycollection
                                      };
                                      rawData.add(tmp);
                                      // }
                                    }

                                    // Map rowColor =

                                    Map tableCons = {
                                      "columnSpacing": 20,
                                      "bgcolor": const Color.fromARGB(
                                          255, 3, 121, 157),
                                      "rowColor": Utils.getDaysRowColorList(),
                                      "contextmenupage": "dailydart",
                                      "contextMenu": [
                                        {"value": "editasalu", "child": "Edit"},
                                        {
                                          "value": "deleteasalu",
                                          "child": "Delete"
                                        }
                                      ],
                                    };

                                    _chiti = value.latestNotes.data!.chiti!;

                                    if (_chiti.lasttrans!.isNotEmpty) {
                                      int days = Utils.daysBetween(
                                          Utils.converttoDateTime(
                                              _chiti.lasttrans![0].date!),
                                          DateTime.now());
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(children: [
                                          Center(
                                            child: GestureDetector(
                                              // get tap location
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context, RoutesName.chiti,
                                                    arguments: [_chiti.id!]);
                                              },
                                              child: Text(
                                                _chiti.customername.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            color:
                                                Utils.setColorOnRemainingAsalu(
                                                    _chiti.remainingasalu!,
                                                    _chiti.remainingdays!,
                                                    _chiti.perday!),
                                            height: 40,
                                            child: Center(
                                              child: Text(
                                                  "Remaining Asalu : ${_chiti.remainingasalu}      Remaining Interest : ${_chiti.remainingint}\n  Remaining Days: ${_chiti.remainingdays}"),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            color: Utils.setDailyColor(days),
                                            height: 20,
                                            child: Center(
                                                child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        "Last Payment Paid Before $days Days ",
                                                  ),
                                                  const WidgetSpan(
                                                      child: Tooltip(
                                                    message: 'My Account',
                                                    child: Icon(
                                                      Icons.info,
                                                      size: 20,
                                                    ),
                                                  )),
                                                ],
                                              ),
                                            )
                                                //  Text("Last Payment Piad Before ${days} Days "),
                                                ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: TableWidget(
                                                columns: columns,
                                                rows: rows,
                                                rowData: rawData,
                                                tableCons: tableCons),
                                          ),
                                        ]),
                                      );
                                    } else {
                                      return Column(children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Center(
                                            child: GestureDetector(
                                                // get tap location
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context, RoutesName.chiti,
                                                      arguments: [_chiti.id!]);
                                                },
                                                child: Text(
                                                  "No Asalu found for Chiti ${_chiti.customername}(${_chiti.id})",
                                                  style: const TextStyle(
                                                      fontSize: 20),
                                                )),
                                          ),
                                        ),
                                      ]);
                                    }
                                }
                              }
                                  // return TableWidget(columns: columns, rows: rows, rowData: rowData, tableCons: tableCons)
                                  // ),],
                                  //   )
                                  // TextFormField(
                                  //   controller: _dateInput,
                                  //   keyboardType: TextInputType.emailAddress,
                                  //   focusNode: amountFocusNode,
                                  //   decoration: const InputDecoration(
                                  //       hintText: 'Email',
                                  //       labelText: 'Email',
                                  //       prefixIcon: Icon(Icons.email)),
                                  //   onFieldSubmitted: (value) {
                                  //     // Utils.fieldFocusChange(
                                  //     //     context, emailFocusNode, passwordFocusNode);
                                  //   },
                                  // ),
                                  ),
                            ),
                          ]),
                    ),
                  ],
                ),
              )),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.lightBlue,
            child: const Icon(Icons.done),
            onPressed: () {
              if (_myFormKey.currentState!.validate()) {
                if (_user.collector == null) {
                  Utils.showToast("Please Login again and Make entry..!!",
                      "error", context);
                  return;
                }
                if (_chiti.remainingasalu! <
                    int.parse(_amount.text.toString())) {
                  Utils.showToast(
                      "Chiti Balance is only ${_chiti.remainingasalu} \n  But you are creating Entry for ${_amount.text.toString()}",
                      "error",
                      context);
                  return;
                }
                if (_paymentmode == 50) {
                  if (_pmtrans.length >= 2) {
                    int ttl = 0;
                    _pmtrans.forEach((e) {
                      if (int.tryParse(e.credit.toString()) != null &&
                          int.tryParse(e.credit.toString())! > 0) {
                        ttl += int.parse(e.credit.toString());
                      } else {
                        Utils.flushBarErrorMessage(
                            "Multi payment amounts not entered properly...!!",
                            context);
                        return;
                      }
                    });
                    if (_amount.text.isNotEmpty &&
                        ttl != int.tryParse(_amount.text)) {
                      Utils.flushBarErrorMessage(
                          "Amount and Multi payment amounts doesn't match",
                          context);
                      return;
                    }
                  } else {
                    Utils.flushBarErrorMessage(
                        "Minimum Two paymentmodes to be selected !!", context);
                    return;
                  }
                }
                createasalu();
              }
            }));
  }

  Future createasalu() async {
    latestNotesViewModel.setLatestNotes(ApiResponse.loading());
    if (_dateInput.text.contains(' ')) {
      _dateInput.text = (_dateInput.text.split(' '))[0];
      _dateInput.text = Utils.userFormat(_dateInput.text);
    }
    var tmp = {
      "date": Utils.sqlFormat(_dateInput.text).toString(),
      "customer": _chiti.customer.toString(),
      "customername": _chiti.customername.toString(),
      "chiti": _chiti.id.toString(),
      "amount": _amount.text.toString(),
      "chitiamount": "0",
      "paymentmode": _paymentmode.toString(),
      "pmtrans": "",
      "collectedby": "0",
      "note": _note.text.toString(),
    };

    if (_paymentmode == 1) {
      tmp["collectedby"] = _user.collector.toString();
    } else if (_paymentmode == 50) {
      tmp["pmtrans"] = jsonEncode(_pmtrans);
      for (PaymentmodeModel element in _pmtrans) {
        if (element.paymentmode == 1) {
          tmp["collectedby"] = _user.collector.toString();
        }
      }
    }
    // var url = "${baseurl}/asalu?date=${tmp['date']}&chiti=${tmp['chiti']}";
    var queryParameters = {
      "date": tmp['date'].toString(),
      "chiti": tmp["chiti"].toString()
    };
    // final authViewModel = Provider.of<AuthViewModel>(context);
    // asaluViewModel.fetchAsaluListApi(queryParameters);
    final _myRepo = AsaluRepository();
    bool _res = false;
    _myRepo.fetchAsaluList(queryParameters).then((value) async {
      if (value.Apistatus == 'success' && value.data!.isNotEmpty) {
        _res = await showDialogbox(context,
            "Already amount for same chiti submitted on same date \n Would you like to continue ?");
      } else {
        _res = true;
      }
      print(_res);
      if (_res) {
        _myRepo.createAsaluApi(tmp).then((value) {
          if (value.Apistatus == 'success') {
            Utils.showResponseToast(value, context);
            isCollected = true;
            getChitiData(1);
          }
        }).onError((error, stackTrace) {
          Utils.flushBarErrorMessage(error.toString(), context);
        });
      }
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
    });
    // Future.delayed(const Duration(seconds: 1), () {
    //   asaluViewModel.dispose();
    // });
  }

  // void getTextFieldValue() {
  //   Future.delayed(const Duration(seconds: 1), () {
  //     _amount.text = _chiti.regularamt.toString();
  //     _note.text = _chiti.notes.toString();
  //   });
  // }

  void getNotes(value) {
    if (_chiti.irregular == 0) {
      var paiddays = int.parse(value) / _chiti.perday!;
      num paiddays1 = paiddays.toInt();

      if (paiddays != paiddays1) {
        String msg =
            "Amount is Not equal to .$paiddays1 \n $paiddays1 days amount is ${paiddays1 * _chiti.perday!}";
        Utils.showToast(msg, "warn", context);
      }
      if (paiddays == 1) {
        setState(() {
          _note.text = (_chiti.notes!.floor()).toString();
        });
      } else if (paiddays == 2) {
        setState(() {
          _note.text =
              "${_chiti.notes!.floor()},${(_chiti.notes! + 1).floor()}";
        });
      } else if (paiddays > 2) {
        setState(() {
          _note.text =
              "${_chiti.notes!.floor()} - ${(_chiti.notes! + paiddays - 1).floor()}";
        });
      }
    } else {
      setState(() {
        _note.text = _chiti.notes!.toString();
      });
    }
  }
}
