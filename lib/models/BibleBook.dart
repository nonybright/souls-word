import 'package:flutter_emergency_app_one/services/local/bible_book_local.dart';

class BibleBook {
  int id;
  String name;
  String shortName;
  int testament;
  int chapters;
  int maxVerse;

  BibleBook({this.id, this.name, this.shortName, this.testament, this.chapters, this.maxVerse});

  
  BibleBook.fromMap(Map category) {
    this.id = category[BibleBookLocal.columnId];
    this.name = category[BibleBookLocal.columnName];
    this.shortName = category[BibleBookLocal.columnShortName];
    this.testament = category[BibleBookLocal.columnTestament];
    this.chapters = category[BibleBookLocal.columnChapters];
    this.maxVerse = category[BibleBookLocal.columnMaxVerse];
  }

  Map<String, dynamic> toMap() {
    return {
      BibleBookLocal.columnId : this.id,
      BibleBookLocal.columnName : this.name,
      BibleBookLocal.columnShortName : this.shortName,
      BibleBookLocal.columnTestament : this.testament,
      BibleBookLocal.columnChapters : this.chapters,
      BibleBookLocal.columnMaxVerse : this.maxVerse,
    };
  }
}
