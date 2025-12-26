import 'dart:async';

import 'package:chanda_finance/repository/asalu_repository.dart';
import 'package:chanda_finance/utils/showAlertDialog.dart';
import 'package:chanda_finance/view_model/asalu_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:chanda_finance/utils/toast.dart';
import '../../utils/routes_name.dart';
import '../../utils/utils.dart';
import '../../view/chiti_view.dart';
import '../../view/collection_rcvd_view.dart';
import '../../view_model/collection_view_model.dart';
import '../../view_model/latest_notes_view_model.dart';
import '../color.dart';
import 'app_url.dart';

class TableWidget extends StatefulWidget {
  final List<String> columns;
  final List rows;
  final List rowData;
  final dynamic tableCons;

  const TableWidget(
      {super.key,
      required this.columns,
      required this.rows,
      required this.rowData,
      required this.tableCons});

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  final FToast ftoast = FToast();
  late ToastNotification toast = ToastNotification(ftoast);
  dynamic tableCons;
  List<String> columns = [];
  List rows = [];
  List rowData = [];
  double ColumnSpacing = 10;
  int? sortColumnIndex;
  bool isAscending = false;
  bool isTotal = false;
  late Color borderColor = Colors.black;
  late Color headingColor = Color.fromARGB(255, 48, 41, 41);
  late Color headingTextColor = AppColors.whiteColor;

  AsaluViewModel asaluViewModel = AsaluViewModel();
  LatestNotesViewModel latestNotesViewModel = LatestNotesViewModel();

  // final widgetKey = GlobalKey();

  // Tap location will be used use to position the context menu
  Offset _tapPosition = Offset.zero;
  void _getTapPosition(TapDownDetails details) {
    // Offset _tapPosition = Offset.zero;
    // final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      // _tapPosition = referenceBox.globalToLocal(details.globalPosition);
      _tapPosition = details.globalPosition;
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
          for (var item in tableCons['contextMenu'])
            PopupMenuItem(
              value: item['value'],
              child: Text(item['child']),
            )
          // (tableCons['contextmenupage'] == 'chitidart' &&
          //         editValue['received'] == 1 &&
          //         item['value'] == 'received')
          //     ? const PopupMenuItem(
          //         value: 'notreceived',
          //         child: Text("Not Received"),
          //       )
          //     : PopupMenuItem(
          //         value: item['value'],
          //         child: Text(item['child']),
          //       ),
          // const PopupMenuItem(
          //   value: 'editinterest',
          //   child: Text('Edit'),
          // ),
          // const PopupMenuItem(
          //   value: 'hide',
          //   child: Text('Hide'),
          // ),
        ]);

    // Implement the logic for each choice here
    switch (result) {
      case 'received':
        if (editValue['received'] == 1) {
          toast.info("Already Received");
        } else {
          bool refresh = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CollectionRcvdView(
                      colId: editValue['id'],
                    )),
          );

          // Navigator.pushNamed(context, RoutesName.collection_rcvd,
          //     arguments: [editValue['id']]);
          if (refresh) {
            // refresh the page here
            Navigator.popAndPushNamed(context, RoutesName.chiti,
                arguments: [int.tryParse(editValue['chiti'].toString())]);
          }
        }

        break;
      case 'editasalu':
        // debugPrint('Add To Favorites');
        Navigator.pushNamed(context, RoutesName.editasalu,
            arguments: [editValue['id'], editValue['backPage']]);
        break;
      case 'deleteasalu':
        // debugPrint('Write Comment');
        if (editValue['id'] > 0) {
          bool res = await showDialogbox(
              context, "Are You sure you want to Delete Entry ?");
          if (res == true) {
            final _myRepo = AsaluRepository();
            _myRepo.deleteAsaluApi(editValue['id'], context).then((value) {
              if (value.Apistatus == "success") {
                Navigator.pushNamed(context, editValue['backPage'],
                    arguments: [editValue["chiti"]]);
              }
            }).onError((error, stackTrace) {
              Utils.flushBarErrorMessage(error.toString(), context);
            });

            //       }));
            // });
            // var response = await http.delete(
            //   Uri.parse("${AppUrl.baseUrl}/asalu/${editValue}"),
            //   headers: {
            //     'Accept': 'application/json',
            //     "Content-Type": "application/x-www-form-urlencoded",
            //   },
            // );
            // var data = jsonDecode(response.body.toString());

            // toast.success(data["message"]);
            // // print(data);
            // if (response.statusCode == 200 && data["status"] == "success") {
            //   // fetchdata();
            // }
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
    super.initState();
    setState(() {
      tableCons = widget.tableCons;
      columns = widget.columns;
      rows = widget.rows;
      rowData = widget.rowData;
    });
  }

  @override
  Widget build(BuildContext context) {
    // dynamic tableCons = widget.tableCons;
    // List<String> columns = widget.columns;
    // List rows = widget.rows;
    // List rowData = widget.rowData;

    if (widget.rowData != rowData) {
      setState(() {
        rowData = widget.rowData;
      });
    }

    if (tableCons != null) {
      if (tableCons.containsKey('borderColor')) {
        borderColor = tableCons["borderColor"];
      }
      if (tableCons.containsKey('headingColor')) {
        headingColor = tableCons["headingColor"];
      }
      if (tableCons.containsKey('headingTextColor')) {
        headingTextColor = tableCons["headingTextColor"];
      }
      if (tableCons.containsKey('columnSpacing')) {
        ColumnSpacing = tableCons["columnSpacing"].toDouble();
      }
      if (tableCons.containsKey('total')) {
        isTotal = tableCons["total"];
      }
    }

    return DataTable(
      showCheckboxColumn: false,
      sortAscending: isAscending,
      sortColumnIndex: sortColumnIndex,
      border: TableBorder.all(color: borderColor),
      columnSpacing: ColumnSpacing,
      headingRowColor: MaterialStateColor.resolveWith((states) => headingColor),
      headingTextStyle: TextStyle(color: headingTextColor),
      // sortAscending: isAscending,
      // sortColumnIndex: sortColumnIndex,
      columns: getColumns(),
      // headingRowColor: MaterialStatePropertyAll(Color.fromARGB(0, 67, 67, 232)),
      rows: getRows(),
    );
  }

  List<DataColumn> getColumns() => columns
      .map((String column) => DataColumn(
            label: Text(column),
            onSort: onSort,
          ))
      .toList();

  List<DataRow> getRows() => rowData.map((user) {
        var index = rowData.indexOf(user) + 1;
        final cells = [];
        for (var i = 0; i < rows.length; i++) {
          // if ((rows[i] == "date" || rows[i] == "rcvddate")) {
          //   print(user[rows[i]].toString().contains(' '));
          // }
          if ((rows[i] == "date" || rows[i] == "rcvddate") &&
              user[rows[i].toString()] != "") {
            (user[rows[i].toString()] != "Total")
                ? (user[rows[i]].toString().contains(' '))
                    ? cells.add(Utils.userTimeFormat(user[rows[i].toString()]))
                    : cells.add(Utils.userFormat(user[rows[i].toString()]))
                : cells.add(user[rows[i].toString()]);
          } else if (rows[i] == "sno") {
            (index == rowData.length && isTotal)
                ? cells.add("")
                : cells.add(index.toString());
          } else if (rows[i] == "received") {
            (user[rows[i]] == 1) ? cells.add("Yes") : cells.add("NO");
          } else if (rows[i] == "paymentmode") {
            // print(user['paymentmode'].runtimeType);
            // print(int.parse(user["paymentmode"]));
            if (user.containsKey('paymentmode')) {
              if ((user['paymentmode'].runtimeType == String) &&
                  (int.parse(user["paymentmode"]) > 0)) {
                (user['paymentmodename'] != "" &&
                        user['paymentmodename'] != null)
                    ? cells.add((user['paymentmodename']).toString())
                    : cells.add(Utils.getpmname(
                        tableCons['paymentmodeList'], user['paymentmode']));
                // }
                // ? cells.add(user['paymentmodename'])
              } else if (user['paymentmode'].runtimeType == int &&
                  user["paymentmode"] > 0) {
                cells.add((user['paymentmodename']).toString());
              } else {
                cells.add("");
              }
            } else {
              cells.add("");
            }
          } else if (rows[i] == "action") {
            if (tableCons.containsKey('actions') &&
                tableCons["actions"]["widget"] == "button") {
              cells.add("");
            } else {
              cells.add("");
            }
          } else {
            (user[rows[i]] == null)
                ? cells.add("")
                : cells.add(user[rows[i].toString()]);
          }
        }

        return DataRow(

            // onLongPress: () => {
            //   customFunc(tableCons)
            // // },
            // onSelectChanged: (bool? selected) {
            //   if (selected!) {
            //     print('row-selected: ${rowData.indexOf(user)}');
            //   }
            // },
            cells: getCells(cells, user, tableCons),
            color: MaterialStatePropertyAll(checkColor(user)));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells, user, tableCons) => cells
      .map(
        (data) => DataCell((tableCons.containsKey('contextMenu'))
                ? GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTapDown: (details) => _getTapPosition(details),
                    // show the context menu
                    onLongPress: () => _showContextMenu(context, user),
                    child: getCellText(data, user))
                : (tableCons.containsKey('ontap'))
                    ? InkWell(
                        onTap: () => {
                              if (tableCons['ontap'] == RoutesName.chiti ||
                                  tableCons['ontap'] ==
                                      RoutesName.editCashEntry)
                                {
                                  if (user.containsKey("chiti"))
                                    {
                                      Navigator.pushNamed(
                                          context, tableCons['ontap'],
                                          arguments: [
                                            int.parse(user['chiti'].toString())
                                          ])
                                    }
                                  else if (user.containsKey("id"))
                                    {
                                      Navigator.pushNamed(
                                          context, tableCons['ontap'],
                                          arguments: [
                                            int.parse(user['id'].toString())
                                          ])
                                    }
                                }
                              else if (tableCons['ontap'] == "dynamic")
                                {
                                  Navigator.pushNamed(
                                      context, user['ontapRoute'], arguments: [
                                    int.parse(user['ontapArg'].toString())
                                  ])
                                }
                              // else if (tableCons['ontap'] == RoutesName.editCashEntry){
                              //   Navigator.pushNamed(context,RoutesName.editCashEntry,arguments: [int.parse(user[id])])
                              // }
                            },
                        child: getCellText(data, user))
                    : getCellText(data, user)
            // child: Text('$data'))

            ),
      )
      .toList();

  Widget getCellText(dynamic data, dynamic user) {
    return (data.toString().length > 30)
        ? Container(
            width: (data.toString().length > 40) ? 200 : null,
            child: Tooltip(
              triggerMode: TooltipTriggerMode.tap,
              showDuration: Duration(seconds: 2),
              message: data.toString(),
              child: Text('$data',
                  style: TextStyle(
                    color: checktextColor(user),
                  )),
            ))
        : Container(
            child: Text('$data',
                style: TextStyle(
                  color: checktextColor(user),
                )),
          );
  }

  Color checkColor(user) {
    Color tmpcolor = (tableCons.containsKey('bgcolor'))
        ? tableCons['bgcolor']
        : Colors.white;
    if (tableCons.containsKey('rowColor')) {
      for (var j = 0; j < tableCons["rowColor"].length; j++) {
        if (tableCons["rowColor"][j]["op"] == "=") {
          if (tableCons["rowColor"][j]["param"] == "days") {
            if (user[tableCons["rowColor"][j]["param"]].toString() ==
                tableCons["rowColor"][j]["value"]) {
              tmpcolor = tableCons["rowColor"][j]["yes"];
            } else {
              tmpcolor = tableCons["rowColor"][j]["no"];
            }
          } else {
            // print(
            //     "param =  ${user[tableCons["rowColor"][j]["param"]].toString()} == ${tableCons["rowColor"][j]["value"].toString()}");
            if (tableCons["rowColor"][j].containsKey('no')) {
              if (user[tableCons["rowColor"][j]["param"]].toString() ==
                  tableCons["rowColor"][j]["value"].toString()) {
                tmpcolor = tableCons["rowColor"][j]["yes"];
              } else {
                tmpcolor = tableCons["rowColor"][j]["no"];
              }
            } else {
              if (user[tableCons["rowColor"][j]["param"]].toString() ==
                  tableCons["rowColor"][j]["value"].toString()) {
                tmpcolor = tableCons["rowColor"][j]["color"];
              }
            }
          }
        } else if (tableCons["rowColor"][j]["op"] == ">") {
          if (tableCons["rowColor"][j]["param"] == "days") {
            // print(user[tableCons["rowColor"][j]["param"]].toString());
            if (int.parse(user[tableCons["rowColor"][j]["param"]].toString()) >
                int.parse(tableCons["rowColor"][j]["value"])) {
              tmpcolor = tableCons["rowColor"][j]["color"];
            }
          }
        } else if (tableCons["rowColor"][j]["op"] == "<") {
          if (tableCons["rowColor"][j]["param"] == "days") {
            if (int.parse(user[tableCons["rowColor"][j]["param"]].toString()) <
                int.parse(tableCons["rowColor"][j]["value"])) {
              tmpcolor = tableCons["rowColor"][j]["color"];
            }
          }
        } else if (tableCons["rowColor"][j]["op"] == "between") {
          if (tableCons["rowColor"][j]["param"] == "days") {
            if ((int.parse(
                        user[tableCons["rowColor"][j]["param"]].toString()) >=
                    int.parse(tableCons["rowColor"][j]["value1"])) &&
                (int.parse(
                        user[tableCons["rowColor"][j]["param"]].toString()) <=
                    int.parse(tableCons["rowColor"][j]["value2"]))) {
              tmpcolor = tableCons["rowColor"][j]["color"];
            }
          }
        }
      }
    }
    return tmpcolor;
  }

  Color checktextColor(user) {
    if (!tableCons.containsKey('rowColor')) {
      return Colors.black;
    }
    return Colors.white;
  }

  void onSort(int columnIndex, bool ascending) {
    for (var i = 0; i < rows.length; i++) {
      if (columnIndex == i) {
        // if(columns[i] == '')
        if (rows[i] == 'sno') {
        } else if (rows[i] == 'amount' || rows[i] == 'days') {
          rowData.sort((user1, user2) => compareInt(
              ascending,
              int.parse(user1[rows[i]].toString()),
              int.parse(user2[rows[i]].toString())));
        } else {
          rowData.sort((user1, user2) =>
              compareString(ascending, user1[rows[i]], user2[rows[i]]));
        }
      }
    }
    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);
  int compareInt(bool ascending, int value1, int value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);
}

// }
