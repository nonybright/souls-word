import 'package:flutter_emergency_app_one/models/loading_status.dart';
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
  final LoadingStatus loadingStatus;

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
      this.loadingStatus,
      this.onSortByDateDesc,
      this.onSortByDateAsc,
      this.onSortByBookAsc,
      this.onSortByBookDesc,
      this.onShareClicked,
      this.onShareImageClicked,
      this.onFavToggleClicked,
      this.onLoadMore});

  static VerseViewModel fromStore(
      Store<AppState> store,
      VerseDisplayType type,
      {int categoryId}) {
    
    return VerseViewModel(
      latestVerses: store.state.verseState.latestVerses,
      displayedVerses: (type == VerseDisplayType.category) 
      // use else if type == fav for the next line too to prevent it from changing when null is passed in the other side
          ? store.state.verseState.currentVerses
          : store.state.verseState.currentFavorite,
      loadingStatus: verseLoadingSelector(store.state, type), 
      onLoadMore: () {
        int totalPages = totalPagesSelector(store.state, type);
       // int pageCount = verseCountSelector(store.state,type);

        if(verseCountSelector(store.state,type) < totalPages){
          if(type == VerseDisplayType.favorite){
               store.dispatch(GetMoreCurrentFavAction(verseCountSelector(store.state,type),
               action: null, categoryID: categoryId));
          }else{
              store.dispatch(GetMoreCurrentVersesAction(verseCountSelector(store.state,type),
               action: null, categoryID: categoryId));
          }

        }
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
