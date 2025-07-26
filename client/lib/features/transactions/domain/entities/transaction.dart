import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';

enum TransactionType {
  income,
  expense,
}

@freezed
abstract class Transaction with _$Transaction {
  const factory Transaction({
    required String id,
    required double amount,
    required TransactionType type,
    required String categoryId,
    required DateTime date,
    String? description,
    String? accountId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Transaction;

  const Transaction._();

  bool get isIncome => type == TransactionType.income;
  bool get isExpense => type == TransactionType.expense;
}
