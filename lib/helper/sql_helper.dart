import 'package:f_contact/data/contact_model.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    fullName TEXT,
    phoneNumber TEXT,
    email TEXT,
    country TEXT,
    region TEXT,
    district TEXT,
    address TEXT
   )
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('contact.db', version: 3,
        onCreate: (sql.Database database, int version) async {
      await createTable(database);
    });
  }

  Future<int> createItem(
    String fullName,
    String? phoneNumber,
    String? email,
    String? country,
    String? region,
    String? district,
    String? address,
  ) async {
    final db = await SQLHelper.db();

    final data = {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'country': country,
      'region': region,
      'district': district,
      'address': address,
    };
    final id = await db.insert('items', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  Future<List<ContactModel>> getItems() async {
    final db = await SQLHelper.db();
    var contacts = await db.query('items', orderBy: "id");
    final List<ContactModel> contactList = contacts.map((e) => ContactModel.fromJson(e)).toList();
    return contactList;
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  Future<int> updateItem(
      int id,
      String fullName,
      String? phoneNumber,
      String? email,
      String? country,
      String? region,
      String? district,
      String? address,
  ) async {
    final db = await SQLHelper.db();

    final data = {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'country': country,
      'region': region,
      'district': district,
      'address': address,
    };

    final result = await db.update('items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
