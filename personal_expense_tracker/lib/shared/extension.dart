import 'package:intl/intl.dart';

extension DoubleExtension on double {
  String toCurrencyFormat() {
    final formatter = this == roundToDouble() ? NumberFormat('#,##0', 'en_US') : NumberFormat('#,##0.00', 'en_US');
    return formatter.format(this);
  }
}

extension DateTimeExtension on DateTime {
  String get toFormattedDate12 => DateFormat('dd MMM yyyy').format(this);
  String get toFormattedDate12Time => DateFormat('dd MMM yyyy, hh:mm a').format(this);
}
