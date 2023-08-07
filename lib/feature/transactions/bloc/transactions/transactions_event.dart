part of 'transactions_bloc.dart';

abstract class TransactionsEvent {
  const TransactionsEvent();
}

class TransactionsStarted extends TransactionsEvent{}

class TransactionsItemAdded extends TransactionsEvent{}

class TransactionsItemRemoved extends TransactionsEvent{
  const TransactionsItemRemoved(this.id);

  final int id;
}