import 'package:redux/redux.dart';
import 'package:flutter_emergency_app_one/redux/app/app_state.dart';
import 'package:flutter_emergency_app_one/redux/app/app_reducer.dart';
import 'package:flutter_emergency_app_one/redux/verse/verse_middleware.dart';

Store<AppState> createStore() {
  return Store(
    appReducer,
    initialState: AppState.initial(),
    middleware: createVerseMiddleWare(),
  );
}
