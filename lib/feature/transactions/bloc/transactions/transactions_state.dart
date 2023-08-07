part of 'transactions_bloc.dart';

abstract class TransactionsState {
  const TransactionsState();
}

class TransactionsInitial extends TransactionsState {}

class TransactionsLoading extends TransactionsState {}

class TransactionsLoaded extends TransactionsState {
  final List<Transaction> transactionsList;

  const TransactionsLoaded(this.transactionsList);
  get dataMap => groupBy(transactionsList, (e) => e.type)
      .map((k, v) => MapEntry(k, v.map((e) => 1.0).sum));
}

class TransactionsError extends TransactionsState{
  final String? message;
  const TransactionsError(this.message);
}
