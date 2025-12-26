import 'package:chanda_finance/view_model/collector_amount_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';
import '../res/components/round_button.dart';
import '../utils/utils.dart';
import '../view_model/user_view_model.dart';

class CreateCollectorAmountView extends StatefulWidget {
  const CreateCollectorAmountView({Key? key}) : super(key: key);

  @override
  State<CreateCollectorAmountView> createState() =>
      _CreateCollectorAmountViewState();
}

class _CreateCollectorAmountViewState extends State<CreateCollectorAmountView> {
  TextEditingController _dateInput = TextEditingController();
  TextEditingController _amount = TextEditingController();
  TextEditingController _collectionDate = TextEditingController();
  TextEditingController _note = TextEditingController();
  final _myFormKey = GlobalKey<FormState>();
  UserModel _user = UserModel();
  bool isLoading = false;

  FocusNode amountFocusNode = FocusNode();
  // Collector_Amount_ViewModel collector_amount_viewModel =
  //     Collector_Amount_ViewModel();

  Future<UserModel> getUserData() => UserViewModel().getUser();

  @override
  void dispose() {
    _dateInput.dispose();
    _amount.dispose();
    _collectionDate.dispose();
    _note.dispose();
    super.dispose();
    amountFocusNode.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dateInput.text = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());
    _collectionDate.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    getUserData().then((value) async {
      _user = value;
    });
    Future.delayed(Duration.zero, () {
      amountFocusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final collector_amount_viewModel =
        Provider.of<Collector_Amount_ViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Collection Received"),
        centerTitle: true,
      ),
      body: Container(
        height: height,
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _myFormKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (String? msg) {
                    if (msg == null || msg.isEmpty) {
                      return "Please Enter Date and Time!!";
                    }
                    return null;
                  },
                  controller: _dateInput,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today),
                      labelText: "Enter Date and Time",
                      border: OutlineInputBorder()),
                  readOnly: true,
                  onTap: () async {
                    DateTime initDate = (_dateInput.text.isEmpty)
                        ? DateTime.now()
                        : Utils.convertUserToDateTime(_dateInput.text);
                    TimeOfDay initTime = TimeOfDay.fromDateTime(initDate);
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: initDate,
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2100));
                    if (pickedDate != null) {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: initTime,
                      );
                      if (pickedTime != null) {
                        DateTime pickedDateTime = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            pickedTime.hour,
                            pickedTime.minute);
                        String formattedDate = DateFormat('dd/MM/yyyy HH:mm')
                            .format(pickedDateTime);
                        setState(() {
                          _dateInput.text = formattedDate;
                          amountFocusNode.requestFocus();
                        });
                      }
                    }
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _amount,
                  focusNode: amountFocusNode,
                  decoration: InputDecoration(
                      labelText: 'Amount', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an amount';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                //editing controller of this TextField

                SizedBox(
                  height: height * 0.08,
                  child: Row(children: [
                    Expanded(
                      child: TextFormField(
                        validator: (String? msg) {
                          if (msg == null || msg.isEmpty) {
                            return 'Please enter a collection date';
                          }
                          return null;
                        },
                        controller: _collectionDate,
                        decoration: const InputDecoration(
                          labelText: 'Collection Date',
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.calendar_today), //icon of text field
                        ),
                        readOnly: true,
                        //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime initDate = (_collectionDate.text.isEmpty)
                              ? DateTime.now()
                              : Utils.convertUserToDateTime(
                                  _collectionDate.text);
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
                              _collectionDate.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {
                            setState(() {
                              _collectionDate.text = DateFormat('dd/MM/yyyy')
                                  .format(DateTime.now());

                              // _collectionDate.text = DateTime.now().toString();
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
                              textStyle: MaterialStateProperty.all(
                                  const TextStyle(
                                      fontSize: 14, color: Colors.black))),
                          onPressed: () {
                            setState(() {
                              _collectionDate.text = _collectionDate.text =
                                  DateFormat('dd/MM/yyyy')
                                      .format(DateTime.now());
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
                                  MaterialStateProperty.all(Colors.green),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(20)),
                              textStyle: MaterialStateProperty.all(
                                  const TextStyle(
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
                              _collectionDate.text = formattedDate;
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
                                  MaterialStateProperty.all(Colors.green),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(20)),
                              textStyle: MaterialStateProperty.all(
                                  const TextStyle(
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
                              _collectionDate.text = formattedDate;
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
                                MaterialStateProperty.all(Colors.green),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(20)),
                            textStyle: MaterialStateProperty.all(
                                const TextStyle(
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
                            _collectionDate.text = formattedDate;
                          });
                        },
                        child: const Text("3"),
                      ),
                    ),
                  ]),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _note,
                  decoration: InputDecoration(
                      labelText: 'Note', border: OutlineInputBorder()),
                ),
                SizedBox(height: 16.0),
                RoundButton(
                  title: 'Submit',
                  loading: collector_amount_viewModel.createLoading,
                  onPress: () {
                    if (_myFormKey.currentState!.validate()) {
                      if (_user.collector == null) {
                        Utils.showToast("Please Login again and Make entry..!!",
                            "error", context);
                        return;
                      }
                      var tmp = {
                        "date": Utils.SqlTimeFormat(_dateInput.text.toString()),
                        "collector": _user.collector,
                        "amount": _amount.text.toString(),
                        "collectiondate":
                            Utils.sqlFormat(_collectionDate.text.toString()),
                        "note": _note.text.toString(),
                      };

                      collector_amount_viewModel.createCollectorAmountApi(
                          tmp, context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
