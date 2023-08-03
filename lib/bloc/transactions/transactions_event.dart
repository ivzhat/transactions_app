part of 'transactions_bloc.dart';

abstract class TransactionsEvent extends Equatable {
  const TransactionsEvent();
}

class TransactionsStarted extends TransactionsEvent{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class TransactionsItemAdded extends TransactionsEvent{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class TransactionsItemRemoved extends TransactionsEvent{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}