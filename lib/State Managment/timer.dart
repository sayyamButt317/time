import 'dart:async';
import 'package:get/get.dart';

class TimerController extends GetxController {
  late Timer timer;
  Rx<int> seconds = 10.obs;
  Rx<int> milliseconds = 0.obs;

  void startTimer() {
    const oneMillisecond = Duration(milliseconds: 1);
    timer = Timer.periodic(
      oneMillisecond,
      (Timer timer) {
        if (seconds.value == 0 && milliseconds.value == 0) {
          timer.cancel();
        } else {
          if (milliseconds.value == 0) {
            seconds.value--;
            milliseconds.value = 999;
          } else {
            milliseconds.value--;
          }
        }
      },
    );
  }
}
