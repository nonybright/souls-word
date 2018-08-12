import 'package:flutter_emergency_app_one/core/verse/verse_list_fragment.dart';
import 'package:flutter_emergency_app_one/models/loading_status.dart';
import 'package:flutter_emergency_app_one/models/verse.dart';
import 'package:flutter_emergency_app_one/models/verse_category.dart';

class VerseState {
  LoadingStatus verseLoadingStatus;
  LoadingStatus favLoadingStatus;
  List<Verse> latestVerses;
  List<VerseCategory> verseCategories;
  List<Verse> currentVerses;
  List<Verse> currentFavorite;
  Verse currentViewed;
 
  int verseCount;
  int favCount;
  int currentVersePages;
  int currentFavoritePages;
  VerseSortType sortType;

  VerseState(
     
      { 
      this.verseLoadingStatus,
      this.favLoadingStatus,
      this.latestVerses,
      this.verseCategories,
      this.currentVerses,
      this.currentFavorite,
      this.verseCount,
      this.favCount,
      this.currentVersePages,
      this.currentFavoritePages,
      this.currentViewed,
      this.sortType});

  factory VerseState.initial() {
    return VerseState(
        verseLoadingStatus: LoadingStatus.loading,
        favLoadingStatus: LoadingStatus.loading,
        latestVerses: <Verse>[],
        verseCategories: <VerseCategory>[],
        currentVerses: <Verse>[],
        currentFavorite: <Verse>[],
        verseCount: 1,
        favCount: 1,
        currentVersePages: null,
        currentFavoritePages: null,
        currentViewed: null,
        sortType: VerseSortType.sortByBookDesc);
  }

  VerseState copyWith({
    LoadingStatus verseLoadingStatus,
    LoadingStatus favLoadingStatus,
    List<Verse> latestVerses,
    List<VerseCategory> verseCategories,
    List<Verse> currentVerses,
    List<Verse> currentFavorite,
    int verseCount,
    int favCount,
    int currentVersePages,
    int currentFavoritePages,
    Verse currentViewed,
    VerseSortType sortType,
  }) {
    return VerseState(
        verseLoadingStatus: verseLoadingStatus ?? this.verseLoadingStatus,
        favLoadingStatus: favLoadingStatus ?? this.favLoadingStatus,
        latestVerses: latestVerses ?? this.latestVerses,
        verseCategories: verseCategories ?? this.verseCategories,
        currentVerses: currentVerses ?? this.currentVerses,
        currentFavorite: currentFavorite ?? this.currentFavorite,
        verseCount: verseCount ?? this.verseCount,
        favCount:  favCount ?? this.favCount,
        currentVersePages: currentVersePages ?? this.currentVersePages,
        currentFavoritePages: currentFavoritePages ?? this.currentFavoritePages,
        currentViewed: currentViewed ?? this.currentViewed,
        sortType: sortType ?? this.sortType,);
  }
}
