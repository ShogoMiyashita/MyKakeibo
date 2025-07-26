import 'package:dartz/dartz.dart';
import '../../../../core/failures/failure.dart';
import '../entities/category.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> getCategories({
    CategoryType? type,
    bool? isActive,
  });

  Future<Either<Failure, Category>> getCategoryById(String id);

  Future<Either<Failure, Category>> createCategory(Category category);

  Future<Either<Failure, Category>> updateCategory(Category category);

  Future<Either<Failure, void>> deleteCategory(String id);

  Future<Either<Failure, List<Category>>> getSubCategories(String parentId);
}
