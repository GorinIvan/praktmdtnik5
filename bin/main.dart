import '../lib/salon_service.dart';

void main() {
  final service = SalonService();

  service.addClient('Анна', '+7-900-111-22-33');
  service.addClient('Мария', '+7-900-444-55-66');
  service.addClient('Ольга', '+7-900-777-88-99');

  print('Список клиентов:');
  for (final client in service.getClients()) {
    print('  $client');
  }

  final found = service.findByName('Мария');
  print('\nПоиск "Мария": $found');

  service.removeClient(1);
  print('\nПосле удаления клиента #1:');
  for (final client in service.getClients()) {
    print('  $client');
  }
}
