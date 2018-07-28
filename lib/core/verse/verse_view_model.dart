import 'package:redux/redux.dart';
//import 'package:flutter_emergency_app_one/core/verse/verse_list_fragment.dart';
import 'package:flutter_emergency_app_one/core/verse/verse_view_page.dart';
import 'package:flutter_emergency_app_one/models/verse.dart';
import 'package:flutter_emergency_app_one/redux/app/app_state.dart';
import 'package:flutter_emergency_app_one/redux/verse/verse_actions.dart';
import 'package:flutter_emergency_app_one/redux/verse/verse_selectors.dart';

class VerseViewModel {
  final List<Verse> latestVerses;
  final List<Verse> displayedVerses;
  final Function onLoadMore;
  final Function(Verse) onVerseClicked;

  final Function onSortByDateDesc;
  final Function onSortByDateAsc;
  final Function onSortByBookDesc;
  final Function onSortByBookAsc;

  final Function(Verse) onShareClicked;
  final Function(Verse) onShareImageClicked;
  final Function(Verse) onFavToggleClicked;

  VerseViewModel(
      {this.latestVerses,
      this.displayedVerses,
      this.onVerseClicked,
      this.onSortByDateDesc,
      this.onSortByDateAsc,
      this.onSortByBookAsc,
      this.onSortByBookDesc,
      this.onShareClicked,
      this.onShareImageClicked,
      this.onFavToggleClicked,
      this.onLoadMore});

  static VerseViewModel fromStore(
      //TODONOW: Remove all links to allVerses .. both on the listframentpage
      Store<AppState> store,
      VerseDisplayType type,
      {int categoryID}) {
    int pageCount = 2; // pageCount is two because the first loading takes one
    //TODO: consider moving pageCount's value to VerseState
    return VerseViewModel(
      latestVerses: store.state.verseState.latestVerses,
      displayedVerses: (type == VerseDisplayType.category)
          ? store.state.verseState.currentVerses
          : store.state.verseState.currentFavorite,
      onLoadMore: () {
        int totalPages = totalPagesSelector(store.state, type);

        if (pageCount < totalPages) {
          //GetCurrentVersesAction();
        }

        pageCount++;
      },
      onVerseClicked: (verse) {
        store.dispatch(CurrentViewedAction(verse));
      },
      onSortByDateDesc: () {
        //  store.dispatch(new GetCurrentVersesAction(
        //     categoryID, VerseListAction.sortByDateDesc));
      },
      onSortByDateAsc: () {
        //   store.dispatch(new GetCurrentVersesAction(
        //     categoryID, VerseListAction.sortByDateAsc));
      },
      onSortByBookAsc: () {
        // store.dispatch(new GetCurrentVersesAction(
        //     categoryID, VerseListAction.sortByBookAsc));
      },
      onSortByBookDesc: () {
        // store.dispatch(new GetCurrentVersesAction(
        //    categoryID, VerseListAction.sortByBookDesc));
      },
      onShareClicked: (verse) {
        print('verse has been clicked and the id is $verse.id');
      },
      onShareImageClicked: (verse) {},
      onFavToggleClicked: (verse) {
        store.dispatch(new ToggleVerseFavoriteAction(verse));
      },
    );
  }
}
