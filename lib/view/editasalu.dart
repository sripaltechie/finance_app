import 'dart:convert';

import 'package:chanda_finance/data/response/status.dart';
import 'package:chanda_finance/model/asalu.dart';
import 'package:chanda_finance/model/paymentmodeModel.dart';
import 'package:chanda_finance/repository/asalu_repository.dart';
import 'package:chanda_finance/repository/paymentmodesList_repository.dart';
import 'package:chanda_finance/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/latest_notes.dart';
import '../model/user_model.dart';
import '../repository/latestnotes_repository.dart';
import '../view_model/paymentmodeslist_view_model.dart';
import '../view_model/user_view_model.dart';

class EditAsaluView extends StatefulWidget {
  final int id;
  String? backPage;

  EditAsaluView({super.key, required this.id, this.backPage});

  @override
  State<EditAsaluView> createState() => _EditAsaluViewState();
}

class _EditAsaluViewState extends State<EditAsaluView> {
  final _myFormKey = GlobalKey<FormState>();
  final _dateInput = TextEditingController();
  final _chitiId = TextEditingController();
  final _amount = TextEditingController();
  final _note = TextEditingController();
  int _paymentmode = 1;
  String customername = "";
  // LatestNotesViewModel latestNotesViewModel = LatestNotesViewModel();
  final _myChitiRepo = LatestNotesRepository();
  Chiti _chiti = Chiti();
  int id = 0;
  // AsaluViewModel asaluViewModel = AsaluViewModel();
  final _myRepo = AsaluRepository();
  AsaluModel asalu = AsaluModel();
  List<PmtransModel> _pmtrans = [];
  late List<TextEditingController> _controllers;
  Future<UserModel> getUserData() => UserViewModel().getUser();
  UserModel _user = UserModel();
  String errorMessage = "";
  PaymentmodesListViewModel paymentmodesListViewModel =
      PaymentmodesListViewModel();
  void getAsaluData() async {
    if (id > 0) {
      await _myRepo.fetchSingleAsalu(id).then((value) {
        if (value.Apistatus == "success" && value.data!.id != null) {
          setState(() {
            asalu = value.data!;
            _dateInput.text =
                (Utils.userFormat(asalu.date.toString())).toString();
            _chitiId.text = asalu.chiti.toString();
            _amount.text = asalu.amount.toString();
            _note.text = asalu.note.toString();
            _paymentmode = int.parse(asalu.paymentmode.toString());
            if (_paymentmode == 50) {
              _pmtrans = asalu.pmtrans!;
              _controllers = List.generate(
                _pmtrans.length,
                (index) => TextEditingController(
                    text: _pmtrans[index].credit.toString()),
              );
            }
            customername = asalu.customername.toString();
          });
        }
      });
    }
  }

  void getChitiData() {
    // latestNotesViewModel.fetchLatestNotesListApi(_chitiId.text, context);
    _myChitiRepo.fetchLatestNotesList(_chitiId.text).then((value) {
      Utils.showResponseToast(value, context);
      setState(() {
        _chiti = value.data!.chiti!;
        customername = _chiti.customername.toString();
        _paymentmode = int.parse(_chiti.regularpmmode.toString());
        getNotes(_amount.text);
      });
    }).onError((error, stackTrace) {
      Utils.showToast(error.toString(), "error", context);
    });
    FocusManager.instance.primaryFocus?.unfocus();
  }

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
    }
  }

  void editAsalu() async {
    if (_dateInput.text.indexOf(' ') >= 0) {
      _dateInput.text = (_dateInput.text.split(' '))[0];
      _dateInput.text = Utils.userFormat(_dateInput.text);
    }

    asalu.date = Utils.sqlFormat(_dateInput.text);
    asalu.chiti = int.parse(_chitiId.text);
    asalu.amount = int.parse(_amount.text);
    asalu.note = _note.text.toString();
    asalu.paymentmode = _paymentmode;
    asalu.pmtrans = [];
    asalu.collectedby = 0;
    if (_paymentmode == 1) {
      asalu.collectedby = int.parse(_user.collector.toString());
    } else if (_paymentmode == 50) {
      asalu.pmtrans = _pmtrans;
      for (PmtransModel element in _pmtrans) {
        if (element.paymentmode == 1) {
          asalu.collectedby = int.parse(_user.collector.toString());
        }
      }
    }

    _myRepo.editAsaluApi(asalu.id, jsonEncode(asalu)).then((value) {
      if (value.status == Status.COMPLETED && value.Apistatus == "success") {
        Utils.showResponseToast(value, context);
        getAsaluData();
      }
    });
  }

  @override
  void initState() {
    id = int.parse(widget.id.toString());
    if (id > 0) {
      getAsaluData();
      paymentmodesListViewModel.fetchPaymentmodesListApi(null);

      getUserData().then((value) async {
        _user = value;
      });
    }
  }

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text("Edit Asalu"),
      )),
      body: ListView(
        children: [
          Center(
            child: Container(
              width: 900,
              height: 900,
              child: Center(
                  child:
                      // ListView(
                      //   children: [
                      // Text("hi"),
                      Form(
                          key: _myFormKey,
                          child: Padding(
                            padding: const EdgeInsets.all(40),
                            child: Column(
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    customername.toString(),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                                TextField(
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
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime
                                            .now(), //Add this in your Code.
                                        // initialEntryMode: DatePickerEntryMode.input,
                                        firstDate: DateTime(1950),
                                        //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2100));

                                    if (pickedDate != null) {
                                      print(
                                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                      String formattedDate =
                                          DateFormat('dd/MM/yyyy')
                                              .format(pickedDate);
                                      print(
                                          formattedDate); //formatted date output using intl package =>  2021-03-16
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
                                  controller: _chitiId,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    if (value.length == 3) {
                                      getChitiData();
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "Enter Chiti Id",
                                    labelText: "Chiti Id",
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  validator: (String? msg) {
                                    if (msg == null || msg.isEmpty) {
                                      return (msg == null || msg.isEmpty)
                                          ? "Email can't be empty"
                                          : null;
                                    }
                                    return null;
                                  },
                                  controller: _amount,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    if (int.parse(value.toString()) > 0) {
                                      getNotes(value);
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "Enter the Amount",
                                    labelText: "Amount",
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  controller: _note,
                                  // keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    hintText: "Enter Notes",
                                    labelText: "Notes",
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ChangeNotifierProvider<
                                    PaymentmodesListViewModel>(
                                  create: (BuildContext context) =>
                                      paymentmodesListViewModel,
                                  child: Consumer<PaymentmodesListViewModel>(
                                    builder: (context, pmvalue, _) {
                                      switch (
                                          pmvalue.PaymentmodesList.status!) {
                                        case Status.LOADING:
                                          // TODO: Handle this case.
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        case Status.ERROR:
                                          // TODO: Handle this case.
                                          return Center(
                                              child: Text(pmvalue
                                                  .PaymentmodesList.message
                                                  .toString()));
                                        case Status.COMPLETED:
                                          return (_paymentmode != 50)
                                              ? DropdownButton<int>(
                                                  isExpanded: true,
                                                  value: _paymentmode,
                                                  items: pmvalue
                                                      .PaymentmodesList.data!
                                                      .map<
                                                          DropdownMenuItem<
                                                              int>>((value) {
                                                    return DropdownMenuItem<
                                                        int>(
                                                      value: int.parse(
                                                          value.id.toString()),
                                                      child: Text(
                                                        value.modename
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  // Step 5.
                                                  onChanged: (int? newValue) {
                                                    setState(() {
                                                      _paymentmode = newValue!;
                                                      if (_paymentmode == 50) {
                                                        _pmtrans = [
                                                          PmtransModel(
                                                              paymentmode: 1,
                                                              credit: 0,
                                                              debit: 0),
                                                          PmtransModel(
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
                                                )
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
                                                                          child:
                                                                              DropdownButton<int>(
                                                                            isExpanded:
                                                                                true,
                                                                            value:
                                                                                _pmtrans[index].paymentmode,
                                                                            items:
                                                                                pmvalue.PaymentmodesList.data!.where((value) => (value.id != 0 && value.id != 50)).map<DropdownMenuItem<int>>((value) {
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
                                                                              if (msg == null || msg.isEmpty) {
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
                                                              onPressed: () {
                                                                setState(() {
                                                                  _pmtrans.add(
                                                                      PmtransModel(
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
                                                              child:
                                                                  Text("Add")),
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
                                                              child: Text(
                                                                  "Single")),
                                                        ],
                                                      )
                                                    ]),
                                                  ),
                                                );
                                      }
                                      ;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                        flex: 1,
                                        child: ElevatedButton(
                                            child: const Text("Back"),
                                            onPressed: () async {
                                              if (widget.backPage != null) {
                                                Navigator.pushReplacementNamed(
                                                    context,
                                                    widget.backPage.toString(),
                                                    arguments: [
                                                      int.parse(asalu.chiti
                                                          .toString())
                                                    ]);
                                              } else {
                                                Navigator.pop(context);
                                              }
                                            })),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green),
                                          child: const Text("Edit"),
                                          onPressed: () async {
                                            if (_myFormKey.currentState!
                                                .validate()) {
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

                                              editAsalu();
                                            }
                                          },
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ))
                  // ],
                  ),
            ),
          ),
          // ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     _myFormKey.currentState!.validate();
      //   },
      //   child: Icon(Icons.done),
      // ),
    );
  }
}
