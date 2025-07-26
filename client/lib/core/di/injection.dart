import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/categories/data/datasources/category_local_data_source.dart';
import '../../features/categories/data/repositories/category_repository_impl.dart';
import '../../features/categories/domain/repositories/category_repository.dart';
import '../../features/categories/domain/usecases/create_category.dart';
import '../../features/categories/domain/usecases/delete_category.dart';
import '../../features/categories/domain/usecases/get_categories.dart';
import '../../features/categories/domain/usecases/update_category.dart';
import '../../features/transactions/data/datasources/transaction_local_data_source.dart';
import '../../features/transactions/data/repositories/transaction_repository_impl.dart';
import '../../features/transactions/domain/repositories/transaction_repository.dart';
import '../../features/transactions/domain/usecases/create_transaction.dart';
import '../../features/transactions/domain/usecases/delete_transaction.dart';
import '../../features/transactions/domain/usecases/get_transactions.dart';
import '../../features/transactions/domain/usecases/update_transaction.dart';

// Data Sources
final transactionLocalDataSourceProvider = Provider<TransactionLocalDataSource>(
  (ref) => TransactionLocalDataSourceImpl(),
);

final categoryLocalDataSourceProvider = Provider<CategoryLocalDataSource>(
  (ref) => CategoryLocalDataSourceImpl(),
);

// Repositories
final transactionRepositoryProvider = Provider<TransactionRepository>(
  (ref) => TransactionRepositoryImpl(
    localDataSource: ref.watch(transactionLocalDataSourceProvider),
  ),
);

final categoryRepositoryProvider = Provider<CategoryRepository>(
  (ref) => CategoryRepositoryImpl(
    localDataSource: ref.watch(categoryLocalDataSourceProvider),
  ),
);

// Use Cases - Transactions
final createTransactionUseCaseProvider = Provider<CreateTransaction>(
  (ref) => CreateTransaction(ref.watch(transactionRepositoryProvider)),
);

final getTransactionsUseCaseProvider = Provider<GetTransactions>(
  (ref) => GetTransactions(ref.watch(transactionRepositoryProvider)),
);

final updateTransactionUseCaseProvider = Provider<UpdateTransaction>(
  (ref) => UpdateTransaction(ref.watch(transactionRepositoryProvider)),
);

final deleteTransactionUseCaseProvider = Provider<DeleteTransaction>(
  (ref) => DeleteTransaction(ref.watch(transactionRepositoryProvider)),
);

// Use Cases - Categories
final createCategoryUseCaseProvider = Provider<CreateCategory>(
  (ref) => CreateCategory(ref.watch(categoryRepositoryProvider)),
);

final getCategoriesUseCaseProvider = Provider<GetCategories>(
  (ref) => GetCategories(ref.watch(categoryRepositoryProvider)),
);

final updateCategoryUseCaseProvider = Provider<UpdateCategory>(
  (ref) => UpdateCategory(ref.watch(categoryRepositoryProvider)),
);

final deleteCategoryUseCaseProvider = Provider<DeleteCategory>(
  (ref) => DeleteCategory(ref.watch(categoryRepositoryProvider)),
);