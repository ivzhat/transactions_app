import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:transactions_app/models/transaction.dart';

import '../../database/transactions_db.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc() : super(TransactionsInitial()) {

    on<TransactionsStarted>((event, emit) async {
      emit(TransactionsLoading());

      final transactionsDB = TransactionsDB();
      final List<Transaction> transactionsList = await transactionsDB.fetchAll();

      emit(TransactionsLoaded(transactionsList));
    });

    on<TransactionsItemAdded>((event, emit) {
      // TODO: implement event handler
    });

    on<TransactionsItemRemoved>((event, emit) {
      // TODO: implement event handler
    });
  }
}
