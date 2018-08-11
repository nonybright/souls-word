import 'dart:async';

import 'package:flutter_emergency_app_one/models/verse_category.dart';
import 'package:redux/redux.dart';
import 'package:flutter_emergency_app_one/core/verse/verse_view_page.dart';
import 'package:flutter_emergency_app_one/models/verse.dart';
import 'package:flutter_emergency_app_one/redux/app/app_state.dart';
import 'package:flutter_emergency_app_one/redux/verse/verse_actions.dart';
import 'package:flutter_emergency_app_one/redux/verse/verse_selectors.dart';
import 'package:flutter_emergency_app_one/services/local/category_local.dart';
import 'package:flutter_emergency_app_one/services/local/verse_local.dart';
import 'package:flutter_emergency_app_one/services/repository/verse_repository.dart';

class VerseMiddleWare extends MiddlewareClass<AppState> {
  VerseRepository verseRepository;
  VerseLocal verseLocal;
  CategoryLocal categoryLocal;

  VerseMiddleWare(this.verseRepository, this.verseLocal, this.categoryLocal);

  @override
  Future<Null> call(Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    if (action is GetVerseCategoryAction) {
      await _getCategories(action, next);
    } else if (action is LatestVerseAction) {
      await _getLatestVerses(next);
    } else if (action is ToggleVerseFavoriteAction) {
      await _toggleVerseFavorite(store, action, next);
    } else if (action is GetCurrentVersesAction ||
        action is GetCurrentFavAction ||
        action is GetMoreCurrentVersesAction ||
        action is GetMoreCurrentFavAction) {
      _getCurrentVerses(store, action, next);
    }
  }

  Future<Null> _getCategories(action, NextDispatcher next) async {
    try {
      List<VerseCategory> categories = await categoryLocal.getCategories();
      next(VerseCategorySuccessfulAction(categories));
    } catch (e) {
      next(action);
    }
  }

  Future<Null> _getLatestVerses(NextDispatcher next) async {
    List<Verse> gottenVerses = await verseRepository.getLatestVerses();

    next(LatestVerseSuccessfulAction(gottenVerses));
  }

  Future<Null> _toggleVerseFavorite(
      Store store, action, NextDispatcher next) async {
    if (action is ToggleVerseFavoriteAction) {
      Verse toggledVerse =
          action.verseToToggle.copyWith(isFaved: !action.verseToToggle.isFaved);

      await verseLocal.updateVerse(toggledVerse);
      next(ToggleVerseFavoriteSuccessFulAction(toggledVerse));
    }
  }

  Future<Null> _getCurrentVerses(
      Store store, action, NextDispatcher next) async {
    int perPage = 10;
    int currentPage = verseCountSelector(store.state, action.type);
    int offset = (currentPage - 1) * perPage;

    //if pagenumber is set in action, dont get this one again.
    verseLocal
        .getVersesCount(action.type, categoryId: action.categoryID)
        .then((totalRows) {
      int totalPages = (totalRows / perPage).ceil();
      if (action.type == VerseDisplayType.category) {
        next(SetCurrentVersePagesAction(totalPages));
      } else {
        next(SetCurrentFavoritePagesAction(totalPages));
      }
    });

    verseLocal
        .getVerses(action.type,
            sortType: sortTypeSelector(store.state),
            limit: perPage,
            offset: offset,
            categoryId: action.categoryID)
        .then((verses) {
      if (action.type == VerseDisplayType.category) {
        next(CurrentVersesSuccessfulAction(verses));
      } else {
        next(CurrentFavSuccessfulAction(verses));
      }
    });
  }
} 