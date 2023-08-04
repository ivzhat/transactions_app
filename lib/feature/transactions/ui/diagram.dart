import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';
import '../bloc/transactions/transactions_bloc.dart';

class DiagramPage extends StatelessWidget {
  const DiagramPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (context, state) {
        if (state is TransactionsInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TransactionsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TransactionsLoaded) {
          return Scaffold(
            appBar: AppBar(title: const Text('Диаграмма')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 38.0),
                    child: Text(
                      "Количество транзакций по типам",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0
                      ),
                    ),
                  ),
                  PieChart(
                    ringStrokeWidth: 30.0,
                    dataMap: state.dataMap,
                    chartRadius: MediaQuery.of(context).size.width / 2,
                    chartType: ChartType.ring,
                    chartValuesOptions: const ChartValuesOptions(
                      decimalPlaces: 0,
                    ),
                    legendOptions: const LegendOptions(
                      showLegends: true,
                      legendPosition: LegendPosition.bottom,
                      legendTextStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}