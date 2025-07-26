import 'package:dartz/dartz.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/failures/failure.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/transaction_local_data_source.dart';
import '../models/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionLocalDataSource localDataSource;

  TransactionRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Transaction>>> getTransactions({
    DateTime? startDate,
    DateTime? endDate,
    String? categoryId,
    TransactionType? type,
  }) async {
    try {
      final String? typeString = type != null 
          ? (type == TransactionType.income ? 'income' : 'expense')
          : null;

      final transactionModels = await localDataSource.getTransactions(
        startDate: startDate,
        endDate: endDate,
        categoryId: categoryId,
        type: typeString,
      );

      final transactions = transactionModels
          .map((model) => model.toEntity())
          .toList();

      return Right(transactions);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Transaction>> getTransactionById(String id) async {
    try {
      final transactionModel = await localDataSource.getTransactionById(id);
      return Right(transactionModel.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Transaction>> createTransaction(Transaction transaction) async {
    try {
      final transactionModel = TransactionModel.fromEntity(transaction);
      final createdModel = await localDataSource.createTransaction(transactionModel);
      return Right(createdModel.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Transaction>> updateTransaction(Transaction transaction) async {
    try {
      final transactionModel = TransactionModel.fromEntity(transaction);
      final updatedModel = await localDataSource.updateTransaction(transactionModel);
      return Right(updatedModel.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTransaction(String id) async {
    try {
      await localDataSource.deleteTransaction(id);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, double>> getTotalAmount({
    DateTime? startDate,
    DateTime? endDate,
    TransactionType? type,
  }) async {
    try {
      final String? typeString = type != null 
          ? (type == TransactionType.income ? 'income' : 'expense')
          : null;

      final transactionModels = await localDataSource.getTransactions(
        startDate: startDate,
        endDate: endDate,
        type: typeString,
      );

      final total = transactionModels
          .map((model) => model.amount)
          .fold(0.0, (sum, amount) => sum + amount);

      return Right(total);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}