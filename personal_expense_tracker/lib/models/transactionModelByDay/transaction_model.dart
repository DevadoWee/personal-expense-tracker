import 'transaction_category_enum.dart';

class TransactionModel {
  const TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final TransactionCategoryEnum category;

  static final empty = TransactionModel(
    id: '',
    title: '',
    amount: 0,
    date: DateTime.fromMillisecondsSinceEpoch(0),
    category: TransactionCategoryEnum.other,
  );

  TransactionModel copyWith({
    String? id,
    String? title,
    double? amount,
    DateTime? date,
    TransactionCategoryEnum? category,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      category: category ?? this.category,
    );
  }

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String,
      title: json['title'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      category: TransactionCategoryEnum.fromString(json['category'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category.value,
    };
  }

  static List<TransactionModel> toList(List<dynamic> list) => list.map((json) => TransactionModel.fromJson(json as Map<String, dynamic>)).toList();
}
