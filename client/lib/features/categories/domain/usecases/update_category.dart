import 'package:dartz/dartz.dart';
import '../../../../core/failures/failure.dart';
import '../entities/category.dart';
import '../repositories/category_repository.dart';

class UpdateCategory {
  final CategoryRepository repository;

  UpdateCategory(this.repository);

  Future<Either<Failure, Category>> call(UpdateCategoryParams params) async {
    if (params.name.trim().isEmpty) {
      return const Left(ValidationFailure(message: 'カテゴリ名を入力してください'));
    }

    if (params.colorCode.isEmpty) {
      return const Left(ValidationFailure(message: 'カテゴリの色を選択してください'));
    }

    final updatedCategory = params.category.copyWith(
      name: params.name.trim(),
      type: params.type,
      colorCode: params.colorCode,
      iconName: params.iconName,
      parentId: params.parentId,
      isActive: params.isActive,
      updatedAt: DateTime.now(),
    );

    return await repository.updateCategory(updatedCategory);
  }
}

class UpdateCategoryParams {
  final Category category;
  final String name;
  final CategoryType type;
  final String colorCode;
  final String? iconName;
  final String? parentId;
  final bool isActive;

  const UpdateCategoryParams({
    required this.category,
    required this.name,
    required this.type,
    required this.colorCode,
    this.iconName,
    this.parentId,
    this.isActive = true,
  });
}