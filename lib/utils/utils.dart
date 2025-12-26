import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:chanda_finance/data/response/api_response.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:chanda_finance/utils/toast.dart';
import 'package:intl/intl.dart';
import '../model/paymentmodeModel.dart';

class Utils {
  static double averageRating(List<int> rating) {
    var avgRating = 0;
    for (int i = 0; i < rating.length; i++) {
      avgRating += rating[i];
    }
    return double.parse((avgRating / rating.length).toStringAsFixed(1));
  }

  static showSnackBar(context, msg) {
    var snackBar = SnackBar(
      content: Text(
        msg,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.orangeAccent,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static toastMessage(String message, BuildContext context) {
    // Fluttertoast.showToast(msg: message);
    Fluttertoast.showToast(
        msg: "This is a Toast message",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        textColor: Colors.white,
        backgroundColor: Colors.black,
        fontSize: 16.0);
  }

  static showResponseToast(ApiResponse response, context) {
    if (response.message!.isNotEmpty) {
      showToast(response.message, response.Apistatus, context);
    }
  }

  static showToast(msg, type, context) {
    final FToast ftoast = FToast();
    late ToastNotification toast = ToastNotification(ftoast);
    toast = new ToastNotification(ftoast.init(context));
    if (type == "success") {
      toast.success(msg);
    } else if (type == "error") {
      toast.error(msg);
    }
  }

  static setData(ApiResponse response) {
    return ApiResponse.completed(
        response.data, response.message, response.Apistatus);
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(15),
          titleColor: Colors.white,
          borderRadius: BorderRadius.circular(10),
          reverseAnimationCurve: Curves.easeOut,
          message: message,
          // backgroundColor: AppColors.redColor,
          backgroundColor: Colors.red,
          flushbarPosition: FlushbarPosition.TOP,
          positionOffset: 20,
          title: "Error",
          icon: const Icon(
            Icons.error,
            size: 28,
            color: Colors.white,
          ),
          duration: const Duration(seconds: 3),
        )..show(context));
  }

  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static String userFormat(String dte) {
    if (dte != "0000-00-00") {
      var inputFormat = DateFormat('yyyy-MM-dd');
      var date1 = inputFormat.parse(dte);
      var outputFormat = DateFormat('dd/MM/yyyy');
      return outputFormat.format(date1);
    }
    return "";
  }

  static String userTimeFormat(String dte) {
    if (dte != "0000-00-00 00:00:00") {
      DateTime originalDate = DateTime.parse(dte);
      String formattedDateString =
          DateFormat('dd/MM/yyyy HH:mm:ss').format(originalDate);

      return formattedDateString; // Output: 06/05/2023 19:20:54
    }
    return "";
  }

  static String SqlTimeFormat(String dte) {
    // Parse the input string to a DateTime object
    DateTime dateTime = DateFormat('dd/MM/yyyy HH:mm').parse(dte);

    // Format the DateTime object to the desired output string
    String output = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);

    return output; // Output: 2023-05-07 11:59
  }

  static String sqlFormat(String dte) {
    var inputFormat = DateFormat('dd/MM/yyyy');
    var date1 = inputFormat.parse(dte);
    var outputFormat = DateFormat('yyyy-MM-dd');
    return outputFormat.format(date1);
  }

  static List<String> getpmnames(List<PaymentmodeModel> list) {
    List<String> tmp = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        tmp.add(item.modename.toString());
      }
      return tmp;
    }
    return tmp;
  }

  static String getpmmode(List<PaymentmodeModel> list, modename) {
    if (list.isNotEmpty) {
      for (var item in list) {
        if (item.modename == modename) {
          return item.id.toString();
        }
      }
    }
    return "1";
  }

  static String getpmname(List<PaymentmodeModel> list, pmmode) {
    if (list.isNotEmpty) {
      for (var item in list) {
        if (item.id.toString() == pmmode.toString()) {
          return item.modename.toString();
        }
      }
    }
    return "";
  }

  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  static DateTime converttoDateTime(String date) {
    DateTime dateTime;
    dateTime = DateTime.parse(date.toString());
    return dateTime;
  }

  static DateTime convertUserToDateTime(String date) {
    // Create a date format object for the input string
    if (date.contains(' ')) {
      date = DateFormat('dd/MM/yyyy').format(DateTime.now());
    }
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');

    // Parse the input string to a DateTime object
    //DateTime dateTime =
    return dateFormat.parse(date);
  }

  static String formatDateTimeToDateString(DateTime dateTime) {
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dateTime);
  }

  static String todayUserDate() {
    return DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  static String todaySqlDate() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  static String calculateAddDate(DateTime baseDate, int daysToAdd) {
    final newDate = baseDate.add(Duration(days: daysToAdd));
    return DateFormat('dd/MM/yyyy').format(newDate);
  }

  static String calculateSubtractDate(DateTime baseDate, int daysToSub) {
    final newDate = baseDate.subtract(Duration(days: daysToSub));
    return DateFormat('dd/MM/yyyy').format(newDate);
  }

  static Color setDailyColor(int days) {
    // Utils.daysBetween(
    //     Utils.converttoDateTime(lasttrans.date.toString()), DateTime.now());
    if (days > 100) {
      return Colors.red;
    } else if (days > 51 && days <= 100) {
      return Colors.orange;
    } else if (days > 4 && days <= 50) {
      return Colors.blue;
    } else if (days <= 4) {
      return Colors.green;
    }
    return Colors.white;
  }

  static Color setColorOnRemainingAsalu(int asalu, int days, int perday) {
    int paymentDays = (asalu / perday).round();

    // int diffDays = days - paymentDays;
    if (paymentDays >= (days * 2)) {
      return Colors.red;
    } else if (paymentDays >= (days + days / 2) && (paymentDays < (days * 2))) {
      return Colors.orange;
    } else if (paymentDays >= (days + days / 4) &&
        paymentDays >= (days + days / 2)) {
      return Colors.blue;
    } else {
      return Colors.green;
    }
  }

  static List<dynamic> getDaysRowColorList() {
    List rowColor = [
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
        "value1": "7",
        "value2": "50",
        "color": Colors.blue,
      },
      {
        "param": "days",
        "op": "<",
        "value": "7",
        "color": Colors.green,
      },
    ];
    return rowColor;
  }

  static Future<String> showContextMenu(BuildContext context, editValue,
      _tapPosition, List contextMenuList) async {
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
          for (var item in contextMenuList)
            PopupMenuItem(
              value: item['value'],
              child: Text(item['child']),
            )
        ]);

    // Implement the logic for each choice here
    return Future.value(result.toString());
  }

  static Future<void> delayedFunctionUntilTrue(
      bool Function() checkCondition) async {
    bool condition = false;
    while (!condition) {
      await Future.delayed(Duration(seconds: 1));
      // Replace the condition with your own logic
      if (checkCondition()) {
        condition = true;
      }
    }
    // The condition is true, so execute the desired function here
    return;
  }

  static bool hasFloatingPointNumber(String str) {
    final pattern = RegExp(r'^-?\d+(\.\d+)?$');
    return pattern.hasMatch(str);
  }

  static int strFloatToInt(String str) {
    int number = double.parse(str).toInt();
    return number; // Output: 1500
  }
}
