import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/category.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

@freezed
abstract class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    required String id,
    required String name,
    required String type,
    required String colorCode,
    String? iconName,
    String? parentId,
    @Default(true) bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _CategoryModel;

  const CategoryModel._();

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Category toEntity() {
    return Category(
      id: id,
      name: name,
      type: type == 'income' ? CategoryType.income : CategoryType.expense,
      colorCode: colorCode,
      iconName: iconName,
      parentId: parentId,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static CategoryModel fromEntity(Category category) {
    return CategoryModel(
      id: category.id,
      name: category.name,
      type: category.type == CategoryType.income ? 'income' : 'expense',
      colorCode: category.colorCode,
      iconName: category.iconName,
      parentId: category.parentId,
      isActive: category.isActive,
      createdAt: category.createdAt,
      updatedAt: category.updatedAt,
    );
  }
}
