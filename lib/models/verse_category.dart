import 'package:flutter_emergency_app_one/services/local/category_local.dart';
import 'package:flutter_emergency_app_one/utils/date_formater.dart';

class VerseCategory {
  int id;
  String name;
  String description;
  DateTime dateAdded;
  bool isDefault;

  VerseCategory({
    this.id,
    this.name,
    this.description,
    this.dateAdded,
    this.isDefault:false,
  });

  VerseCategory.fromMap(Map category) {
    this.id = category[CategoryLocal.columnId];
    this.name = category[CategoryLocal.columnName];
    this.description = category[CategoryLocal.columnDescription];
    this.dateAdded = DateTime.parse(category[CategoryLocal.columnDateAdded]);
    this.isDefault = category[CategoryLocal.columnIsDefault] == 1;
  }

  Map<String, dynamic> toMap() {
    return {
      CategoryLocal.columnId: this.id,
      CategoryLocal.columnName: this.name,
      CategoryLocal.columnDescription: this.description,
      CategoryLocal.columnDateAdded: dateToString(this.dateAdded),
      CategoryLocal.columnIsDefault: this.isDefault ? 1 : 0,
    };
  }
}
