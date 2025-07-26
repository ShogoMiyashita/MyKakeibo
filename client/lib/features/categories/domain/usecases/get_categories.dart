import 'package:dartz/dartz.dart';
import '../../../../core/failures/failure.dart';
import '../entities/category.dart';
import '../repositories/category_repository.dart';

class GetCategories {
  final CategoryRepository repository;

  GetCategories(this.repository);

  Future<Either<Failure, List<Category>>> call(
      GetCategoriesParams params) async {
    return await repository.getCategories(
      type: params.type,
      isActive: params.isActive,
    );
  }
}

class GetCategoriesParams {
  final CategoryType? type;
  final bool? isActive;

  const GetCategoriesParams({
    this.type,
    this.isActive,
  });
}
