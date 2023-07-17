import 'package:companionapp/services/Timer/Bloc/TimerBloc/timer_bloc.dart';
import 'package:companionapp/services/Timer/Bloc/TimerBloc/timer_events.dart';
import 'package:companionapp/services/Timer/Bloc/TimerBloc/timer_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/Timer/timer_service.dart';

class MeditateView extends StatefulWidget {
  const MeditateView({super.key});

  @override
  State<MeditateView> createState() => _MeditateViewState();
}

class _MeditateViewState extends State<MeditateView> {
  late final TimerService timer;
  late TextEditingController _textEditingController;
  late int time;

  @override
  void initState() {
    timer = TimerService();
    _textEditingController = TextEditingController();
    time = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TimerBloc>(
      create: (context) => TimerBloc(timer),
      child: Scaffold(
          appBar: AppBar(title: const Text("Hello")),
          body:
              BlocBuilder<TimerBloc, TimerState>(//listener: (context, state) {
                  //print(state);
                  //if (state is TimerStateRunning) {
                  //} else if (state is TimerStateStopped) {
                  // time = 0;
                  //}
                  //},

                  builder: (context, state) {
            if (state is TimerStateRunning) {
              return StreamBuilder(
                stream: timer.getTime(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                    case ConnectionState.done:
                      if (snapshot.hasData) {
                        time = snapshot.data!.time;
                        if (time <= 0) {
                          context.read<TimerBloc>().add(const TimerEventStop());
                        }
                        return Column(
                          children: [
                            Text(time.toString()),
                            TextButton(
                              onPressed: () {
                                context
                                    .read<TimerBloc>()
                                    .add(const TimerEventSet(duration: 10));
                                context
                                    .read<TimerBloc>()
                                    .add(const TimerEventStart());
                              },
                              child: const Text('Start'),
                            ),
                            TextButton(
                              onPressed: () {
                                context
                                    .read<TimerBloc>()
                                    .add(const TimerEventStop());
                                time = 0;
                              },
                              child: const Text('Start'),
                            ),
                          ],
                        );
                      }
                    default:
                      return const CircularProgressIndicator();
                  }
                  print("Empty");
                  return const CircularProgressIndicator();
                },
              );
            }
            return Column(
              children: [
                TextField(
                  controller: _textEditingController,
                  keyboardType: TextInputType.number,
                ),
                TextButton(
                  onPressed: () {
                    context.read<TimerBloc>().add(TimerEventSet(
                        duration: int.parse(_textEditingController.text)));
                    context.read<TimerBloc>().add(const TimerEventStart());
                  },
                  child: const Text('Start'),
                ),
                TextButton(
                  onPressed: () {
                    context.read<TimerBloc>().add(const TimerEventStop());
                  },
                  child: const Text('Stop'),
                ),
              ],
            );
          })),
    );
  }
}
