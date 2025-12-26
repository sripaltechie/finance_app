import 'package:chanda_finance/model/paymentmodeModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/response/status.dart';
import '../res/components/tableWidget.dart';
import '../res/components/widget/scrollable_widget.dart';
import '../utils/routes_name.dart';
import '../view_model/last_payments_view_model.dart';

class LastPaymentsView extends StatefulWidget {
  const LastPaymentsView({super.key});

  @override
  State<LastPaymentsView> createState() => _LastPaymentsViewState();
}

class _LastPaymentsViewState extends State<LastPaymentsView> {
  LastPaymentsViewModel lastPaymentsViewModel = LastPaymentsViewModel();
  List<String> paymentColumns = [
    "Days",
    "Customer",
    "Hami",
    "Rcvd Date",
    "Amount",
    "Notes",
    "Mode",
  ];

  List paymentRows = [
    "days",
    "customername",
    "haminame",
    "rcvddate",
    "amount",
    "note",
    "paymentmode",
  ];

  dynamic tableCons = {
    "rowColor": [
      {
        "param": "days",
        "op": ">",
        "value": "100",
        "color": Colors.red,
      },
      {
        "param": "days",
        "op": "between",
        "value1": "51",
        "value2": "100",
        "color": Colors.orange,
      },
      {
        "param": "days",
        "op": "between",
        "value1": "5",
        "value2": "50",
        "color": Colors.blue,
      },
      {
        "param": "days",
        "op": "<",
        "value": "5",
        "color": Colors.green,
      },
    ],
    "paymentmodeList": <PaymentmodeModel>[],
    "ontap": RoutesName.chiti,

    // "headingColor": Colors.blueGrey,
    // "contextMenu": [
    //   {"value": "received", "child": "Received"},
    //   {"value": "editinterest", "child": "Edit"}
    // ]
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lastPaymentsViewModel.fetchLastPaymentsListApi();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LastPaymentsViewModel>(
      create: (BuildContext context) => lastPaymentsViewModel,
      child: Consumer<LastPaymentsViewModel>(builder: (context, value, _) {
        switch (value.lastPaymentsList.status!) {
          case Status.LOADING:
            // TODO: Handle this case.
            return const Center(child: CircularProgressIndicator());
          case Status.ERROR:
            // TODO: Handle this case.
            return Center(
                child: Text(value.lastPaymentsList.message.toString()));
          case Status.COMPLETED:
            List<dynamic> rawData = [];

            for (var e in value.lastPaymentsList.data!.lastpayments!) {
              Map tmp = {
                "chiti": e.chiti,
                "days": e.days,
                "customername": "${e.customername} (${e.chiti})",
                "haminame": e.haminame,
                "rcvddate": e.rcvddate,
                "amount": e.amount,
                "note": e.note,
                "paymentmode": e.paymentmode,
                // "action":e.action,
              };
              rawData.add(tmp);
            }

            return Scaffold(
                appBar: AppBar(
                  title: Text("Last Payments"),
                  centerTitle: true,
                ),
                body: ScrollableWidget(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            child: Text("  100+"),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            color: Colors.orange,
                          ),
                          const SizedBox(
                            child: Text("  51-100"),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            color: Colors.blue,
                          ),
                          const SizedBox(
                            child: Text("  5-50"),
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
                            child: Text("  1-4"),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        TableWidget(
                            columns: paymentColumns,
                            rows: paymentRows,
                            rowData: rawData,
                            tableCons: tableCons),
                      ],
                    ),
                  ],
                )));
        }
      }),
    );
  }
}
