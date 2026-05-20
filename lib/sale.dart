class Sale {
  final int id;
  final int catId;
  final int customerId;
  final String soldAt;

  Sale({
    required this.id,
    required this.catId,
    required this.customerId,
    required this.soldAt,
  });

  factory Sale.fromRow(Map<String, Object?> row) {
    return Sale(
      id: row['id'] as int,
      catId: row['cat_id'] as int,
      customerId: row['customer_id'] as int,
      soldAt: row['sold_at'] as String,
    );
  }

  @override
  String toString() {
    return 'Sale(id: $id, catId: $catId, customerId: $customerId, soldAt: $soldAt)';
  }
}
