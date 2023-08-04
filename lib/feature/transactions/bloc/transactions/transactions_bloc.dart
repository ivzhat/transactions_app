import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/transaction.dart';
import 'package:collection/collection.dart';
import '../../database/transactions_db.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc() : super(TransactionsInitial()) {
    late List<Transaction> transactionsList;
    late TransactionsDB transactionsDB;

    on<TransactionsStarted>((event, emit) async {
      emit(TransactionsLoading());
      transactionsDB = event.transactionsDB;
      transactionsList = await transactionsDB.fetchAll();
      emit(TransactionsLoaded(transactionsList));
    });

    on<TransactionsItemAdded>((event, emit) async {
      emit(TransactionsLoading());
      final List<String> types = ['Перевод', 'Пополнение', 'Снятие'];
      final double sum = Random().nextInt(300).toDouble();
      final double commission = sum/10;
      final double total = sum - commission;
      final String number = Random().nextInt(150).toString();
      final int id = await transactionsDB.create(
          type: types[Random().nextInt(2)],
          sum: sum,
          commission: commission,
          total: total,
          number: number
      );
      transactionsList.add(
          Transaction(
              id: id,
              date: DateTime.now(),
              type: types[Random().nextInt(2)],
              sum: sum,
              commission: commission,
              total: total,
              number: number
          )
      );
      emit(TransactionsLoaded(transactionsList));
    });

    on<TransactionsItemRemoved>((event, emit) {
      emit(TransactionsLoading());
      transactionsList.removeWhere((element) => element.id == event.id);
      transactionsDB.delete(event.id);
      emit(TransactionsLoaded(transactionsList));
    });
  }
}
