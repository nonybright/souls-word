import 'package:flutter_emergency_app_one/services/local/verse_local.dart';
import 'package:flutter_emergency_app_one/utils/date_formater.dart';

class Verse {
  int id;
  String globalId;
  String content;
  String quotation;
  bool isFaved;
  DateTime dateAdded;
  int categoryId;

  Verse({
    this.id,
    this.globalId,
    this.content,
    this.quotation,
    this.isFaved:false,
    this.dateAdded,
    this.categoryId,
  });

  Verse copyWith({
    int id,
    String globalId,
    String content,
    String quotation,
    bool isFaved,
    DateTime dateAdded,
    int categoryId,
  }) {
    return Verse(
      id: id ?? this.id,
      globalId: globalId ?? this.globalId,
      content: content ?? this.content,
      quotation: quotation ?? this.quotation,
      isFaved: isFaved ?? this.isFaved,
      dateAdded: dateAdded ?? this.dateAdded,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  Verse.fromMap(Map verse) {
    this.id = verse[VerseLocal.columnId];
    this.globalId = verse[VerseLocal.columnGlobalId];
    this.content = verse[VerseLocal.columnContent];
    this.quotation = verse[VerseLocal.columnQuotation];
    this.isFaved = (verse[VerseLocal.columnIsFaved] == 1) ? true : false;
    this.dateAdded = DateTime.parse(verse[VerseLocal.columnDateAdded]);
    this.categoryId = verse[VerseLocal.columnCategoryId];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map =  {
      VerseLocal.columnId: this.id,
      VerseLocal.columnGlobalId: this.globalId,
      VerseLocal.columnContent: this.content,
      VerseLocal.columnQuotation: this.quotation,
      VerseLocal.columnIsFaved:this.isFaved ? 1 : 0,
      VerseLocal.columnCategoryId: this.categoryId,
    };
    if(this.dateAdded != null){
      map[VerseLocal.columnDateAdded] = dateToString(this.dateAdded);
    }
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Verse &&
      id == other.id &&
      globalId == other.globalId &&
      content == other.content &&
      quotation == other.quotation &&
      isFaved == other.isFaved &&
      dateAdded == other.dateAdded &&
      categoryId == other.categoryId;

  @override
  int get hashCode =>
      id.hashCode ^
      globalId.hashCode ^
      content.hashCode ^
      quotation.hashCode ^
      isFaved.hashCode ^
      dateAdded.hashCode ^
      categoryId.hashCode;
}
