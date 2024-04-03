import 'package:intl/intl.dart';

class Category {
  DateTime now = DateTime.now();

  String getCurrentCategory() {
    DateTime now = DateTime.now();
    int currentHour = now.hour;
    String time = DateFormat.jm().format(now);

    if (currentHour > 8 && currentHour <= 16) {
      return 'Work ( $time)';
    } else if (currentHour > 16 && currentHour <= 24) {
      return 'Free ($time)';
    } else {
      return 'Sleep ( $time)';
    }
  }
}
