import 'package:flutter_emergency_app_one/redux/app/app_state.dart';
import 'package:flutter_emergency_app_one/redux/app/appbaraction/app_bar_action_reducer.dart';
import 'package:flutter_emergency_app_one/redux/app/updated/is_updated_reducer.dart';
import 'package:flutter_emergency_app_one/redux/verse/verse_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return new AppState(
    appbarActions: actionBarActionReducer(state.appbarActions, action),
    isUpdated: isUpdatedReducer(state.isUpdated, action),
    verseState: verseReducer(state.verseState, action),
    //verseState:
  );
}
