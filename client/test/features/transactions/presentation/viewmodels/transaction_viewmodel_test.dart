import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mykakeibo/core/failures/failure.dart';
import 'package:mykakeibo/features/transactions/domain/entities/transaction.dart';
import 'package:mykakeibo/features/transactions/domain/usecases/create_transaction.dart';
import 'package:mykakeibo/features/transactions/domain/usecases/delete_transaction.dart';
import 'package:mykakeibo/features/transactions/domain/usecases/get_transactions.dart';
import 'package:mykakeibo/features/transactions/domain/usecases/update_transaction.dart';
import 'package:mykakeibo/features/transactions/presentation/viewmodels/transaction_viewmodel.dart';

class MockGetTransactions extends Mock implements GetTransactions {}
class MockCreateTransaction extends Mock implements CreateTransaction {}
class MockUpdateTransaction extends Mock implements UpdateTransaction {}
class MockDeleteTransaction extends Mock implements DeleteTransaction {}

void main() {
  late MockGetTransactions mockGetTransactions;
  late MockCreateTransaction mockCreateTransaction;
  late MockUpdateTransaction mockUpdateTransaction;
  late MockDeleteTransaction mockDeleteTransaction;
  late ProviderContainer container;

  setUp(() {
    mockGetTransactions = MockGetTransactions();
    mockCreateTransaction = MockCreateTransaction();
    mockUpdateTransaction = MockUpdateTransaction();
    mockDeleteTransaction = MockDeleteTransaction();

    container = ProviderContainer(
      overrides: [
        transactionViewModelProvider.overrideWith((ref) => TransactionViewModel(
          getTransactions: mockGetTransactions,
          createTransaction: mockCreateTransaction,
          updateTransaction: mockUpdateTransaction,
          deleteTransaction: mockDeleteTransaction,
        )),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('TransactionViewModel', () {
    final testTransaction = Transaction(
      id: 'test_id',
      amount: 1000.0,
      type: TransactionType.expense,
      categoryId: 'test_category_id',
      date: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    group('loadTransactions', () {
      test('should emit loading state then success state', () async {
        // arrange
        when(() => mockGetTransactions(any()))
            .thenAnswer((_) async => Right([testTransaction]));

        final notifier = container.read(transactionViewModelProvider.notifier);

        // act
        final future = notifier.loadTransactions();

        // assert loading state
        expect(
          container.read(transactionViewModelProvider).isLoading,
          true,
        );

        await future;

        // assert success state
        final finalState = container.read(transactionViewModelProvider);
        expect(finalState.isLoading, false);
        expect(finalState.transactions, [testTransaction]);
        expect(finalState.errorMessage, null);
      });

      test('should emit loading state then error state on failure', () async {
        // arrange
        const failure = ServerFailure(message: 'Server error');
        when(() => mockGetTransactions(any()))
            .thenAnswer((_) async => const Left(failure));

        final notifier = container.read(transactionViewModelProvider.notifier);

        // act
        final future = notifier.loadTransactions();

        // assert loading state
        expect(
          container.read(transactionViewModelProvider).isLoading,
          true,
        );

        await future;

        // assert error state
        final finalState = container.read(transactionViewModelProvider);
        expect(finalState.isLoading, false);
        expect(finalState.transactions, isEmpty);
        expect(finalState.errorMessage, 'Server error');
      });
    });

    group('createNewTransaction', () {
      test('should add transaction to list on success', () async {
        // arrange
        when(() => mockCreateTransaction(any()))
            .thenAnswer((_) async => Right(testTransaction));

        final notifier = container.read(transactionViewModelProvider.notifier);

        // act
        await notifier.createNewTransaction(
          amount: 1000.0,
          type: TransactionType.expense,
          categoryId: 'test_category_id',
          date: DateTime.now(),
        );

        // assert
        final finalState = container.read(transactionViewModelProvider);
        expect(finalState.isLoading, false);
        expect(finalState.transactions, contains(testTransaction));
        expect(finalState.errorMessage, null);
      });

      test('should emit error state on failure', () async {
        // arrange
        const failure = ValidationFailure(message: 'Validation error');
        when(() => mockCreateTransaction(any()))
            .thenAnswer((_) async => const Left(failure));

        final notifier = container.read(transactionViewModelProvider.notifier);

        // act
        await notifier.createNewTransaction(
          amount: 0.0,
          type: TransactionType.expense,
          categoryId: 'test_category_id',
          date: DateTime.now(),
        );

        // assert
        final finalState = container.read(transactionViewModelProvider);
        expect(finalState.isLoading, false);
        expect(finalState.transactions, isEmpty);
        expect(finalState.errorMessage, 'Validation error');
      });
    });

    group('deleteExistingTransaction', () {
      test('should remove transaction from list on success', () async {
        // arrange
        // まず取引をリストに追加
        when(() => mockGetTransactions(any()))
            .thenAnswer((_) async => Right([testTransaction]));
        
        final notifier = container.read(transactionViewModelProvider.notifier);
        await notifier.loadTransactions();

        // 削除のモック設定
        when(() => mockDeleteTransaction(any()))
            .thenAnswer((_) async => const Right(null));

        // act
        await notifier.deleteExistingTransaction('test_id');

        // assert
        final finalState = container.read(transactionViewModelProvider);
        expect(finalState.isLoading, false);
        expect(finalState.transactions, isEmpty);
        expect(finalState.errorMessage, null);
      });
    });

    group('selectTransaction', () {
      test('should update selectedTransaction', () {
        // arrange
        final notifier = container.read(transactionViewModelProvider.notifier);

        // act
        notifier.selectTransaction(testTransaction);

        // assert
        final state = container.read(transactionViewModelProvider);
        expect(state.selectedTransaction, testTransaction);
      });
    });

    group('clearError', () {
      test('should clear error message', () async {
        // arrange - まずエラー状態にする
        const failure = ValidationFailure(message: 'Test error');
        when(() => mockCreateTransaction(any()))
            .thenAnswer((_) async => const Left(failure));

        final notifier = container.read(transactionViewModelProvider.notifier);
        await notifier.createNewTransaction(
          amount: 0.0,
          type: TransactionType.expense,
          categoryId: '',
          date: DateTime.now(),
        );

        // エラーがあることを確認
        expect(
          container.read(transactionViewModelProvider).errorMessage,
          'Test error',
        );

        // act
        notifier.clearError();

        // assert
        expect(
          container.read(transactionViewModelProvider).errorMessage,
          null,
        );
      });
    });
  });
}