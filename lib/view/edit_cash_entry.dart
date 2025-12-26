import 'dart:convert';
import 'package:chanda_finance/model/asalu.dart';
import 'package:chanda_finance/model/drcrModel.dart';
import 'package:chanda_finance/utils/utils.dart';
import 'package:chanda_finance/view_model/customerslist_view_model.dart';
import 'package:chanda_finance/view_model/drcr_view_model.dart';
import 'package:chanda_finance/view_model/yesno_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';
import '../model/user_model.dart';
import '../view_model/paymentmodeslist_view_model.dart';
import '../view_model/user_view_model.dart';

class EditCashEntryView extends StatefulWidget {
  final Id;
  const EditCashEntryView({super.key, this.Id});

  @override
  _EditCashEntryViewState createState() => _EditCashEntryViewState();
}

class _EditCashEntryViewState extends State<EditCashEntryView> {
  final _formKey = GlobalKey<FormState>();
  int? _paymentmode;
  int? _forIntValue;
  int? _showDaybook;
  bool _isCreditAmt = false;
  List<PmtransModel>? _pmtrans = [];
  late List<TextEditingController> _controllers;
  // Controllers for text fields
  Future<UserModel> getUserData() => UserViewModel().getUser();
  UserModel _user = UserModel();
  final _dateController = TextEditingController();
  final _customerNameController = TextEditingController();
  final _creditController = TextEditingController();
  final _debitController = TextEditingController();
  final _noteController = TextEditingController();

  FocusNode _customerFocusNode = FocusNode();
  FocusNode _creditFocusNode = FocusNode();
  FocusNode _debitFocusNode = FocusNode();
  FocusNode _noteFocusNode = FocusNode();

  PaymentmodesListViewModel paymentmodesListViewModel =
      PaymentmodesListViewModel();
  CustomersListViewModel customersListViewModel = CustomersListViewModel();
  YesnoViewModel yesnoViewModel = YesnoViewModel();
  DrcrViewModel drcrViewModel = DrcrViewModel();

  int? _selectedCustomerId;

  List<Map<String, dynamic>> _creditExp = [
    {"id": 0, "name": "None"},
    {"id": 1, "name": "Credit"},
    {"id": 2, "name": "Expenses"},
    {"id": 3, "name": "P2C"},
    {"id": 4, "name": "ChitFund"},
    {"id": 5, "name": "Medical"},
    {"id": 6, "name": "Investment"},
  ];

  // String _creditExpValue = 'Credit';
  int? _creditExpValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.Id != null && int.parse(widget.Id.toString()) > 0) {
      drcrViewModel.fetchSingleDrcrApi(widget.Id);
      paymentmodesListViewModel.fetchPaymentmodesListApi(null);
      customersListViewModel.fetchCustomersListApi();
      yesnoViewModel.getYesno(context);
      getUserData().then((value) async {
        _user = value;
      });
    }
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed

    _dateController.dispose();
    _customerNameController.dispose();
    _creditController.dispose();
    _debitController.dispose();
    _noteController.dispose();
    _customerFocusNode.dispose();
    _creditFocusNode.dispose();
    _debitFocusNode.dispose();
    _noteFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Cash Entry'),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider<DrcrViewModel>(
        create: (BuildContext context) => drcrViewModel,
        child: Consumer<DrcrViewModel>(
          builder: (context, drcrValue, _) {
            switch (drcrValue.singleDrcr.status!) {
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());

              case Status.ERROR:
                return Center(
                    child: Text(drcrValue.singleDrcr.message.toString()));
              case Status.COMPLETED:
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  // code to be executed after the current build has completed
                  if (drcrValue.isSingleDrcrCalled) {
                    DrcrModel temp = DrcrModel();
                    temp = drcrValue.singleDrcr.data!;
                    _dateController.text =
                        Utils.userFormat(temp.date!.toString());
                    _customerNameController.text = temp.customername!;
                    _selectedCustomerId = temp.customer;
                    _creditController.text =
                        Utils.hasFloatingPointNumber(temp.credit.toString())
                            ? Utils.strFloatToInt(temp.credit.toString())
                                .toString()
                            : temp.credit.toString();
                    _debitController.text =
                        Utils.hasFloatingPointNumber(temp.debit.toString())
                            ? Utils.strFloatToInt(temp.debit.toString())
                                .toString()
                            : temp.debit.toString();
                    _forIntValue = int.parse(temp.forint.toString());
                    _showDaybook = int.parse(temp.showdaybook.toString());
                    _creditExpValue = int.parse(temp.creditexp.toString());
                    _paymentmode = int.parse(temp.paymentmode.toString());
                    _noteController.text = temp.note.toString();
                    if (int.tryParse(temp.credit.toString()) != null &&
                        int.parse(temp.credit.toString()) > 0) {
                      _isCreditAmt = true;
                    } else {
                      _isCreditAmt = true;
                    }
                    if (_paymentmode == 50) {
                      _pmtrans = temp.pmtrans;
                      _controllers = List.generate(
                        _pmtrans!.length,
                        (index) => TextEditingController(
                            text: _pmtrans![index].credit.toString()),
                      );
                    } else {
                      _pmtrans = [];
                    }
                    drcrViewModel.setisSingleDrcrCalled(false);
                  }
                });
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Customer field with typing and autocomplete list
                            SizedBox(height: 16.0),

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
                                    icon: Icon(Icons
                                        .calendar_today), //icon of text field
                                  ),
                                  readOnly: true,
                                  //set it true, so that user will not able to edit text
                                  onTap: () async {
                                    DateTime initDate =
                                        (_dateController.text.isEmpty)
                                            ? DateTime.now()
                                            : Utils.convertUserToDateTime(
                                                _dateController.text);
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate:
                                            initDate, //Add this in your Code.
                                        // initialEntryMode: DatePickerEntryMode.input,
                                        firstDate: DateTime(1950),
                                        //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2100));

                                    if (pickedDate != null) {
                                      String formattedDate =
                                          DateFormat('dd/MM/yyyy')
                                              .format(pickedDate);

                                      setState(() {
                                        _dateController.text =
                                            formattedDate; //set output date to TextField value.
                                      });
                                    } else {
                                      setState(() {
                                        _dateController.text =
                                            DateFormat('dd/MM/yyyy')
                                                .format(DateTime.now());
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
                                            MaterialStateProperty.all(
                                                Colors.green),
                                        padding: MaterialStateProperty.all(
                                            const EdgeInsets.all(20)),
                                        textStyle: MaterialStateProperty.all(
                                            const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black))),
                                    onPressed: () {
                                      setState(() {
                                        _dateController.text =
                                            _dateController.text =
                                                DateFormat('dd/MM/yyyy')
                                                    .format(DateTime.now());
                                        _customerFocusNode.requestFocus();
                                      });
                                    },
                                    child: const Text('0')),
                              ),
                              SizedBox(width: 5),
                              SizedBox(
                                width: 50,
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
                                      // Get yesterday's date
                                      DateTime yesterday = DateTime.now()
                                          .subtract(Duration(days: 1));
                                      // Format the date as string
                                      String formattedDate =
                                          DateFormat('dd/MM/yyyy')
                                              .format(yesterday);
                                      // Set the formatted date as the initial value of the text field
                                      setState(() {
                                        _dateController.text = formattedDate;
                                        _customerFocusNode.requestFocus();
                                      });
                                    },
                                    child: const Text('1')),
                              ),
                              SizedBox(width: 5),
                              SizedBox(
                                width: 50,
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
                                      // Get yesterday's date
                                      DateTime yesterday = DateTime.now()
                                          .subtract(Duration(days: 2));
                                      // Format the date as string
                                      String formattedDate =
                                          DateFormat('dd/MM/yyyy')
                                              .format(yesterday);
                                      // Set the formatted date as the initial value of the text field
                                      setState(() {
                                        _dateController.text = formattedDate;
                                        _customerFocusNode.requestFocus();
                                      });
                                    },
                                    child: const Text('2')),
                              ),
                              SizedBox(width: 5),
                              SizedBox(
                                width: 50,
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
                                    // Get yesterday's date
                                    DateTime yesterday = DateTime.now()
                                        .subtract(Duration(days: 3));
                                    // Format the date as string
                                    String formattedDate =
                                        DateFormat('dd/MM/yyyy')
                                            .format(yesterday);
                                    // Set the formatted date as the initial value of the text field
                                    setState(() {
                                      _dateController.text = formattedDate;
                                      _customerFocusNode.requestFocus();
                                    });
                                  },
                                  child: const Text("3"),
                                ),
                              ),
                            ]),
                            SizedBox(
                              height: 30,
                            ),
                            ChangeNotifierProvider<CustomersListViewModel>(
                              create: (BuildContext context) =>
                                  customersListViewModel,
                              child: Consumer<CustomersListViewModel>(
                                builder: (context, value, _) {
                                  switch (value.customersList.status!) {
                                    case Status.LOADING:
                                      return const Center(
                                          child: CircularProgressIndicator());

                                    case Status.ERROR:
                                      return Center(
                                          child: Text(value
                                              .customersList.message
                                              .toString()));
                                    case Status.COMPLETED:
                                      return TypeAheadFormField(
                                        textFieldConfiguration:
                                            TextFieldConfiguration(
                                          controller: _customerNameController,
                                          focusNode: _customerFocusNode,
                                          onSubmitted: (_) {
                                            Utils.fieldFocusChange(
                                                context,
                                                _customerFocusNode,
                                                _creditFocusNode);
                                          },
                                          decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              icon: const Icon(Icons.clear),
                                              onPressed: () {
                                                _customerNameController.clear();
                                                setState(() {
                                                  _customerFocusNode
                                                      .requestFocus();
                                                });
                                              },
                                            ),
                                            labelText: 'Customer',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        suggestionsCallback: (pattern) async {
                                          return value
                                              .customersList.data!.customers!
                                              .where((item) => item.fullname
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains(
                                                      pattern.toLowerCase()));
                                        },
                                        itemBuilder: (context, itemData) {
                                          return ListTile(
                                            title: Text(
                                                itemData.fullname.toString()),
                                          );
                                        },
                                        onSuggestionSelected:
                                            (selectedItemData) {
                                          setState(() {
                                            _customerNameController.text =
                                                selectedItemData.fullname
                                                    .toString();
                                            _selectedCustomerId =
                                                selectedItemData.id;
                                            _creditFocusNode.requestFocus();
                                          });
                                        },
                                      );
                                  }
                                },
                              ),
                              // ),
                            ),

                            SizedBox(
                              height: 30,
                            ),

                            // Credit field with select options yes and no
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _creditController,
                                    focusNode: _creditFocusNode,
                                    decoration: InputDecoration(
                                      labelText: 'Credit',
                                      hintText: 'Enter credit amount',
                                    ),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      (value.isNotEmpty && int.parse(value) > 0)
                                          ? _debitController.text = "0"
                                          : null;
                                    },
                                    onFieldSubmitted: (_) {
                                      Utils.fieldFocusChange(context,
                                          _creditFocusNode, _debitFocusNode);
                                    },
                                  ),
                                ),
                                SizedBox(width: 16.0),
                                // Debit field with select options yes and no
                                Expanded(
                                  child: TextFormField(
                                    controller: _debitController,
                                    focusNode: _debitFocusNode,
                                    decoration: InputDecoration(
                                      labelText: 'Debit',
                                      hintText: 'Enter debit amount',
                                    ),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      (value.isNotEmpty &&
                                              int.parse(value.toString()) > 0)
                                          ? _creditController.text = "0"
                                          : null;
                                    },
                                    onFieldSubmitted: (_) {
                                      Utils.fieldFocusChange(context,
                                          _debitFocusNode, _noteFocusNode);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            ChangeNotifierProvider<YesnoViewModel>(
                              create: (BuildContext context) => yesnoViewModel,
                              child: Consumer<YesnoViewModel>(
                                builder: (context, value, _) {
                                  switch (value.yesno.status!) {
                                    case Status.LOADING:
                                      return const Center(
                                          child: CircularProgressIndicator());

                                    case Status.ERROR:
                                      return Center(
                                          child: Text(
                                              value.yesno.message.toString()));
                                    case Status.COMPLETED:
                                      return Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: DropdownButtonFormField<
                                                    int>(
                                                  decoration: InputDecoration(
                                                    labelText: 'For Int',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                  isExpanded: true,
                                                  value: _forIntValue,
                                                  items: value
                                                      .yesno.data!.yesno!
                                                      .map<
                                                          DropdownMenuItem<
                                                              int>>((value) {
                                                    return DropdownMenuItem<
                                                        int>(
                                                      value: int.parse(
                                                          value.id.toString()),
                                                      child: Text(
                                                        value.name.toString(),
                                                        style: const TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  // Step 5.
                                                  onChanged: (int? newValue) {
                                                    setState(() {
                                                      _forIntValue = newValue!;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: DropdownButtonFormField<
                                                    int>(
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        'Show In Daybook',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                  isExpanded: true,
                                                  value: _showDaybook,
                                                  items: value
                                                      .yesno.data!.yesno!
                                                      .map<
                                                          DropdownMenuItem<
                                                              int>>((value) {
                                                    return DropdownMenuItem<
                                                        int>(
                                                      value: int.parse(
                                                          value.id.toString()),
                                                      child: Text(
                                                        value.name.toString(),
                                                        style: const TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  // Step 5.
                                                  onChanged: (int? newValue) {
                                                    setState(() {
                                                      _showDaybook = newValue!;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      );
                                  }
                                },
                              ),
                            ),

                            // SizedBox(height: 16.0),
                            // Forint field with select options yes and no
                            // DropdownButtonFormField<String>(
                            //   value: _forIntValue,
                            //   onChanged: (value) {
                            //     setState(() {
                            //       _forIntValue = value!;
                            //     });
                            //   },
                            //   decoration: InputDecoration(
                            //     labelText: 'For Int Select',
                            //   ),
                            //   items: <String>['No', 'Yes']
                            //       .map<DropdownMenuItem<String>>((String value) {
                            //     return DropdownMenuItem<String>(
                            //       value: value,
                            //       child: Text(value),
                            //     );
                            //   }).toList(),
                            // ),
                            SizedBox(
                              height: 30,
                            ),

                            DropdownButtonFormField<int>(
                              decoration: InputDecoration(
                                labelText: 'Credit Exp Select',
                                border: OutlineInputBorder(),
                              ),
                              value: _creditExpValue,
                              onChanged: (int? newValue) {
                                setState(() {
                                  _creditExpValue = newValue!;
                                });
                              },
                              items: _creditExp.map((creditExp) {
                                return DropdownMenuItem<int>(
                                  value: int.tryParse(
                                          creditExp['id'].toString()) ??
                                      null,
                                  child: Text(creditExp['name'].toString()),
                                );
                              }).toList(),
                            ),
                            SizedBox(
                              height: 30,
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
                                                            _pmtrans!.length,
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
                                                        itemCount: _pmtrans!
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
                                                                              _pmtrans![index].paymentmode,
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
                                                                              _pmtrans![index].paymentmode = newValue!;
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
                                                                              if (_isCreditAmt) {
                                                                                _pmtrans![index].credit = int.parse(value);
                                                                              } else {
                                                                                _pmtrans![index].debit = int.parse(value);
                                                                              }
                                                                            } else {
                                                                              _pmtrans![index].credit = 0;
                                                                              _pmtrans![index].debit = 0;
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
                                                                              _pmtrans!.removeAt(index);
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
                                                                _pmtrans!.add(
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
                            // ChangeNotifierProvider<PaymentmodesListViewModel>(
                            //     create: (BuildContext context) =>
                            //         paymentmodesListViewModel,
                            //     child: Consumer<PaymentmodesListViewModel>(
                            //       builder: (context, pmvalue, _) {
                            //         switch (pmvalue.PaymentmodesList.status!) {
                            //           case Status.LOADING:
                            //             // TODO: Handle this case.
                            //             return const Center(
                            //                 child: CircularProgressIndicator());
                            //           case Status.ERROR:
                            //             // TODO: Handle this case.
                            //             return Center(
                            //                 child: Text(pmvalue
                            //                     .PaymentmodesList.message
                            //                     .toString()));
                            //           case Status.COMPLETED:
                            //             return DropdownButton<int>(
                            //               isExpanded: true,
                            //               value: _paymentmode,
                            //               items: pmvalue.PaymentmodesList.data!
                            //                   .map<DropdownMenuItem<int>>(
                            //                       (value) {
                            //                 return DropdownMenuItem<int>(
                            //                   value: value.id,
                            //                   child: Text(
                            //                     value.modename.toString(),
                            //                     style: const TextStyle(
                            //                         fontSize: 15),
                            //                   ),
                            //                 );
                            //               }).toList(),
                            //               // Step 5.
                            //               onChanged: (int? newValue) {
                            //                 setState(() {
                            //                   _paymentmode = newValue!;
                            //                 });
                            //               },
                            //             );
                            //         }
                            //       },
                            //     )),

                            // DropdownButtonFormField<String>(
                            //   value: _showDaybookValue,
                            //   onChanged: (value) {
                            //     setState(() {
                            //       _showDaybookValue = value!;
                            //     });
                            //   },
                            //   decoration: InputDecoration(
                            //     labelText: 'Credit Exp Select',
                            //   ),
                            //   items: <String>['Credit', 'Expenses', 'Medical', 'Investment']
                            //       .map<DropdownMenuItem<String>>((String value) {
                            //     return DropdownMenuItem<String>(
                            //       value: value,
                            //       child: Text(value),
                            //     );
                            //   }).toList(),
                            // ),
                            SizedBox(
                              height: 30,
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _noteController,
                                    focusNode: _noteFocusNode,
                                    minLines: 1,
                                    maxLines: 15,
                                    decoration: InputDecoration(
                                        labelText: 'Note',
                                        hintText: 'Enter Note',
                                        border: OutlineInputBorder()),
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (_user.collector == null) {
                                      Utils.showToast(
                                          "Collector name is not Received...!! \n Kindly restart app or re-Login the app",
                                          "error",
                                          context);
                                    }
                                    bool _collectedby = false;

                                    if (_paymentmode == 50) {
                                      int _amount = 0;
                                      _amount = (int.parse(_creditController
                                                  .text
                                                  .toString()) >
                                              0)
                                          ? int.parse(
                                              _creditController.text.toString())
                                          : int.parse(
                                              _debitController.text.toString());
                                      if (_pmtrans!.length >= 2) {
                                        int ttl = 0;
                                        _pmtrans!.forEach((e) {
                                          if (e.paymentmode == 1 &&
                                              _isCreditAmt) {
                                            _collectedby = true;
                                          }
                                          if (_isCreditAmt) {
                                            if (int.tryParse(
                                                        e.credit.toString()) !=
                                                    null &&
                                                int.tryParse(
                                                        e.credit.toString())! >
                                                    0) {
                                              ttl += int.parse(
                                                  e.credit.toString());
                                            } else {
                                              Utils.flushBarErrorMessage(
                                                  "Multi payment amounts not entered properly...!!",
                                                  context);
                                              return;
                                            }
                                          } else if (int.tryParse(
                                                      e.debit.toString()) !=
                                                  null &&
                                              int.tryParse(
                                                      e.debit.toString())! >
                                                  0) {
                                            ttl +=
                                                int.parse(e.debit.toString());
                                          } else {
                                            Utils.flushBarErrorMessage(
                                                "Multi payment amounts not entered properly...!!",
                                                context);
                                            return;
                                          }
                                        });
                                        if (ttl != _amount) {
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
                                    } else if (_paymentmode == 1 &&
                                        _isCreditAmt) {
                                      _collectedby = true;
                                    }
                                    if (_dateController.text.contains(' ')) {
                                      _dateController.text =
                                          (_dateController.text.split(' '))[0];
                                      _dateController.text = Utils.userFormat(
                                          _dateController.text);
                                    }
                                    Map drcr = {
                                      "credit":
                                          _creditController.text.toString(),
                                      "customer":
                                          _selectedCustomerId.toString(),
                                      "date": Utils.sqlFormat(
                                          _dateController.text.toString()),
                                      "debit": _debitController.text.toString(),
                                      "forint": _forIntValue.toString(),
                                      "note": _noteController.text.toString(),
                                      "paymentmode": _paymentmode.toString(),
                                      "pmtrans": (_paymentmode == 50)
                                          ? _pmtrans
                                          : jsonEncode([]),
                                      "showdaybook": _showDaybook.toString(),
                                      "collectedby": (_collectedby)
                                          ? _user.collector.toString()
                                          : "0",
                                    };
                                    drcrViewModel.editDrcrApi(
                                        widget.Id, jsonEncode(drcr), context);
                                  }
                                },
                                child: Text("Edit"),
                              ),
                            ),
                          ]),
                    ),
                  ),
                );
            }
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => setState(() {
      //     drcrViewModel.fetchSingleDrcrApi(widget.Id);
      //   }),
      //   child: Icon(Icons.refresh),
      // ),
    );
  }
}
