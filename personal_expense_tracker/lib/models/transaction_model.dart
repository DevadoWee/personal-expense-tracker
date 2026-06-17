enum TransactionCategory {
  food,
  transport,
  entertainment,
  utilities,
  other;

  String get value {
    switch (this) {
      case TransactionCategory.food:
        return 'food';
      case TransactionCategory.transport:
        return 'transport';
      case TransactionCategory.entertainment:
        return 'entertainment';
      case TransactionCategory.utilities:
        return 'utilities';
      case TransactionCategory.other:
        return 'other';
    }
  }

  String get label {
    switch (this) {
      case TransactionCategory.food:
        return 'Food';
      case TransactionCategory.transport:
        return 'Transport';
      case TransactionCategory.entertainment:
        return 'Fun';
      case TransactionCategory.utilities:
        return 'Utilities';
      case TransactionCategory.other:
        return 'Other';
    }
  }

  static TransactionCategory fromString(String value) {
    return TransactionCategory.values.firstWhere(
      (category) => category.value == value.toLowerCase(),
      orElse: () => TransactionCategory.other,
    );
  }
}

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
  final TransactionCategory category;

  static final empty = TransactionModel(
    id: '',
    title: '',
    amount: 0,
    date: DateTime.fromMillisecondsSinceEpoch(0),
    category: TransactionCategory.other,
  );

  TransactionModel copyWith({
    String? id,
    String? title,
    double? amount,
    DateTime? date,
    TransactionCategory? category,
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
      category: TransactionCategory.fromString(json['category'] as String),
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

  static List<TransactionModel> toList(List<dynamic> list) => list
      .map((json) => TransactionModel.fromJson(json as Map<String, dynamic>))
      .toList();
}
