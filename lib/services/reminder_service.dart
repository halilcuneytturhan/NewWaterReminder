import 'dart:async';

class ReminderService {
  late Timer _timer;
  int remainingSeconds = 3600; // 1 saat
  Function onReminder;

  ReminderService({required this.onReminder});

  void start() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
      } else {
        onReminder(); // Su içme hatırlatıcısını tetikle
        remainingSeconds = 3600;
      }
    });
  }

  void stop() {
    _timer.cancel();
  }

  String getFormattedTime() {
    final minutes = (remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final secs = (remainingSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }
}
