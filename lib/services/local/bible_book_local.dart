import 'dart:async';

import 'package:flutter_emergency_app_one/models/BibleBook.dart';
import 'package:flutter_emergency_app_one/services/local/database_helper.dart';
// import 'package:sqflite/sqflite.dart';

class BibleBookLocal{
  static final String tableBibleBook = 'BibleBook';
  static final String columnId = 'id';
  static final String columnName = 'name';
  static final String columnTestament = 'testament';
  static final String columnChapters = 'chapters';
  static final String columnMaxVerse = 'maxVerse';


  DatabaseHelper helper;

  BibleBookLocal(this.helper);

  Future<List<BibleBook>> getBooks() async {
    // Database db = await helper.db;
    // List<Map> bibleBookMaps = await db.query(tableBibleBook);

    // if (bibleBookMaps.length > 0) {
    //   return bibleBookMaps
    //       .map((book) => BibleBook.fromMap(book))
    //       .toList();
    // }
    // return [];
    return [

      BibleBook(id: 1, name: 'Genesis', chapters: 44, maxVerse: 22, testament: 1),
      BibleBook(id: 2, name: 'Exodus', chapters: 10, maxVerse: 19, testament: 1),
      BibleBook(id: 3, name: 'Levinticus', chapters: 19, maxVerse: 41, testament: 1),
      BibleBook(id: 4, name: 'Mathew', chapters: 15, maxVerse: 13, testament: 2),
      BibleBook(id: 5, name: 'Mark', chapters: 21, maxVerse: 10, testament: 2),
      BibleBook(id: 6, name: '1 Peter', chapters: 0, maxVerse: 10, testament: 2),

    ];
  }
}