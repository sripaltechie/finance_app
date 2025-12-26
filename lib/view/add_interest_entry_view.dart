import 'package:chanda_finance/view_model/collection_view_model.dart';
import 'package:flutter/material.dart';

class AddInterestEntryView extends StatefulWidget {
  final chitiId;
  final customerId;
  final lastDate;
  const AddInterestEntryView(
      {super.key,
      required this.chitiId,
      required this.customerId,
      required this.lastDate});

  @override
  State<AddInterestEntryView> createState() => _AddInterestEntryViewState();
}

class _AddInterestEntryViewState extends State<AddInterestEntryView> {
  final TextEditingController _noofentries = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  final _myFormKey = GlobalKey<FormState>();
  CollectionViewModel collectionViewModel = CollectionViewModel();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Interest Entry"),
        centerTitle: true,
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _myFormKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Number of Entries';
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.black),
                  controller: _noofentries,
                  // focusNode: amountFocusNode,
                  decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      helperText: "Number of Entries",
                      helperStyle: TextStyle(fontWeight: FontWeight.bold),
                      hintText: "Number of Entries",
                      hintStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Amount';
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.black),
                  controller: _amount,
                  // focusNode: amountFocusNode,
                  decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      helperText: "Amount",
                      helperStyle: TextStyle(fontWeight: FontWeight.bold),
                      hintText: "Amount",
                      hintStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_myFormKey.currentState!.validate()) {
                        Map data = {
                          "noof": _noofentries.text.toString(),
                          "dAte": widget.lastDate.toString(),
                          "chiti": widget.chitiId.toString(),
                          "sowji": "0",
                          "customer": widget.customerId.toString(),
                          "pdwtm": _amount.text.toString(),
                          "suri": "0",
                        };
                        collectionViewModel.createCollectionApi(data, context);
                      }
                    },
                    child: const Text("Submit")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
