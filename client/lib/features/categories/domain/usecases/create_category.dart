import 'package:dartz/dartz.dart';
import '../../../../core/failures/failure.dart';
import '../entities/category.dart';
import '../repositories/category_repository.dart';

class CreateCategory {
  final CategoryRepository repository;

  CreateCategory(this.repository);

  Future<Either<Failure, Category>> call(CreateCategoryParams params) async {
    if (params.name.trim().isEmpty) {
      return const Left(ValidationFailure(message: 'カテゴリ名を入力してください'));
    }

    if (params.colorCode.isEmpty) {
      return const Left(ValidationFailure(message: 'カテゴリの色を選択してください'));
    }

    final category = Category(
      id: params.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: params.name.trim(),
      type: params.type,
      colorCode: params.colorCode,
      iconName: params.iconName,
      parentId: params.parentId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    return await repository.createCategory(category);
  }
}

class CreateCategoryParams {
  final String? id;
  final String name;
  final CategoryType type;
  final String colorCode;
  final String? iconName;
  final String? parentId;

  const CreateCategoryParams({
    this.id,
    required this.name,
    required this.type,
    required this.colorCode,
    this.iconName,
    this.parentId,
  });
}