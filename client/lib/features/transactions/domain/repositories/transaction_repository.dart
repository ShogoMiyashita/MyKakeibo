import 'package:dartz/dartz.dart';
import '../../../../core/failures/failure.dart';
import '../entities/transaction.dart';

abstract class TransactionRepository {
  Future<Either<Failure, List<Transaction>>> getTransactions({
    DateTime? startDate,
    DateTime? endDate,
    String? categoryId,
    TransactionType? type,
  });

  Future<Either<Failure, Transaction>> getTransactionById(String id);

  Future<Either<Failure, Transaction>> createTransaction(
      Transaction transaction);

  Future<Either<Failure, Transaction>> updateTransaction(
      Transaction transaction);

  Future<Either<Failure, void>> deleteTransaction(String id);

  Future<Either<Failure, double>> getTotalAmount({
    DateTime? startDate,
    DateTime? endDate,
    TransactionType? type,
  });
}
