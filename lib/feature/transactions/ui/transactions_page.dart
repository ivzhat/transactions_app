import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transactions_app/feature/auth/bloc/auth_bloc.dart';
import 'widgets/transaction_item.dart';
import '../bloc/transactions/transactions_bloc.dart';
import '../database/transactions_db.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class TransactionsPage extends StatelessWidget {
  TransactionsPage({super.key});

  final transactionsDB = TransactionsDB();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TransactionsBloc>(context).add(TransactionsStarted(transactionsDB));
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => BlocProvider.of<TransactionsBloc>(context).add(TransactionsItemAdded())),
      appBar: AppBar(
        title: const Text('Транзакции'),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(AuthLogoutTapped());
            },
            icon: const Icon(Icons.output))
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthorized) {
            GoRouter.of(context).go('/');
          }
        },
        child: BlocBuilder<TransactionsBloc, TransactionsState>(
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
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.transactionsList.length,
                      itemBuilder: (context, index) {
                        return TransactionItem(
                          transaction: state.transactionsList[index],
                          onRemove: () {
                            BlocProvider.of<TransactionsBloc>(context).add(
                              TransactionsItemRemoved(
                                  state.transactionsList[index].id));
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 35.0),
                    child: Text(
                      "Всего транзакций: ${state.transactionsList.length}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16.0),
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}