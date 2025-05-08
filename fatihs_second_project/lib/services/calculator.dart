import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Calculator {
  static String dateTimeToString (DateTime dateTime) {
    String formattedDate =DateFormat('dd / MM / yyyy').format(dateTime);

 return formattedDate;
  }

  static Timestamp dateTimeToTimestamp (DateTime dateTime){
    return Timestamp.fromDate(dateTime);
  }

  static DateTime timestampToDateTime (Timestamp timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
  }
}