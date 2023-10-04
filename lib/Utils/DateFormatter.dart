import 'package:intl/intl.dart';

String formatDate(DateTime dateTime) {
  final dateFormat = DateFormat('dd. MMM yyyy', 'en_US');
  return dateFormat.format(dateTime);
}

String getMonthName(DateTime dateTime) {
  final monthFormat = DateFormat('MMMM', 'en_US');
  return monthFormat.format(dateTime);
}
