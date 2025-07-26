// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_viewmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CategoryState {
  List<Category> get categories;
  bool get isLoading;
  String? get errorMessage;
  Category? get selectedCategory;

  /// Create a copy of CategoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CategoryStateCopyWith<CategoryState> get copyWith =>
      _$CategoryStateCopyWithImpl<CategoryState>(
          this as CategoryState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CategoryState &&
            const DeepCollectionEquality()
                .equals(other.categories, categories) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.selectedCategory, selectedCategory) ||
                other.selectedCategory == selectedCategory));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(categories),
      isLoading,
      errorMessage,
      selectedCategory);

  @override
  String toString() {
    return 'CategoryState(categories: $categories, isLoading: $isLoading, errorMessage: $errorMessage, selectedCategory: $selectedCategory)';
  }
}

/// @nodoc
abstract mixin class $CategoryStateCopyWith<$Res> {
  factory $CategoryStateCopyWith(
          CategoryState value, $Res Function(CategoryState) _then) =
      _$CategoryStateCopyWithImpl;
  @useResult
  $Res call(
      {List<Category> categories,
      bool isLoading,
      String? errorMessage,
      Category? selectedCategory});

  $CategoryCopyWith<$Res>? get selectedCategory;
}

/// @nodoc
class _$CategoryStateCopyWithImpl<$Res>
    implements $CategoryStateCopyWith<$Res> {
  _$CategoryStateCopyWithImpl(this._self, this._then);

  final CategoryState _self;
  final $Res Function(CategoryState) _then;

  /// Create a copy of CategoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? selectedCategory = freezed,
  }) {
    return _then(_self.copyWith(
      categories: null == categories
          ? _self.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<Category>,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedCategory: freezed == selectedCategory
          ? _self.selectedCategory
          : selectedCategory // ignore: cast_nullable_to_non_nullable
              as Category?,
    ));
  }

  /// Create a copy of CategoryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CategoryCopyWith<$Res>? get selectedCategory {
    if (_self.selectedCategory == null) {
      return null;
    }

    return $CategoryCopyWith<$Res>(_self.selectedCategory!, (value) {
      return _then(_self.copyWith(selectedCategory: value));
    });
  }
}

/// @nodoc

class _CategoryState implements CategoryState {
  const _CategoryState(
      {final List<Category> categories = const [],
      this.isLoading = false,
      this.errorMessage,
      this.selectedCategory})
      : _categories = categories;

  final List<Category> _categories;
  @override
  @JsonKey()
  List<Category> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;
  @override
  final Category? selectedCategory;

  /// Create a copy of CategoryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CategoryStateCopyWith<_CategoryState> get copyWith =>
      __$CategoryStateCopyWithImpl<_CategoryState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CategoryState &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.selectedCategory, selectedCategory) ||
                other.selectedCategory == selectedCategory));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_categories),
      isLoading,
      errorMessage,
      selectedCategory);

  @override
  String toString() {
    return 'CategoryState(categories: $categories, isLoading: $isLoading, errorMessage: $errorMessage, selectedCategory: $selectedCategory)';
  }
}

/// @nodoc
abstract mixin class _$CategoryStateCopyWith<$Res>
    implements $CategoryStateCopyWith<$Res> {
  factory _$CategoryStateCopyWith(
          _CategoryState value, $Res Function(_CategoryState) _then) =
      __$CategoryStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<Category> categories,
      bool isLoading,
      String? errorMessage,
      Category? selectedCategory});

  @override
  $CategoryCopyWith<$Res>? get selectedCategory;
}

/// @nodoc
class __$CategoryStateCopyWithImpl<$Res>
    implements _$CategoryStateCopyWith<$Res> {
  __$CategoryStateCopyWithImpl(this._self, this._then);

  final _CategoryState _self;
  final $Res Function(_CategoryState) _then;

  /// Create a copy of CategoryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? categories = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? selectedCategory = freezed,
  }) {
    return _then(_CategoryState(
      categories: null == categories
          ? _self._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<Category>,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedCategory: freezed == selectedCategory
          ? _self.selectedCategory
          : selectedCategory // ignore: cast_nullable_to_non_nullable
              as Category?,
    ));
  }

  /// Create a copy of CategoryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CategoryCopyWith<$Res>? get selectedCategory {
    if (_self.selectedCategory == null) {
      return null;
    }

    return $CategoryCopyWith<$Res>(_self.selectedCategory!, (value) {
      return _then(_self.copyWith(selectedCategory: value));
    });
  }
}

// dart format on
