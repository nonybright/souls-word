import 'package:flutter_emergency_app_one/models/loading_status.dart';
import 'package:flutter_emergency_app_one/models/verse.dart';
import 'package:flutter_emergency_app_one/models/verse_category.dart';

class VerseState {
  LoadingStatus loadingStatus;
  List<Verse> latestVerses;
  List<VerseCategory> verseCategories;
  List<Verse> currentVerses;
  List<Verse> currentFavorite;
  bool verseLoading;
  bool favLoading;
  int verseCount;
  int favCount;
  int currentVersePages;
  int currentFavoritePages;
  Verse currentViewed;

  VerseState(
      {this.latestVerses,
      this.loadingStatus,
      this.verseCategories,
      this.currentVerses,
      this.currentFavorite,
      this.verseLoading,
      this.favLoading,
      this.verseCount,
      this.favCount,
      this.currentVersePages,
      this.currentFavoritePages,
      this.currentViewed});

  factory VerseState.initial() {
    return VerseState(
        loadingStatus: LoadingStatus.loading,
        latestVerses: <Verse>[],
        verseCategories: <VerseCategory>[],
        currentVerses: <Verse>[],
        currentFavorite: <Verse>[],
        verseLoading: false,
        favLoading: false,
        verseCount: 1, //TODONOW: check if you will set this to two or remove its value from get current
        favCount: 1,
        currentVersePages: null,
        currentFavoritePages: null,
        currentViewed: null);
  }

  VerseState copyWith({
    LoadingStatus loadingStatus,
    List<Verse> latestVerses,
    List<VerseCategory> verseCategories,
    List<Verse> currentVerses,
    List<Verse> currentFavorite,
    bool verseLoading,
    bool favLoading,
    int verseCount,
    int favCount,
    int currentVersePages,
    int currentFavoritePages,
    Verse currentViewed,
  }) {
    return VerseState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        latestVerses: latestVerses ?? this.latestVerses,
        verseCategories: verseCategories ?? this.verseCategories,
        currentVerses: currentVerses ?? this.currentVerses,
        currentFavorite: currentFavorite ?? this.currentFavorite,
        verseLoading: verseLoading ?? this.verseLoading,
        favLoading: favLoading ?? this.favLoading,
        verseCount: verseCount ?? this.verseCount,
        favCount:  favCount ?? this.favCount,
        currentVersePages: currentVersePages ?? this.currentVersePages,
        currentFavoritePages: currentFavoritePages ?? this.currentFavoritePages,
        currentViewed: currentViewed ?? this.currentViewed);
  }
}
