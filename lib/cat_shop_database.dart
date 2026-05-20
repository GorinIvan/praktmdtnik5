import 'package:sqlite3/sqlite3.dart';

import 'cat.dart';
import 'customer.dart';
import 'sale.dart';

class CatShopDatabase {
  final Database _database;

  CatShopDatabase._(this._database) {
    _createTables();
  }

  factory CatShopDatabase.inMemory() {
    return CatShopDatabase._(sqlite3.openInMemory());
  }

  factory CatShopDatabase.file([String path = 'cat_shop.db']) {
    return CatShopDatabase._(sqlite3.open(path));
  }

  void _createTables() {
    _database.execute('PRAGMA foreign_keys = ON;');
    _database.execute('''
      CREATE TABLE IF NOT EXISTS cats (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        breed TEXT NOT NULL,
        age INTEGER NOT NULL,
        price REAL NOT NULL,
        is_sold INTEGER NOT NULL DEFAULT 0
      );
    ''');
    _database.execute('''
      CREATE TABLE IF NOT EXISTS customers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        phone TEXT NOT NULL
      );
    ''');
    _database.execute('''
      CREATE TABLE IF NOT EXISTS sales (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cat_id INTEGER NOT NULL UNIQUE,
        customer_id INTEGER NOT NULL,
        sold_at TEXT NOT NULL,
        FOREIGN KEY(cat_id) REFERENCES cats(id),
        FOREIGN KEY(customer_id) REFERENCES customers(id)
      );
    ''');
  }

  int addCat(String name, String breed, int age, double price) {
    _database.execute(
      'INSERT INTO cats (name, breed, age, price) VALUES (?, ?, ?, ?)',
      [name, breed, age, price],
    );

    return _lastInsertId();
  }

  int addCustomer(String name, String phone) {
    _database.execute(
      'INSERT INTO customers (name, phone) VALUES (?, ?)',
      [name, phone],
    );

    return _lastInsertId();
  }

  int sellCat({
    required int catId,
    required int customerId,
    String? soldAt,
  }) {
    final catRows = _database.select(
      'SELECT is_sold FROM cats WHERE id = ?',
      [catId],
    );
    if (catRows.isEmpty) {
      throw ArgumentError('Кот не найден');
    }
    if ((catRows.first['is_sold'] as int) == 1) {
      throw ArgumentError('Кот уже продан');
    }

    final customerRows = _database.select(
      'SELECT id FROM customers WHERE id = ?',
      [customerId],
    );
    if (customerRows.isEmpty) {
      throw ArgumentError('Покупатель не найден');
    }

    _database.execute(
      'INSERT INTO sales (cat_id, customer_id, sold_at) VALUES (?, ?, ?)',
      [catId, customerId, soldAt ?? DateTime.now().toIso8601String()],
    );
    _database.execute(
      'UPDATE cats SET is_sold = 1 WHERE id = ?',
      [catId],
    );

    return _lastInsertId();
  }

  List<Cat> getCats() {
    final rows = _database.select(
      'SELECT id, name, breed, age, price, is_sold FROM cats ORDER BY id',
    );

    return rows.map((row) => Cat.fromRow(row)).toList();
  }

  List<Customer> getCustomers() {
    final rows = _database.select(
      'SELECT id, name, phone FROM customers ORDER BY id',
    );

    return rows.map((row) => Customer.fromRow(row)).toList();
  }

  List<Sale> getSales() {
    final rows = _database.select(
      'SELECT id, cat_id, customer_id, sold_at FROM sales ORDER BY id',
    );

    return rows.map((row) => Sale.fromRow(row)).toList();
  }

  int _lastInsertId() {
    final row = _database.select(
      'SELECT last_insert_rowid() AS id',
    ).first;

    return row['id'] as int;
  }

  void close() {
    _database.dispose();
  }
}
