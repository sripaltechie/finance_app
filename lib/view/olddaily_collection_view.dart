import 'dart:convert';
import 'package:chanda_finance/model/paymentmodeModel.dart';
import 'package:chanda_finance/view/navbar_view.dart';
import 'package:chanda_finance/model/lasttransold.dart';
import 'package:chanda_finance/res/components/widget/scrollable_widget.dart';

import 'package:chanda_finance/utils/toast.dart';
// import 'dart:html';
// import 'dart:ffi';

import 'package:flutter/material.dart';
// import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:chanda_finance/model/model.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';
import '../res/components/app_url.dart';
import '../utils/showAlertDialog.dart';
import '../utils/utils.dart';
import '../view_model/latest_notes_view_model.dart';
import '../view_model/paymentmodeslist_view_model.dart';
import '../view_model/theme_changer_view_model.dart';
// import 'package:flutterto';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class oldDailyCollection extends StatefulWidget {
  final int chitiId;
  const oldDailyCollection({Key? key, required this.chitiId}) : super(key: key);
  @override
  State<oldDailyCollection> createState() => _oldDailyCollectionState();
}

class _oldDailyCollectionState extends State<oldDailyCollection> {
  // late _JsonDataGridSource jsonDataGridSource;
  Latestnotes latestnotes = Latestnotes();
  Lasttransold lasttrans = Lasttransold();
  List<dynamic> lastdetails = [];
  List<PaymentmodeModel> paymentmodeList = [];
  List<String> pmnames = [];
  bool _isLoading = false;
  // Paymentmode paymentmodeList = Paymentmode();
  var createasaluStatus;
  String dropdownValue = 'Cash';
  final FToast ftoast = FToast();
  late ToastNotification toast;
  final _myFormKey = GlobalKey<FormState>();
  final _chitiId = TextEditingController();
  final _dateInput = TextEditingController();
  final _amount = TextEditingController();
  final _note = TextEditingController();
  final customername = "";
  FocusNode amountFocusNode = FocusNode();

  bool res = false;
  bool pressedRes = false;
  String errmsg = "";

  //start
  PaymentmodesListViewModel paymentmodesListViewModel =
      PaymentmodesListViewModel();

  late LatestNotesViewModel latestNotesViewModel = LatestNotesViewModel();
  // String getFormattedDate(String date) {
  //   /// Convert into local date format.
  //   var localDate = DateTime.parse(date).toLocal();

  //   /// inputFormat - format getting from api or other func.
  //   /// e.g If 2021-05-27 9:34:12.781341 then format must be yyyy-MM-dd HH:mm
  //   /// If 27/05/2021 9:34:12.781341 then format must be dd/MM/yyyy HH:mm
  //   var inputFormat = DateFormat('dd-MM-yyyy');
  //   var inputDate = inputFormat.parse(localDate.toString());

  //   /// outputFormat - convert into format you want to show.
  //   var outputFormat = DateFormat('yyyy/MM/dd');
  //   var outputDate = outputFormat.format(inputDate);

  //   return outputDate.toString();
  // }

  // getPaymentmodeList() async {
  //   //List();
  //   var response = await http.get(
  //     Uri.parse("$baseurl/paymentmodes"),
  //     headers: {
  //       'Accept': 'application/json',
  //       "Content-Type": "application/x-www-form-urlencoded",
  //     },
  //   );
  //   var data = jsonDecode(response.body.toString());
  //   if (response.statusCode == 200 && data["status"] == "success") {
  //     paymentmodeList = data["paymentmode"];
  //     for (var p = 0; p < paymentmodeList.length; p++) {
  //       pmnames.add(paymentmodeList[p]["modename"]);
  //     }
  //   }
  // }

  checkAsalu(asalu) async {
    if (asalu["chiti"] == "null" && _chitiId.text == "") {
      toast.error("Please Enter chiti Id & Press Ok button");
      return false;
    } else if (asalu["customer"] == "null") {
      toast.error("Please Press Ok button");
      return false;
    } else if (_amount.text == "") {
      toast.error("Please Enter Amount Properly");
      return false;
    } else if (_note.text == "") {
      toast.error("Please Enter Note Properly");
      return false;
    }
    return true;
  }

  void fetchdata() async {
    _isLoading = true;

    if (_chitiId.text != "") {
      setState(() {
        errmsg = "";
        latestnotes = Latestnotes();
        //res = true;
      });
      var response = await http.get(
        Uri.parse("${AppUrl.baseUrl}/latestnotes/${_chitiId.text}"),
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );
      var data = jsonDecode(response.body.toString());
      print(data);
      if (response.statusCode == 200 && data["status"] == "success") {
        setState(() {
          latestnotes = Latestnotes.fromJson(data["chiti"]);
          latestnotes.haminame = latestnotes.haminame ?? "";
          _amount.text = latestnotes.regularamt.toString();
          dropdownValue = 'Cash';
          // paymentmode.getpaymentmodeList();
          //(latestnotes.regularamt!.toString() != null)
          // ? latestnotes.regularamt.toString()
          // : 0;
          if (latestnotes.irregular == 0 &&
              int.parse(latestnotes.regularamt!) > 0) {
            getNotes(latestnotes.regularamt);
          } else {
            _note.text = (latestnotes.notes!.floor()).toString();
          }
          if (latestnotes.lasttrans!.isEmpty) {
            errmsg = "No Asalu Found for customer ${latestnotes.customername}";
          }
          // res = (latestnotes.lasttrans != null) ? true : false;
        });
        // jsonDataGridSource = _JsonDataGridSource(lastdetails!);
        // return lastdetails;
      } else {
        setState(() {
          errmsg = data["message"];
          //res = true;
        });
        //Latestnotes.fromJson(data["chiti"]);
      }
    }
    _isLoading = false;
  }

  Future createasalu() async {
    if (_dateInput.text.contains(' ')) {
      _dateInput.text = (_dateInput.text.split(' '))[0];
      _dateInput.text = Utils.userFormat(_dateInput.text);
    }
    var tmp = {
      "date": Utils.sqlFormat(_dateInput.text),
      "customer": latestnotes.customer.toString(),
      "customername": latestnotes.customername.toString(),
      "chiti": latestnotes.id.toString(),
      "amount": _amount.text.toString(),
      "chitiamount": "0",
      "paymentmode": Utils.getpmmode(paymentmodeList, dropdownValue),
      "pmtrans": "",
      "note": _note.text.toString(),
    };

    if (await checkAsalu(tmp)) {
      var confirmRes = false;
      var url =
          "${AppUrl.baseUrl}/asalu?date=${tmp['date']}&chiti=${tmp['chiti']}";
      var asaluResponse = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );
      var todayAsalu = jsonDecode(asaluResponse.body.toString());
      if (todayAsalu["asalu"].length > 0) {
        print("not avc");
        // ignore: use_build_context_synchronously
        await showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('AlertDialog Title'),
            content: const Text(
                'Already amount for same chiti submitted on same date \n Would you like to continue ?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'Cancel');
                  confirmRes = false;
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'OK');
                  confirmRes = true;
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
        //   ,
        //       "Already amount for same chiti submitted \n Would you like to continue ?");
      }

      if (todayAsalu["asalu"].length == 0 ||
          (todayAsalu["asalu"].length > 0 && confirmRes)) {
        url = "${AppUrl.baseUrl}/asalu";
        var response = await http.post(Uri.parse(url), body: tmp, headers: {
          'Accept': 'application/json',
          "Content-Type": "application/x-www-form-urlencoded",
        });
        createasaluStatus = jsonDecode(response.body.toString());
        fetchdata();
        if (createasaluStatus["status"] == "success") {
          print(createasaluStatus["status"]);
          toast.success("${createasaluStatus["message"]}");
        }
      }
    }
    // return true;
  }

  void getNotes(value) {
    if (latestnotes.irregular == 0) {
      var paiddays = int.parse(value) / latestnotes.perday!;
      num paiddays1 = paiddays.toInt();

      if (paiddays != paiddays1) {
        toast.warn(
            "Amount is Not equal to .${paiddays1} \n ${paiddays1} days amount is ${paiddays1 * latestnotes.perday!}");
      }
      if (paiddays == 1) {
        _note.text = (latestnotes.notes!.floor()).toString();
      } else if (paiddays == 2) {
        _note.text =
            "${latestnotes.notes!.floor()},${(latestnotes.notes! + 1).floor()}";
      } else if (paiddays > 2) {
        _note.text =
            "${latestnotes.notes!.floor()} - ${(latestnotes.notes! + paiddays - 1).floor()}";
      }
    }
  }

// Tap location will be used use to position the context menu
  Offset _tapPosition = Offset.zero;
  void _getTapPosition(TapDownDetails details) {
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      _tapPosition = referenceBox.globalToLocal(details.globalPosition);
    });
  }

  // This function will be called when you long press on the blue box or the image
  void _showContextMenu(BuildContext context, editValue) async {
    final RenderObject? overlay =
        Overlay.of(context).context.findRenderObject();

    final result = await showMenu(
        context: context,

        // Show the context menu at the tap location
        position: RelativeRect.fromRect(
            Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 30, 30),
            Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
                overlay.paintBounds.size.height)),

        // set a list of choices for the context menu
        items: [
          const PopupMenuItem(
            value: 'editasalu',
            child: Text('Edit'),
          ),
          const PopupMenuItem(
            value: 'deleteasalu',
            child: Text('Delete'),
          ),
          // const PopupMenuItem(
          //   value: 'hide',
          //   child: Text('Hide'),
          // ),
        ]);

    // Implement the logic for each choice here
    switch (result) {
      case 'editasalu':
        debugPrint('Add To Favorites');
        Navigator.of(context).pushNamed('/editasalu', arguments: [editValue]);
        break;
      case 'deleteasalu':
        debugPrint('Write Comment');
        if (editValue > 0) {
          bool res = await showDialogbox(
              context, "Are You sure you want to Delete Entry ?");
          if (res == true) {
            var response = await http.delete(
              Uri.parse("${AppUrl.baseUrl}/asalu/${editValue}"),
              headers: {
                'Accept': 'application/json',
                "Content-Type": "application/x-www-form-urlencoded",
              },
            );
            var data = jsonDecode(response.body.toString());
            toast.success(data["message"]);
            print(data);
            if (response.statusCode == 200 && data["status"] == "success") {
              fetchdata();
            }
          }
        }
        break;
      // case 'hide':
      //   debugPrint('Hide');
      //   break;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    // getPaymentmodeList();
    dynamic queryParameters = null;
    paymentmodesListViewModel.fetchPaymentmodesListApi(queryParameters);

    toast = ToastNotification(ftoast.init(context));
    amountFocusNode.addListener(() {
      if (!amountFocusNode.hasFocus && _amount.text.isNotEmpty) {
        if (int.parse(_amount.text) >= latestnotes.perday!) {
          getNotes(_amount.text);
        } else {
          toast.info(
              "Per Day for ${latestnotes.customername} is ${latestnotes.perday}");
        }
      }
    });
    const res = false;
    _dateInput.text = DateTime.now().day.toString() +
        '/' +
        DateTime.now().month.toString() +
        '/' +
        DateTime.now().year.toString();

    // paymentmodeList = await DbLists().getpaymentmodeList() as Paymentmode;
    if (widget.chitiId > 0) {
      _chitiId.text = widget.chitiId.toString();
      fetchdata();
    }
    super.initState();
  }

  @override
  void dispose() {
    amountFocusNode.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      toast = new ToastNotification(ftoast.init(context));
    });

    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          title: const Text('Sripal Api Calls'),
        ),
        body: Stack(children: [
          Container(
            // padding:
            //     EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
            child: Form(
              key: _myFormKey,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Stack(fit: StackFit.expand, children: [
                      Container(
                        margin: EdgeInsets.only(left: 35, right: 35),
                        child: Column(
                          children: [
                            TextField(
                              controller: _dateInput,
                              //editing controller of this TextField
                              decoration: InputDecoration(
                                  icon: Icon(Icons
                                      .calendar_today), //icon of text field
                                  labelText: "Enter Date" //label text of field
                                  ),
                              readOnly: true,
                              //set it true, so that user will not able to edit text
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate:
                                        DateTime.now(), //Add this in your Code.
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
                                    _dateInput.text = DateTime.now().toString();
                                  });
                                }
                              },
                            ),
                            // Column(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceEvenly,
                            //     children: [Row()]),
                            TextFormField(
                              style: const TextStyle(color: Colors.black),
                              controller: _chitiId,
                              keyboardType: TextInputType.number,
                              validator: (String? msg) {
                                if (msg == null || msg.isEmpty) {
                                  return "Please Enter Chiti ID !!";
                                }
                                if (msg.length < 3) {
                                  return "Please Enter 3 numbers !!";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Chiti ID",
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
                                        setState(() {
                                          // fetchdata();
                                          // istapped = 'Button tapped';
                                          latestNotesViewModel
                                              .fetchLatestNotesListApi(
                                                  _chitiId.text, context);
                                        });
                                      },
                                      child: const Text('Ok')),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.black),
                              controller: _amount,
                              focusNode: amountFocusNode,
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "Amount",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            SizedBox(height: 40),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                latestnotes.customername != null
                                    ? Row(children: [
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 0),
                                            child: Container(
                                                child: FloatingActionButton(
                                              backgroundColor: Colors.lightBlue,
                                              heroTag: "btn1",
                                              shape: RoundedRectangleBorder(),
                                              child: const Text(
                                                "1",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              onPressed: () {
                                                _amount.text = latestnotes
                                                    .perday
                                                    .toString();
                                                // _note.text =
                                                //     "${latestnotes.notes!.floor()}";
                                                getNotes(_amount.text);
                                              },
                                            ))),
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 0),
                                            child: Container(
                                                child: FloatingActionButton(
                                              backgroundColor: Colors.lightBlue,
                                              heroTag: "btn2",
                                              shape: RoundedRectangleBorder(),
                                              child: const Text(
                                                "2",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              onPressed: () {
                                                _amount.text =
                                                    (latestnotes.perday! * 2)
                                                        .toString();
                                                // _note.text =
                                                //     "${latestnotes.notes!.floor()},${(latestnotes.notes! + 1).floor()}";
                                                getNotes(_amount.text);
                                              },
                                            ))),
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 0),
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
                                                    (latestnotes.perday! * 3)
                                                        .toString();
                                                // _note.text =
                                                //     "${latestnotes.notes!.floor()}-${(latestnotes.notes! + 2).floor()}";
                                                getNotes(_amount.text);
                                              },
                                            ))),
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 0),
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
                                                    (latestnotes.perday! * 4)
                                                        .toString();
                                                // _note.text =
                                                //     "${latestnotes.notes!.floor()}-${(latestnotes.notes! + 3).floor()}";
                                                getNotes(_amount.text);
                                              },
                                            ))),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 0),
                                          child: Container(
                                            child: FloatingActionButton(
                                              backgroundColor: Colors.lightBlue,
                                              heroTag: "btn5",
                                              shape: RoundedRectangleBorder(),
                                              child: const Text(
                                                "5",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              onPressed: () {
                                                _amount.text =
                                                    (latestnotes.perday! * 5)
                                                        .toString();
                                                // _note.text =
                                                //     "${latestnotes.notes!.floor()}-${(latestnotes.notes! + 4).floor()}";
                                                getNotes(_amount.text);
                                              },
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 0),
                                          child: Container(
                                            child: FloatingActionButton(
                                              backgroundColor: Colors.lightBlue,
                                              heroTag: "btn6",
                                              shape: RoundedRectangleBorder(),
                                              child: const Text(
                                                "10",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              onPressed: () {
                                                _amount.text =
                                                    (latestnotes.perday! * 10)
                                                        .toString();
                                                // _note.text =
                                                //     "${latestnotes.notes!.floor()}-${(latestnotes.notes! + 9).floor()}";
                                                getNotes(_amount.text);
                                              },
                                            ),
                                          ),
                                        ),
                                      ])
                                    : Container(),
                              ],
                            ),

                            // ],
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.black),
                              controller: _note,
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "Note",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            // Paymentmodedp(),
                            SizedBox(
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
                                        pmnames = Utils.getpmnames(
                                            pmvalue.PaymentmodesList.data!);
                                        return DropdownButton<String>(
                                          isExpanded: true,
                                          value: dropdownValue,
                                          items: pmnames
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            );
                                          }).toList(),
                                          // Step 5.
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropdownValue = newValue!;
                                            });
                                          },
                                        );
                                    }
                                  },
                                )),
                            Builder(builder: (_) {
                              if (_isLoading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else {
                                return Container();
                              }
                            }),
                            // DropdownButton(
                            //   isExpanded: true,
                            //   hint: Text("Select "),
                            //   value: selectedValue == null
                            //       ? selectedValue
                            //       : getSelectedValue(selectedValue),
                            //   // paymentmodeList
                            //   //     .where((i) =>
                            //   //         i["id"].toString() == selectedValue)
                            //   //     .first,
                            //   //selectedValue,
                            //   items: paymentmodeList.map((value) {
                            //     return DropdownMenuItem(
                            //       value: value,
                            //       child: Row(
                            //         children: <Widget>[
                            //           SizedBox(
                            //             width: 10,
                            //           ),
                            //           Text(value["modename"]),
                            //         ],
                            //       ),
                            //     );
                            //     // ),
                            //   }).toList(),
                            //   onChanged: (newValue) {
                            //     setState(() {
                            //       selectedValue = newValue.toString();
                            //     });
                            //   },
                            //   //paymentmodeList.map((map) {}).toList(),
                            //   //paymentmodeList.map((item) {
                            //   // return DropdownMenuItem(
                            //   // value: item["id"],
                            //   // child: Text(item["modename"]));
                            //   // }),
                            //   // onChanged: (String? value) {
                            //   //   setState(() {
                            //   //     selectedValue = value!;
                            //   //   });
                            //   // },
                            //   //(String? value) {},
                            //   // return DropdownMenuItem(child:
                            //   //   Text(item["modename"]),
                            //   //   value: item["id"],
                            //   // )
                            //   // }).toList(),
                            // )
                            // TextField(
                            //   style: TextStyle(),
                            //   controller: _note,
                            //   decoration: InputDecoration(
                            //       fillColor: Colors.grey.shade100,
                            //       filled: true,
                            //       hintText: "Payment Mode",
                            //       border: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(10),
                            //       )),
                            // ),

                            // ]),
                            //     CircleAvatar(
                            //       radius: 30,
                            //       backgroundColor: Color(0xff4c505b),
                            //       child: IconButton(
                            //           color: Colors.black,
                            //           onPressed: () {},
                            //           icon: Icon(
                            //             Icons.arrow_forward,
                            //           )),
                            //     )
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: 40,
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     TextButton(
                            //       onPressed: () {
                            //         Navigator.pushNamed(context, 'register');
                            //       },
                            //       child: Text(
                            //         'Sign Up',
                            //         textAlign: TextAlign.left,
                            //         style: TextStyle(
                            //             decoration: TextDecoration.underline,
                            //             color: Color(0xff4c505b),
                            //             fontSize: 18),
                            //       ),
                            //       style: ButtonStyle(),
                            //     ),
                            //     TextButton(
                            //         onPressed: () {},
                            //         child: Text(
                            //           'Forgot Password',
                            //           style: TextStyle(
                            //             decoration: TextDecoration.underline,
                            //             color: Color(0xff4c505b),
                            //             fontSize: 18,
                            //           ),
                            //         )),
                            //   ],
                            // )
                          ],
                        ),
                      ),
                      // Container(child: DailyCollection())
                    ]),
                  ),
                ],
              ),
            ),
          ),
          // ),

          // (pressedRes)
          // Container(
          //   margin: EdgeInsetsDirectional.symmetric(
          //       horizontal: 20.0, vertical: 40.0),
          //   child: FutureBuilder(
          //     future: fetchdata(),
          //     builder: (context, snapshot) {
          //       if (snapshot.hasData) {
          //         results = snapshot.data;
          //         if (snapshot.data.length != 0) {
          //           return Container(
          //             decoration: BoxDecoration(
          //               border: Border.all(color: Colors.grey),
          //             ),
          //             child: DataTable(
          //               headingRowColor: MaterialStateColor.resolveWith(
          //                 (states) => Colors.blue,
          //               ),
          //               columnSpacing: 20,
          //               columns: [
          //                 DataColumn(label: Text('Customer')),
          //                 DataColumn(label: Text('Date')),
          //                 DataColumn(label: Text('Amount')),
          //                 DataColumn(label: Text('Note')),
          //               ],
          //               rows: List.generate(
          //                 results.length,
          //                 (index) => _getDataRow(
          //                   index,
          //                   results[index],
          //                 ),
          //               ),
          //               showBottomBorder: true,
          //             ),
          //           );
          //         } else {
          //           return Row(
          //             children: const <Widget>[
          //               SizedBox(
          //                 // ignore: sort_child_properties_last
          //                 child: CircularProgressIndicator(),
          //                 width: 30,
          //                 height: 30,
          //               ),
          //               Padding(
          //                 padding: EdgeInsets.all(40),
          //                 child: Text('No Data Found...'),
          //               ),
          //             ],
          //           );
          //         }
          //       } else {
          //         return Row(
          //           children: const <Widget>[
          //             SizedBox(
          //               // ignore: sort_child_properties_last
          //               child: CircularProgressIndicator(),
          //               width: 30,
          //               height: 30,
          //             ),
          //             Padding(
          //               padding: EdgeInsets.all(40),
          //               child: Text('No Data Found...'),
          //             ),
          //           ],
          //         );
          //       }
          //     },
          //   ),
          // )
          // : Container(),
          Positioned(
            top: 450,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              // MediaQuery.of(context).size.height * 0.3
              height: MediaQuery.of(context).size.height * 0.35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  // Padding(padding: EdgeInsets.symmetric(vertical: 30.0)),
                  Expanded(
                      // margin: EdgeInsets.symmetric(vertical: 340.0),
                      // height: 200.0,
                      child: (latestnotes.customername != null &&
                              latestnotes.lasttrans!.length > 0)
                          // latestnotes.lasttrans.toString().length > 0)
                          // true
                          ? Column(
                              // mainAxisSize: MainAxisSize.min,
                              // mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                  Row(children: <Widget>[
                                    (latestnotes.customername != null)
                                        ? Expanded(
                                            // flex: 2,
                                            child: Center(
                                                child: GestureDetector(
                                                    // get tap location
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pushNamed('/chiti',
                                                              arguments: [
                                                            latestnotes.id!
                                                          ]);
                                                    },
                                                    child: Text(
                                                        "${latestnotes.customername!} ${latestnotes.haminame!}",
                                                        style: const TextStyle(
                                                          height: 3.0,
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          // ignore: dead_code
                                                        )))))
                                        : const Expanded(child: Text(""))
                                    // Container()
                                  ]),
                                  Row(children: <Widget>[
                                    (latestnotes.customername != null)
                                        ? Expanded(
                                            // flex: 2,
                                            child: Center(
                                                child: Text(
                                                    "Remaining Asalu: ${latestnotes.remainingasalu!}          Remaining Days ${latestnotes.remainingdays!}",
                                                    style: const TextStyle(
                                                      height: 3.0,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      // ignore: dead_code
                                                    ))))
                                        : const Expanded(child: Text(""))
                                    // Container()
                                  ]),
                                  Row(children: const <Widget>[
                                    Expanded(
                                        flex: 1,
                                        child: Text('SNO',
                                            style: TextStyle(
                                                height: 3.0,
                                                fontSize: 15.2,
                                                fontWeight: FontWeight.bold))),
                                    Expanded(
                                        flex: 3,
                                        child: Center(
                                            child: Text('Date',
                                                style: TextStyle(
                                                    height: 3.0,
                                                    fontSize: 15.2,
                                                    fontWeight:
                                                        FontWeight.bold)))),
                                    Expanded(
                                        flex: 3,
                                        child: Text('Amount',
                                            style: TextStyle(
                                              height: 3.0,
                                              fontSize: 15.2,
                                              fontWeight: FontWeight.bold,
                                            ))),
                                    // Expanded(child: Text('Last Name', style:  TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                                    // Expanded(child: Text('Customer Id', style: TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                                    Expanded(
                                        flex: 2,
                                        child: Text('Notes',
                                            style: TextStyle(
                                              height: 3.0,
                                              fontSize: 15.2,
                                              fontWeight: FontWeight.bold,
                                            ))),
                                    // Expanded(child: Text('', style: TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                                  ]),
                                  Expanded(
                                    child: Container(
                                      child: ListView.builder(
                                        itemCount: latestnotes.lasttrans == null
                                            ? 0
                                            : latestnotes.lasttrans?.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          // return row
                                          // var row = data[index];
                                          final user =
                                              latestnotes.lasttrans![index];
                                          final asaluid = user['id'];
                                          final customername =
                                              user['customername'];
                                          final haminame = user['haminame'];
                                          final amount = user['amount'];
                                          final note = user['note'];
                                          var inputFormat =
                                              DateFormat('yyyy-MM-dd');
                                          var date1 =
                                              inputFormat.parse(user['date']);
                                          var outputFormat =
                                              DateFormat('dd/MM/yyyy');
                                          final date =
                                              outputFormat.format(date1);

                                          return InkWell(
                                            // onTap: () {
                                            //   Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) => APIDetailView(data[index])),
                                            //   );
                                            // },

                                            child: GestureDetector(
                                              // get tap location
                                              onTapDown: (details) =>
                                                  _getTapPosition(details),
                                              // show the context menu
                                              onLongPress: () =>
                                                  _showContextMenu(
                                                      context, asaluid),
                                              child: ListTile(
                                                //return new ListTile(
                                                // onTap: () {
                                                //   Navigator.of(context)
                                                //       .pushNamed('/chiti',
                                                //           arguments: [
                                                //         latestnotes.id!
                                                //       ]);
                                                // },

                                                // leading: CircleAvatar(
                                                //   backgroundColor: Colors.blue,
                                                //   child: Text((index + 1).toString()),
                                                // ),
                                                title: Row(children: <Widget>[
                                                  Expanded(
                                                      flex: 1,
                                                      child: Text((index + 1)
                                                          .toString())),
                                                  Expanded(
                                                      flex: 3,
                                                      child: Text(date)),
                                                  Expanded(
                                                      flex: 3,
                                                      child: Text(
                                                          amount.toString())),
                                                  Expanded(
                                                      flex: 2,
                                                      child: Text(note)),
                                                  // Expanded(child: Text(users[index]["PhoneNo"])),
                                                  // Expanded(child: Text(users[index]["Customer_Id"])),
                                                ]),
                                                // tileColor: color,
                                              ),
                                            ),
                                          );
                                        }, //itemBuilder
                                      ),
                                    ),
                                  ),
                                ]
                              // ),
                              // )
                              )
                          : Container(
                              padding: EdgeInsets.all(10),
                              child: Center(
                                child: GestureDetector(
                                    // get tap location
                                    onTap: () {
                                      Navigator.of(context).pushNamed('/chiti',
                                          arguments: [latestnotes.id!]);
                                    },
                                    child: Text(
                                      errmsg,
                                      style: TextStyle(fontSize: 20),
                                    )),
                              ),
                            ))
                ],
              ),
            ),
          ),
          // Positioned(
          //     top: 740,
          //     left: 50,
          //     child: ElevatedButton(
          //         onPressed: () {
          //           toast.success("Hello!");
          // Fluttertoast.showToast(
          //   msg: "THE toast message",
          //   //${createasaluStatus["message"]}",
          //   toastLength: Toast.LENGTH_SHORT,
          //   gravity: ToastGravity.BOTTOM,
          //   timeInSecForIosWeb: 2,
          //   backgroundColor: Colors.black,
          //   textColor: Color.fromARGB(255, 221, 11, 11),
          //   fontSize: 16.0,
          // );
          // },
          // child: Text("Press here"))
          // (createasaluStatus != null)
          //     ? Container(
          //         child: Center(
          //           child: Text(createasaluStatus.message),
          //         ),
          //       )
          //     : Container(
          //         // child: Text("Hi"),
          //         )
          // )
        ]),
        extendBody: true,
        floatingActionButton: FloatingActionButton(
            heroTag: "btn7",
            child: const Icon(Icons.done),
            onPressed: () async {
              createasalu();
              // await BaseClient()
              //     .post('/asaludemo', asalu)
              //     .catchError((err) {
              //   AlertDialog(actions: [
              //     Title(color: Colors.black, child: Text('Error Dynamic')),
              //   ]);
              //   asalu["date"] = _dateInput.text
              // });
            }));

    // () async => {
    // setState(() {
    //   pressedRes = true;
    // }),
    // AsyncSnapshot.waiting(),
    // await fetchdata()
    // .then((value) => setState(() {
    //       pressedRes = false;
    //     })),
    // }));

    // ChangeNotifierProvider<MyHomePageProvider>(
    //   create: (context) => MyHomePageProvider(),
    //   // child: Consumer <MyHomePageProvider>{
    //   //       Builder : (context,provider,child)
    //   //     }
    // ));
  }
}

// class _JsonDataGridSource extends DataGridSource {
//   _JsonDataGridSource(this.lastdetails) {
//     buildDataGridRow();
//   }

//   late _JsonDataGridSource jsonDataGridSource;
//   List<DataGridRow> dataGridRows = [];
//   List<dynamic> lastdetails = [];
//   void buildDataGridRow() {
//     dataGridRows = lastdetails.map<DataGridRow>((dataGridRow) {
//       return DataGridRow(cells: [
//         DataGridCell<String>(
//             columnName: 'customer',
//             value: dataGridRow["customername"].toString()),
//         DataGridCell<String>(columnName: 'date', value: dataGridRow["date"]),
//         DataGridCell<int>(columnName: 'amount', value: dataGridRow["amount"]),
//         DataGridCell<String>(columnName: 'note', value: dataGridRow["note"]),
// //  DataGridCell<double>(columnName: 'freight', value: dataGridRow.freight),
//       ]);
//     }).toList(growable: false);
//   }

//   @override
//   List<DataGridRow> get rows => dataGridRows;

//   @override
//   DataGridRowAdapter buildRow(DataGridRow row) {
//     return DataGridRowAdapter(cells: [
//       Container(
//         alignment: Alignment.centerRight,
//         padding: EdgeInsets.all(8.0),
//         child: Text(
//           row.getCells()[0].value.toString(),
//           overflow: TextOverflow.ellipsis,
//         ),
//       ),
//       Container(
//         alignment: Alignment.centerRight,
//         padding: EdgeInsets.all(8.0),
//         child: Text(
//           DateFormat('MM/dd/yyyy').format(row.getCells()[3].value).toString(),
//           overflow: TextOverflow.ellipsis,
//         ),
//       ),
//       Container(
//         alignment: Alignment.centerLeft,
//         padding: EdgeInsets.all(8.0),
//         child: Text(
//           row.getCells()[1].value,
//           overflow: TextOverflow.ellipsis,
//         ),
//       ),
//       Container(
//         alignment: Alignment.centerRight,
//         padding: EdgeInsets.all(8.0),
//         child: Text(
//           row.getCells()[2].value.toString(),
//           overflow: TextOverflow.ellipsis,
//         ),
//       ),

//       // Container(
//       //   alignment: Alignment.centerRight,
//       //   padding: EdgeInsets.all(8.0),
//       //   child: Text(
//       //     row.getCells()[4].value.toString(),
//       //     overflow: TextOverflow.ellipsis,
//       //   ),
//       // ),
//     ]);
//   }
// }
