import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/transaction.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required String id,
    required double amount,
    required String type,
    required String categoryId,
    required DateTime date,
    String? description,
    String? accountId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _TransactionModel;

  const TransactionModel._();

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Transaction toEntity() {
    return Transaction(
      id: id,
      amount: amount,
      type: type == 'income' ? TransactionType.income : TransactionType.expense,
      categoryId: categoryId,
      date: date,
      description: description,
      accountId: accountId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static TransactionModel fromEntity(Transaction transaction) {
    return TransactionModel(
      id: transaction.id,
      amount: transaction.amount,
      type: transaction.type == TransactionType.income ? 'income' : 'expense',
      categoryId: transaction.categoryId,
      date: transaction.date,
      description: transaction.description,
      accountId: transaction.accountId,
      createdAt: transaction.createdAt,
      updatedAt: transaction.updatedAt,
    );
  }
}