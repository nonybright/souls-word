import 'package:intl/intl.dart';

enum DateFormatPattern {general}

String dateToString(DateTime date, [DateFormatPattern pattern = DateFormatPattern.general]){

  String formatPattern = '';
  switch(pattern){

      case DateFormatPattern.general:
      formatPattern = 'yyyy-MM-dd HH:mm:ss';
      break;
  }
  var formatter = new DateFormat(formatPattern);
  String formatted = formatter.format(date);
  return formatted;
}