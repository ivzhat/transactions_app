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

  @override
  List<Object> get props => [];
}
