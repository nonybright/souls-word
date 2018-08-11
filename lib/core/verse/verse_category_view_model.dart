import 'package:redux/redux.dart';
import 'package:flutter_emergency_app_one/core/verse/verse_view_page.dart';
import 'package:flutter_emergency_app_one/models/verse.dart';
import 'package:flutter_emergency_app_one/models/verse_category.dart';
import 'package:flutter_emergency_app_one/redux/app/app_state.dart';
import 'package:flutter_emergency_app_one/redux/verse/verse_selectors.dart';
import 'package:flutter_emergency_app_one/redux/verse/verse_actions.dart';


class VerseCategoryViewModel {
  final List<Verse> verses;
  final List<VerseCategory> verseCategories;
  final Function(int) onCategoryClicked;
  final Function(int) verseCount;

  VerseCategoryViewModel(
      {this.verses,
      this.verseCategories,
      this.onCategoryClicked,
      this.verseCount});

  static VerseCategoryViewModel fromStore(Store<AppState> store) {
    return VerseCategoryViewModel(
        verses: store.state.verseState.latestVerses,
        verseCategories: store.state.verseState.verseCategories,
        onCategoryClicked: (categoryId) {
          //store.dispatch(GetCategoryVerseAndFavAction(categoryId));
          store.dispatch(GetCurrentFavAction(verseCountSelector(store.state,VerseDisplayType.favorite),
               null, categoryID: categoryId));
          store.dispatch(GetCurrentVersesAction(verseCountSelector(store.state,VerseDisplayType.category),
              null, categoryID: categoryId));
        },
        verseCount: (categoryID) {
          return verseInCategory(store.state.verseState, categoryID).length;
        });
  }
}
