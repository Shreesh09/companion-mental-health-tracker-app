import 'package:companionapp/assets/widgets/white_text_widget.dart';
import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class TimerWidget extends StatelessWidget {
  final String minutes, seconds;
  final double timerProgress;
  const TimerWidget(
      {super.key,
      required this.minutes,
      required this.seconds,
      required this.timerProgress});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width * .80,
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WhiteText(
                minutes,
                fontSize: 70,
                fontWeight: FontWeight.bold,
              ),
              const WhiteText(
                ":",
                fontSize: 70,
                fontWeight: FontWeight.bold,
              ),
              WhiteText(
                seconds,
                fontSize: 70,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: LinearProgressIndicator(
            minHeight: 10,
            color: timerButtonsColor,
            value: timerProgress,
          ),
        ),
      ],
    );
  }
}
