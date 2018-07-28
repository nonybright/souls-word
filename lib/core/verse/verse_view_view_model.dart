import 'package:redux/redux.dart';
import 'package:flutter_emergency_app_one/core/verse/verse_view_page.dart';
import 'package:flutter_emergency_app_one/models/verse.dart';
import 'package:flutter_emergency_app_one/redux/app/app_state.dart';
import 'package:flutter_emergency_app_one/redux/verse/verse_actions.dart';
import 'package:flutter_emergency_app_one/redux/verse/verse_selectors.dart';

class VerseViewViewModel {
  final Function(int) getCurrentVerse;
  Verse currentViewed;
  final Function canGoForward;
  final Function canGoBackward;

  VerseViewViewModel({
    this.getCurrentVerse,
    this.currentViewed,
    this.canGoForward,
    this.canGoBackward,
  });

  static VerseViewViewModel fromStore(
      Store<AppState> store, VerseDisplayType viewType) {
    return VerseViewViewModel(
        currentViewed: currentViewedVerseSelector(store.state),
        canGoForward: () {
          int verseIndex = verseSelector(store.state, viewType)
              .indexOf(currentViewedVerseSelector(store.state));

          return verseIndex != verseSelector(store.state, viewType).length - 1;
        },
        canGoBackward: () {
          int verseIndex = verseSelector(store.state, viewType)
              .indexOf(currentViewedVerseSelector(store.state));

          return verseIndex != 0;
        },
        getCurrentVerse: (index) {
          store.dispatch(
              CurrentViewedAction(verseSelector(store.state, viewType)[index]));
        });
  }
}
