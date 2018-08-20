import 'dart:async';

import 'package:flutter_emergency_app_one/core/verse/verse_list_fragment.dart';
import 'package:flutter_emergency_app_one/core/verse/verse_view_page.dart';
import 'package:flutter_emergency_app_one/models/verse.dart';
import 'package:flutter_emergency_app_one/models/verse_category.dart';

class LatestVerseAction {
  LatestVerseAction();
}

class LatestVerseSuccessfulAction {
  final List<Verse> verses;
  LatestVerseSuccessfulAction(this.verses);
}

class GetVerseCategoryAction {
  GetVerseCategoryAction();
}

class VerseCategorySuccessfulAction {
  final List<VerseCategory> verseCategories;
  VerseCategorySuccessfulAction(this.verseCategories);
}

//TODO: Refactor all these to extend
class GetCurrentVersesAction {
  final int categoryID;
  final VerseSortType sortType;
  final int currentPage;
  final VerseDisplayType type = VerseDisplayType.category;
  GetCurrentVersesAction(
    this.currentPage,
    this.sortType,
   {
    this.categoryID,
  });
}

class GetCurrentFavAction {
  final int categoryID;
  final VerseSortType sortType;
  final int currentPage;
  final VerseDisplayType type = VerseDisplayType.favorite;
  GetCurrentFavAction(
    this.currentPage,
    this.sortType,
    {
    this.categoryID,
  });
}


class GetMoreCurrentVersesAction {
  final int categoryID;
  final VerseSortType sortType;
  final int currentPage;
  final VerseDisplayType type = VerseDisplayType.category;
  GetMoreCurrentVersesAction(
    this.currentPage,
   {
    this.sortType,
    this.categoryID,
  });
}

class GetMoreCurrentFavAction {
  final int categoryID;
  final VerseSortType sortType;
  final int currentPage;
  final VerseDisplayType type = VerseDisplayType.favorite;
  GetMoreCurrentFavAction(
    this.currentPage,
    {
    this.sortType,
    this.categoryID,
  });
}

class ClearCurrentVersesDetailsAction {
  ClearCurrentVersesDetailsAction();
}

class SetCurrentVersePagesAction {
  int totalPages;
  SetCurrentVersePagesAction(this.totalPages);
}

class ClearCurrentFavoriteDetailsAction {
  ClearCurrentFavoriteDetailsAction();
}

class SetCurrentFavoritePagesAction {
  int totalPages;
  SetCurrentFavoritePagesAction(this.totalPages);
}

class CurrentVersesSuccessfulAction {
  final List<Verse> verses;
  CurrentVersesSuccessfulAction(this.verses);
}

class CurrentFavSuccessfulAction {
  final List<Verse> favVerses;
  CurrentFavSuccessfulAction(this.favVerses);
}

class CurrentViewedAction {
  Verse currentViewed;
  CurrentViewedAction(this.currentViewed);
}

class ToggleVerseFavoriteAction {
  Verse verseToToggle;
  ToggleVerseFavoriteAction(this.verseToToggle);
}

class ToggleVerseFavoriteSuccessFulAction {
  Verse toggledVerse;
  ToggleVerseFavoriteSuccessFulAction(this.toggledVerse);
}

//TODO: What happens when a user pops while a save is going on ... ask the user tho.
class AddVerseCategory{
  VerseCategory categoryToAdd;
  Completer completer;
  AddVerseCategory(this.categoryToAdd, this.completer);
}

class VerseCategoryAddSuccessfulAction{
    VerseCategoryAddSuccessfulAction();
}

class AddVerseAction{
  Verse verseToAdd;
  Completer completer;
  AddVerseAction(this.verseToAdd, this.completer);
}

class AddVerseSuccessfulAction{
  AddVerseSuccessfulAction();
}