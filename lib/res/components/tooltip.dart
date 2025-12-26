import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

class ToolTipWidget extends StatefulWidget {
  String message;

  ToolTipWidget({super.key, required this.message});

  @override
  State<ToolTipWidget> createState() => _ToolTipWidgetState();
}

class _ToolTipWidgetState extends State<ToolTipWidget> {
  @override
  Widget build(BuildContext context) {
    return JustTheTooltip(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          widget.message.toString(),
        ),
      ),
      child: Material(
        color: Colors.grey.shade800,
        shape: const CircleBorder(),
        elevation: 4.0,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
