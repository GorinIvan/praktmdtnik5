import 'package:test/test.dart';
import 'package:salon/cat_shop_database.dart';

void main() {
  late CatShopDatabase database;

  setUp(() {
    database = CatShopDatabase.inMemory();
  });

  tearDown(() {
    database.close();
  });

  test('добавление кота в базу', () {
    database.addCat('Барсик', 'Сфинкс', 3, 25000);

    final cats = database.getCats();

    expect(cats.length, equals(1));
    expect(cats.first.name, equals('Барсик'));
    expect(cats.first.isSold, isFalse);
  });

  test('добавление покупателя в базу', () {
    database.addCustomer('Оля', '+7-900-555-55-55');

    final customers = database.getCustomers();

    expect(customers.length, equals(1));
    expect(customers.first.name, equals('Оля'));
  });

  test('продажа кота создает запись и меняет статус кота', () {
    final catId = database.addCat('Снежок', 'Перс', 1, 40000);
    final customerId = database.addCustomer('Петя', '+7-900-777-77-77');

    database.sellCat(
      catId: catId,
      customerId: customerId,
      soldAt: '2026-05-20 13:00:00',
    );

    final cats = database.getCats();
    final sales = database.getSales();

    expect(cats.single.isSold, isTrue);
    expect(sales.length, equals(1));
    expect(sales.single.catId, equals(catId));
  });

  test('нельзя продать уже проданного кота', () {
    final catId = database.addCat('Рыжик', 'Сибирский', 2, 28000);
    final firstCustomerId = database.addCustomer('Лена', '+7-900-111-11-11');
    final secondCustomerId = database.addCustomer('Коля', '+7-900-222-22-22');

    database.sellCat(catId: catId, customerId: firstCustomerId);

    expect(
      () => database.sellCat(catId: catId, customerId: secondCustomerId),
      throwsArgumentError,
    );
  });
}
