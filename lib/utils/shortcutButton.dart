import 'package:flutter/material.dart';

class ShortcutButton extends StatefulWidget {
  final String text;
  final List<Map<String, String>> subOptions;
  final Function(String) onOptionSelected;
  final bool expanded;
  final VoidCallback onExpand;

  ShortcutButton({
    required this.text,
    required this.subOptions,
    required this.onOptionSelected,
    required this.expanded,
    required this.onExpand,
  });

  @override
  _ShortcutButtonState createState() => _ShortcutButtonState();

  void collapse() {}
}

class _ShortcutButtonState extends State<ShortcutButton> {
  bool _isExpanded = false;
  bool? _expanded;

  void collapse() {
    setState(() {
      _expanded = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _expanded = widget.expanded;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
              _expanded = _isExpanded; // Update the expanded state
              if (_expanded!) {
                widget
                    .onExpand(); // Callback to notify parent that this button was expanded
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(4.0),
            ),
            padding: EdgeInsets.all(8.0),
            child: Text(widget.text),
          ),
        ),
        if (_isExpanded)
          Container(
            margin: EdgeInsets.only(top: 8.0),
            child: Column(
              children: widget.subOptions
                  .map((option) => GestureDetector(
                        onTap: () {
                          widget.onOptionSelected(option['id']!);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          padding: EdgeInsets.all(8.0),
                          child: Text(option['name']!),
                        ),
                      ))
                  .toList(),
            ),
          ),
      ],
    );
  }
}






// class _ShortcutButtonState extends State<ShortcutButton> {
//   bool _isExpanded = false;
//   bool _expanded = false;

//   void collapse() {
//     setState(() {
//       _expanded = false;
//     });
//   }
//   @override
//   void initState() {
//     super.initState();
//     _expanded = widget.expanded;
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               _isExpanded = !_isExpanded;
//             });
//           },
//           child: Container(
//             decoration: BoxDecoration(
//               border: Border.all(),
//               borderRadius: BorderRadius.circular(4.0),
//             ),
//             padding: EdgeInsets.all(8.0),
//             child: Text(widget.text),
//           ),
//         ),
//         if (_isExpanded)
//           Container(
//             margin: EdgeInsets.only(top: 8.0),
//             child: Column(
//               children: widget.subOptions
//                   .map((option) => GestureDetector(
//                         onTap: () {
//                           widget.onOptionSelected(option['id']!);
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey),
//                             borderRadius: BorderRadius.circular(4.0),
//                           ),
//                           padding: EdgeInsets.all(8.0),
//                           child: Text(option['name']!),
//                         ),
//                       ))
//                   .toList(),
//             ),
//           ),
//       ],
//     );
//   }
// }
