import 'package:flutter/widgets.dart';
import 'generic_dialog.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog<void>(
      context: context,
      title: 'Share Notes',
      content: 'You cannot share an Empty Note!',
      optionsBuilder: () => {
            'OK': null,
          });
}
