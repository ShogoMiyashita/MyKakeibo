import '../../../../core/exceptions/exceptions.dart';
import '../models/transaction_model.dart';

abstract class TransactionLocalDataSource {
  Future<List<TransactionModel>> getTransactions({
    DateTime? startDate,
    DateTime? endDate,
    String? categoryId,
    String? type,
  });

  Future<TransactionModel> getTransactionById(String id);

  Future<TransactionModel> createTransaction(TransactionModel transaction);

  Future<TransactionModel> updateTransaction(TransactionModel transaction);

  Future<void> deleteTransaction(String id);
}

class TransactionLocalDataSourceImpl implements TransactionLocalDataSource {
  // インメモリデータストレージ（MVP用の簡易実装）
  final List<TransactionModel> _transactions = [];

  @override
  Future<List<TransactionModel>> getTransactions({
    DateTime? startDate,
    DateTime? endDate,
    String? categoryId,
    String? type,
  }) async {
    // 実際のDBクエリをシミュレート
    await Future.delayed(const Duration(milliseconds: 100));

    var filteredTransactions = _transactions.toList();

    if (startDate != null) {
      filteredTransactions = filteredTransactions
          .where((t) =>
              t.date.isAfter(startDate) || t.date.isAtSameMomentAs(startDate))
          .toList();
    }

    if (endDate != null) {
      filteredTransactions = filteredTransactions
          .where((t) =>
              t.date.isBefore(endDate) || t.date.isAtSameMomentAs(endDate))
          .toList();
    }

    if (categoryId != null) {
      filteredTransactions = filteredTransactions
          .where((t) => t.categoryId == categoryId)
          .toList();
    }

    if (type != null) {
      filteredTransactions =
          filteredTransactions.where((t) => t.type == type).toList();
    }

    return filteredTransactions;
  }

  @override
  Future<TransactionModel> getTransactionById(String id) async {
    await Future.delayed(const Duration(milliseconds: 50));

    try {
      return _transactions.firstWhere((t) => t.id == id);
    } catch (e) {
      throw const CacheException(message: '取引が見つかりません');
    }
  }

  @override
  Future<TransactionModel> createTransaction(
      TransactionModel transaction) async {
    await Future.delayed(const Duration(milliseconds: 100));

    _transactions.add(transaction);
    return transaction;
  }

  @override
  Future<TransactionModel> updateTransaction(
      TransactionModel transaction) async {
    await Future.delayed(const Duration(milliseconds: 100));

    final index = _transactions.indexWhere((t) => t.id == transaction.id);
    if (index == -1) {
      throw const CacheException(message: '更新対象の取引が見つかりません');
    }

    _transactions[index] = transaction;
    return transaction;
  }

  @override
  Future<void> deleteTransaction(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));

    final index = _transactions.indexWhere((t) => t.id == id);
    if (index == -1) {
      throw const CacheException(message: '削除対象の取引が見つかりません');
    }

    _transactions.removeAt(index);
  }
}
