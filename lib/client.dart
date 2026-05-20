class Client {
  final int id;
  final String name;
  final String phone;

  Client({required this.id, required this.name, required this.phone});

  @override
  String toString() => 'Client(id: $id, name: $name, phone: $phone)';
}
