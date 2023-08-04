part of 'transactions_bloc.dart';

abstract class TransactionsEvent extends Equatable {
  const TransactionsEvent();
}

class TransactionsStarted extends TransactionsEvent{
  const TransactionsStarted(this.transactionsDB);

  final TransactionsDB transactionsDB;
  @override
  List<Object?> get props => [];
}

class TransactionsItemAdded extends TransactionsEvent{
  @override
  List<Object?> get props => [];
}

class TransactionsItemRemoved extends TransactionsEvent{
  const TransactionsItemRemoved(this.id);

  final int id;
  @override
  List<Object?> get props => [];
}