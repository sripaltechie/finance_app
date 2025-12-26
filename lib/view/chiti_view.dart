import 'dart:convert';
import 'package:chanda_finance/data/response/status.dart';
import 'package:chanda_finance/model/chitiModel.dart';
import 'package:chanda_finance/utils/routes_name.dart';
import 'package:chanda_finance/view_model/chiti_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../res/components/blue_container.dart';
import '../res/components/tableWidget.dart';
import '../res/components/widget/scrollable_widget.dart';
import '../utils/utils.dart';
import '../view_model/asalu_view_model.dart';
import '../view_model/collection_view_model.dart';

class ChitiView extends StatefulWidget {
  final chitiId;
  const ChitiView({super.key, required this.chitiId});

  @override
  State<ChitiView> createState() => _ChitiViewState();
}

class _ChitiViewState extends State<ChitiView> {
  ChitiViewModel chitiViewModel = ChitiViewModel();
  CollectionViewModel collectionViewModel = CollectionViewModel();
  AsaluViewModel asaluViewModel = AsaluViewModel();
  int chitiId = 0;
  String? lastDate;
  Offset _tapPosition = Offset.zero;

  // List contextMenuList = [
  //   {"value": "received", "child": "Received"},
  //   {"value": "editinterest", "child": "Edit"}
  // ];
  List asaluRows = ["sno", "date", "amount", "note", "paymentmode", "action"];

  List<String> asaluColumns = [
    "SNO",
    "Date",
    "Amount",
    "Notes",
    "Mode",
    "Action"
  ];

  List collRows = [
    "sno",
    "date",
    "amount",
    "received",
    "rcvddate",
    "notes",
    "paymentmode",
  ];

  List<String> collColumns = [
    "SNO",
    "Date",
    "Amount",
    "Received",
    "Rcvddate",
    "Note",
    "Mode",
  ];

  Object collTableCons = {
    "rowColor": [
      {
        "param": "received",
        "op": "=",
        "value": "1",
        "yes": Colors.green,
        "no": Colors.red
      }
    ],
    "contextmenupage": "chitidart",
    "contextMenu": [
      {"value": "received", "child": "Received"},
      {"value": "editinterest", "child": "Edit"}
    ]
  };

  void updateChiti(ChitiModel value, context) {
    value.irregular = value.irregular == 0 ? 1 : 0;

    var tmp = {
      "id": value.id.toString(),
      "customer": value.customer.toString(),
      "code": value.code.toString(),
      "date": value.date.toString(),
      "tYpe": value.tYpe.toString(),
      "advintmonths": value.advintmonths.toString(),
      "iscountable": value.iscountable.toString(),
      "chitiamount": value.chitiamount.toString(),
      "paymentmode": value.paymentmode.toString(),
      "pmid": value.pmid.toString(),
      "pdwtm": value.pdwtm.toString(),
      "interestrate": value.interestrate.toString(),
      "ccomm": value.ccomm.toString(),
      "ccommpaymentmode": value.ccommpaymentmode.toString(),
      "suriccomm": value.suriccomm.toString(),
      "sowji": value.sowji.toString(),
      "suri": value.suri.toString(),
      "fullandevi": value.fullandevi.toString(),
      "reverse": value.reverse.toString(),
      "revcash": value.revcash.toString(),
      "status": value.status.toString(),
      "note": value.note.toString(),
      "irregular": value.irregular.toString(),
    };
    chitiViewModel.updateChiti(tmp["id"], jsonEncode(tmp), context);
  }

  void _getTapPosition(TapDownDetails details) {
    // Offset _tapPosition = Offset.zero;
    // final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      // _tapPosition = referenceBox.globalToLocal(details.globalPosition);
      _tapPosition = details.globalPosition;
    });
  }

  void refreshPage() {
    Navigator.popAndPushNamed(context, RoutesName.chiti,
        arguments: [widget.chitiId]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chitiId = (widget.chitiId > 0) ? widget.chitiId : 0;
    // ChitiViewModel chitiViewModel = ChitiViewModel();
    chitiViewModel.fetchSingleChiti(chitiId);
    collectionViewModel.fetchCollectionsList({"chiti": chitiId.toString()});
    asaluViewModel.fetchAsaluListApi({"chiti": chitiId.toString()});
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    return ChangeNotifierProvider<ChitiViewModel>(
      create: (BuildContext context) => chitiViewModel,
      child: Consumer<ChitiViewModel>(builder: (context, value, _) {
        switch (value.chiti.status!) {
          case Status.LOADING:
            return const Center(child: CircularProgressIndicator());

          case Status.ERROR:
            // TODO: Handle this case.
            return Center(child: Text(value.chiti.message!.toString()));
          case Status.COMPLETED:
            // TODO: Handle this case.

            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text((chitiViewModel.chiti.data != null)
                    ? (int.parse(chitiViewModel.chiti.data!.hami!.toString()) >
                            0)
                        ? "${chitiViewModel.chiti.data!.customername!.toString()}(${chitiViewModel.chiti.data!.haminame!.toString()})"
                        : chitiViewModel.chiti.data!.customername!.toString()
                    : ""),
                actions: [
                  InkWell(
                    onTap: () {
                      refreshPage();
                    },
                    child: Icon(Icons.refresh_outlined),
                  ),
                  SizedBox(width: 15.0),
                ],
              ),
              body: SizedBox(
                width: width * 1.5,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              BlueContainer(
                                textMsg:
                                    "ID: ${value.chiti.data!.id.toString()}",
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              BlueContainer(
                                  textMsg:
                                      "Date : ${Utils.userFormat(value.chiti.data!.date.toString())}"),
                              const SizedBox(
                                width: 5,
                              ),
                              BlueContainer(
                                  textMsg:
                                      "Amount: ${value.chiti.data!.chitiamount.toString()}"),
                              const SizedBox(
                                width: 5,
                              ),
                              BlueContainer(
                                  textMsg: (int.parse(value
                                              .chiti.data!.ccommpaymentmode!
                                              .toString()) >
                                          0)
                                      ? "CCOMM: ${value.chiti.data!.ccomm.toString()}(${value.chiti.data!.ccommpaymentmodename.toString()})"
                                      : "CCOMM: ${value.chiti.data!.ccomm.toString()}"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              BlueContainer(
                                  textMsg:
                                      "Remaining Asalu: ${value.chiti.data!.remainingasalu.toString()}"),
                              const SizedBox(
                                width: 5,
                              ),
                              BlueContainer(
                                  textMsg:
                                      "Int Rate: ${value.chiti.data!.interestrate.toString()}%"),
                              const SizedBox(
                                width: 5,
                              ),
                              BlueContainer(
                                  textMsg:
                                      "Adv Int : ${value.chiti.data!.advintmonths.toString()}"),
                              const SizedBox(
                                width: 5,
                              ),
                              BlueContainer(
                                  textMsg:
                                      "Paymentmode : ${value.chiti.data!.paymentmodename.toString()}"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              BlueContainer(
                                  textMsg:
                                      "Note : ${value.chiti.data!.note.toString()}"),
                              const SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                  onTapDown: (details) =>
                                      _getTapPosition(details),
                                  onLongPress: () async {
                                    String result = await Utils.showContextMenu(
                                        context,
                                        value.chiti.data!,
                                        _tapPosition, [
                                      {
                                        "value": "irregular",
                                        "child": "Change",
                                      },
                                    ]);
                                    if (result == "irregular") {
                                      updateChiti(value.chiti.data!, context);
                                    }
                                  },
                                  child: BlueContainer(
                                      textMsg: (int.parse(value
                                                  .chiti.data!.irregular
                                                  .toString()) ==
                                              0)
                                          ? "  Regular  "
                                          : "  Irregular  "))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(
                            child: Row(
                              children: [
                                // (value.chiti.data!.tYpe == 5)
                                Container(
                                    width: 100,
                                    margin: const EdgeInsets.only(right: 10),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, RoutesName.home,
                                            arguments: [value.chiti.data!.id]);
                                      },
                                      child: const Text("Add Daily"),
                                    )),
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                    width: 100,
                                    margin: const EdgeInsets.only(right: 10),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        final data = await Navigator.pushNamed(
                                            context,
                                            RoutesName.add_interest_entry,
                                            arguments: [
                                              value.chiti.data!.id,
                                              value.chiti.data!.customer,
                                              lastDate
                                            ]);
                                        if (data == true) {
                                          refreshPage();
                                        }
                                      },
                                      child: const Text("Add Entry"),
                                    )),
                                const SizedBox(
                                  width: 5,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Container(
                                    color: (value.chiti.data!.status! == 1)
                                        ? Colors.green
                                        : Colors.red,
                                    width: 200,
                                    // margin: const EdgeInsets.only(right: 100),
                                    child: BlueContainer(
                                        textMsg:
                                            (value.chiti.data!.status! == 1)
                                                ? "Chiti Pending"
                                                : "Chiti Cleared"),
                                  ),
                                ),
                                // SizedBox(
                                //     width: 100,
                                //     child: RoundButton(
                                //         title: "Refresh",
                                //         onPress: () {
                                //           Utils.showSnackBar(
                                //               context, "Loading...");
                                //           initState();
                                //         })),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              ChangeNotifierProvider<AsaluViewModel>(
                                create: (BuildContext context) =>
                                    asaluViewModel,
                                child: Consumer<AsaluViewModel>(
                                    builder: (context, asaluvalue, _) {
                                  switch (asaluvalue.asaluList.status!) {
                                    case Status.LOADING:
                                      return const Center(
                                          child: CircularProgressIndicator());

                                    case Status.ERROR:
                                      // TODO: Handle this case.
                                      return Center(
                                          child: Text(asaluvalue
                                              .asaluList.message!
                                              .toString()));
                                    case Status.COMPLETED:
                                      // TODO: Handle this case.
                                      if (asaluvalue
                                          .asaluList.data!.isNotEmpty) {
                                        List<dynamic> asaluRawData = [];

                                        for (var e
                                            in asaluvalue.asaluList.data!) {
                                          Map tmp = {
                                            "id": e.id,
                                            "date": e.date,
                                            "amount": e.amount,
                                            "chiti": e.chiti,
                                            "note": e.note,
                                            "paymentmode": e.paymentmode,
                                            "paymentmodename":
                                                e.paymentmodename,
                                            "backPage": RoutesName.chiti
                                          };
                                          asaluRawData.add(tmp);
                                        }
                                        return Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Asalu List",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall,
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                    height: 300,
                                                    child: ScrollableWidget(
                                                        child: TableWidget(
                                                            columns:
                                                                asaluColumns,
                                                            rows: asaluRows,
                                                            rowData:
                                                                asaluRawData,
                                                            tableCons: const {
                                                          "columnSpacing": 5,
                                                          "borderColor":
                                                              Colors.lightBlue,
                                                          "headingColor":
                                                              Colors.lightBlue,
                                                          "contextMenu": [
                                                            {
                                                              "value":
                                                                  "editasalu",
                                                              "child": "Edit"
                                                            },
                                                            {
                                                              "value":
                                                                  "deleteasalu",
                                                              "child": "Delete"
                                                            }
                                                          ]
                                                          // "bgcolor":
                                                          //     Colors.lightBlue
                                                        }))),
                                              ],
                                            )
                                          ],
                                        );
                                      } else {
                                        return Container(
                                          margin:
                                              const EdgeInsets.only(left: 120),
                                          child: Text(
                                            "No Asalu Paid Yet ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall,
                                          ),
                                        );
                                      }
                                  }
                                }),
                              ),
                            ],
                          ),
                        ),
                        ChangeNotifierProvider<CollectionViewModel>(
                          create: (BuildContext context) => collectionViewModel,
                          child: Consumer<CollectionViewModel>(
                              builder: (context, collvalue, _) {
                            switch (collvalue.collectionsList.status!) {
                              case Status.LOADING:
                                return const Center(
                                    child: CircularProgressIndicator());

                              case Status.ERROR:
                                // TODO: Handle this case.
                                return Center(
                                    child: Text(collvalue
                                        .collectionsList.message!
                                        .toString()));
                              case Status.COMPLETED:
                                // TODO: Handle this case.
                                List<dynamic> CollrawData = [];
                                for (var e in collvalue.collectionsList.data!) {
                                  String _paymentmodename = "";
                                  String _separator = "";
                                  (e.pmtrans != null && e.pmtrans!.isNotEmpty)
                                      ? e.pmtrans!.forEach((element) {
                                          _paymentmodename +=
                                              "$_separator ${element.paymentmodename} : ${element.credit} ";
                                          _separator = ",";
                                        })
                                      : null;
                                  Map tmp = {
                                    "id": e.id,
                                    "date": e.date,
                                    "amount": e.amount,
                                    "chiti": e.chiti,
                                    "received": e.received,
                                    "rcvddate": e.rcvddate,
                                    "notes": e.notes,
                                    "paymentmode": e.paymentmode ?? 1,
                                    "paymentmodename": _paymentmodename
                                  };
                                  CollrawData.add(tmp);
                                  // }
                                }

                                (collvalue.isCollectionListCalled)
                                    ? Future.delayed(Duration.zero, () {
                                        lastDate = collvalue
                                            .collectionsList
                                            .data![collvalue.collectionsList
                                                    .data!.length -
                                                1]
                                            .date
                                            .toString();
                                        collvalue
                                            .setIsCollectionListCalled(false);
                                      })
                                    : null;
                                return Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Interest List",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall,
                                          )
                                        ],
                                      ),
                                      Row(children: [
                                        SizedBox(
                                          height: 300,
                                          child: ScrollableWidget(
                                            child: TableWidget(
                                                columns: collColumns,
                                                rows: collRows,
                                                rowData: CollrawData,
                                                tableCons: collTableCons),
                                          ),
                                        ),
                                      ]),
                                      // ),
                                    ],
                                  ),
                                );
                            }
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
        }
      }),
    );
  }
}
