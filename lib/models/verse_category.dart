import 'package:flutter_emergency_app_one/services/local/category_local.dart';

class VerseCategory {
  int id;
  String name;
  String description;
  bool isDefault;

  VerseCategory({this.id, this.name, this.description, this.isDefault});

  VerseCategory.fromMap(Map category) {
    this.id = category[CategoryLocal.columnId];
    this.name = category[CategoryLocal.columnName];
    this.description = category[CategoryLocal.columnDescription];
    this.isDefault = category[CategoryLocal.columnIsDefault] == 1;
  }

  Map toMap() {
    /*Map<String, dynamic> map = new Map();
    map[CategoryLocal.columnId] = this.id;
    map[CategoryLocal.columnName] = this.name;
    map[CategoryLocal.columnDescription] = this.description;
    map[CategoryLocal.columnIsDefault] = this.isDefault ? 1 : 0;*/

    Map map = {
      CategoryLocal.columnId: this.id,
      CategoryLocal.columnName: this.name,
      CategoryLocal.columnDescription: this.description,
      CategoryLocal.columnIsDefault: this.isDefault ? 1 : 0,
    };

    return map;
  }

  /*static VerseCategory fromMap(Map category) {
    VerseCategory verseCat = new VerseCategory();
    verseCat.id = category[CategoryLocal.columnId];
    verseCat.name = category[CategoryLocal.columnName];
    verseCat.description = category[CategoryLocal.columnDescription];
    verseCat.isDefault = category[CategoryLocal.columnIsDefault] == 1;

    return verseCat;
  }*/
}
