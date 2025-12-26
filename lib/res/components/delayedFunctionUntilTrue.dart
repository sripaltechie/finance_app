import 'package:flutter/material.dart';

import '../color.dart';

class delayedFunctionUntilTrue extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback customFunc;
  const delayedFunctionUntilTrue(
      {super.key,
      required this.title,
      this.loading = false,
      required this.customFunc});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: customFunc,
      child: Container(
          height: 40,
          width: 200,
          decoration: BoxDecoration(
              color: AppColors.buttonColor,
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: loading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    title,
                    style: const TextStyle(color: AppColors.whiteColor),
                  ),
          )),
    );
  }
}
