import 'package:bloc/bloc.dart';
import 'package:companionapp/services/Timer/Bloc/TimerBloc/timer_events.dart';
import 'package:companionapp/services/Timer/Bloc/TimerBloc/timer_states.dart';
import 'package:companionapp/services/Timer/timer_service.dart';
import 'package:companionapp/utilities/dialogs/timer_finished_dialog.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc(TimerService timer) : super(const TimerStateUninitialized()) {
    on<TimerEventSet>(
      (event, emit) {
        timer.setTimer(time: event.duration);
        emit(const TimerStateStopped(exception: null));
      },
    );

    on<TimerEventStart>(
      (event, emit) {
        try {
          timer.startTimer();
          emit(const TimerStateRunning());
        } on Exception catch (e) {
          emit(TimerStateStopped(exception: e));
        }
      },
    );

    on<TimerEventStop>(
      (event, emit) async {
        timer.stopTimer();
        if (event.context != null) {
          await showTimerFinishedDialog(event.context!, "Timer Ran Out!");
        }
        emit(const TimerStateStopped(exception: null));
      },
    );
  }
}
