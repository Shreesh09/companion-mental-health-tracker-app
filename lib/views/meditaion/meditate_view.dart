import 'package:companionapp/assets/colors/app_colors.dart';
import 'package:companionapp/assets/widgets/timer_text_field_widget.dart';
import 'package:companionapp/assets/widgets/timer_widget.dart';
import 'package:companionapp/assets/widgets/triangle_widget.dart';
import 'package:companionapp/assets/widgets/white_text_widget.dart';
import 'package:companionapp/services/Timer/Bloc/TimerBloc/timer_bloc.dart';
import 'package:companionapp/services/Timer/Bloc/TimerBloc/timer_events.dart';
import 'package:companionapp/services/Timer/Bloc/TimerBloc/timer_states.dart';
import 'package:companionapp/utilities/dialogs/error_dialog.dart';
import 'package:companionapp/views/meditaion/meditaion_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../assets/gradients/home_page_gradient.dart';
import '../../services/Timer/timer_service.dart';

class MeditateView extends StatefulWidget {
  const MeditateView({super.key});

  @override
  State<MeditateView> createState() => _MeditateViewState();
}

class _MeditateViewState extends State<MeditateView> {
  double timerProgress = 1.0;
  late final TimerService timer;
  late TextEditingController _textEditingControllerMinutes,
      _textEditingControllerSeconds;
  late int time;
  double rate = 0.0;

  @override
  void initState() {
    timer = TimerService();
    _textEditingControllerMinutes = TextEditingController();
    _textEditingControllerSeconds = TextEditingController();

    time = 0;
    super.initState();
  }

  @override
  void dispose() {
    _textEditingControllerMinutes.dispose();
    _textEditingControllerSeconds.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TimerBloc>(
      create: (context) => TimerBloc(timer),
      child: BlocBuilder<TimerBloc, TimerState>(
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(gradient: homePageGradient),
            child: Scaffold(
              backgroundColor: Colors.black45,
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.white),
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.black,
                ),
                backgroundColor: appBarColor,
                title: const WhiteText("Mindfullness"),
              ),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 250,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Container(
                                  color: Colors.white10,
                                  child: const MediataionText())),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        BlocBuilder<TimerBloc, TimerState>(
                          builder: (context, state) {
                            if (state is TimerStateStopped ||
                                state is TimerStateUninitialized) {
                              return Column(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * .80,
                                    height: 150,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          width: 25,
                                        ),
                                        TimerTextField(
                                          controller:
                                              _textEditingControllerMinutes,
                                          height: 70,
                                        ),
                                        const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 12, 25),
                                          child: WhiteText(
                                            ":",
                                            fontSize: 70,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TimerTextField(
                                          controller:
                                              _textEditingControllerSeconds,
                                          height: 70,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                    child: LinearProgressIndicator(
                                      minHeight: 10,
                                      color: timerButtonsColor,
                                      value: timerProgress,
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return StreamBuilder(
                                  stream: timer.getTime(),
                                  builder: (context, snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.waiting:
                                      case ConnectionState.active:
                                        if (snapshot.hasData) {
                                          time = snapshot.data!.time;
                                          final m = time ~/ 60;
                                          final minutes = m < 10 ? '0$m' : '$m';
                                          final s = time - (60 * m);
                                          final seconds = s < 10 ? '0$s' : '$s';
                                          timerProgress = timerProgress - rate;
                                          //print(timerProgress);
                                          if (time == 0) {
                                            context.read<TimerBloc>().add(
                                                TimerEventStop(
                                                    context: context));
                                            timerProgress = 1.0;
                                          }
                                          return TimerWidget(
                                              minutes: minutes,
                                              seconds: seconds,
                                              timerProgress: timerProgress);
                                        } else {
                                          String minutes =
                                              _textEditingControllerMinutes
                                                  .text;
                                          minutes =
                                              minutes.isEmpty ? "00" : minutes;

                                          String seconds =
                                              _textEditingControllerSeconds
                                                  .text;
                                          seconds =
                                              seconds.isEmpty ? "00" : seconds;

                                          return TimerWidget(
                                              minutes: minutes,
                                              seconds: seconds,
                                              timerProgress: 1.0);
                                        }
                                      default:
                                        return const CircularProgressIndicator();
                                    }
                                  });
                            }
                          },
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                if (state is TimerStateRunning) {
                                } else {
                                  if (_textEditingControllerMinutes.text ==
                                      "") {
                                    time = 0;
                                  } else {
                                    final integer = int.tryParse(
                                        _textEditingControllerMinutes.text);
                                    if (integer == null) {
                                      time = 0;
                                      showErrorDialog(context, "Invalid Input");
                                      _textEditingControllerMinutes.clear();
                                    } else {
                                      time = integer * 60;
                                    }
                                  }
                                  if (_textEditingControllerSeconds.text !=
                                      "") {
                                    final integer = int.tryParse(
                                        _textEditingControllerSeconds.text);
                                    if (integer == null) {
                                      time = 0;
                                      showErrorDialog(context, "Invalid Input");
                                      _textEditingControllerSeconds.clear();
                                    } else {
                                      time = time + integer;
                                    }
                                  }
                                  rate = 1.0 / time;
                                  context
                                      .read<TimerBloc>()
                                      .add(TimerEventSet(duration: time));
                                  context
                                      .read<TimerBloc>()
                                      .add(const TimerEventStart());
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100)),
                                child: SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: Center(
                                        child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                      child:
                                          Triangle(40, timerButtonsColor, 90),
                                    ))),
                              ),
                            ),
                            const SizedBox(
                              width: 100,
                            ),
                            InkWell(
                              onTap: () {
                                context
                                    .read<TimerBloc>()
                                    .add(const TimerEventStop());
                                timerProgress = 1.0;
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100)),
                                child: SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: Center(
                                        child: Container(
                                      width: 32,
                                      height: 32,
                                      color: timerButtonsColor,
                                    ))),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Visibility(
                            visible: state is TimerStateRunning,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.music_note,
                                  color: Colors.white54,
                                ),
                                Text(
                                  "Now playing: Relaxing Music",
                                  style: TextStyle(
                                      color: Colors.white54, fontSize: 20),
                                )
                              ],
                            ))
                      ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
