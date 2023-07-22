import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:companionapp/services/Timer/Bloc/TimerBloc/timer_events.dart';
import 'package:companionapp/services/Timer/Bloc/TimerBloc/timer_states.dart';
import 'package:companionapp/services/Timer/timer_service.dart';
import 'package:companionapp/utilities/dialogs/timer_finished_dialog.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc(TimerService timer) : super(const TimerStateUninitialized()) {
    final assetsAudioPlayer = AssetsAudioPlayer();

    on<TimerEventSet>(
      (event, emit) {
        if (state is TimerStateRunning) {
          emit(state);
        } else {
          timer.setTimer(time: event.duration);
          emit(const TimerStateStopped(exception: null));
        }
      },
    );

    on<TimerEventStart>(
      (event, emit) {
        if (state is TimerStateRunning) {
          emit(state);
        } else {
          try {
            timer.startTimer();
            assetsAudioPlayer.open(Audio("assets/sound/relax.mp3"));
            emit(const TimerStateRunning());
          } on Exception catch (e) {
            emit(TimerStateStopped(exception: e));
          }
        }
      },
    );

    on<TimerEventStop>(
      (event, emit) async {
        assetsAudioPlayer.stop();
        timer.stopTimer();
        if (event.context != null) {
          await showTimerFinishedDialog(event.context!, "Timer Ran Out!");
        }
        emit(const TimerStateStopped(exception: null));
      },
    );
  }
}
