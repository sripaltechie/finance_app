import 'package:flutter/material.dart';

import '../color.dart';

class BlueContainer extends StatelessWidget {
  final String textMsg;
  final Color? textColor;
  const BlueContainer({
    super.key,
    required this.textMsg,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color? _textColor = (textColor != null)
        ? textColor
        : Theme.of(context).brightness == Brightness.dark
            ? AppColors.whiteColor
            : AppColors.blackColor;
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.blue),
        borderRadius: const BorderRadius.all(Radius.circular(50)),
      ),
      child: Center(
        child: Text(
          textMsg,
          style: TextStyle(color: _textColor),
        ),
      ),
    );
  }
}
