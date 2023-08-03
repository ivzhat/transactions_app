import 'package:sqflite/sqflite.dart';
import 'package:transactions_app/database/database_service.dart';
import 'package:transactions_app/models/transaction.dart' as model;

class TransactionsDB {
  final tableName = 'transactions';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "id" INTEGER NOT NULL,
      "name" TEXT NOT NULL,
      "date" INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as integer)),
      "type" TEXT NOT NULL,
      "commission" REAL NOT NULL,
      "total" REAL NOT NULL,
      "number" INTEGER NOT NULL,
      PRIMARY KEY("id" AUTOINCREMENT)
      );"""
    );
  }

  Future<int> create({required String name,
    required String type,
    required double commission,
    required double total,
    required int number}) async {
    final database = await DatabaseService().database;
    return await database.rawInsert(
      '''INSERT INTO $tableName (name, date, type, commission, total, number) VALUES (?,?,?,?,?,?)''',
      [name, DateTime.now().millisecondsSinceEpoch, type, commission, total, number],
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