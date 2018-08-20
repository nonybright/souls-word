import 'package:flutter_emergency_app_one/redux/app/biblebook/bible_book_middleware.dart';
import 'package:flutter_emergency_app_one/services/local/bible_book_local.dart';
import 'package:flutter_emergency_app_one/services/local/category_local.dart';
import 'package:flutter_emergency_app_one/services/local/database_helper.dart';
import 'package:flutter_emergency_app_one/services/local/verse_local.dart';
import 'package:flutter_emergency_app_one/services/repository/verse_repository.dart';
import 'package:redux/redux.dart';
import 'package:flutter_emergency_app_one/redux/app/app_state.dart';
import 'package:flutter_emergency_app_one/redux/app/app_reducer.dart';
import 'package:flutter_emergency_app_one/redux/verse/verse_middleware.dart';

Store<AppState> createStore() {

   VerseRepository verseRepository = VerseRepository();

  DatabaseHelper dbHelper = new DatabaseHelper();

  VerseLocal verseLocal = VerseLocal(dbHelper);
  CategoryLocal categoryLocal = CategoryLocal(dbHelper);
  BibleBookLocal bibleBookLocal = BibleBookLocal(dbHelper);

  return Store(
    appReducer,
    initialState: AppState.initial(),
    middleware: [VerseMiddleWare(verseRepository, verseLocal, categoryLocal), BibleBookMiddleWare(bibleBookLocal)],
  );
}


// class VerseMiddleWare extends MiddlewareClass<AppState>{
  
  
//   @override
//   void call(Store<AppState> store, action, NextDispatcher next) {
//     // TODO: implement call
//     next(action);
//     if(action is GetVerseCategoryAction){
//           print('this is to get the verse categories');
//     }
//   }

// }

// class QuoteMiddleWare extends MiddlewareClass<AppState>{
  
  
//   @override
//   void call(Store<AppState> store, action, NextDispatcher next) {
//     // TODO: implement call
//     if(action is ChangeActionWidget){
//        print('change the action widget');
//     }
//   }

// }
