
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

successDialog(BuildContext context, String successDialogTitle,
    String lottiePath) {
  return Dialogs.materialDialog(
    barrierDismissible: false,
    color: Colors.white,
    title: successDialogTitle,
    titleAlign: TextAlign.center,
    lottieBuilder: Lottie.asset(
      lottiePath,
      fit: BoxFit.contain,
    ),
    dialogWidth: kIsWeb ? 0.3 : null,
    context: context,
    actions: [
      IconsButton(
        onPressed: () {
          Navigator.popUntil(context, ModalRoute.withName('/home_page'));
        },
        text: "Close",
        color: Colors.blue,
        textStyle: const TextStyle(color: Colors.white),
        iconColor: Colors.white,
      ),
    ],
  );
}
