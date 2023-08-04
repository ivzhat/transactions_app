import 'package:sqflite/sqflite.dart';
import '../database/database_service.dart';
import '../models/transaction.dart' as model;

class TransactionsDB {
  final tableName = 'transactions';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "id" INTEGER NOT NULL,
      "date" INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as integer)),
      "type" TEXT NOT NULL,
      "sum" REAL NOT NULL,
      "commission" REAL NOT NULL,
      "total" REAL NOT NULL,
      "number" TEXT NOT NULL,
      PRIMARY KEY("id" AUTOINCREMENT)
      );"""
    );
    final List<Map<String, dynamic>> transactions = [
      {
        'date': DateTime.now().millisecondsSinceEpoch,
        'type': 'Перевод',
        'sum': 110.0,
        'commission': 10.0,
        'total': 100.0,
        'number': '123',
      },
      {
        'date': DateTime.now().millisecondsSinceEpoch,
        'type': 'Пополнение',
        'sum': 50.0,
        'commission': 0.0,
        'total': 50.0,
        'number': '456',
      },
      {
        'date': DateTime.now().millisecondsSinceEpoch,
        'type': 'Снятие',
        'sum': 50.0,
        'commission': 10.0,
        'total': 40.0,
        'number': '789',
      },
      {
        'date': DateTime.now().millisecondsSinceEpoch,
        'type': 'Снятие',
        'sum': 75.0,
        'commission': 0.0,
        'total': 75.0,
        'number': '012',
      },
      {
        'date': DateTime.now().millisecondsSinceEpoch,
        'type': 'Снятие',
        'sum': 75.0,
        'commission': 5.0,
        'total': 70.0,
        'number': '345',
      },
      {
        'date': DateTime.now().millisecondsSinceEpoch,
        'type': 'Пополнение',
        'sum': 175.0,
        'commission': 25.0,
        'total': 150.0,
        'number': '678',
      },
    ];
    for (var element in transactions) {
      await database.rawInsert('''INSERT INTO $tableName (date, type, sum, commission, total, number) VALUES (?,?,?,?,?,?)''',
        [element['date'], element['type'], element['sum'], element['commission'], element['total'], element['number']]
      );
    }
  }

  Future<int> create({
    required String type,
    required double sum,
    required double commission,
    required double total,
    required String number}) async {
    final database = await DatabaseService().database;

    return await database.rawInsert(
      '''INSERT INTO $tableName (date, type, sum, commission, total, number) VALUES (?,?,?,?,?,?)''',
      [DateTime.now().millisecondsSinceEpoch, type, sum, commission, total, number],
    );
  }

  Future<List<model.Transaction>> fetchAll() async {
    final database = await DatabaseService().database;
    final transactions = await database.rawQuery(
      '''SELECT * FROM $tableName'''
    );
    return transactions.map((item) => model.Transaction.fromSqfliteDatabase(item)).toList();
  }

  Future<void> delete(int id) async {
    final database = await DatabaseService().database;
    await database.rawDelete('''DELETE FROM $tableName WHERE id = ?''', [id]);
  }
}