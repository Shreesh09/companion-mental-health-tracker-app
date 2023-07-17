import 'package:companionapp/services/Timer/timer_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Mock Timer', () {
    final TimerService timer = TimerService();
    timer.setTimer(time: 10);

    test('Start Timer', () {
      expect(timer.seconds, 10);
    });
  });
}
