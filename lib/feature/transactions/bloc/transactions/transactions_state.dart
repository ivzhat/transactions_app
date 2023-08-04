part of 'transactions_bloc.dart';

abstract class TransactionsState extends Equatable {
  const TransactionsState();
}

class TransactionsInitial extends TransactionsState {
  @override
  List<Object> get props => [];
}

class TransactionsLoading extends TransactionsState {
  @override
  List<Object> get props => [];
}

class TransactionsLoaded extends TransactionsState {
  final List<Transaction> transactionsList;

  const TransactionsLoaded(this.transactionsList);
  get dataMap => groupBy(transactionsList, (e) => e.type)
      .map((k, v) => MapEntry(k, v.map((e) => 1.0).sum));

  @override
  List<Object> get props => [];
}

class TransactionsError extends TransactionsState{
  final String? message;
  const TransactionsError(this.message);

  @override
  List<Object> get props => [];
}
