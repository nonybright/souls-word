import 'package:flutter_emergency_app_one/models/BibleBook.dart';
import 'package:flutter_emergency_app_one/redux/app/biblebook/bible_book_action.dart';

//TODO: Refactor and wrap floating action and appbaraction in a substate called uiState or so . Put the reducers in one file
List<BibleBook> bibleBooksReducer(List<BibleBook> state, action) {
  if (action is GetBibleBooksSuccessfulAction) {
    return action.gottenBooks;
  }else{
    return state;
  }
}