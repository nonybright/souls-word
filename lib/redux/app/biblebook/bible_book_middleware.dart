import 'dart:async';

import 'package:flutter_emergency_app_one/models/BibleBook.dart';
import 'package:flutter_emergency_app_one/redux/app/biblebook/bible_book_action.dart';
import 'package:flutter_emergency_app_one/services/local/bible_book_local.dart';
import 'package:redux/redux.dart';
import 'package:flutter_emergency_app_one/redux/app/app_state.dart';

class BibleBookMiddleWare extends MiddlewareClass<AppState> {
  BibleBookLocal biblebookLocal;

  BibleBookMiddleWare(this.biblebookLocal);
  @override
  Future<Null> call(Store<AppState> store, action, NextDispatcher next) async {
    // TODO: implement call

    next(action);
    if (action is GetBibleBooksAction) {
      await _getBibleBooks(action, next);
    }
  }

  Future<Null> _getBibleBooks(GetBibleBooksAction action, NextDispatcher next) async{

        List<BibleBook> books = await biblebookLocal.getBooks();
        next(GetBibleBooksSuccessfulAction(books));
  }
}
