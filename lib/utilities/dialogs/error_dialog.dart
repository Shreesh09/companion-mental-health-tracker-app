import 'package:flutter/material.dart';
import 'package:companionapp/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: "Error",
    content: text,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
