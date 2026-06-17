import 'package:intl/intl.dart';

extension DoubleExtension on double {
  String toCurrencyFormat() {
    final formatter = this == roundToDouble() ? NumberFormat('#,##0', 'en_US') : NumberFormat('#,##0.00', 'en_US');
    return formatter.format(this);
  }
}
