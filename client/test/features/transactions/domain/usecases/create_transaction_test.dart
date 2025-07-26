import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mykakeibo/core/failures/failure.dart';
import 'package:mykakeibo/features/transactions/domain/entities/transaction.dart';
import 'package:mykakeibo/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:mykakeibo/features/transactions/domain/usecases/create_transaction.dart';

class MockTransactionRepository extends Mock implements TransactionRepository {}

void main() {
  late CreateTransaction useCase;
  late MockTransactionRepository mockRepository;

  setUp(() {
    mockRepository = MockTransactionRepository();
    useCase = CreateTransaction(mockRepository);
  });

  group('CreateTransaction', () {
    final testDate = DateTime.now();
    final params = CreateTransactionParams(
      amount: 1000.0,
      type: TransactionType.expense,
      categoryId: 'test_category_id',
      date: testDate,
    );

    final transaction = Transaction(
      id: 'test_id',
      amount: 1000.0,
      type: TransactionType.expense,
      categoryId: 'test_category_id',
      date: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    test(
        'should create transaction successfully when valid params are provided',
        () async {
      // arrange
      when(() => mockRepository.createTransaction(any()))
          .thenAnswer((_) async => Right(transaction));

      // act
      final result = await useCase(params);

      // assert
      verify(() => mockRepository.createTransaction(any()));
      expect(result, equals(Right(transaction)));
    });

    test('should return ValidationFailure when amount is zero or negative',
        () async {
      // arrange
      final invalidParams = CreateTransactionParams(
        amount: 0.0,
        type: TransactionType.expense,
        categoryId: 'test_category_id',
        date: testDate,
      );

      // act
      final result = await useCase(invalidParams);

      // assert
      expect(result, isA<Left<Failure, Transaction>>());
      expect(
        (result as Left).value,
        isA<ValidationFailure>().having(
          (f) => f.message,
          'message',
          '金額は0より大きい値を入力してください',
        ),
      );
      verifyNever(() => mockRepository.createTransaction(any()));
    });

    test('should return ValidationFailure when categoryId is empty', () async {
      // arrange
      final invalidParams = CreateTransactionParams(
        amount: 1000.0,
        type: TransactionType.expense,
        categoryId: '',
        date: testDate,
      );

      // act
      final result = await useCase(invalidParams);

      // assert
      expect(result, isA<Left<Failure, Transaction>>());
      expect(
        (result as Left).value,
        isA<ValidationFailure>().having(
          (f) => f.message,
          'message',
          'カテゴリを選択してください',
        ),
      );
      verifyNever(() => mockRepository.createTransaction(any()));
    });

    test('should return repository failure when repository fails', () async {
      // arrange
      const failure = ServerFailure(message: 'Server error');
      when(() => mockRepository.createTransaction(any()))
          .thenAnswer((_) async => const Left(failure));

      // act
      final result = await useCase(params);

      // assert
      verify(() => mockRepository.createTransaction(any()));
      expect(result, equals(const Left(failure)));
    });
  });
}
