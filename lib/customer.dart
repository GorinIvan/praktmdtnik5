class Customer {
  final int id;
  final String name;
  final String phone;

  Customer({
    required this.id,
    required this.name,
    required this.phone,
  });

  factory Customer.fromRow(Map<String, Object?> row) {
    return Customer(
      id: row['id'] as int,
      name: row['name'] as String,
      phone: row['phone'] as String,
    );
  }

  @override
  String toString() => 'Customer(id: $id, name: $name, phone: $phone)';
}
