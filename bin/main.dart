import 'package:salon/cat_shop_database.dart';

void main() {
  final database = CatShopDatabase.file();

  if (database.getCats().isEmpty) {
    final customerId = database.addCustomer('Иван', '+7-900-123-45-67');
    final firstCatId = database.addCat('Барсик', 'Британец', 2, 30000);
    database.addCat('Мурка', 'Мейн-кун', 1, 45000);
    database.sellCat(
      catId: firstCatId,
      customerId: customerId,
      soldAt: '2026-05-20 12:00:00',
    );
  }

  print('Коты:');
  for (final cat in database.getCats()) {
    print(cat);
  }

  print('\nПокупатели:');
  for (final customer in database.getCustomers()) {
    print(customer);
  }

  print('\nПродажи:');
  for (final sale in database.getSales()) {
    print(sale);
  }

  database.close();
}
