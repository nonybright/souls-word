import 'package:flutter_emergency_app_one/core/verse/verse_view_page.dart';
import 'package:flutter_emergency_app_one/models/verse.dart';
import 'package:flutter_emergency_app_one/redux/app/app_state.dart';
import 'package:flutter_emergency_app_one/redux/verse/verse_state.dart';

List<Verse> verseSelector(AppState state, VerseDisplayType type) {
  return (type == VerseDisplayType.category)
      ? state.verseState.currentVerses
      : state.verseState.currentFavorite;
}
bool verseLoadingSelector(AppState state, VerseDisplayType type) {
  return (type == VerseDisplayType.category)
      ? state.verseState.verseLoading
      : state.verseState.favLoading;
}
int verseCountSelector(AppState state, VerseDisplayType type) {
  return (type == VerseDisplayType.category)
      ? state.verseState.verseCount
      : state.verseState.favCount;
}

Verse currentViewedVerseSelector(AppState state) {
  return state.verseState.currentViewed;
}

int totalPagesSelector(AppState state, VerseDisplayType type) {
  return (type == VerseDisplayType.category)
      ? state.verseState.currentVersePages
      : state.verseState.currentFavoritePages;
}

List<Verse> verseInCategory(VerseState state, categoryId) {
  return state.latestVerses
      .where((verse) => verse.categoryId == categoryId)
      .toList();
}

List<Verse> favVersesInCategory(VerseState state, categoryId) {
  return state.currentVerses
      .where((verse) => verse.categoryId == categoryId && verse.isFaved)
      .toList();
}
