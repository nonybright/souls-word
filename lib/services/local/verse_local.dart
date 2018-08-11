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

  Future<Verse> insert(Verse verse) async {
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
    VerseListAction action,
    bool random,
  }) async {
   
    if (action == null) {
      action = VerseListAction.sortByDateDesc;
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

    queryString += _sortOrder(action);
    queryString += (limit != null)? ' LIMIT $limit ':' ';
    queryString += (offset != null)? ' OFFSET $offset ':' ';

    /*String whereString;
    List<dynamic> whereArgs;
    if (categoryId != null) {
      if (type == VerseDisplayType.category) {
        whereString = '$columnCategoryId == ? ';
        whereArgs = [categoryId];
      } else if (type == VerseDisplayType.favorite) {
        whereString = '$columnCategoryId == ? AND $columnIsFaved = 1 ';
        whereArgs = [categoryId];
      } else {
        throw Error;
      }
    } else {
      //for all
      if (type == VerseDisplayType.favorite) {
        whereString = '$columnIsFaved = 1 ';
        whereArgs = [];
      }
    }

    Database database = await dbHelper.db;
    List<Map> map = await database.query(tableVerse,
        where: whereString, whereArgs: whereArgs, limit: limit, offset: offset);*/
    
    Database database = await dbHelper.db;
    List<Map> map = await database.rawQuery(queryString, args);
    return map.map((verse) => Verse.fromMap(verse)).toList();
  }

  _sortOrder(VerseListAction action) {
    switch (action) {
      case VerseListAction.sortByBookDesc:
        return ' ORDER BY quotation DESC ';
      case VerseListAction.sortByBookAsc:
        return ' ORDER BY quotation ASC ';
      case VerseListAction.sortByDateDesc:
        return ' ORDER BY dateAdded DESC ';
      case VerseListAction.sortByDateAsc:
        return ' ORDER BY dateAdded ASC ';
    }
  }
}
