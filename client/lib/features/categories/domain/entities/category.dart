import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';

enum CategoryType {
  income,
  expense,
}

@freezed
class Category with _$Category {
  const factory Category({
    required String id,
    required String name,
    required CategoryType type,
    required String colorCode,
    String? iconName,
    String? parentId,
    @Default(true) bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Category;

  const Category._();

  bool get isIncomeCategory => type == CategoryType.income;
  bool get isExpenseCategory => type == CategoryType.expense;
  bool get hasParent => parentId != null;
}