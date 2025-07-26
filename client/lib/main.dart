import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/transactions/presentation/views/transaction_list_view.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyKakeibo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MainView(),
    );
  }
}

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const TransactionListView(),
    const Center(child: Text('カテゴリ管理（実装予定）')),
    const Center(child: Text('レポート（実装予定）')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: '取引一覧',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'カテゴリ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'レポート',
          ),
        ],
      ),
    );
  }
}
