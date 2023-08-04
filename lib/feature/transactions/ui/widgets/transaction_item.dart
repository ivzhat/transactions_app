import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  final Transaction transaction;
  final VoidCallback onRemove;

  const TransactionItem(
      {super.key, required this.transaction, required this.onRemove,});

  @override
  TransactionItemState createState() => TransactionItemState();
}

class TransactionItemState extends State<TransactionItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('Тип: ${widget.transaction.type}'),
          subtitle: Text('№ ${widget.transaction.number}'),
          trailing: Text('Сумма: ${widget.transaction.sum.toString()}'),
          onTap: () {
            setState(() {
              _expanded = !_expanded;
            });
          },
        ),
        if (_expanded)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Дата транзакции: ${DateFormat('dd.MM.y HH:mm').format(widget.transaction.date)}'),
                const SizedBox(height: 5.0),
                Text('Сумма: ${widget.transaction.sum}'),
                const SizedBox(height: 5.0),
                Text('Комиссия: ${widget.transaction.commission}'),
                const SizedBox(height: 5.0),
                Text('Итого: ${widget.transaction.total}'),
                const SizedBox(height: 5.0),
                Text('Номер транзакции: ${widget.transaction.number}'),
                const SizedBox(height: 5.0),
                Text('Тип транзакции: ${widget.transaction.type}'),
                const SizedBox(height: 5.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40), // NEW
                  ),
                  onPressed: widget.onRemove,
                  child: const Text('Отменить транзакцию'),
                ),
              ],
            ),
          ),
      ],
    );
  }
}