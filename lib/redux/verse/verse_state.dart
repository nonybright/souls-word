import 'package:flutter_emergency_app_one/models/loading_status.dart';
import 'package:flutter_emergency_app_one/models/verse.dart';
import 'package:flutter_emergency_app_one/models/verse_category.dart';

class VerseState {
  LoadingStatus loadingStatus;
  List<Verse> latestVerses;
  List<VerseCategory> verseCategories;
  List<Verse> currentVerses;
  List<Verse> currentFavorite;
  int currentVersePages;
  int currentFavoritePages;
  Verse currentViewed;

  VerseState(
      {this.latestVerses,
      this.loadingStatus,
      this.verseCategories,
      this.currentVerses,
      this.currentFavorite,
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
        currentVersePages: currentVersePages ?? this.currentVersePages,
        currentFavoritePages: currentFavoritePages ?? this.currentFavoritePages,
        currentViewed: currentViewed ?? this.currentViewed);
  }
}
