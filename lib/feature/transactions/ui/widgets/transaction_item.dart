import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  final Transaction transaction;
  final VoidCallback onRemove;

  const TransactionItem(
      {super.key, required this.transaction, required this.onRemove,});

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
            // padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Дата транзакции: ${DateFormat('dd.MM.y HH:mm').format(widget.transaction.date)}'),
                Text('Сумма: ${widget.transaction.sum}'),
                Text('Комиссия: ${widget.transaction.commission}'),
                Text('Итого: ${widget.transaction.total}'),
                Text('Номер транзакции: ${widget.transaction.number}'),
                Text('Тип транзакции: ${widget.transaction.type}'),
                ElevatedButton(
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