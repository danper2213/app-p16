import 'package:intl/intl.dart';

String getDateFormat() {
  DateTime now = DateTime.now();
  final formattedDate = DateFormat('dd/MM/yyyy').format(now);
  return formattedDate;
}
