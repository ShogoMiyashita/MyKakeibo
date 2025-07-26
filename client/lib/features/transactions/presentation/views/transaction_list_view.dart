import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/transaction.dart';
import '../viewmodels/transaction_viewmodel.dart';
import '../../../categories/presentation/viewmodels/category_viewmodel.dart';

class TransactionListView extends ConsumerStatefulWidget {
  const TransactionListView({super.key});

  @override
  ConsumerState<TransactionListView> createState() =>
      _TransactionListViewState();
}

class _TransactionListViewState extends ConsumerState<TransactionListView> {
  @override
  void initState() {
    super.initState();
    // 初期データロード
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(transactionViewModelProvider.notifier).loadTransactions();
      ref.read(categoryViewModelProvider.notifier).loadCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final transactionState = ref.watch(transactionViewModelProvider);
    final categoryState = ref.watch(categoryViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('取引一覧'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () => _showAddTransactionDialog(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: transactionState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : transactionState.errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'エラー: ${transactionState.errorMessage}',
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => ref
                            .read(transactionViewModelProvider.notifier)
                            .loadTransactions(),
                        child: const Text('再試行'),
                      ),
                    ],
                  ),
                )
              : transactionState.transactions.isEmpty
                  ? const Center(
                      child: Text(
                        '取引データがありません\n右上の+ボタンから取引を追加してください',
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      itemCount: transactionState.transactions.length,
                      itemBuilder: (context, index) {
                        final transaction =
                            transactionState.transactions[index];
                        final category = categoryState.categories
                            .where((c) => c.id == transaction.categoryId)
                            .firstOrNull;

                        return _TransactionTile(
                          transaction: transaction,
                          categoryName: category?.name ?? '不明なカテゴリ',
                          onTap: () =>
                              _showTransactionDetails(context, transaction),
                        );
                      },
                    ),
    );
  }

  void _showAddTransactionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const _AddTransactionDialog(),
    );
  }

  void _showTransactionDetails(BuildContext context, Transaction transaction) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('取引詳細'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('金額: ¥${NumberFormat('#,###').format(transaction.amount)}'),
            Text('種別: ${transaction.isIncome ? '収入' : '支出'}'),
            Text('日付: ${DateFormat('yyyy/MM/dd').format(transaction.date)}'),
            if (transaction.description != null)
              Text('メモ: ${transaction.description}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('閉じる'),
          ),
        ],
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final Transaction transaction;
  final String categoryName;
  final VoidCallback onTap;

  const _TransactionTile({
    required this.transaction,
    required this.categoryName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: transaction.isIncome ? Colors.green : Colors.red,
        child: Icon(
          transaction.isIncome ? Icons.arrow_upward : Icons.arrow_downward,
          color: Colors.white,
        ),
      ),
      title: Text(categoryName),
      subtitle: Text(DateFormat('yyyy/MM/dd').format(transaction.date)),
      trailing: Text(
        '${transaction.isIncome ? '+' : '-'}¥${NumberFormat('#,###').format(transaction.amount)}',
        style: TextStyle(
          color: transaction.isIncome ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _AddTransactionDialog extends ConsumerStatefulWidget {
  const _AddTransactionDialog();

  @override
  ConsumerState<_AddTransactionDialog> createState() =>
      _AddTransactionDialogState();
}

class _AddTransactionDialogState extends ConsumerState<_AddTransactionDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  TransactionType _selectedType = TransactionType.expense;
  String? _selectedCategoryId;
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoryState = ref.watch(categoryViewModelProvider);
    final availableCategories = _selectedType == TransactionType.income
        ? categoryState.categories.where((c) => c.isIncomeCategory).toList()
        : categoryState.categories.where((c) => c.isExpenseCategory).toList();

    return AlertDialog(
      title: const Text('取引を追加'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<TransactionType>(
                value: _selectedType,
                decoration: const InputDecoration(labelText: '種別'),
                items: const [
                  DropdownMenuItem(
                    value: TransactionType.income,
                    child: Text('収入'),
                  ),
                  DropdownMenuItem(
                    value: TransactionType.expense,
                    child: Text('支出'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedType = value!;
                    _selectedCategoryId = null;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategoryId,
                decoration: const InputDecoration(labelText: 'カテゴリ'),
                items: availableCategories
                    .map((category) => DropdownMenuItem(
                          value: category.id,
                          child: Text(category.name),
                        ))
                    .toList(),
                validator: (value) => value == null ? 'カテゴリを選択してください' : null,
                onChanged: (value) =>
                    setState(() => _selectedCategoryId = value),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: '金額'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '金額を入力してください';
                  }
                  if (double.tryParse(value) == null ||
                      double.parse(value) <= 0) {
                    return '正しい金額を入力してください';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'メモ（任意）'),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(
                    '日付: ${DateFormat('yyyy/MM/dd').format(_selectedDate)}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: _selectDate,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        ElevatedButton(
          onPressed: _submitTransaction,
          child: const Text('追加'),
        ),
      ],
    );
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }

  void _submitTransaction() {
    if (_formKey.currentState!.validate()) {
      ref.read(transactionViewModelProvider.notifier).createNewTransaction(
            amount: double.parse(_amountController.text),
            type: _selectedType,
            categoryId: _selectedCategoryId!,
            date: _selectedDate,
            description: _descriptionController.text.isNotEmpty
                ? _descriptionController.text
                : null,
          );
      Navigator.of(context).pop();
    }
  }
}
