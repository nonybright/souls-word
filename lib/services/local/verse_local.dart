import 'dart:async';

import 'package:flutter_emergency_app_one/core/verse/verse_list_fragment.dart';
import 'package:flutter_emergency_app_one/core/verse/verse_view_page.dart';
import 'package:flutter_emergency_app_one/models/verse.dart';
import 'package:flutter_emergency_app_one/services/local/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class VerseLocal {
  static final String tableVerse = 'Verse';
  static final String columnId = 'id';
  static final String columnContent = 'content';
  static final String columnQuotation = 'quotation';
  static final String columnIsFaved = 'isFaved';
  static final String columnCategoryId = 'categoryId';
  static final String columnDateAdded = 'dateAdded';
  static final String columnIsDefault = 'isDefault';

  DatabaseHelper dbHelper;
  VerseLocal(this.dbHelper);

  Future<int> updateVerse(Verse verse) async {
    Database database = await dbHelper.db;
    return await database.update(tableVerse, verse.toMap(),
        where: '$columnId = ?', whereArgs: [verse.id]);
  }

  Future<Verse> addVerse(Verse verse) async {
    Database database = await dbHelper.db;
    await database.insert(tableVerse, verse.toMap());
    //make id autoincrement and use the code below instaead f above
    //verse.id = await database.insert(tableVerse, verse.toMap());
    return verse;
  }

  Future<int> getVersesCount(
    VerseDisplayType type, {
    int categoryId,
  }) async {
    String queryString = 'SELECT count(*) as count FROM $tableVerse ';
    List<dynamic> args = [];
    if (categoryId != null) {
      if (type == VerseDisplayType.category) {
        queryString += ' WHERE $columnCategoryId == ? ';
        args.add(categoryId);
      } else if (type == VerseDisplayType.favorite) {
        queryString += ' WHERE $columnCategoryId == ? AND $columnIsFaved = 1 ';
        args.add(categoryId);
      } else {
        throw Error;
      }
    } else {
      //for all
      if (type == VerseDisplayType.favorite) {
        queryString += ' WHERE $columnIsFaved = 1 ';
      }
    }
    Database database = await dbHelper.db;
    List<Map> map = await database.rawQuery(queryString, args);
    int count = map.first['count'];
    return count;
    // return map.map((verse) => Verse.fromMap(verse)).toList();
  }

  Future<List<Verse>> getVerses(
    VerseDisplayType type, {
    int categoryId,
    int limit,
    int offset,
    VerseSortType sortType,
    bool random,
  }) async {
   
    if (sortType == null) {
      sortType = VerseSortType.sortByDateDesc;
    }

     String queryString = 'SELECT * FROM $tableVerse ';
    List<dynamic> args = [];
    if (categoryId != null) {
      if (type == VerseDisplayType.category) {
        queryString += ' WHERE $columnCategoryId == ? ';
        args.add(categoryId);
      } else if (type == VerseDisplayType.favorite) {
        queryString += ' WHERE $columnCategoryId == ? AND $columnIsFaved = 1 ';
        args.add(categoryId);
      } else {
        throw Error;
      }
    } else {
      //for all
      if (type == VerseDisplayType.favorite) {
        queryString += ' WHERE $columnIsFaved = 1 ';
      }
    }

    queryString += _sortOrder(sortType);
    queryString += (limit != null)? ' LIMIT $limit ':' ';
    queryString += (offset != null)? ' OFFSET $offset ':' ';

    Database database = await dbHelper.db;
    List<Map> map = await database.rawQuery(queryString, args);
    return map.map((verse) => Verse.fromMap(verse)).toList();
  }

  _sortOrder(VerseSortType sortType) {
    switch (sortType) {
      case VerseSortType.sortByBookDesc:
        return ' ORDER BY quotation DESC ';
      case VerseSortType.sortByBookAsc:
        return ' ORDER BY quotation ASC ';
      case VerseSortType.sortByDateDesc:
        return ' ORDER BY dateAdded DESC ';
      case VerseSortType.sortByDateAsc:
        return ' ORDER BY dateAdded ASC ';
    }
  }
}
