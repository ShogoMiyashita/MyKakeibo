import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/category.dart';
import '../../domain/usecases/create_category.dart';
import '../../domain/usecases/delete_category.dart';
import '../../domain/usecases/get_categories.dart';
import '../../domain/usecases/update_category.dart';

part 'category_viewmodel.freezed.dart';

@freezed
abstract class CategoryState with _$CategoryState {
  const factory CategoryState({
    @Default([]) List<Category> categories,
    @Default(false) bool isLoading,
    String? errorMessage,
    Category? selectedCategory,
  }) = _CategoryState;
}

final categoryViewModelProvider =
    StateNotifierProvider<CategoryViewModel, CategoryState>(
  (ref) => CategoryViewModel(
    getCategories: ref.watch(getCategoriesUseCaseProvider),
    createCategory: ref.watch(createCategoryUseCaseProvider),
    updateCategory: ref.watch(updateCategoryUseCaseProvider),
    deleteCategory: ref.watch(deleteCategoryUseCaseProvider),
  ),
);

class CategoryViewModel extends StateNotifier<CategoryState> {
  final GetCategories _getCategories;
  final CreateCategory _createCategory;
  final UpdateCategory _updateCategory;
  final DeleteCategory _deleteCategory;

  CategoryViewModel({
    required GetCategories getCategories,
    required CreateCategory createCategory,
    required UpdateCategory updateCategory,
    required DeleteCategory deleteCategory,
  })  : _getCategories = getCategories,
        _createCategory = createCategory,
        _updateCategory = updateCategory,
        _deleteCategory = deleteCategory,
        super(const CategoryState());

  Future<void> loadCategories({
    CategoryType? type,
    bool? isActive,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _getCategories(GetCategoriesParams(
      type: type,
      isActive: isActive,
    ));

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      ),
      (categories) => state = state.copyWith(
        isLoading: false,
        categories: categories,
      ),
    );
  }

  Future<void> createNewCategory({
    required String name,
    required CategoryType type,
    required String colorCode,
    String? iconName,
    String? parentId,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _createCategory(CreateCategoryParams(
      name: name,
      type: type,
      colorCode: colorCode,
      iconName: iconName,
      parentId: parentId,
    ));

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      ),
      (category) {
        state = state.copyWith(
          isLoading: false,
          categories: [...state.categories, category],
        );
      },
    );
  }

  Future<void> updateExistingCategory({
    required Category category,
    required String name,
    required CategoryType type,
    required String colorCode,
    String? iconName,
    String? parentId,
    bool isActive = true,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _updateCategory(UpdateCategoryParams(
      category: category,
      name: name,
      type: type,
      colorCode: colorCode,
      iconName: iconName,
      parentId: parentId,
      isActive: isActive,
    ));

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      ),
      (updatedCategory) {
        final updatedCategories = state.categories
            .map((c) => c.id == updatedCategory.id ? updatedCategory : c)
            .toList();

        state = state.copyWith(
          isLoading: false,
          categories: updatedCategories,
        );
      },
    );
  }

  Future<void> deleteExistingCategory(String categoryId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _deleteCategory(categoryId);

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      ),
      (_) {
        final updatedCategories =
            state.categories.where((c) => c.id != categoryId).toList();

        state = state.copyWith(
          isLoading: false,
          categories: updatedCategories,
        );
      },
    );
  }

  void selectCategory(Category? category) {
    state = state.copyWith(selectedCategory: category);
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  List<Category> getIncomeCategories() {
    return state.categories
        .where((category) => category.isIncomeCategory && category.isActive)
        .toList();
  }

  List<Category> getExpenseCategories() {
    return state.categories
        .where((category) => category.isExpenseCategory && category.isActive)
        .toList();
  }
}
