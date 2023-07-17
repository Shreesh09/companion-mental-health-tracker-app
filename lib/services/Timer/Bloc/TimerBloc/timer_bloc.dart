import 'package:bloc/bloc.dart';
import 'package:companionapp/services/Timer/Bloc/TimerBloc/timer_events.dart';
import 'package:companionapp/services/Timer/Bloc/TimerBloc/timer_states.dart';
import 'package:companionapp/services/Timer/timer_service.dart';

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
      (event, emit) {
        timer.stopTimer();
        emit(const TimerStateStopped(exception: null));
      },
    );
  }
}
