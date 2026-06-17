import 'transaction_model.dart';

class TransactionModelByDay {
  const TransactionModelByDay({
    required this.date,
    required this.total,
    required this.transactions,
  });

  final DateTime date;
  final double total;
  final List<TransactionModel> transactions;

  static final empty = TransactionModelByDay(
    date: DateTime.fromMillisecondsSinceEpoch(0),
    total: 0,
    transactions: const [],
  );

  TransactionModelByDay copyWith({
    DateTime? date,
    double? total,
    List<TransactionModel>? transactions,
  }) {
    return TransactionModelByDay(
      date: date ?? this.date,
      total: total ?? this.total,
      transactions: transactions ?? this.transactions,
    );
  }

  factory TransactionModelByDay.fromJson(Map<String, dynamic> json) {
    return TransactionModelByDay(
      date: DateTime.parse(json['date'] as String),
      total: (json['total'] as num?)?.toDouble() ?? 0,
      transactions: TransactionModel.toList(json['transactions'] as List<dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'total': total,
      'transactions': transactions.map((transaction) => transaction.toJson()).toList(),
    };
  }

  static List<TransactionModelByDay> toList(List<dynamic> list) => list.map((json) => TransactionModelByDay.fromJson(json as Map<String, dynamic>)).toList();
}
