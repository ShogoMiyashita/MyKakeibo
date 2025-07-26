import 'package:dartz/dartz.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/failures/failure.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_local_data_source.dart';
import '../models/category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryLocalDataSource localDataSource;

  CategoryRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Category>>> getCategories({
    CategoryType? type,
    bool? isActive,
  }) async {
    try {
      final String? typeString = type != null 
          ? (type == CategoryType.income ? 'income' : 'expense')
          : null;

      final categoryModels = await localDataSource.getCategories(
        type: typeString,
        isActive: isActive,
      );

      final categories = categoryModels
          .map((model) => model.toEntity())
          .toList();

      return Right(categories);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Category>> getCategoryById(String id) async {
    try {
      final categoryModel = await localDataSource.getCategoryById(id);
      return Right(categoryModel.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Category>> createCategory(Category category) async {
    try {
      final categoryModel = CategoryModel.fromEntity(category);
      final createdModel = await localDataSource.createCategory(categoryModel);
      return Right(createdModel.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Category>> updateCategory(Category category) async {
    try {
      final categoryModel = CategoryModel.fromEntity(category);
      final updatedModel = await localDataSource.updateCategory(categoryModel);
      return Right(updatedModel.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCategory(String id) async {
    try {
      await localDataSource.deleteCategory(id);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getSubCategories(String parentId) async {
    try {
      final categoryModels = await localDataSource.getSubCategories(parentId);
      final categories = categoryModels
          .map((model) => model.toEntity())
          .toList();

      return Right(categories);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}