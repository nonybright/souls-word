import 'package:flutter_emergency_app_one/services/local/verse_local.dart';
import 'package:flutter_emergency_app_one/utils/date_formater.dart';

class Verse {
  int id;
  String content;
  String quotation;
  bool isFaved;
  DateTime dateAdded;
  int categoryId;
  bool isDefault;

  Verse({
    this.id,
    this.content,
    this.quotation,
    this.isFaved:false,
    this.dateAdded,
    this.categoryId,
    this.isDefault:false,
  });

  Verse copyWith({
    int id,
    String content,
    String quotation,
    bool isFaved,
    DateTime dateAdded,
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
    this.dateAdded = DateTime.parse(verse[VerseLocal.columnDateAdded]);
    this.categoryId = verse[VerseLocal.columnCategoryId];
    this.isDefault = (verse[VerseLocal.columnIsDefault] == 1) ? true : false;
  }

  Map<String, dynamic> toMap() {
    return {
      VerseLocal.columnId: this.id,
      VerseLocal.columnIsDefault: isDefault? 1 : 0,
      VerseLocal.columnContent: this.content,
      VerseLocal.columnQuotation: this.quotation,
      VerseLocal.columnIsFaved:this.isFaved ? 1 : 0,
      VerseLocal.columnDateAdded: (this.dateAdded != null)?dateToString(this.dateAdded):null,
      VerseLocal.columnCategoryId: this.categoryId,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Verse &&
      id == other.id &&
      content == other.content &&
      quotation == other.quotation &&
      isFaved == other.isFaved &&
      dateAdded == other.dateAdded &&
      categoryId == other.categoryId &&
      isDefault == other.isDefault;

  @override
  int get hashCode =>
      id.hashCode ^
      content.hashCode ^
      quotation.hashCode ^
      isFaved.hashCode ^
      dateAdded.hashCode ^
      categoryId.hashCode ^
      isDefault.hashCode;
}
