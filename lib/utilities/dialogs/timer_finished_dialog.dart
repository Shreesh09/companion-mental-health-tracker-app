import 'package:flutter/cupertino.dart';
import 'generic_dialog.dart';

Future<void> showTimerFinishedDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: "Time Up!",
    content: text,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
