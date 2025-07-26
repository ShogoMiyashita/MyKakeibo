import 'package:dartz/dartz.dart';
import '../../../../core/failures/failure.dart';
import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

class GetTransactions {
  final TransactionRepository repository;

  GetTransactions(this.repository);

  Future<Either<Failure, List<Transaction>>> call(
      GetTransactionsParams params) async {
    return await repository.getTransactions(
      startDate: params.startDate,
      endDate: params.endDate,
      categoryId: params.categoryId,
      type: params.type,
    );
  }
}

class GetTransactionsParams {
  final DateTime? startDate;
  final DateTime? endDate;
  final String? categoryId;
  final TransactionType? type;

  const GetTransactionsParams({
    this.startDate,
    this.endDate,
    this.categoryId,
    this.type,
  });
}
