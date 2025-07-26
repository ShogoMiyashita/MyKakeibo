import 'package:dartz/dartz.dart';
import '../../../../core/failures/failure.dart';
import '../repositories/transaction_repository.dart';

class DeleteTransaction {
  final TransactionRepository repository;

  DeleteTransaction(this.repository);

  Future<Either<Failure, void>> call(String transactionId) async {
    if (transactionId.isEmpty) {
      return const Left(ValidationFailure(message: '削除する取引が見つかりません'));
    }

    return await repository.deleteTransaction(transactionId);
  }
}