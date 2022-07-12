import 'package:flutter/material.dart';

import '../../../../core/utils/ui_helper.dart';

class ErrorDialogWidget {
  Widget showDialog(BuildContext context, String title, String text,
      String action, Function(dynamic) callback) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("${action}"),
      onPressed: () {
        callback(0);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "${title}!",
        style: Theme.of(context)
            .textTheme
            .headlineSmall
            .apply(color: UiHelper.BLACK_COLOR),
      ),
      content: Text("${text}", style: Theme.of(context).textTheme.bodyMedium),
      actions: [
        okButton,
      ],
    );

    return alert;
  }
}
