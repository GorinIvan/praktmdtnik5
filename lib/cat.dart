class Cat {
  final int id;
  final String name;
  final String breed;
  final int age;
  final double price;
  final bool isSold;

  Cat({
    required this.id,
    required this.name,
    required this.breed,
    required this.age,
    required this.price,
    required this.isSold,
  });

  factory Cat.fromRow(Map<String, Object?> row) {
    final priceValue = row['price'] as num;

    return Cat(
      id: row['id'] as int,
      name: row['name'] as String,
      breed: row['breed'] as String,
      age: row['age'] as int,
      price: priceValue.toDouble(),
      isSold: (row['is_sold'] as int) == 1,
    );
  }

  @override
  String toString() {
    return 'Cat(id: $id, name: $name, breed: $breed, age: $age, price: $price, isSold: $isSold)';
  }
}
