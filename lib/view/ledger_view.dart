import 'dart:convert';
import 'dart:ffi';

import 'package:chanda_finance/data/response/status.dart';
import 'package:chanda_finance/utils/shortcutButton.dart';
import 'package:chanda_finance/utils/utils.dart';
import 'package:chanda_finance/view_model/customerslist_view_model.dart';
import 'package:chanda_finance/view_model/ledger_view_model.dart';
import 'package:chanda_finance/view_model/yesno_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LedgerView extends StatefulWidget {
  final String customerId; // Parameter for customer ID
  final String customerName;
  final String fromDate;
  final String toDate;
  final String forInt;

  LedgerView({
    required this.customerId,
    required this.customerName,
    required this.fromDate,
    required this.toDate,
    required this.forInt,
  });

  @override
  _LedgerViewState createState() => _LedgerViewState();
}

class _LedgerViewState extends State<LedgerView> {
  final _fromDateInput = TextEditingController();
  final _toDateInput = TextEditingController();
  final _myFormKey = GlobalKey<FormState>();
  final _customerNameController = TextEditingController();
  CustomersListViewModel customersListViewModel = CustomersListViewModel();
  LedgerViewModel ledgerViewModel = LedgerViewModel();
  YesnoViewModel yesnoViewModel = YesnoViewModel();

  int? _selectedCustomerId;
  FocusNode _customerFocusNode = FocusNode();
  ShortcutButton? _expandedButton;

  double filterHeight = 0; // Initial height of filter options area
  double _iconsize = 0; // Initial height of filter options area
  bool filterVisible = false; // To track whether the filter area is visible
  int? _forIntValue = 0;

  @override
  void initState() {
    super.initState();
    if (widget.fromDate.isNotEmpty && widget.toDate.isNotEmpty) {
      _fromDateInput.text = Utils.userFormat(widget.fromDate);
      _toDateInput.text = Utils.userFormat(widget.toDate);
    } else {
      _fromDateInput.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
      _toDateInput.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    }

    if (widget.customerId.isNotEmpty &&
        int.parse(widget.customerId.toString()) > 0) {
      _selectedCustomerId = int.parse(widget.customerId);
    }

    if (widget.customerName.isNotEmpty) {
      _customerNameController.text = widget.customerName.toString();
    } else {
      _customerNameController.text = "";
    }

    _forIntValue = (widget.forInt.isNotEmpty) ? int.tryParse(widget.forInt) : 0;
    customersListViewModel.fetchCustomersListApi();
    yesnoViewModel.getYesno(context);

    if (widget.customerId == '0') {
      // Customer ID is 0, so prompt the user to add filter options.
      _showFilterOptionsDialog(1000);
      filterVisible = !filterVisible;
    } else {
      fetchAndDisplayLedgerData();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();

    // _fromDateInput.dispose();
    // _toDateInput.dispose();
    // _customerNameController.dispose();
  }

  void _showFilterOptionsDialog(screenHeight) {
    setState(() {
      filterHeight = screenHeight * 0.3;
      _iconsize = 25;
    });
    // Implement your dialog to input filter options here.
    // This can include the 'fromDate', 'toDate', and 'filterOption'.
  }

  void _hideFilterOptionsDialog() {
    setState(() {
      filterHeight = 0; // Hide filter options
      _iconsize = 0;
    });
  }

  // void _toggleExpanded(ShortcutButton button) {
  //   setState(() {
  //     if (_expandedButton == button) {
  //       // If the same button is tapped, close it
  //       _expandedButton = null;
  //     } else {
  //       // Otherwise, expand the new button and close the previous one
  //       _expandedButton?.collapse();
  //       _expandedButton = button;
  //     }
  //   });
  // }

  void _onExpandButton(ShortcutButton button) {
    setState(() {
      if (_expandedButton == button) {
        // If the same button is tapped, close it
        _expandedButton = null;
      } else {
        // Otherwise, expand the new button and close the previous one
        _expandedButton?.collapse();
        _expandedButton = button;
      }
    });
  }

  void fetchAndDisplayLedgerData() {
    dynamic queryParameters = {
      "customer": _selectedCustomerId.toString(),
      "date": jsonEncode({
        "op": "Between",
        "value": Utils.sqlFormat(_fromDateInput.text),
        "value1": Utils.sqlFormat(_toDateInput.text)
      }),
      "forint": _forIntValue.toString()
    };
    if (checkAllParams()) {
      ledgerViewModel.fetchLedgerApi(queryParameters);
    } else {
      _showFilterOptionsDialog(1000);
      filterVisible = true;
    }
    // Implement fetching and displaying ledger data based on filter options.
  }

  bool checkAllParams() {
    bool allOk = true;
    if (_fromDateInput.text.isEmpty || _toDateInput.text.isEmpty) {
      allOk = false;
    } else if (int.parse(_selectedCustomerId.toString()) == 0) {
      allOk = false;
    } else if (_forIntValue != 0 && _forIntValue != 1) {
      allOk = false;
    }
    return allOk;
  }

  emptyFields() {
    setState(() {
      _fromDateInput.text = "01/01/2023";
      _toDateInput.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
      _customerNameController.text = "";
      _selectedCustomerId = 0;
      _forIntValue = 0;
    });
  }

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

    return Scaffold(
        appBar: AppBar(
          title: Text(
              'Customer Ledger - ${widget.customerId}'), // Display customer name or ID
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_drop_down),
              onPressed: () {
                // Toggle filter area visibility on arrow button press
                setState(() {
                  if (filterVisible) {
                    _hideFilterOptionsDialog();
                  } else {
                    _showFilterOptionsDialog(height);
                  }
                  filterVisible = !filterVisible;
                });
              },
            ),
          ],
        ),
        body: Column(
          children: [
            // Filter options section
            // You can use DatePicker or Dropdowns to select dates and filter options
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: filterHeight,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _myFormKey,
                    child: Column(children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: width * 0.4,
                              child: TextFormField(
                                validator: (String? msg) {
                                  if (msg == null || msg.isEmpty) {
                                    return "Please Enter Date !!";
                                  }

                                  return null;
                                },
                                controller: _fromDateInput,
                                //editing controller of this TextField
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.calendar_today,
                                      size: _iconsize,
                                    ), //icon of text field
                                    labelText:
                                        "Enter From Date" //label text of field
                                    ),
                                readOnly: true,
                                //set it true, so that user will not able to edit text
                                onTap: () async {
                                  DateTime initDate =
                                      (_fromDateInput.text.isEmpty)
                                          ? DateTime.now()
                                          : Utils.convertUserToDateTime(
                                              _fromDateInput.text);
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
                                      _fromDateInput.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  } else {
                                    // var now = new DateTime.now();
                                    // var formattedDate =
                                    //     new DateFormat('dd-MM-yyyy');
                                    // print(formattedDate);
                                    setState(() {
                                      _fromDateInput.text = _fromDateInput.text;
                                    });
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: width * 0.1,
                            ),
                            Container(
                              width: width * 0.4,
                              child: TextFormField(
                                validator: (String? msg) {
                                  if (msg == null || msg.isEmpty) {
                                    return "Please Enter Date !!";
                                  }

                                  return null;
                                },
                                controller: _toDateInput,
                                //editing controller of this TextField
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.calendar_today,
                                      size: _iconsize,
                                    ), //icon of text field
                                    labelText:
                                        "Enter To Date" //label text of field
                                    ),
                                readOnly: true,
                                //set it true, so that user will not able to edit text
                                onTap: () async {
                                  DateTime initDate =
                                      (_toDateInput.text.isEmpty)
                                          ? DateTime.now()
                                          : Utils.convertUserToDateTime(
                                              _toDateInput.text);
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
                                      _toDateInput.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  } else {
                                    // var now = new DateTime.now();
                                    // var formattedDate =
                                    //     new DateFormat('dd-MM-yyyy');
                                    // print(formattedDate);
                                    setState(() {
                                      _toDateInput.text = _toDateInput.text;
                                    });
                                  }
                                },
                              ),
                            ),
                          ]),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ShortcutButton(
                            text: "Days",
                            subOptions: [
                              {"id": "1", "name": "Last 3 days"},
                              {"id": "2", "name": "Last 7 days"},
                              {"id": "3", "name": "Last 15 days"}
                            ],
                            onOptionSelected: (option) {
                              setState(() {
                                if (option == "1") {
                                  _fromDateInput.text =
                                      Utils.calculateSubtractDate(
                                          DateTime.now(), 2);
                                  _toDateInput.text = Utils.todayUserDate();
                                } else if (option == "2") {
                                  _fromDateInput.text =
                                      Utils.calculateSubtractDate(
                                          DateTime.now(), 6);
                                  _toDateInput.text = Utils.todayUserDate();
                                } else if (option == "3") {
                                  _fromDateInput.text =
                                      Utils.calculateSubtractDate(
                                          DateTime.now(), 14);
                                  _toDateInput.text = Utils.todayUserDate();
                                }
                                fetchAndDisplayLedgerData();
                              });
                            },
                            expanded: _expandedButton == null
                                ? false
                                : _expandedButton!.text ==
                                    "Days", // Check if this button should be expanded
                            onExpand: () {
                              _onExpandButton(_expandedButton!);
                            },
                          ),
                          ShortcutButton(
                            text: "Months",
                            subOptions: [
                              {"id": "1", "name": "Current month"},
                              {"id": "2", "name": "Previous 3 months"},
                              {"id": "3", "name": "6 months"}
                            ],
                            onOptionSelected: (option) {
                              setState(() {
                                _fromDateInput.text = option;
                                _toDateInput.text = "";
                              });
                            },
                            expanded: _expandedButton == null
                                ? false
                                : _expandedButton!.text ==
                                    "Days", // Check if this button should be expanded
                            onExpand: () {
                              _onExpandButton(_expandedButton!);
                            },
                          ),
                          ShortcutButton(
                            text: "Yearly",
                            subOptions: [
                              {"id": "1", "name": "Current year"},
                              {"id": "2", "name": "Last year"},
                              {"id": "3", "name": "Last 2 years"}
                            ],
                            onOptionSelected: (option) {
                              setState(() {
                                _fromDateInput.text = option;
                                _toDateInput.text = "";
                              });
                            },
                            expanded: _expandedButton == null
                                ? false
                                : _expandedButton!.text ==
                                    "Days", // Check if this button should be expanded
                            onExpand: () {
                              _onExpandButton(_expandedButton!);
                            },
                          ),
                          ShortcutButton(
                            text: "Financial Year",
                            subOptions: [
                              {
                                "id": "last3days",
                                "name": "Current financial year"
                              },
                              {
                                "id": "last7days",
                                "name": "Last financial year"
                              },
                              {"id": "last15days", "name": "Last 2 years"}
                            ],
                            onOptionSelected: (option) {
                              setState(() {
                                _fromDateInput.text = option;
                                _toDateInput.text = "";
                              });
                            },
                            expanded: _expandedButton == null
                                ? false
                                : _expandedButton!.text ==
                                    "Days", // Check if this button should be expanded
                            onExpand: () {
                              _onExpandButton(_expandedButton!);
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child:
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
                                            // _creditFocusNode.requestFocus();
                                          });
                                        },
                                      );
                                  }
                                },
                              ),
                              // ),
                            ),
                          ),
                        ],
                      ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ChangeNotifierProvider<YesnoViewModel>(
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
                                        ],
                                      );
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                fetchAndDisplayLedgerData();
                              },
                              child: Text("Filter"),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                emptyFields();
                              },
                              child: Text("Reset"),
                            ),
                          ]),
                    ]),
                  ),
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: ChangeNotifierProvider<LedgerViewModel>(
                    create: (BuildContext context) => ledgerViewModel,
                    child: Consumer<LedgerViewModel>(
                      builder: (context, value, _) {
                        switch (value.ledgerData.status!) {
                          case Status.LOADING:
                            return const Center(
                                child: CircularProgressIndicator());

                          case Status.ERROR:
                            return Center(
                                child:
                                    Text(value.ledgerData.message.toString()));
                          case Status.COMPLETED:
                            return Column(
                              children: <Widget>[
                                // Data table section
                                DataTable(
                                  sortColumnIndex:
                                      0, // Index for the column to be initially sorted
                                  sortAscending: true, // Sort order
                                  columns: <DataColumn>[
                                    DataColumn(
                                      label: Text('Sno'),
                                      onSort: (columnIndex, ascending) {
                                        // Implement sorting logic for this column
                                      },
                                    ),
                                    DataColumn(
                                      label: Text('Date'),
                                      onSort: (columnIndex, ascending) {
                                        // Implement sorting logic for this column
                                      },
                                    ),
                                    DataColumn(
                                      label: Text('Debit'),
                                      onSort: (columnIndex, ascending) {
                                        // Implement sorting logic for this column
                                      },
                                    ),
                                    DataColumn(
                                      label: Text('Credit'),
                                      onSort: (columnIndex, ascending) {
                                        // Implement sorting logic for this column
                                      },
                                    ),
                                    DataColumn(
                                      label: Text('Note'),
                                      onSort: (columnIndex, ascending) {
                                        // Implement sorting logic for this column
                                      },
                                    ),
                                    DataColumn(
                                      label: Text('Main Balance'),
                                      onSort: (columnIndex, ascending) {
                                        // Implement sorting logic for this column
                                      },
                                    ),
                                    DataColumn(
                                      label: Text('Asalu Bal'),
                                      onSort: (columnIndex, ascending) {
                                        // Implement sorting logic for this column
                                      },
                                    ),
                                    DataColumn(
                                      label: Text('Int Bal'),
                                      onSort: (columnIndex, ascending) {
                                        // Implement sorting logic for this column
                                      },
                                    ),
                                  ],
                                  rows: value.ledgerData.data!.ledgerList!
                                      .map((entry) {
                                    int index = value
                                            .ledgerData.data!.ledgerList!
                                            .indexOf(entry) +
                                        1;
                                    return DataRow(cells: <DataCell>[
                                      DataCell(Text(index.toString())),
                                      DataCell(Text(Utils.userFormat(
                                          entry.date.toString()))),
                                      DataCell(Text(entry.debit.toString())),
                                      DataCell(Text(entry.credit.toString())),
                                      DataCell(Text(entry.note.toString())),
                                      DataCell(Text(entry.balance.toString())),
                                      DataCell(Text('0')),
                                      DataCell(Text('0')),
                                    ]);
                                  }).toList(),
                                  // Add more rows with ledger data
                                ),
                              ],
                            );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            // ),
          ],
          // ),
        ));
  }
}
