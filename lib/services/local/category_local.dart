import 'dart:async';

import 'package:flutter_emergency_app_one/models/verse_category.dart';
import 'package:flutter_emergency_app_one/services/local/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class CategoryLocal {
  static final String tableCategory = 'VerseCategory';
  static final String columnId = 'id';
  static final String columnGlobalId= 'globalId';
  static final String columnName = 'name';
  static final String columnDescription = 'description';
  static final String columnDateAdded = 'dateAdded';

  DatabaseHelper helper;

  CategoryLocal(this.helper);

  Future<List<VerseCategory>> getCategories() async {
    Database db = await helper.db;
    List<Map> categoryMaps = await db.query(tableCategory);

    if (categoryMaps.length > 0) {
      return categoryMaps
          .map((category) => VerseCategory.fromMap(category))
          .toList();
    }
    return null;
  }

  Future<Null> addCategory(VerseCategory categoryToAdd) async{

      Database db = await helper.db;
      await db.insert(tableCategory, categoryToAdd.toMap());
  }

  Future<Null> updateCategory(VerseCategory categoryToUpdate) async{

      Database db = await helper.db;
      await db.update(tableCategory, categoryToUpdate.toMap(), where: '$columnId = ?', whereArgs: [categoryToUpdate.id]);

  }
}
