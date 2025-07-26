import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/usecases/create_transaction.dart';
import '../../domain/usecases/delete_transaction.dart';
import '../../domain/usecases/get_transactions.dart';
import '../../domain/usecases/update_transaction.dart';

part 'transaction_viewmodel.freezed.dart';

@freezed
class TransactionState with _$TransactionState {
  const factory TransactionState({
    @Default([]) List<Transaction> transactions,
    @Default(false) bool isLoading,
    String? errorMessage,
    Transaction? selectedTransaction,
  }) = _TransactionState;
}

final transactionViewModelProvider = StateNotifierProvider<TransactionViewModel, TransactionState>(
  (ref) => TransactionViewModel(
    getTransactions: ref.watch(getTransactionsUseCaseProvider),
    createTransaction: ref.watch(createTransactionUseCaseProvider),
    updateTransaction: ref.watch(updateTransactionUseCaseProvider),
    deleteTransaction: ref.watch(deleteTransactionUseCaseProvider),
  ),
);

class TransactionViewModel extends StateNotifier<TransactionState> {
  final GetTransactions _getTransactions;
  final CreateTransaction _createTransaction;
  final UpdateTransaction _updateTransaction;
  final DeleteTransaction _deleteTransaction;

  TransactionViewModel({
    required GetTransactions getTransactions,
    required CreateTransaction createTransaction,
    required UpdateTransaction updateTransaction,
    required DeleteTransaction deleteTransaction,
  })  : _getTransactions = getTransactions,
        _createTransaction = createTransaction,
        _updateTransaction = updateTransaction,
        _deleteTransaction = deleteTransaction,
        super(const TransactionState());

  Future<void> loadTransactions({
    DateTime? startDate,
    DateTime? endDate,
    String? categoryId,
    TransactionType? type,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _getTransactions(GetTransactionsParams(
      startDate: startDate,
      endDate: endDate,
      categoryId: categoryId,
      type: type,
    ));

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      ),
      (transactions) => state = state.copyWith(
        isLoading: false,
        transactions: transactions,
      ),
    );
  }

  Future<void> createNewTransaction({
    required double amount,
    required TransactionType type,
    required String categoryId,
    required DateTime date,
    String? description,
    String? accountId,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _createTransaction(CreateTransactionParams(
      amount: amount,
      type: type,
      categoryId: categoryId,
      date: date,
      description: description,
      accountId: accountId,
    ));

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      ),
      (transaction) {
        state = state.copyWith(
          isLoading: false,
          transactions: [...state.transactions, transaction],
        );
      },
    );
  }

  Future<void> updateExistingTransaction({
    required Transaction transaction,
    required double amount,
    required TransactionType type,
    required String categoryId,
    required DateTime date,
    String? description,
    String? accountId,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _updateTransaction(UpdateTransactionParams(
      transaction: transaction,
      amount: amount,
      type: type,
      categoryId: categoryId,
      date: date,
      description: description,
      accountId: accountId,
    ));

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      ),
      (updatedTransaction) {
        final updatedTransactions = state.transactions
            .map((t) => t.id == updatedTransaction.id ? updatedTransaction : t)
            .toList();
        
        state = state.copyWith(
          isLoading: false,
          transactions: updatedTransactions,
        );
      },
    );
  }

  Future<void> deleteExistingTransaction(String transactionId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _deleteTransaction(transactionId);

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      ),
      (_) {
        final updatedTransactions = state.transactions
            .where((t) => t.id != transactionId)
            .toList();
        
        state = state.copyWith(
          isLoading: false,
          transactions: updatedTransactions,
        );
      },
    );
  }

  void selectTransaction(Transaction? transaction) {
    state = state.copyWith(selectedTransaction: transaction);
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}