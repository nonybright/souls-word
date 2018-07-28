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

///gets the verses to be displayed on the list from local store
// class GetCurrentVersesAction {
//   final int categoryID;
//   final VerseListAction action;
//   GetCurrentVersesAction(this.categoryID, this.action);
// }

class GetCurrentVersesAction {
  final int categoryID;
  final VerseListAction action;
  final int currentPage;
  final VerseDisplayType type;
  GetCurrentVersesAction(
    this.currentPage,
    this.type, {
    this.action,
    this.categoryID,
  });
}

//class GetFavoriteVersesAction {}

//class GetCategoryVerseAndFavAction {
// int categoryId;
//  GetCategoryVerseAndFavAction(this.categoryId);
//}

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

// class ClearCurrentFavAction {
//   ClearCurrentFavAction();
// }

// class GetAllVersesAction {
//   final VerseDisplayType type;
//   final VerseListAction action;
//   final int currentPage;
//   GetAllVersesAction(this.type, this.action, this.currentPage);
// }

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
