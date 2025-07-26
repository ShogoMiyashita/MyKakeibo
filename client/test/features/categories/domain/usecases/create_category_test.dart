import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mykakeibo/core/failures/failure.dart';
import 'package:mykakeibo/features/categories/domain/entities/category.dart';
import 'package:mykakeibo/features/categories/domain/repositories/category_repository.dart';
import 'package:mykakeibo/features/categories/domain/usecases/create_category.dart';

class MockCategoryRepository extends Mock implements CategoryRepository {}

void main() {
  late CreateCategory useCase;
  late MockCategoryRepository mockRepository;

  setUp(() {
    mockRepository = MockCategoryRepository();
    useCase = CreateCategory(mockRepository);
  });

  group('CreateCategory', () {
    const params = CreateCategoryParams(
      name: 'テストカテゴリ',
      type: CategoryType.expense,
      colorCode: '#FF0000',
      iconName: 'restaurant',
    );

    final category = Category(
      id: 'test_category_id',
      name: 'テストカテゴリ',
      type: CategoryType.expense,
      colorCode: '#FF0000',
      iconName: 'restaurant',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    test('should create category successfully when valid params are provided', () async {
      // arrange
      when(() => mockRepository.createCategory(any()))
          .thenAnswer((_) async => Right(category));

      // act
      final result = await useCase(params);

      // assert
      verify(() => mockRepository.createCategory(any()));
      expect(result, equals(Right(category)));
    });

    test('should return ValidationFailure when name is empty', () async {
      // arrange
      const invalidParams = CreateCategoryParams(
        name: '',
        type: CategoryType.expense,
        colorCode: '#FF0000',
      );

      // act
      final result = await useCase(invalidParams);

      // assert
      expect(result, isA<Left<Failure, Category>>());
      expect(
        (result as Left).value,
        isA<ValidationFailure>().having(
          (f) => f.message,
          'message',
          'カテゴリ名を入力してください',
        ),
      );
      verifyNever(() => mockRepository.createCategory(any()));
    });

    test('should return ValidationFailure when name is only whitespace', () async {
      // arrange
      const invalidParams = CreateCategoryParams(
        name: '   ',
        type: CategoryType.expense,
        colorCode: '#FF0000',
      );

      // act
      final result = await useCase(invalidParams);

      // assert
      expect(result, isA<Left<Failure, Category>>());
      expect(
        (result as Left).value,
        isA<ValidationFailure>().having(
          (f) => f.message,
          'message',
          'カテゴリ名を入力してください',
        ),
      );
      verifyNever(() => mockRepository.createCategory(any()));
    });

    test('should return ValidationFailure when colorCode is empty', () async {
      // arrange
      const invalidParams = CreateCategoryParams(
        name: 'テストカテゴリ',
        type: CategoryType.expense,
        colorCode: '',
      );

      // act
      final result = await useCase(invalidParams);

      // assert
      expect(result, isA<Left<Failure, Category>>());
      expect(
        (result as Left).value,
        isA<ValidationFailure>().having(
          (f) => f.message,
          'message',
          'カテゴリの色を選択してください',
        ),
      );
      verifyNever(() => mockRepository.createCategory(any()));
    });

    test('should trim whitespace from name', () async {
      // arrange
      const paramsWithWhitespace = CreateCategoryParams(
        name: '  テストカテゴリ  ',
        type: CategoryType.expense,
        colorCode: '#FF0000',
      );

      when(() => mockRepository.createCategory(any()))
          .thenAnswer((_) async => Right(category));

      // act
      final result = await useCase(paramsWithWhitespace);

      // assert
      verify(() => mockRepository.createCategory(any()));
      expect(result, isA<Right<Failure, Category>>());
    });

    test('should return repository failure when repository fails', () async {
      // arrange
      const failure = ServerFailure(message: 'Server error');
      when(() => mockRepository.createCategory(any()))
          .thenAnswer((_) async => const Left(failure));

      // act
      final result = await useCase(params);

      // assert
      verify(() => mockRepository.createCategory(any()));
      expect(result, equals(const Left(failure)));
    });
  });
}