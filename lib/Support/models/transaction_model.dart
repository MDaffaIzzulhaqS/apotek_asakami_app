class Transaction {
  final String id;
  final String status;
  final String message;

  Transaction({
    required this.id,
    required this.status,
    required this.message,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      status: json['status'],
      message: json['message'],
    );
  }
}
