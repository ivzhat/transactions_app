class Transaction {
  final int id;
  final DateTime date;
  final String type;
  final double sum;
  final double commission;
  final double total;
  final String number;

  Transaction({
    required this.id,
    required this.date,
    required this.type,
    required this.sum,
    required this.commission,
    required this.total,
    required this.number,
  });

  factory Transaction.fromSqfliteDatabase(Map<String, dynamic> map) => Transaction(
      id: map['id'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      type: map['type'],
      sum: map['sum'],
      commission: map['commission'],
      total: map['total'],
      number: map['number'],
  );
}