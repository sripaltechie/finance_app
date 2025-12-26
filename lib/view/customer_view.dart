import 'package:chanda_finance/res/components/round_button.dart';
import 'package:chanda_finance/res/components/tableWidget.dart';
import 'package:chanda_finance/utils/routes_name.dart';
import 'package:chanda_finance/view_model/chiti_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';

class CustomerView extends StatefulWidget {
  final int id;
  final String? customername;
  const CustomerView({super.key, required this.id, this.customername});

  @override
  State<CustomerView> createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {
  int id = 0;
  ChitiViewModel chitiViewModel = ChitiViewModel();
  late String _customerName;
  bool _showPending = true;
  List<String> chitiColumns = [
    "SNo",
    "Code",
    "Date",
    "Type",
    "Amount",
    "Per Month",
    "Interest Rate",
    "Note"
  ];
  List<String> chitiRows = [
    "sno",
    "code",
    "date",
    "tYpe",
    "chitiamount",
    "pdwtm",
    "interestrate",
    "note"
  ];

  void getChitiList() {
    chitiViewModel.fetchChitiList({"customer": id.toString()});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (int.parse(widget.id.toString()) > 0) {
      id = widget.id;
      getChitiList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChitiViewModel>(
      create: (BuildContext context) => chitiViewModel,
      child: Consumer<ChitiViewModel>(
        builder: (context, value, _) {
          switch (value.chitiList.status!) {
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());
            case Status.ERROR:
              // TODO: Handle this case.
              return Center(child: Text(value.chitiList.message.toString()));
            case Status.COMPLETED:
              // TODO: Handle this case.
              List<dynamic> rawData = [];
              _customerName = (widget.customername != null)
                  ? widget.customername.toString()
                  : (value.chitiList.data!.isNotEmpty)
                      ? value.chitiList.data![0].customername.toString()
                      : "blank_Customer";
              for (var e in value.chitiList.data!) {
                if (!_showPending || _showPending && e.status != 2) {
                  Map tmp = {
                    "id": e.id,
                    "chiti": e.id, //for ontap
                    "code": e.code,
                    "chitiamount": e.chitiamount,
                    "tYpe": e.tYpe,
                    "date": e.date,
                    "pdwtm": e.pdwtm,
                    "note": e.note,
                    "status": e.status,
                    "interestrate": e.interestrate,
                    "paymentmode": e.paymentmode,
                    "paymentmodename": e.paymentmodename,
                    // "backPage": RoutesName.dailycollection
                  };
                  rawData.add(tmp);
                }
                // }
              }

              // if (value.chitiList.data!.isNotEmpty) {
              return Scaffold(
                // drawer: NavBar(),
                appBar: AppBar(
                    title: Center(child: Text("$_customerName ")
                        //Text("${value.chitiList.data![0].customername} ")
                        )),
                body: Column(children: [
                  SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          child: Text("  Cleared"),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          color: Colors.green,
                        ),
                        const SizedBox(
                          child: Text("  Pending"),
                        ),
                        const SizedBox(
                          width: 60,
                        ),
                        SizedBox(
                          width: 100,
                          child: RoundButton(
                              title:
                                  (_showPending) ? "Show All" : "Only Pending",
                              onPress: () {
                                setState(() {
                                  _showPending = !_showPending;
                                });
                              }),
                        ),
                      ],
                    ),
                  ),
                  (rawData.isNotEmpty)
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: TableWidget(
                              columns: chitiColumns,
                              rows: chitiRows,
                              rowData: rawData,
                              tableCons: const {
                                // "headingColor": Colors.lightBlue,
                                "ontap": RoutesName.chiti,
                                "rowColor": [
                                  {
                                    "param": "status",
                                    "op": "=",
                                    "value": "2",
                                    "yes": Colors.red,
                                    "no": Colors.green
                                  }
                                ]
                              }),
                        )
                      : Container(
                          height: 200,
                          color: Colors.blue[200],
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Center(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                        text:
                                            "No Chiti's Found For Customer\n"),
                                    TextSpan(
                                      text: _customerName.toString(),
                                    ),
                                  ],
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                            ),
                          ),
                        ),
                ]),
              );
            // } else {
            //   return Container(
            //       color: Colors.lightBlue,
            //       child: Center(
            //           child: Text(
            //         "No Chiti Pending For This Customer",
            //         style: Theme.of(context).textTheme.headlineMedium,
            //       )));
            // }
          }
        },
      ),
    );
  }
}
