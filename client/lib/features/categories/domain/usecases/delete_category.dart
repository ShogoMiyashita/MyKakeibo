import 'package:dartz/dartz.dart';
import '../../../../core/failures/failure.dart';
import '../repositories/category_repository.dart';

class DeleteCategory {
  final CategoryRepository repository;

  DeleteCategory(this.repository);

  Future<Either<Failure, void>> call(String categoryId) async {
    if (categoryId.isEmpty) {
      return const Left(ValidationFailure(message: '削除するカテゴリが見つかりません'));
    }

    return await repository.deleteCategory(categoryId);
  }
}