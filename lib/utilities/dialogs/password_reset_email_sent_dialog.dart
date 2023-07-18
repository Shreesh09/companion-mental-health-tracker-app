import 'package:flutter/widgets.dart';

import 'generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Password Reset',
    content:
        'We have sent you a link to reset your password. Please check you email.',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
