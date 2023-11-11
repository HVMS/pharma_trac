import 'package:intl/intl.dart';

class TimeUtils {

  static String greetingMessage(){
    final now = DateTime.now();
    final hour = now.hour;

    if (hour < 12){
      return "Good morning,";
    } else if (hour < 17){
      return "Good afternoon,";
    } else {
      return "Good Evening,";
    }
  }

  static String getFormattedDateSimple(int time) {
    DateFormat newFormat = DateFormat("MMMM dd, yyyy");
    return newFormat.format(DateTime.fromMillisecondsSinceEpoch(time));
  }

}