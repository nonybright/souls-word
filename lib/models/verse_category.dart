import 'package:flutter_emergency_app_one/services/local/category_local.dart';
import 'package:flutter_emergency_app_one/utils/date_formater.dart';

class VerseCategory {
  int id;
  String globalId;
  String name;
  String description;
  DateTime dateAdded;

  VerseCategory({
    this.id,
    this.globalId,
    this.name,
    this.description,
    this.dateAdded,
  });

  VerseCategory.fromMap(Map category) {
    this.id = category[CategoryLocal.columnId];
    this.globalId = category[CategoryLocal.columnGlobalId];
    this.name = category[CategoryLocal.columnName];
    this.description = category[CategoryLocal.columnDescription];
    this.dateAdded = DateTime.parse(category[CategoryLocal.columnDateAdded]);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      CategoryLocal.columnId: this.id,
      CategoryLocal.columnGlobalId: this.globalId,
      CategoryLocal.columnName: this.name,
      CategoryLocal.columnDescription: this.description,
    }; 

    if(this.dateAdded != null){
      map[CategoryLocal.columnDateAdded] = dateToString(this.dateAdded);
    }
    return map;
  }
}
