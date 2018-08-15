import 'package:flutter_emergency_app_one/models/verse_category.dart';
import 'package:redux/redux.dart';
import 'package:flutter_emergency_app_one/redux/app/app_state.dart';

class VerseAddViewModel {
  final Function(VerseCategory) addVerseCategory;

  VerseAddViewModel({
    this.addVerseCategory,
  });

  static VerseAddViewModel fromStore(Store<AppState> store) {
    return VerseAddViewModel(
      addVerseCategory: (VerseCategory verseToAdd) {
        // store.dispatch(
        //     CurrentViewedAction(verseSelector(store.state, viewType)[index]));
      },
    );
  }
}
