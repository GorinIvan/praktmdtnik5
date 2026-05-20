import 'package:test/test.dart';
import '../lib/salon_service.dart';

void main() {
  late SalonService service;

  setUp(() {
    service = SalonService();
  });

  test('добавление клиента', () {
    service.addClient('Анна', '+7-900-111-22-33');
    expect(service.getClients().length, equals(1));
    expect(service.getClients().first.name, equals('Анна'));
  });

  test('поиск клиента по имени', () {
    service.addClient('Мария', '+7-900-444-55-66');
    final client = service.findByName('Мария');
    expect(client, isNotNull);
    expect(client!.phone, equals('+7-900-444-55-66'));
  });

  test('поиск несуществующего клиента возвращает null', () {
    final client = service.findByName('Никто');
    expect(client, isNull);
  });

  test('удаление клиента', () {
    service.addClient('Ольга', '+7-900-777-88-99');
    final id = service.getClients().first.id;
    final result = service.removeClient(id);
    expect(result, isTrue);
    expect(service.getClients().length, equals(0));
  });

  test('удаление несуществующего клиента возвращает false', () {
    final result = service.removeClient(999);
    expect(result, isFalse);
  });
}
