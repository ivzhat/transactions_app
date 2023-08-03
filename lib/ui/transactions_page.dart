import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transactions_app/database/transactions_db.dart';
import '../models/transaction.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  Future<List<Transaction>>? futureTransactions;
  final transactionsDB = TransactionsDB();
  final List<Transaction> _transactions = [
    Transaction(
      name: 'Transaction 1',
      date: DateTime.now(),
      type: 'Перевод',
      commission: 10.0,
      total: 100.0,
      number: 123,
    ),
    Transaction(
      name: 'Transaction 2',
      date: DateTime.now(),
      type: 'Пополнение',
      commission: 0.0,
      total: 50.0,
      number: 456,
    ),
    Transaction(
      name: 'Transaction 3',
      date: DateTime.now(),
      type: 'Снятие',
      commission: 0.0,
      total: 50.0,
      number: 789,
    ),
  ];

  @override
  void initState(){
    super.initState();

    fetchTransactions();
    // transactionsDB.create(
    //   name: "Тестовая транзакция 2",
    //   type: "Пополнение",
    //   commission: 2.0,
    //   total: 200.0,
    //   number: 456,  // добавить поле сумма!
    // );
  }

  void fetchTransactions() {
    setState(() {
      futureTransactions = transactionsDB.fetchAll();
    });
    // futureTransactions?.then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Транзакции')),
      body: ListView.builder(
        itemCount: _transactions.length,
        itemBuilder: (context, index) {
          return TransactionItem(
            transaction: _transactions[index],
            onRemove: () {
              setState(() {
                _transactions.removeAt(index);
              });
            },
          );
        },
      ),
    );
  }
}

class TransactionItem extends StatefulWidget {
  final Transaction transaction;
  final VoidCallback onRemove;

  const TransactionItem({super.key, required this.transaction,required this.onRemove,});

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(widget.transaction.name),
          subtitle: Text(DateFormat('dd.MM.y HH:mm').format(widget.transaction.date)),
          trailing: Text(widget.transaction.type),
          onTap: () {
            setState(() {
              _expanded = !_expanded;
            });
          },
        ),
        if (_expanded)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Тип операции: ${widget.transaction.type}'),
                Text('Комиссия: ${widget.transaction.commission}'),
                Text('Итого: ${widget.transaction.total}'),
                Text('Номер транзакции: ${widget.transaction.number}'),
                ElevatedButton(
                  onPressed: widget.onRemove,
                  child: const Text('Удалить'),
                ),
              ],
            ),
          ),
      ],
    );
  }
}