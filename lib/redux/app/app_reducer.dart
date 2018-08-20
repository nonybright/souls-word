import 'package:flutter_emergency_app_one/redux/app/app_state.dart';
import 'package:flutter_emergency_app_one/redux/app/appbaraction/app_bar_action_reducer.dart';
import 'package:flutter_emergency_app_one/redux/app/biblebook/bible_book_reducer.dart';
import 'package:flutter_emergency_app_one/redux/app/floating_action_button/floating_action_button_reducer.dart';
import 'package:flutter_emergency_app_one/redux/app/updated/is_updated_reducer.dart';
import 'package:flutter_emergency_app_one/redux/verse/verse_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return new AppState(
    //TODO: move these two(appbarActions, floatingActionButton) to a uiState just like verseState
    appbarActions: actionBarActionReducer(state.appbarActions, action),
    floatingActionButton: floatinActionButtonReducer(state.floatingActionButton, action), 
    isUpdated: isUpdatedReducer(state.isUpdated, action),
    bibleBooks: bibleBooksReducer(state.bibleBooks , action),
    verseState: verseReducer(state.verseState, action),
    //verseState:
  );
}
//TODONOW: bible books middleware and linking to addversepage / verseselector widget