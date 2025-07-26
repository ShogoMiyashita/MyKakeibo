import 'package:dartz/dartz.dart';
import '../../../../core/failures/failure.dart';
import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

class UpdateTransaction {
  final TransactionRepository repository;

  UpdateTransaction(this.repository);

  Future<Either<Failure, Transaction>> call(UpdateTransactionParams params) async {
    if (params.amount <= 0) {
      return const Left(ValidationFailure(message: '金額は0より大きい値を入力してください'));
    }

    if (params.categoryId.isEmpty) {
      return const Left(ValidationFailure(message: 'カテゴリを選択してください'));
    }

    final updatedTransaction = params.transaction.copyWith(
      amount: params.amount,
      type: params.type,
      categoryId: params.categoryId,
      date: params.date,
      description: params.description,
      accountId: params.accountId,
      updatedAt: DateTime.now(),
    );

    return await repository.updateTransaction(updatedTransaction);
  }
}

class UpdateTransactionParams {
  final Transaction transaction;
  final double amount;
  final TransactionType type;
  final String categoryId;
  final DateTime date;
  final String? description;
  final String? accountId;

  const UpdateTransactionParams({
    required this.transaction,
    required this.amount,
    required this.type,
    required this.categoryId,
    required this.date,
    this.description,
    this.accountId,
  });
}