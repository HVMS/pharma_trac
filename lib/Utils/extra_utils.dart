import 'package:intl/intl.dart';

class ExtraUtils {

  static List<dynamic>? sortData<T>(List<dynamic> data){
    data.sort((a, b) {
      DateFormat format = DateFormat("MMMM d, yyyy h:mm a");
      DateTime aDateTime = format.parse("${a.date} ${a.time}");
      DateTime bDateTime = format.parse("${b.date} ${b.time}");
      return bDateTime.compareTo(aDateTime);
    });
  }

}