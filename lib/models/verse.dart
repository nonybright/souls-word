import 'package:flutter_emergency_app_one/services/local/verse_local.dart';

class Verse {
  int id;
  String content;
  String quotation;
  bool isFaved;
  String dateAdded;
  int categoryId;
  bool isDefault;

  Verse({
    this.id,
    this.content,
    this.quotation,
    this.isFaved,
    this.dateAdded,
    this.categoryId,
    this.isDefault,
  });

  Verse copyWith({
    int id,
    String content,
    String quotation,
    bool isFaved,
    String dateAdded,
    int categoryId,
    bool isDefault,
  }) {
    return Verse(
      id: id ?? this.id,
      content: content ?? this.content,
      quotation: quotation ?? this.quotation,
      isFaved: isFaved ?? this.isFaved,
      dateAdded: dateAdded ?? this.dateAdded,
      categoryId: categoryId ?? this.categoryId,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  Verse.fromMap(Map verse) {
    this.id = verse[VerseLocal.columnId];
    this.content = verse[VerseLocal.columnContent];
    this.quotation = verse[VerseLocal.columnQuotation];
    this.isFaved = (verse[VerseLocal.columnIsFaved] == 1) ? true : false;
    this.dateAdded = verse[VerseLocal.columnDateAdded];
    this.categoryId = verse[VerseLocal.columnCategoryId];
    this.isDefault = (verse[VerseLocal.columnIsDefault] == 1) ? true : false;
  }

  Map<String, dynamic> toMap() {
    return {
      VerseLocal.columnId: this.id,
      VerseLocal.columnContent: this.content,
      VerseLocal.columnQuotation: this.quotation,
      VerseLocal.columnIsFaved: this.isFaved ? 1 : 0,
      VerseLocal.columnDateAdded: this.dateAdded,
      VerseLocal.columnCategoryId: this.categoryId,
      VerseLocal.columnIsDefault: this.isDefault
    };
  }
}
