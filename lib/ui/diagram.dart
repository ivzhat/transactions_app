import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../models/transaction.dart';

class DiagramPage extends StatelessWidget {
  DiagramPage({super.key});

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
    Transaction(
      name: 'Transaction 3',
      date: DateTime.now(),
      type: 'Снятие',
      commission: 0.0,
      total: 75.0,
      number: 012,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {};
    for (var transaction in _transactions) {
      if (dataMap.containsKey(transaction.type)) {
        dataMap[transaction.type] = dataMap[transaction.type]! + transaction.total;
      } else {
        dataMap[transaction.type] = transaction.total;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Диаграмма')),
      body: Center(
        child: PieChart(
          dataMap: dataMap,
          chartRadius: MediaQuery.of(context).size.width / 2,
          chartType: ChartType.disc,
          legendOptions: const LegendOptions(
            showLegends: true,
            legendPosition: LegendPosition.bottom,
            legendTextStyle: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}