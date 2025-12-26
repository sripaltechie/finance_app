import 'dart:convert';

import 'package:chanda_finance/data/response/status.dart';
import 'package:chanda_finance/res/color.dart';
import 'package:chanda_finance/res/components/tableWidget.dart';
import 'package:chanda_finance/view_model/daybook_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../utils/routes_name.dart';
import '../utils/utils.dart';

class DaybookView extends StatefulWidget {
  const DaybookView({super.key});

  @override
  State<DaybookView> createState() => _DaybookViewState();
}

class _DaybookViewState extends State<DaybookView> {
  DaybookViewModel daybookViewModel = DaybookViewModel();
  final _dateController = TextEditingController();
  ScrollController scrollController = ScrollController();

  bool isPressed = false;
  bool isDown = false;
  final GlobalKey _key = GlobalKey();

  final ScrollController _verticalScrollController = ScrollController();
  final ScrollController _horizontalScrollController = ScrollController();

  void dispose() {
    _verticalScrollController.dispose();
    _horizontalScrollController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void getDaybook() {
    isPressed = true;
    if (_dateController.text.contains(' ')) {
      _dateController.text = (_dateController.text.split(' '))[0];
      _dateController.text = Utils.userFormat(_dateController.text);
    }
    daybookViewModel
        .getDaybook({"date": Utils.sqlFormat(_dateController.text)}, context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    getDaybook();
  }

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double appBarHeight = kToolbarHeight;
    final double bottomNavigationBarHeight = kBottomNavigationBarHeight;
    final double height =
        screenHeight - appBarHeight - bottomNavigationBarHeight;

    return Scaffold(
      appBar: AppBar(
        title: Text("Daybook"),
        centerTitle: true,
      ),
      body: SizedBox(
        height: height,
        width: width * 5,
        child:
            // LayoutBuilder(
            //     builder: (BuildContext context, BoxConstraints constraints) {
            //   final availableHeight = constraints.maxHeight;
            //   final availableWidth = constraints.maxWidth;
            //   return
            Column(
          children: [
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: height * 0.09,
              child: Row(children: [
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
                          getDaybook();
                        });
                      } else {
                        setState(() {
                          _dateController.text =
                              DateFormat('dd/MM/yyyy').format(DateTime.now());
                          getDaybook();
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
                        getDaybook();
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

                        getDaybook();
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

                        getDaybook();
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

                      getDaybook();
                    },
                    child: const Text("3"),
                  ),
                ),
              ]),
            ),

            Row(children: [
              Container(
                child: ChangeNotifierProvider<DaybookViewModel>(
                  create: (BuildContext context) => daybookViewModel,
                  child: Consumer<DaybookViewModel>(
                    builder: (context, value, _) {
                      if (_dateController.text.isNotEmpty && isPressed) {
                        switch (value.daybook.status!) {
                          case Status.LOADING:
                            return SizedBox(
                                width: width * 0.95,
                                height: height * 0.5,
                                child: Center(
                                    child: const CircularProgressIndicator()));

                          case Status.ERROR:
                            return Container(
                                child: Text(value.daybook.message.toString()));

                          case Status.COMPLETED:
                            return SizedBox(
                              width: width * 1,
                              // height: height * 0.90,
                              child:
                                  // SingleChildScrollView(
                                  //   scrollDirection: Axis.vertical,
                                  //   child:
                                  Column(children: [
                                SizedBox(
                                  height: height * 0.89,
                                  child: Scrollbar(
                                    controller: scrollController,
                                    thumbVisibility: true,
                                    child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          // SingleChildScrollView(
                                          //   scrollDirection: Axis.horizontal,
                                          //   child:

                                          Container(
                                            // width: width * 2,
                                            // color: Colors.blue,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: SingleChildScrollView(
                                                  controller: scrollController,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        child: Row(children: [
                                                          Container(
                                                            width: width * 0.95,
                                                            height: 100,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .grey[300],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: Center(
                                                              child: RichText(
                                                                text: TextSpan(
                                                                  children: [
                                                                    for (int i =
                                                                            0;
                                                                        i <
                                                                            value
                                                                                .daybook.data!.opbal!.length;
                                                                        i++)
                                                                      (int.parse(value.daybook.data!.opbal![i].amt.toString()) >
                                                                              0)
                                                                          ? TextSpan(
                                                                              text: " ${value.daybook.data!.opbal![i].name} : ${value.daybook.data!.opbal![i].amt} ",
                                                                              style: TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 16,
                                                                                color: Colors.black,
                                                                              ),
                                                                            )
                                                                          : TextSpan(
                                                                              text: ""),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ]),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: width,
                                                            child: Center(
                                                              child: Text(
                                                                "Creditors",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headlineMedium,
                                                              ),
                                                            ),
                                                          ),
                                                          (value
                                                                  .daybook
                                                                  .data!
                                                                  .debitors!
                                                                  .customers!
                                                                  .isNotEmpty)
                                                              ? Container(
                                                                  width: width,
                                                                  child: Center(
                                                                      child: Text(
                                                                          "Debitors",
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .headlineMedium)),
                                                                )
                                                              : Container()
                                                        ],
                                                      ),
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: value
                                                                    .daybook
                                                                    .data!
                                                                    .creditors!
                                                                    .customers!
                                                                    .map(
                                                                      (item) =>
                                                                          Column(
                                                                              children: [
                                                                            // Padding(padding: EdgeInsets.all(10)),
                                                                            SingleChildScrollView(
                                                                              scrollDirection: Axis.horizontal,
                                                                              child: Container(
                                                                                decoration: BoxDecoration(
                                                                                  border: Border.all(
                                                                                    color: Colors.white,
                                                                                    width: 2.0,
                                                                                  ),
                                                                                ),
                                                                                child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                                  Container(
                                                                                    color: AppColors.whiteColor,
                                                                                    width: width,
                                                                                    child: Center(
                                                                                      child: RichText(
                                                                                        text: TextSpan(children: [
                                                                                          TextSpan(
                                                                                            text: "${item.firstname.toString()} ${item.lastname.toString()} ",
                                                                                            style: TextStyle(color: AppColors.blackColor, fontWeight: FontWeight.bold, fontSize: 25),
                                                                                          ),
                                                                                          (item.hamifirstname != null)
                                                                                              ? TextSpan(
                                                                                                  text: "(${item.hamifirstname.toString()})",
                                                                                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                                                                                                )
                                                                                              : TextSpan(text: ""),
                                                                                          // Text(
                                                                                          // (${item.hamifirstname.toString()} ) ",
                                                                                          // style: TextStyle( color: Colors.red, fontWeight: FontWeight.bold, fontSize: 25),
                                                                                          // textAlign: TextAlign.center,
                                                                                        ]),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  (item.disp!.rcvdamt! ==
                                                                                          1)
                                                                                      ? TableWidget(
                                                                                          columns: [
                                                                                            "Chiti",
                                                                                            "Amount",
                                                                                            "Paymentmode",
                                                                                            "Note"
                                                                                          ],
                                                                                          rows: [
                                                                                            "chiti",
                                                                                            "amount",
                                                                                            "paymentmode",
                                                                                            "note"
                                                                                          ],
                                                                                          rowData: jsonDecode(jsonEncode(item.rcvdamtlist!.map((e) => e.toJson()).toList())),
                                                                                          tableCons: {
                                                                                            "ontap": RoutesName.chiti,
                                                                                            "bgcolor": Color.fromARGB(255, 3, 121, 157),
                                                                                            "headingColor": Color.fromARGB(255, 143, 228, 253),
                                                                                            "headingTextColor": AppColors.blackColor
                                                                                          })
                                                                                      : Container(),
                                                                                  (item.disp!.ccomm! == 1)
                                                                                      ? Column(children: [
                                                                                          Text("CCOMM"),
                                                                                          TableWidget(
                                                                                              columns: [
                                                                                                "Chiti",
                                                                                                "Amount",
                                                                                                "Paymentmode",
                                                                                                "Note"
                                                                                              ],
                                                                                              rows: [
                                                                                                "id",
                                                                                                "amount",
                                                                                                "ccommpaymentmode",
                                                                                                "note"
                                                                                              ],
                                                                                              rowData: jsonDecode(jsonEncode(item.ccommlist!.map((e) => e.toJson()).toList())),
                                                                                              tableCons: {
                                                                                                "ontap": RoutesName.chiti,
                                                                                                "bgcolor": Color.fromARGB(255, 3, 121, 157),
                                                                                                "headingColor": Color.fromARGB(255, 143, 228, 253),
                                                                                                "headingTextColor": AppColors.blackColor
                                                                                              })
                                                                                        ])
                                                                                      : Container(),
                                                                                  (item.disp!.drcr! == 1)
                                                                                      ? Column(children: [
                                                                                          Text(
                                                                                            "Receipts",
                                                                                            style: TextStyle(color: Colors.red),
                                                                                          ),
                                                                                          TableWidget(
                                                                                              columns: [
                                                                                                "Id",
                                                                                                "Amount",
                                                                                                "Paymentmode",
                                                                                                "Note"
                                                                                              ],
                                                                                              rows: [
                                                                                                "id",
                                                                                                "amount",
                                                                                                "ccommpaymentmode",
                                                                                                "note"
                                                                                              ],
                                                                                              rowData: jsonDecode(jsonEncode(item.drcrlist!.map((e) => e.toJson()).toList())),
                                                                                              tableCons: {
                                                                                                "ontap": RoutesName.chiti,
                                                                                                "bgcolor": Color.fromARGB(255, 3, 121, 157),
                                                                                                "headingColor": Color.fromARGB(255, 143, 228, 253),
                                                                                                "headingTextColor": AppColors.blackColor
                                                                                              })
                                                                                        ])
                                                                                      : Container(),
                                                                                  (item.disp!.cftrans! == 1)
                                                                                      ? Column(children: [
                                                                                          Text("Chit Fund"),
                                                                                          TableWidget(
                                                                                              columns: [
                                                                                                "Id",
                                                                                                "Amount",
                                                                                                "Paymentmode",
                                                                                                "Note"
                                                                                              ],
                                                                                              rows: [
                                                                                                "id",
                                                                                                "amount",
                                                                                                "ccommpaymentmode",
                                                                                                "note"
                                                                                              ],
                                                                                              rowData: jsonDecode(jsonEncode(item.cftranslist!.map((e) => e.toJson()).toList())),
                                                                                              tableCons: {
                                                                                                "bgcolor": Color.fromARGB(255, 3, 121, 157),
                                                                                                "headingColor": Color.fromARGB(255, 143, 228, 253),
                                                                                                "headingTextColor": AppColors.blackColor
                                                                                              })
                                                                                        ])
                                                                                      : Container(),
                                                                                  SizedBox(
                                                                                    height: 10,
                                                                                  )
                                                                                ]),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                          ]),
                                                                    )
                                                                    .toList(),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            //Debitors section
                                                            SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: value
                                                                    .daybook
                                                                    .data!
                                                                    .debitors!
                                                                    .customers!
                                                                    .map(
                                                                      (item) =>
                                                                          Column(
                                                                              children: [
                                                                            SingleChildScrollView(
                                                                              scrollDirection: Axis.horizontal,
                                                                              child: Container(
                                                                                decoration: BoxDecoration(
                                                                                  border: Border.all(
                                                                                    color: Colors.white,
                                                                                    width: 2.0,
                                                                                  ),
                                                                                ),
                                                                                child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                                  Container(
                                                                                    color: AppColors.whiteColor,
                                                                                    width: width,
                                                                                    child: Center(
                                                                                      child: RichText(
                                                                                        text: TextSpan(children: [
                                                                                          TextSpan(
                                                                                            text: "${item.firstname.toString()} ${item.lastname.toString()} ",
                                                                                            style: TextStyle(color: AppColors.blackColor, fontWeight: FontWeight.bold, fontSize: 25),
                                                                                          ),
                                                                                          (item.hamifirstname != null)
                                                                                              ? TextSpan(
                                                                                                  text: "(${item.hamifirstname.toString()})",
                                                                                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                                                                                                )
                                                                                              : TextSpan(text: ""),
                                                                                          // Text(
                                                                                          // (${item.hamifirstname.toString()} ) ",
                                                                                          // style: TextStyle( color: Colors.red, fontWeight: FontWeight.bold, fontSize: 25),
                                                                                          // textAlign: TextAlign.center,
                                                                                        ]),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  (item.disp!.chiti! ==
                                                                                          1)
                                                                                      ? TableWidget(
                                                                                          columns: [
                                                                                            "Chiti",
                                                                                            "Amount",
                                                                                            "Paymentmode",
                                                                                            "Note"
                                                                                          ],
                                                                                          rows: [
                                                                                            "id",
                                                                                            "amount",
                                                                                            "paymentmode",
                                                                                            "note"
                                                                                          ],
                                                                                          rowData: jsonDecode(jsonEncode(item.chitilist!.map((e) => e.toJson()).toList())),
                                                                                          tableCons: {
                                                                                            "bgcolor": Color.fromARGB(255, 3, 121, 157),
                                                                                            "headingColor": Color.fromARGB(255, 143, 228, 253),
                                                                                            "headingTextColor": AppColors.blackColor
                                                                                          })
                                                                                      : Container(),
                                                                                  (item.disp!.drcr! == 1)
                                                                                      ? Column(children: [
                                                                                          TableWidget(
                                                                                              columns: [
                                                                                                "Amount",
                                                                                                "For Int",
                                                                                                "Paymentmode",
                                                                                                "Note"
                                                                                              ],
                                                                                              rows: [
                                                                                                "debit",
                                                                                                "forint",
                                                                                                "paymentmode",
                                                                                                "note"
                                                                                              ],
                                                                                              rowData: jsonDecode(jsonEncode(item.drcrlist!.map((e) => e.toJson()).toList())),
                                                                                              tableCons: {
                                                                                                "ontap": RoutesName.chiti,
                                                                                                "bgcolor": Color.fromARGB(255, 3, 121, 157),
                                                                                                "headingColor": Color.fromARGB(255, 143, 228, 253),
                                                                                                "headingTextColor": AppColors.blackColor
                                                                                              })
                                                                                        ])
                                                                                      : Container(),
                                                                                  SizedBox(
                                                                                    height: 10,
                                                                                  )
                                                                                ]),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 10,
                                                                            )
                                                                          ]),
                                                                    )
                                                                    .toList(),
                                                              ),
                                                            ),
                                                            // SingleChildScrollView(
                                                            //   scrollDirection:
                                                            //       Axis.vertical,
                                                            //   child: Column(
                                                            //     children:
                                                            //         value
                                                            //             .daybook
                                                            //             .data!
                                                            //             .creditors!
                                                            //             .customers!
                                                            //             .map(
                                                            //               (item) =>
                                                            //                   SingleChildScrollView(
                                                            //                 scrollDirection:
                                                            //                     Axis.horizontal,
                                                            //                 child:
                                                            //                     Container(
                                                            //                   margin: const EdgeInsets
                                                            //                           .all(
                                                            //                       8.0),
                                                            //                   padding: const EdgeInsets
                                                            //                           .all(
                                                            //                       16.0),
                                                            //                   decoration:
                                                            //                       BoxDecoration(
                                                            //                     color: Colors
                                                            //                             .grey[
                                                            //                         200],
                                                            //                     borderRadius:
                                                            //                         BorderRadius.circular(
                                                            //                             10),
                                                            //                   ),
                                                            //                   child: Text(
                                                            //                     item.firstname
                                                            //                         .toString(),
                                                            //                     style: TextStyle(
                                                            //                         fontSize:
                                                            //                             18),
                                                            //                   ),
                                                            //                 ),
                                                            //               ),
                                                            //             )
                                                            //             .toList(),
                                                            //   ),
                                                            // ),
                                                          ]),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        child: Row(children: [
                                                          Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            width: width * 0.95,
                                                            height: 100,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .grey[300],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: Center(
                                                              child: RichText(
                                                                text: TextSpan(
                                                                  children: [
                                                                    for (int i =
                                                                            0;
                                                                        i <
                                                                            value
                                                                                .daybook.data!.transttl!.length;
                                                                        i++)
                                                                      (int.parse(value.daybook.data!.transttl![i].amt.toString()) >
                                                                              0)
                                                                          ? TextSpan(
                                                                              text: " ${value.daybook.data!.transttl![i].name} : ${value.daybook.data!.transttl![i].amt} ",
                                                                              style: TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 16,
                                                                                color: Colors.black,
                                                                              ),
                                                                            )
                                                                          : TextSpan(
                                                                              text: ""),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ]),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        child: Row(children: [
                                                          Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            width: width * 0.95,
                                                            height: 100,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .grey[300],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: Center(
                                                              child: RichText(
                                                                text: TextSpan(
                                                                  children: [
                                                                    for (int i =
                                                                            0;
                                                                        i <
                                                                            value
                                                                                .daybook.data!.closingbal!.length;
                                                                        i++)
                                                                      (int.parse(value.daybook.data!.closingbal![i].amt.toString()) >
                                                                              0)
                                                                          ? TextSpan(
                                                                              text: " ${value.daybook.data!.closingbal![i].name} : ${value.daybook.data!.closingbal![i].amt} ",
                                                                              style: TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 16,
                                                                                color: Colors.black,
                                                                              ),
                                                                            )
                                                                          : TextSpan(
                                                                              text: ""),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ]),
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                          ),
                                          // ),
                                          // ),
                                        ]),
                                  ),
                                ),
                              ]),
                              // ),
                            );
                        }
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ),
            ]),
            // ),
          ],
        ),
      ),

      // }),
      floatingActionButton: FloatingActionButton(
        child: Icon((isDown) ? Icons.arrow_upward : Icons.arrow_downward),
        onPressed: () {
          if (isDown) {
            scrollController.animateTo(0,
                duration: Duration(seconds: 1), curve: Curves.easeIn);
            setState(() {
              isDown = !isDown;
            });
          } else {
            scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                // 20000,
                duration: Duration(seconds: 1),
                curve: Curves.easeIn);
            setState(() {
              isDown = !isDown;
            });
          }
        },
        backgroundColor: AppColors.ThemeBlue,
        splashColor: AppColors.whiteColor,
      ),
    );
  }
}
