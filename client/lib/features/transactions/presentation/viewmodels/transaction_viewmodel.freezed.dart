// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_viewmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransactionState {
  List<Transaction> get transactions;
  bool get isLoading;
  String? get errorMessage;
  Transaction? get selectedTransaction;

  /// Create a copy of TransactionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TransactionStateCopyWith<TransactionState> get copyWith =>
      _$TransactionStateCopyWithImpl<TransactionState>(
          this as TransactionState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TransactionState &&
            const DeepCollectionEquality()
                .equals(other.transactions, transactions) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.selectedTransaction, selectedTransaction) ||
                other.selectedTransaction == selectedTransaction));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(transactions),
      isLoading,
      errorMessage,
      selectedTransaction);

  @override
  String toString() {
    return 'TransactionState(transactions: $transactions, isLoading: $isLoading, errorMessage: $errorMessage, selectedTransaction: $selectedTransaction)';
  }
}

/// @nodoc
abstract mixin class $TransactionStateCopyWith<$Res> {
  factory $TransactionStateCopyWith(
          TransactionState value, $Res Function(TransactionState) _then) =
      _$TransactionStateCopyWithImpl;
  @useResult
  $Res call(
      {List<Transaction> transactions,
      bool isLoading,
      String? errorMessage,
      Transaction? selectedTransaction});

  $TransactionCopyWith<$Res>? get selectedTransaction;
}

/// @nodoc
class _$TransactionStateCopyWithImpl<$Res>
    implements $TransactionStateCopyWith<$Res> {
  _$TransactionStateCopyWithImpl(this._self, this._then);

  final TransactionState _self;
  final $Res Function(TransactionState) _then;

  /// Create a copy of TransactionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactions = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? selectedTransaction = freezed,
  }) {
    return _then(_self.copyWith(
      transactions: null == transactions
          ? _self.transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<Transaction>,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedTransaction: freezed == selectedTransaction
          ? _self.selectedTransaction
          : selectedTransaction // ignore: cast_nullable_to_non_nullable
              as Transaction?,
    ));
  }

  /// Create a copy of TransactionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransactionCopyWith<$Res>? get selectedTransaction {
    if (_self.selectedTransaction == null) {
      return null;
    }

    return $TransactionCopyWith<$Res>(_self.selectedTransaction!, (value) {
      return _then(_self.copyWith(selectedTransaction: value));
    });
  }
}

/// @nodoc

class _TransactionState implements TransactionState {
  const _TransactionState(
      {final List<Transaction> transactions = const [],
      this.isLoading = false,
      this.errorMessage,
      this.selectedTransaction})
      : _transactions = transactions;

  final List<Transaction> _transactions;
  @override
  @JsonKey()
  List<Transaction> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;
  @override
  final Transaction? selectedTransaction;

  /// Create a copy of TransactionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TransactionStateCopyWith<_TransactionState> get copyWith =>
      __$TransactionStateCopyWithImpl<_TransactionState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TransactionState &&
            const DeepCollectionEquality()
                .equals(other._transactions, _transactions) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.selectedTransaction, selectedTransaction) ||
                other.selectedTransaction == selectedTransaction));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_transactions),
      isLoading,
      errorMessage,
      selectedTransaction);

  @override
  String toString() {
    return 'TransactionState(transactions: $transactions, isLoading: $isLoading, errorMessage: $errorMessage, selectedTransaction: $selectedTransaction)';
  }
}

/// @nodoc
abstract mixin class _$TransactionStateCopyWith<$Res>
    implements $TransactionStateCopyWith<$Res> {
  factory _$TransactionStateCopyWith(
          _TransactionState value, $Res Function(_TransactionState) _then) =
      __$TransactionStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<Transaction> transactions,
      bool isLoading,
      String? errorMessage,
      Transaction? selectedTransaction});

  @override
  $TransactionCopyWith<$Res>? get selectedTransaction;
}

/// @nodoc
class __$TransactionStateCopyWithImpl<$Res>
    implements _$TransactionStateCopyWith<$Res> {
  __$TransactionStateCopyWithImpl(this._self, this._then);

  final _TransactionState _self;
  final $Res Function(_TransactionState) _then;

  /// Create a copy of TransactionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? transactions = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? selectedTransaction = freezed,
  }) {
    return _then(_TransactionState(
      transactions: null == transactions
          ? _self._transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<Transaction>,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedTransaction: freezed == selectedTransaction
          ? _self.selectedTransaction
          : selectedTransaction // ignore: cast_nullable_to_non_nullable
              as Transaction?,
    ));
  }

  /// Create a copy of TransactionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransactionCopyWith<$Res>? get selectedTransaction {
    if (_self.selectedTransaction == null) {
      return null;
    }

    return $TransactionCopyWith<$Res>(_self.selectedTransaction!, (value) {
      return _then(_self.copyWith(selectedTransaction: value));
    });
  }
}

// dart format on
