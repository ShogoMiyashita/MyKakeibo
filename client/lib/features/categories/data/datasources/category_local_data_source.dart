import '../../../../core/exceptions/exceptions.dart';
import '../models/category_model.dart';

abstract class CategoryLocalDataSource {
  Future<List<CategoryModel>> getCategories({
    String? type,
    bool? isActive,
  });

  Future<CategoryModel> getCategoryById(String id);

  Future<CategoryModel> createCategory(CategoryModel category);

  Future<CategoryModel> updateCategory(CategoryModel category);

  Future<void> deleteCategory(String id);

  Future<List<CategoryModel>> getSubCategories(String parentId);
}

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  // インメモリデータストレージ（MVP用の簡易実装）
  final List<CategoryModel> _categories = [
    // デフォルトカテゴリを事前に追加
    CategoryModel(
      id: 'income_salary',
      name: '給与',
      type: 'income',
      colorCode: '#4CAF50',
      iconName: 'work',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    CategoryModel(
      id: 'expense_food',
      name: '食費',
      type: 'expense',
      colorCode: '#FF9800',
      iconName: 'restaurant',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    CategoryModel(
      id: 'expense_transport',
      name: '交通費',
      type: 'expense',
      colorCode: '#2196F3',
      iconName: 'directions_car',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  @override
  Future<List<CategoryModel>> getCategories({
    String? type,
    bool? isActive,
  }) async {
    // 実際のDBクエリをシミュレート
    await Future.delayed(const Duration(milliseconds: 100));

    var filteredCategories = _categories.toList();

    if (type != null) {
      filteredCategories =
          filteredCategories.where((c) => c.type == type).toList();
    }

    if (isActive != null) {
      filteredCategories =
          filteredCategories.where((c) => c.isActive == isActive).toList();
    }

    return filteredCategories;
  }

  @override
  Future<CategoryModel> getCategoryById(String id) async {
    await Future.delayed(const Duration(milliseconds: 50));

    try {
      return _categories.firstWhere((c) => c.id == id);
    } catch (e) {
      throw const CacheException(message: 'カテゴリが見つかりません');
    }
  }

  @override
  Future<CategoryModel> createCategory(CategoryModel category) async {
    await Future.delayed(const Duration(milliseconds: 100));

    _categories.add(category);
    return category;
  }

  @override
  Future<CategoryModel> updateCategory(CategoryModel category) async {
    await Future.delayed(const Duration(milliseconds: 100));

    final index = _categories.indexWhere((c) => c.id == category.id);
    if (index == -1) {
      throw const CacheException(message: '更新対象のカテゴリが見つかりません');
    }

    _categories[index] = category;
    return category;
  }

  @override
  Future<void> deleteCategory(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));

    final index = _categories.indexWhere((c) => c.id == id);
    if (index == -1) {
      throw const CacheException(message: '削除対象のカテゴリが見つかりません');
    }

    _categories.removeAt(index);
  }

  @override
  Future<List<CategoryModel>> getSubCategories(String parentId) async {
    await Future.delayed(const Duration(milliseconds: 100));

    return _categories.where((c) => c.parentId == parentId).toList();
  }
}
