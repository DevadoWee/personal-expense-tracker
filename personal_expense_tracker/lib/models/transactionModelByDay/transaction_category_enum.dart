enum TransactionCategoryEnum {
  food,
  transport,
  entertainment,
  utilities,
  other;

  String get value {
    switch (this) {
      case TransactionCategoryEnum.food:
        return 'food';
      case TransactionCategoryEnum.transport:
        return 'transport';
      case TransactionCategoryEnum.entertainment:
        return 'entertainment';
      case TransactionCategoryEnum.utilities:
        return 'utilities';
      case TransactionCategoryEnum.other:
        return 'other';
    }
  }

  String get label {
    switch (this) {
      case TransactionCategoryEnum.food:
        return 'Food';
      case TransactionCategoryEnum.transport:
        return 'Transport';
      case TransactionCategoryEnum.entertainment:
        return 'Fun';
      case TransactionCategoryEnum.utilities:
        return 'Utilities';
      case TransactionCategoryEnum.other:
        return 'Other';
    }
  }

  static TransactionCategoryEnum fromString(String value) {
    return TransactionCategoryEnum.values.firstWhere(
      (category) => category.value == value.toLowerCase(),
      orElse: () => TransactionCategoryEnum.other,
    );
  }
}
