class Transaction {
  final String name;
  final DateTime date;
  final String type;
  final double commission;
  final double total;
  final int number;

  Transaction({
    required this.name,
    required this.date,
    required this.type,
    required this.commission,
    required this.total,
    required this.number,
  });

  factory Transaction.fromSqfliteDatabase(Map<String, dynamic> map) => Transaction(
      name: map['name'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      type: map['type'] ?? '',
      commission: map['commission'] ?? 0.0,
      total: map['total'] ?? 0.0,
      number: map['number'] ?? 123
  );
}