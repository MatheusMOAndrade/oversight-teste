import '../../../../themes/oversight_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(
  BuildContext context,
  String message,
  IconData toastIcon,
  Color iconColor,
) {
  FToast fToast = FToast();
  fToast.init(context);

  Widget toast = Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 24.0,
      vertical: 8.0,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      color: OversightColors.lightGrey,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(
          toastIcon,
          color: iconColor,
        ),
        const SizedBox(
          width: 12.0,
        ),
        Text(message),
      ],
    ),
  );
  fToast.showToast(
    child: toast,
    toastDuration: const Duration(seconds: 2),
    gravity: ToastGravity.TOP,
  );
}
