import 'client.dart';

class SalonService {
  final List<Client> _clients = [];
  int _nextId = 1;

  void addClient(String name, String phone) {
    _clients.add(Client(id: _nextId++, name: name, phone: phone));
  }

  List<Client> getClients() => List.unmodifiable(_clients);

  Client? findByName(String name) {
    try {
      return _clients.firstWhere((c) => c.name == name);
    } catch (_) {
      return null;
    }
  }

  bool removeClient(int id) {
    final index = _clients.indexWhere((c) => c.id == id);
    if (index == -1) return false;
    _clients.removeAt(index);
    return true;
  }
}
