import 'package:redux/redux.dart';
import 'package:flutter_emergency_app_one/models/loading_status.dart';
import 'package:flutter_emergency_app_one/models/verse.dart';
import 'package:flutter_emergency_app_one/redux/verse/verse_actions.dart';
import 'package:flutter_emergency_app_one/redux/verse/verse_state.dart';

final verseReducer = combineReducers<VerseState>([
  TypedReducer<VerseState, LatestVerseSuccessfulAction>(_updateVerses),
  TypedReducer<VerseState, VerseCategorySuccessfulAction>(_getVerseCategory),
  TypedReducer<VerseState, CurrentVersesSuccessfulAction>(_getCurrentVerses),
  TypedReducer<VerseState, CurrentFavSuccessfulAction>(_getFavVerses),
  TypedReducer<VerseState, CurrentViewedAction>(_getCurrentViewedVerse),
  //TypedReducer<VerseState, ClearCurrentFavAction>(_clearCurrentFavAction),
  TypedReducer<VerseState, ClearCurrentVersesDetailsAction>(
      _clearCurrentVerseAction),
  TypedReducer<VerseState, ClearCurrentFavoriteDetailsAction>(
      _clearCurrentFavoriteAction),
  //TypedReducer<VerseState, GetCurrentVersesAction>(_clearVerses),
  TypedReducer<VerseState, ToggleVerseFavoriteSuccessFulAction>(
      _toggleVerseFav),
  TypedReducer<VerseState, SetCurrentFavoritePagesAction>(_setVersePageAction),
]);

VerseState _clearCurrentFavoriteAction(
    VerseState state, ClearCurrentFavoriteDetailsAction action) {
  return state.copyWith(currentFavorite: [], currentFavoritePages: null);
}

VerseState _clearCurrentVerseAction(
    VerseState state, ClearCurrentVersesDetailsAction action) {
  return state.copyWith(currentVerses: [], currentVersePages: null);
}

VerseState _setVersePageAction(
    VerseState state, SetCurrentFavoritePagesAction action) {
  return state.copyWith(currentVersePages: action.totalPages);
}

// VerseState _clearCurrentFavAction(
//     VerseState state, ClearCurrentFavAction action) {
//   return state.copyWith(currentFavorite: []);
// }

VerseState _updateVerses(VerseState state, LatestVerseSuccessfulAction action) {
  return state.copyWith(
      loadingStatus: LoadingStatus.success,
      latestVerses: []..addAll(state.latestVerses)..addAll(action.verses));
}

VerseState _getVerseCategory(
    VerseState state, VerseCategorySuccessfulAction action) {
  return state.copyWith(verseCategories: action.verseCategories);
}

VerseState _getCurrentVerses(
    VerseState state, CurrentVersesSuccessfulAction action) {
  return state.copyWith(
      currentVerses: []..addAll(state.currentVerses)..addAll(action.verses));
}

VerseState _getFavVerses(VerseState state, CurrentFavSuccessfulAction action) {
  return state.copyWith(
      currentFavorite: []
        ..addAll(state.currentFavorite)
        ..addAll(action.favVerses));
}

VerseState _getCurrentViewedVerse(
    VerseState state, CurrentViewedAction action) {
  return state.copyWith(currentViewed: action.currentViewed);
}

VerseState _toggleVerseFav(
    VerseState state, ToggleVerseFavoriteSuccessFulAction action) {
  return state.copyWith(
    loadingStatus: LoadingStatus.success,
    latestVerses: _replaceVerseIfFound(state.latestVerses, action.toggledVerse),
    currentVerses:
        _replaceVerseIfFound(state.currentVerses, action.toggledVerse),
    currentFavorite: (!action.toggledVerse.isFaved)
        ? _removeVerse(state.currentFavorite, action.toggledVerse)
        : _addVerse(state.currentFavorite, action.toggledVerse),
  );
}

List<Verse> _replaceVerseIfFound(
  List<Verse> originalVerses,
  Verse replacement,
) {
  var newVerses = <Verse>[]..addAll(originalVerses);
  var positionToReplace = originalVerses.indexWhere((candidate) {
    return candidate.id == replacement.id;
  });

  if (positionToReplace > -1) {
    newVerses[positionToReplace] = replacement;
  }

  return newVerses;
}

List<Verse> _removeVerse(
  List<Verse> originalVerses,
  Verse verseToRemove,
) {
  var newVerses = <Verse>[]..addAll(originalVerses);
  newVerses.removeWhere((verse) => verse.id == verseToRemove.id);
  return newVerses;
}

List<Verse> _addVerse(
  List<Verse> originalVerses,
  Verse verseToAdd,
) {
  //TODO: this currently adds fav at the top, consider adding the item based on the current order style if necessary
  var newVerses = <Verse>[]
    ..add(verseToAdd)
    ..addAll(originalVerses);
  return newVerses;
}
