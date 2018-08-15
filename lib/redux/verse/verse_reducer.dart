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
  // TypedReducer<VerseState, ClearCurrentVersesDetailsAction>(
  //     _clearCurrentVerseAction),
  // TypedReducer<VerseState, ClearCurrentFavoriteDetailsAction>(
  //     _clearCurrentFavoriteAction),
  TypedReducer<VerseState, GetCurrentVersesAction>(_initVerses),
  TypedReducer<VerseState, GetCurrentFavAction>(_initFav),
  TypedReducer<VerseState, GetMoreCurrentVersesAction>(_initMoreVerses),
  TypedReducer<VerseState, GetMoreCurrentFavAction>(_initMoreFav),
  TypedReducer<VerseState, ToggleVerseFavoriteSuccessFulAction>(
      _toggleVerseFav),
  TypedReducer<VerseState, SetCurrentFavoritePagesAction>(_setFavPageAction),
  TypedReducer<VerseState, SetCurrentVersePagesAction>(_setVersePageAction),
  TypedReducer<VerseState, AddVerseCategory>(_setAddVerseCatAction),
  TypedReducer<VerseState, VerseCategorySuccessfulAction>(_setAddVerseSuccesFulAction),
]);
VerseState _setAddVerseCatAction(
    VerseState state, AddVerseCategory action) {
   return state.copyWith(saveAndEditStatus: ClickStatus.loading);
}
VerseState _setAddVerseSuccesFulAction(
    VerseState state, VerseCategorySuccessfulAction action) {
   return state.copyWith(saveAndEditStatus: ClickStatus.notLoading);
}

VerseState _initMoreVerses(
    VerseState state, GetMoreCurrentVersesAction action) {
   return state.copyWith(verseLoadingStatus: LoadingStatus.loadingMore);
}
VerseState _initMoreFav(
    VerseState state, GetMoreCurrentFavAction action) {
//count is not increased here because an error might occur during loading and reloading current index might be needed.
return state.copyWith(favLoadingStatus: LoadingStatus.loadingMore); 
}
VerseState _initVerses(
    VerseState state, GetCurrentVersesAction action) {
   return state.copyWith(currentVerses:[], currentVersePages:  null, verseLoadingStatus: LoadingStatus.loading, verseCount: 1, sortType: action.sortType);
}
VerseState _initFav(
    VerseState state, GetCurrentFavAction action) {
return state.copyWith(currentFavorite: [],  currentFavoritePages: null, favLoadingStatus: LoadingStatus.loading, favCount: 1, sortType: action.sortType);
}

VerseState _setVersePageAction(
    VerseState state, SetCurrentVersePagesAction action) {
  return state.copyWith(currentVersePages: action.totalPages);
}
VerseState _setFavPageAction(
    VerseState state, SetCurrentFavoritePagesAction action) {
  return state.copyWith(currentFavoritePages: action.totalPages);
}


VerseState _updateVerses(VerseState state, LatestVerseSuccessfulAction action) {
  return state.copyWith(latestVerses: []..addAll(state.latestVerses)..addAll(action.verses));
}

VerseState _getVerseCategory(
  VerseState state, VerseCategorySuccessfulAction action) {
  return state.copyWith(verseCategories: action.verseCategories);
}

VerseState _getCurrentVerses(
    VerseState state, CurrentVersesSuccessfulAction action) {
  return state.copyWith(
      currentVerses: []..addAll(state.currentVerses)..addAll(action.verses), verseLoadingStatus: LoadingStatus.success, verseCount: state.verseCount + 1, );
}

VerseState _getFavVerses(VerseState state, CurrentFavSuccessfulAction action) {
  return state.copyWith(
      currentFavorite: []
        ..addAll(state.currentFavorite)
        ..addAll(action.favVerses), favLoadingStatus: LoadingStatus.success, favCount: state.favCount + 1);
}

VerseState _getCurrentViewedVerse(
    VerseState state, CurrentViewedAction action) {
  return state.copyWith(currentViewed: action.currentViewed);
}

VerseState _toggleVerseFav(
    VerseState state, ToggleVerseFavoriteSuccessFulAction action) {
  return state.copyWith(
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
